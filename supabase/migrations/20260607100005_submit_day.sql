-- Phase 4 · Secure submission + scoring.
-- All submission writes go through submit_day(), a SECURITY DEFINER function that
-- auto-grades server-side. Direct INSERT/UPDATE on submission is removed so a student
-- can never set their own score. SELECT stays owner-only (from Phase 1).

drop policy if exists "submission owner insert" on public.submission;
drop policy if exists "submission owner update" on public.submission;

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
  if v_uid is null then
    raise exception 'Not authenticated';
  end if;

  -- Authorization: the enrollment must belong to the caller (anti-IDOR).
  select * into v_enr from public.enrollment where id = p_enrollment_id;
  if not found or v_enr.user_id <> v_uid then
    raise exception 'Not authorized for this enrollment';
  end if;

  -- The day must belong to the enrollment's track and be published.
  select * into v_day from public.day
    where id = p_day_id and track_id = v_enr.track_id and is_published;
  if not found then
    raise exception 'Day not found in this track';
  end if;

  if v_self is not null and (v_self < 0 or v_self > 100) then
    raise exception 'self_score out of range';
  end if;

  -- Auto-grade the optional check (server-side, trusted).
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
          if (p_answers -> v_i)::text = 'true' then
            v_correct := v_correct + 1;
          end if;
        end if;
      end loop;
      v_check_score := round(v_correct * 100.0 / v_total);
    end if;
    v_passed := coalesce(v_check_score, 0) >= coalesce(v_check.pass_pct, 70);
  end if;

  -- Composite final score.
  if v_check_score is not null and v_self is not null then
    v_score := round((v_check_score + v_self) / 2.0);
  elsif v_check_score is not null then
    v_score := v_check_score;
  elsif v_self is not null then
    v_score := v_self;
  end if;

  v_status := (case when v_passed then 'scored' else 'needs_revision' end)::submission_status;

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
        submitted_at = now()
  returning * into v_sub;

  -- Best-effort progress pointer = distinct passed days + 1 (authoritative progress
  -- is computed from submissions in the dashboard).
  select count(*) into v_done from public.submission
    where enrollment_id = p_enrollment_id and status = 'scored';
  update public.enrollment
    set current_day = least(greatest(v_done + 1, 1), total_days),
        status = case when v_done >= total_days then 'completed'::enrollment_status else status end
    where id = p_enrollment_id;

  return v_sub;
end;
$$;

revoke all on function public.submit_day(uuid, uuid, text, numeric, jsonb) from public, anon;
grant execute on function public.submit_day(uuid, uuid, text, numeric, jsonb) to authenticated;
