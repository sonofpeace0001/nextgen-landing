-- Elite/Admin Phase 1 · profile flags, email, auto-provisioning, column lockdown.

alter table public.profile
  add column is_elite boolean not null default false,
  add column is_admin boolean not null default false,
  add column email text;

-- Every new auth user gets a profile row; copy their email for the admin members list.
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profile (id, email)
  values (new.id, new.email)
  on conflict (id) do update set email = excluded.email;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- Backfill any existing users.
insert into public.profile (id, email)
select u.id, u.email from auth.users u
on conflict (id) do update set email = excluded.email;

-- A user may only edit display_name on their own profile — NEVER is_elite / is_admin / email.
-- (RLS limits them to their own row; column grants limit which columns.)
revoke update on public.profile from authenticated;
grant update (display_name) on public.profile to authenticated;
