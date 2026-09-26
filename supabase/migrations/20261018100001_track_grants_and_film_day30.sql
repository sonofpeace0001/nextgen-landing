-- 1) Per-member, per-track access grants. Used to keep General AI open for members who had already passed
--    day 10 before the lock, without giving them full access to the paid categories or the Library.
create table if not exists public.track_grant (
  user_id    uuid not null references auth.users(id) on delete cascade,
  track_id   uuid not null references public.track(id) on delete cascade,
  reason     text,
  created_at timestamptz not null default now(),
  primary key (user_id, track_id)
);
alter table public.track_grant enable row level security;
drop policy if exists "track_grant owner read" on public.track_grant;
create policy "track_grant owner read" on public.track_grant for select to authenticated using (auth.uid() = user_id);
drop policy if exists "track_grant admin all" on public.track_grant;
create policy "track_grant admin all" on public.track_grant for all to authenticated using (public.is_admin()) with check (public.is_admin());

create or replace function public.has_track_grant(p_track uuid, uid uuid default auth.uid())
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (select 1 from public.track_grant g where g.user_id = uid and g.track_id = p_track);
$$;
revoke all on function public.has_track_grant(uuid, uuid) from public;
grant execute on function public.has_track_grant(uuid, uuid) to anon, authenticated;

-- Lessons: locked unless full access or a grant for this track.
drop policy if exists "day read published" on public.day;
create policy "day read published" on public.day
  for select to anon, authenticated
  using (
    is_published
    and (
      not exists (
        select 1 from public.track t
         where t.id = day.track_id
           and (t.requires_access or (t.free_days is not null and day.day_number > t.free_days))
      )
      or public.has_full_access()
      or public.has_track_grant(day.track_id)
    )
  );

create or replace function public.enforce_day_access()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  v_locked boolean;
  v_track  uuid;
begin
  if auth.uid() is null then
    return new;
  end if;
  select (t.requires_access or (t.free_days is not null and d.day_number > t.free_days)), t.id
    into v_locked, v_track
    from public.day d
    join public.track t on t.id = d.track_id
   where d.id = new.day_id;
  if coalesce(v_locked, false)
     and not public.has_full_access(auth.uid())
     and not public.has_track_grant(v_track, auth.uid()) then
    raise exception 'This lesson is for Elite and VIP members.';
  end if;
  return new;
end;
$$;

-- Members who had already worked past day 9 of General AI keep access to General AI.
insert into public.track_grant (user_id, track_id, reason)
select distinct s.user_id, t.id, 'Reached General AI day 10+ before the lock'
  from public.submission s
  join public.day d   on d.id = s.day_id
  join public.track t on t.id = d.track_id
 where t.slug = 'ai' and d.day_number >= 10
on conflict do nothing;

-- 2) Republish AI film & video, Capstone day 30.
update public.day d
   set is_published = true
  from public.track t
 where t.id = d.track_id and t.slug = 'film' and d.day_number = 30;
