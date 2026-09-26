-- Lock the Library (resources + prompts) and every goal category after Foundations behind
-- Elite membership or an access code. Enforced in the database, not just the UI.
--
-- Who has full access: an Elite member, an admin, or anyone who has unlocked with the library
-- code (site_settings.elite_prompt_code) or a valid redeem code.
-- Free for every signed-in member: Foundations and the original AI track.

alter table public.track   add column if not exists requires_access boolean not null default false;
alter table public.profile add column if not exists library_access  boolean not null default false;

update public.track set requires_access = true
 where slug in ('graphics','content','apps','agents','film','motion','audio','research','business');

-- Failed/successful unlock attempts (rate limiting). No policies: only definer functions touch it.
create table if not exists public.access_attempt (
  id         bigserial primary key,
  user_id    uuid not null references auth.users(id) on delete cascade,
  ok         boolean not null,
  created_at timestamptz not null default now()
);
alter table public.access_attempt enable row level security;
create index if not exists access_attempt_user_idx on public.access_attempt (user_id, created_at);

create or replace function public.has_full_access(uid uuid default auth.uid())
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select coalesce((select p.is_elite or p.library_access or p.is_admin from public.profile p where p.id = uid), false);
$$;
revoke all on function public.has_full_access(uuid) from public;
grant execute on function public.has_full_access(uuid) to anon, authenticated;

-- Unlock with the shared library code or a single-use redeem code. Returns true/false; never raises
-- for a wrong code so the attempt is always recorded. Eight wrong tries in ten minutes pause the caller.
create or replace function public.unlock_access(p_code text)
returns boolean
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid    uuid := auth.uid();
  v_norm   text := lower(trim(coalesce(p_code, '')));
  v_shared text;
begin
  if v_uid is null then
    raise exception 'Not authenticated';
  end if;
  if (select count(*) from public.access_attempt a
       where a.user_id = v_uid and not a.ok and a.created_at > now() - interval '10 minutes') >= 8 then
    raise exception 'Too many attempts. Try again in a few minutes.';
  end if;
  if v_norm = '' then
    return false;
  end if;

  select lower(trim(value)) into v_shared from public.site_settings where key = 'elite_prompt_code';
  if v_shared is not null and v_shared not in ('', 'changeme') and v_norm = v_shared then
    update public.profile set library_access = true where id = v_uid;
    insert into public.access_attempt (user_id, ok) values (v_uid, true);
    return true;
  end if;

  begin
    perform public.redeem_code(trim(p_code));
    insert into public.access_attempt (user_id, ok) values (v_uid, true);
    return true;
  exception when others then
    insert into public.access_attempt (user_id, ok) values (v_uid, false);
    return false;
  end;
end;
$$;
revoke all on function public.unlock_access(text) from public, anon;
grant execute on function public.unlock_access(text) to authenticated;

-- The shared code must not be readable through the public API.
drop policy if exists "site_settings readable by all" on public.site_settings;
create policy "site_settings readable by all" on public.site_settings
  for select to anon, authenticated
  using (key <> 'elite_prompt_code');

-- Library content: only members with full access.
drop policy if exists "prompt_categories readable by all"    on public.prompt_categories;
drop policy if exists "prompt_subcategories readable by all" on public.prompt_subcategories;
drop policy if exists "prompts readable by all"              on public.prompts;
drop policy if exists "resource readable by all"             on public.resource;
create policy "prompt_categories for full access"    on public.prompt_categories    for select to authenticated using (public.has_full_access());
create policy "prompt_subcategories for full access" on public.prompt_subcategories for select to authenticated using (public.has_full_access());
create policy "prompts for full access"              on public.prompts              for select to authenticated using (public.has_full_access());
create policy "resource for full access"             on public.resource             for select to authenticated using (is_published and public.has_full_access());

-- Lessons of locked categories are only readable with full access (day_check follows via its day subquery).
drop policy if exists "day read published" on public.day;
create policy "day read published" on public.day
  for select to anon, authenticated
  using (
    is_published
    and (
      not exists (select 1 from public.track t where t.id = day.track_id and t.requires_access)
      or public.has_full_access()
    )
  );

-- Enrolling in a locked category needs full access (on top of the existing Elite rule for non-Novice entry).
drop policy if exists "enrollment owner insert" on public.enrollment;
create policy "enrollment owner insert" on public.enrollment
  for insert to authenticated
  with check (
    auth.uid() = user_id
    and (
      entry_level = 'novice'
      or coalesce((select p.is_elite from public.profile p where p.id = auth.uid()), false)
    )
    and (
      not exists (select 1 from public.track t where t.id = enrollment.track_id and t.requires_access)
      or public.has_full_access()
    )
  );
