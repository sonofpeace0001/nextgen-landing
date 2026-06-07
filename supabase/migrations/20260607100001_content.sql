-- Phase 1 · Content tables (authored, data-driven).
-- These hold curriculum and are managed via SQL seeds / service_role,
-- NOT written by end users. Non-devs add tracks/tiers/days here.

create type tier_slug as enum ('basic', 'pro', 'expert', 'grandmaster');
create type check_type as enum ('mcq', 'checklist');

-- A track is a niche path (Freelancing, Web3, AI, ...). Data-driven: add rows, no code.
create table public.track (
  id           uuid primary key default gen_random_uuid(),
  slug         text not null unique,
  title        text not null,
  description  text,
  sort_order   int  not null default 0,
  is_published boolean not null default false,
  created_at   timestamptz not null default now()
);

-- Ordered stages within a track: basic -> pro -> expert -> grandmaster.
create table public.tier (
  id        uuid primary key default gen_random_uuid(),
  track_id  uuid not null references public.track(id) on delete cascade,
  slug      tier_slug not null,
  title     text not null,
  ordinal   int  not null check (ordinal between 1 and 4),
  unique (track_id, slug),
  unique (track_id, ordinal)
);

-- A day: the four parts — objective + lesson (what to learn), skill_focus
-- (what to improve), assignment (what to do), rubric (how it's scored).
create table public.day (
  id            uuid primary key default gen_random_uuid(),
  track_id      uuid not null references public.track(id) on delete cascade,
  tier_id       uuid not null references public.tier(id) on delete cascade,
  day_number    int  not null check (day_number >= 1),
  objective     text not null,
  lesson_md     text not null,
  skill_focus   text not null,
  assignment_md text not null,
  rubric        jsonb not null default '[]'::jsonb,   -- [{criterion, max_points, guidance}]
  est_minutes   int,
  is_published  boolean not null default false,
  created_at    timestamptz not null default now(),
  unique (track_id, day_number)
);

create index day_track_idx on public.day (track_id, day_number);
create index day_tier_idx  on public.day (tier_id);

-- Optional auto-graded gate attached to a day (MCQ or checklist).
create table public.day_check (
  id       uuid primary key default gen_random_uuid(),
  day_id   uuid not null references public.day(id) on delete cascade,
  type     check_type not null,
  items    jsonb not null default '[]'::jsonb,   -- mcq: [{q,options,answer,explain}]; checklist: [{text}]
  pass_pct numeric not null default 70 check (pass_pct between 0 and 100)
);

create index day_check_day_idx on public.day_check (day_id);
