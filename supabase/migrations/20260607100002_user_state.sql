-- Phase 1 · User-state tables (per-user runtime data; RLS-protected in 0003).

create type entry_level       as enum ('novice', 'intermediate', 'advanced');
create type enrollment_status as enum ('active', 'paused', 'completed');
create type unlock_mode       as enum ('completion_capped', 'date', 'completion');
create type submission_status as enum ('submitted', 'scored', 'needs_revision');

create table public.profile (
  id           uuid primary key references auth.users(id) on delete cascade,
  display_name text,
  created_at   timestamptz not null default now()
);

-- user + track + chosen level + dated path + position + status.
create table public.enrollment (
  id            uuid primary key default gen_random_uuid(),
  user_id       uuid not null references auth.users(id) on delete cascade,
  track_id      uuid not null references public.track(id) on delete restrict,
  entry_level   entry_level not null,
  start_tier_id uuid not null references public.tier(id),
  start_date    date not null default current_date,
  total_days    int  not null check (total_days > 0),
  current_day   int  not null default 1 check (current_day >= 1),
  unlock_mode   unlock_mode not null default 'completion_capped',
  status        enrollment_status not null default 'active',
  created_at    timestamptz not null default now(),
  unique (user_id, track_id)   -- one enrollment per track per user
);

create index enrollment_user_idx on public.enrollment (user_id);

-- user + day + content + score + feedback + timestamp.
-- check_score = auto-graded; self_score = student self-rating; score = final composite.
create table public.submission (
  id            uuid primary key default gen_random_uuid(),
  enrollment_id uuid not null references public.enrollment(id) on delete cascade,
  user_id       uuid not null references auth.users(id) on delete cascade,
  day_id        uuid not null references public.day(id) on delete restrict,
  content       text,
  check_score   numeric check (check_score between 0 and 100),
  self_score    numeric check (self_score  between 0 and 100),
  score         numeric check (score       between 0 and 100),
  max_score     numeric not null default 100,
  feedback      text,
  status        submission_status not null default 'submitted',
  submitted_at  timestamptz not null default now(),
  unique (enrollment_id, day_id)
);

create index submission_user_idx       on public.submission (user_id);
create index submission_enrollment_idx on public.submission (enrollment_id);
