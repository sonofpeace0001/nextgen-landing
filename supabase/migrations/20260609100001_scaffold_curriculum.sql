-- Curriculum scaffold: empty, UNPUBLISHED day frames across all tracks/tiers.
-- NO instructional content — the admin authors lessons in the dashboard.
--
-- Per-tier day ranges derive from the spanning-path model (ENTRY_LEVELS config:
-- novice=90 from basic, intermediate=60 from pro, advanced=30 from expert):
--   basic 1-30 · pro 31-60 · expert 61-80 · grandmaster 81-90  (90/track)
-- Idempotent: ON CONFLICT (track_id, day_number) DO NOTHING protects the 24
-- authored AI Basic days (and any future authored day) from being touched.

-- Day title for the admin content list (placeholder until authored).
alter table public.day add column if not exists title text;

-- Web3 + Freelancing tracks: created UNPUBLISHED (invisible to members; the
-- existing publish gates keep everything locked until real content ships).
insert into public.track (slug, title, description, sort_order, is_published) values
  ('web3', 'Web3', 'From wallets and self-custody to building and earning on-chain.', 2, false),
  ('freelancing', 'Freelancing', 'Turn a skill into paid client work, then scale it into a business.', 3, false)
on conflict (slug) do nothing;

-- All four tiers for every track (AI's already exist; conflict-safe).
insert into public.tier (track_id, slug, title, ordinal)
select t.id, v.slug::tier_slug, v.title, v.ordinal
from public.track t,
  (values ('basic','Basic',1), ('pro','Pro',2), ('expert','Expert',3), ('grandmaster','Grandmaster',4)) as v(slug, title, ordinal)
where t.slug in ('ai', 'web3', 'freelancing')
on conflict (track_id, slug) do nothing;

-- Empty day frames, tagged track+tier+day_number, all unpublished.
with ranges(tier_slug, from_n, to_n) as (
  values ('basic', 1, 30), ('pro', 31, 60), ('expert', 61, 80), ('grandmaster', 81, 90)
)
insert into public.day
  (track_id, tier_id, day_number, title, objective, lesson_md, skill_focus, assignment_md, rubric, is_published)
select
  tr.id,
  ti.id,
  n,
  'Day ' || n || ' — untitled',
  '', '', '', '',
  '[]'::jsonb,
  false
from public.track tr
join public.tier ti on ti.track_id = tr.id
join ranges r on r.tier_slug = ti.slug::text
cross join lateral generate_series(r.from_n, r.to_n) as n
where tr.slug in ('ai', 'web3', 'freelancing')
on conflict (track_id, day_number) do nothing;
