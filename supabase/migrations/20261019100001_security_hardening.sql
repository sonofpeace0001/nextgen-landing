-- Hardening from the Supabase security advisor.
--
-- 1) Internal trigger functions must not be callable through the API.
revoke all on function public.enforce_day_access() from public, anon, authenticated;
revoke all on function public.handle_new_user()    from public, anon, authenticated;
revoke all on function public.rls_auto_enable()    from public, anon, authenticated;

-- 2) has_full_access / has_track_grant back RLS policies, so anon/authenticated must keep EXECUTE, but they
--    must only ever answer for the caller: nobody can probe whether another user id is Elite or granted.
create or replace function public.has_full_access(uid uuid default auth.uid())
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select coalesce((
    select p.is_elite or p.is_vip or p.library_access or p.is_admin
           or (p.trial_ends_at is not null and p.trial_ends_at > now())
      from public.profile p
     where p.id = uid and uid is not distinct from auth.uid()
  ), false);
$$;

create or replace function public.has_track_grant(p_track uuid, uid uuid default auth.uid())
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1 from public.track_grant g
     where g.user_id = uid and g.track_id = p_track and uid is not distinct from auth.uid()
  );
$$;
