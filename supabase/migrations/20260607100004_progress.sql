-- Phase 1 · Progress view, derived from submissions.
-- security_invoker = on  => the querying user's RLS on enrollment/submission
-- applies, so each user only ever sees their own progress rows.
-- NOTE: streak (consecutive active days) is intentionally left to the app/dashboard
-- layer in Phase 5; it needs date-window logic that doesn't belong in this view yet.

create view public.progress
  with (security_invoker = on) as
select
  e.id                                as enrollment_id,
  e.user_id                           as user_id,
  e.track_id                          as track_id,
  e.current_day                       as current_day,
  e.total_days                        as total_days,
  e.status                            as status,
  count(s.id)                         as days_scored,
  coalesce(sum(s.score), 0)           as cumulative_score,
  coalesce(round(avg(s.score), 1), 0) as average_score,
  coalesce(max(t.ordinal), 0)         as tier_reached
from public.enrollment e
left join public.submission s on s.enrollment_id = e.id and s.status = 'scored'
left join public.day  d on d.id = s.day_id
left join public.tier t on t.id = d.tier_id
group by e.id;

grant select on public.progress to authenticated;
