-- AI evaluation of practical work (Phase 1).
--
-- Additive. Nothing changes for existing days: only a day flagged
-- ai_evaluate = true is routed to the evaluator. The evaluator itself is the
-- `evaluate-submission` Edge Function (service role); members can never write
-- scores. Anything the AI is unsure about, or cannot read, falls back to the
-- existing instructor review queue ('pending_review').

-- Lifecycle: submitted -> pending_ai -> scored | needs_revision | pending_review
alter type submission_status add value if not exists 'pending_ai';

alter table public.day
  add column if not exists ai_evaluate boolean not null default false;

alter table public.submission
  add column if not exists ai_scores jsonb,
  add column if not exists ai_feedback jsonb,
  add column if not exists ai_model text,
  add column if not exists ai_confidence numeric check (ai_confidence between 0 and 1),
  add column if not exists rubric_version int,
  add column if not exists attempt int not null default 1,
  add column if not exists share_status text not null default 'private'
    check (share_status in ('private', 'shared')),
  add column if not exists ai_evaluated_at timestamptz;

-- Append-only audit + cost log. RLS on with no policies: service role only.
create table if not exists public.ai_evaluation_log (
  id            uuid primary key default gen_random_uuid(),
  user_id       uuid not null references auth.users(id) on delete cascade,
  submission_id uuid references public.submission(id) on delete set null,
  day_id        uuid references public.day(id) on delete set null,
  model         text,
  outcome       text not null,       -- scored | needs_revision | pending_review | no_key | rate_limited | error | skipped
  result        jsonb,
  created_at    timestamptz not null default now()
);
alter table public.ai_evaluation_log enable row level security;
create index if not exists ai_evaluation_log_user_time_idx
  on public.ai_evaluation_log (user_id, created_at desc);

-- submit_day: identical to the instructor-review version, plus
--   * ai_evaluate days park as 'pending_ai' (no score until the evaluator runs)
--   * resubmitting increments `attempt` and clears the previous AI result
create or replace function public.submit_day(
  p_enrollment_id uuid,
  p_day_id uuid,
  p_content text,
  p_self_score numeric default null,
  p_answers jsonb default '[]'::jsonb
) returns public.submission
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid   uuid := auth.uid();
  v_enr   public.enrollment;
  v_day   public.day;
  v_check public.day_check;
  v_total int;
  v_correct int;
  v_i int;
  v_check_score numeric := null;
  v_self numeric := p_self_score;
  v_score numeric := null;
  v_passed boolean := true;
  v_status submission_status;
  v_sub public.submission;
  v_done int;
begin
  if v_uid is null then raise exception 'Not authenticated'; end if;

  select * into v_enr from public.enrollment where id = p_enrollment_id;
  if not found or v_enr.user_id <> v_uid then
    raise exception 'Not authorized for this enrollment';
  end if;

  select * into v_day from public.day
    where id = p_day_id and track_id = v_enr.track_id and is_published;
  if not found then raise exception 'Day not found in this track'; end if;

  if v_self is not null and (v_self < 0 or v_self > 100) then
    raise exception 'self_score out of range';
  end if;

  select * into v_check from public.day_check where day_id = p_day_id limit 1;
  if found then
    v_total := jsonb_array_length(v_check.items);
    v_correct := 0;
    if v_total > 0 then
      for v_i in 0..v_total - 1 loop
        if v_check.type = 'mcq' then
          if (v_check.items -> v_i ->> 'answer') is not distinct from (p_answers ->> v_i) then
            v_correct := v_correct + 1;
          end if;
        elsif v_check.type = 'checklist' then
          if (p_answers -> v_i)::text = 'true' then v_correct := v_correct + 1; end if;
        end if;
      end loop;
      v_check_score := round(v_correct * 100.0 / v_total);
    end if;
    v_passed := coalesce(v_check_score, 0) >= coalesce(v_check.pass_pct, 70);
  end if;

  if v_check_score is not null and v_self is not null then
    v_score := round((v_check_score + v_self) / 2.0);
  elsif v_check_score is not null then
    v_score := v_check_score;
  elsif v_self is not null then
    v_score := v_self;
  end if;

  v_status := (case when v_passed then 'scored' else 'needs_revision' end)::submission_status;

  if v_day.requires_review then
    -- Instructor-review days: an admin finalizes the score.
    v_status := 'pending_review';
    v_score := null;
  elsif v_day.ai_evaluate and v_passed then
    -- AI-evaluated days: the evaluator sets the score. (A failed quiz gate still
    -- needs revision first, so it never reaches the evaluator.)
    v_status := 'pending_ai'::submission_status;
    v_score := null;
  end if;

  insert into public.submission
    (enrollment_id, user_id, day_id, content, check_score, self_score, score, status, submitted_at)
  values
    (p_enrollment_id, v_uid, p_day_id, p_content, v_check_score, v_self, v_score, v_status, now())
  on conflict (enrollment_id, day_id) do update
    set content = excluded.content,
        check_score = excluded.check_score,
        self_score = excluded.self_score,
        score = excluded.score,
        status = excluded.status,
        submitted_at = now(),
        reviewed_by = null,
        reviewed_at = null,
        attempt = public.submission.attempt + 1,
        feedback = null,
        ai_scores = null,
        ai_feedback = null,
        ai_model = null,
        ai_confidence = null,
        ai_evaluated_at = null,
        share_status = 'private'
  returning * into v_sub;

  select count(*) into v_done from public.submission
    where enrollment_id = p_enrollment_id and status in ('scored', 'pending_review');
  update public.enrollment
    set current_day = least(greatest(v_done + 1, 1), total_days),
        status = case when v_done >= total_days then 'completed'::enrollment_status else status end
    where id = p_enrollment_id;

  return v_sub;
end;
$$;

revoke all on function public.submit_day(uuid, uuid, text, numeric, jsonb) from public, anon;
grant execute on function public.submit_day(uuid, uuid, text, numeric, jsonb) to authenticated;

-- Member appeal: ask a human to re-check an AI score. The AI score and feedback
-- are kept so the reviewer can see them. (pending_review is non-blocking.)
create or replace function public.request_recheck(p_submission_id uuid)
returns public.submission
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
  v_sub public.submission;
begin
  if v_uid is null then raise exception 'Not authenticated'; end if;
  update public.submission
     set status = 'pending_review', reviewed_by = null, reviewed_at = null
   where id = p_submission_id
     and user_id = v_uid
     and status in ('scored', 'needs_revision', 'pending_ai')
  returning * into v_sub;
  if not found then raise exception 'Nothing to re-check for that submission'; end if;
  return v_sub;
end;
$$;

-- Safety net: if the evaluator cannot be reached, the member's client parks the
-- submission for a human instead of leaving it stuck in 'pending_ai'.
create or replace function public.park_for_review(p_submission_id uuid)
returns public.submission
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
  v_sub public.submission;
begin
  if v_uid is null then raise exception 'Not authenticated'; end if;
  update public.submission
     set status = 'pending_review'
   where id = p_submission_id and user_id = v_uid and status = 'pending_ai'
  returning * into v_sub;
  if not found then
    select * into v_sub from public.submission where id = p_submission_id and user_id = v_uid;
  end if;
  return v_sub;
end;
$$;

revoke all on function public.request_recheck(uuid) from public, anon;
grant execute on function public.request_recheck(uuid) to authenticated;
revoke all on function public.park_for_review(uuid) from public, anon;
grant execute on function public.park_for_review(uuid) to authenticated;
