-- Phase 1 · Seed scaffold. Proves the schema round-trips end to end.
-- This is a SHELL, not the real curriculum (that's Phase 6). Idempotent-ish:
-- safe to run on a fresh local `supabase db reset`.

insert into public.track (slug, title, description, sort_order, is_published)
values ('ai', 'AI', 'Practical AI skills, from your first prompt to shipping agents.', 1, true)
on conflict (slug) do nothing;

with tr as (select id from public.track where slug = 'ai')
insert into public.tier (track_id, slug, title, ordinal)
select tr.id, v.slug::tier_slug, v.title, v.ordinal
from tr,
  (values ('basic','Basic',1), ('pro','Pro',2), ('expert','Expert',3), ('grandmaster','Grandmaster',4)) as v(slug, title, ordinal)
on conflict (track_id, slug) do nothing;

with tr as (select id from public.track where slug = 'ai'),
     ti as (select id from public.tier where track_id = (select id from tr) and slug = 'basic')
insert into public.day (track_id, tier_id, day_number, objective, lesson_md, skill_focus, assignment_md, rubric, est_minutes, is_published)
select
  (select id from tr),
  (select id from ti),
  1,
  'Understand the AI landscape and pick the right model for a task.',
  '# Day 1\nChatGPT, Claude, Gemini, Grok — strengths and when to use which.',
  'Choosing the right tool instead of defaulting to one.',
  'Write 3 tasks and name which model you would use and why.',
  '[{"criterion":"Reasoning for each choice","max_points":10,"guidance":"Clear, specific justification."}]'::jsonb,
  25,
  true
on conflict (track_id, day_number) do nothing;
