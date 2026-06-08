-- Phase 1 · Row-Level Security. Authorization lives in the database:
-- content is world-readable only when published; all user data is owner-only.
-- service_role bypasses RLS and is used only server-side (seeds, tests, future RPCs).

alter table public.track      enable row level security;
alter table public.tier       enable row level security;
alter table public.day        enable row level security;
alter table public.day_check  enable row level security;
alter table public.profile    enable row level security;
alter table public.enrollment enable row level security;
alter table public.submission enable row level security;

-- ── Content: public read when published. No write policies => only service_role writes. ──
create policy "track read published" on public.track
  for select to anon, authenticated
  using (is_published);

create policy "tier read when track published" on public.tier
  for select to anon, authenticated
  using (exists (select 1 from public.track t where t.id = tier.track_id and t.is_published));

create policy "day read published" on public.day
  for select to anon, authenticated
  using (is_published);

create policy "day_check read when day published" on public.day_check
  for select to anon, authenticated
  using (exists (select 1 from public.day d where d.id = day_check.day_id and d.is_published));

-- ── Profile: owner only. ──
create policy "profile owner select" on public.profile
  for select to authenticated using (auth.uid() = id);
create policy "profile owner insert" on public.profile
  for insert to authenticated with check (auth.uid() = id);
create policy "profile owner update" on public.profile
  for update to authenticated using (auth.uid() = id) with check (auth.uid() = id);

-- ── Enrollment: owner only. ──
create policy "enrollment owner select" on public.enrollment
  for select to authenticated using (auth.uid() = user_id);
create policy "enrollment owner insert" on public.enrollment
  for insert to authenticated with check (auth.uid() = user_id);
create policy "enrollment owner update" on public.enrollment
  for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- ── Submission: owner only, and the enrollment must belong to the same user. ──
-- NOTE (Phase 4): final score/check_score/status will be set by a server-side
-- security-definer RPC, and this UPDATE policy tightened so students can't grade
-- themselves. For Phase 1 the baseline is owner-only.
create policy "submission owner select" on public.submission
  for select to authenticated using (auth.uid() = user_id);
create policy "submission owner insert" on public.submission
  for insert to authenticated
  with check (
    auth.uid() = user_id
    and exists (
      select 1 from public.enrollment e
      where e.id = submission.enrollment_id and e.user_id = auth.uid()
    )
  );
create policy "submission owner update" on public.submission
  for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
