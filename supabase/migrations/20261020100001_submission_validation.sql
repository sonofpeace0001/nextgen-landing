-- Submission fixes found in the submissions audit:
--  1) A too-short answer ("Not bad") used to be accepted and scored. Answers need at least 20 characters.
--  2) Link days accepted text with no link. They now need a link, so a reviewer always has something to open.
--  3) Failing a quiz told the member nothing. The submission now carries a plain message with the score, the
--     pass mark and which question numbers to recheck (never the answers).
--  4) Foundations Day 3 had a 100% pass mark on a 2-question quiz; one member was stuck for six attempts.
-- Everything else in submit_day is unchanged.

update public.day_check dc
   set pass_pct = 50
  from public.day d, public.track t
 where d.id = dc.day_id and t.id = d.track_id and t.slug = 'foundations' and d.day_number = 3;

create or replace function public.submit_day(
  p_enrollment_id uuid,
  p_day_id uuid,
  p_content text,
  p_self_score numeric default null,
  p_answers jsonb default '[]'::jsonb
)
returns public.submission
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
  v_wrong text := '';
  v_feedback text := null;
  v_pass numeric;
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

  if length(btrim(coalesce(p_content, ''))) < 20 then
    raise exception 'Write a little more (at least 20 characters) so your work can be scored.';
  end if;
  if v_day.submission_type = 'link' and coalesce(p_content, '') !~* 'https?://' then
    raise exception 'This assignment needs a link. Paste the link to your work (it starts with http).';
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
          else
            v_wrong := v_wrong || case when v_wrong = '' then '' else ', ' end || (v_i + 1)::text;
          end if;
        elsif v_check.type = 'checklist' then
          if (p_answers -> v_i)::text = 'true' then
            v_correct := v_correct + 1;
          else
            v_wrong := v_wrong || case when v_wrong = '' then '' else ', ' end || (v_i + 1)::text;
          end if;
        end if;
      end loop;
      v_check_score := round(v_correct * 100.0 / v_total);
    end if;
    v_pass := coalesce(v_check.pass_pct, 70);
    v_passed := coalesce(v_check_score, 0) >= v_pass;
    if not v_passed then
      v_feedback := format(
        'You got %s of %s quiz questions right (%s%%). You need %s%% to move on. Recheck %s %s, then submit again.',
        v_correct, v_total, coalesce(v_check_score, 0), v_pass,
        case when position(',' in v_wrong) > 0 then 'questions' else 'question' end,
        case when v_wrong = '' then '1' else v_wrong end);
    end if;
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
    v_feedback := null;
  elsif v_day.ai_evaluate and v_passed then
    -- AI-evaluated days: the evaluator sets the score. (A failed quiz gate still
    -- needs revision first, so it never reaches the evaluator.)
    v_status := 'pending_ai'::submission_status;
    v_score := null;
  end if;

  insert into public.submission
    (enrollment_id, user_id, day_id, content, check_score, self_score, score, status, feedback, submitted_at)
  values
    (p_enrollment_id, v_uid, p_day_id, p_content, v_check_score, v_self, v_score, v_status, v_feedback, now())
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
        feedback = excluded.feedback,
        ai_scores = null,
        ai_feedback = null,
        ai_model = null,
        ai_confidence = null,
        ai_evaluated_at = null,
        share_status = 'private'
  returning * into v_sub;

  select count(*) into v_done from public.submission
    where enrollment_id = p_enrollment_id and status = 'scored'; -- only approved work counts
  update public.enrollment
    set current_day = least(greatest(v_done + 1, 1), total_days),
        status = case when v_done >= total_days then 'completed'::enrollment_status else status end
    where id = p_enrollment_id;

  return v_sub;
end;
$$;
