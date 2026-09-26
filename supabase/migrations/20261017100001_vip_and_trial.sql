-- VIP members get full access, and 14-day free trial codes.
--
-- Full access = Elite, VIP, admin, someone who unlocked with the library code, or a member whose free trial
-- is still running. A trial starts when the member enters a trial code, lasts trial_days (14) and is
-- one per member, ever. When it ends, access ends unless they are Elite or VIP.

alter table public.profile     add column if not exists is_vip        boolean not null default false;
alter table public.profile     add column if not exists trial_ends_at timestamptz;
alter table public.access_code add column if not exists trial_days    int;

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
      from public.profile p where p.id = uid
  ), false);
$$;

-- What the UI needs to know: are they in, why, and when does a trial end.
create or replace function public.my_access_status()
returns jsonb
language plpgsql
stable
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
  p     public.profile;
  src   text := 'none';
begin
  if v_uid is null then
    return jsonb_build_object('signed_in', false, 'full', false, 'source', 'none');
  end if;
  select * into p from public.profile where id = v_uid;
  if p.is_admin then src := 'admin';
  elsif p.is_elite then src := 'elite';
  elsif p.is_vip then src := 'vip';
  elsif p.library_access then src := 'code';
  elsif p.trial_ends_at is not null and p.trial_ends_at > now() then src := 'trial';
  end if;
  return jsonb_build_object(
    'signed_in', true,
    'full', src <> 'none',
    'source', src,
    'trial_ends_at', p.trial_ends_at,
    'trial_used', p.trial_ends_at is not null
  );
end;
$$;
revoke all on function public.my_access_status() from public, anon;
grant execute on function public.my_access_status() to authenticated;

-- SECURITY: redeem_code makes the caller permanently Elite whatever the code grants. Trial codes must never
-- go through it, or anyone could turn the public trial code into lifetime Elite.
create or replace function public.redeem_code(p_code text)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid  uuid := auth.uid();
  v_code public.access_code;
begin
  if v_uid is null then raise exception 'Not authenticated'; end if;

  select * into v_code from public.access_code where code = p_code for update;
  if not found then raise exception 'Invalid code'; end if;
  if v_code.grants = 'trial' then raise exception 'Invalid code'; end if;
  if v_code.revoked then raise exception 'Code revoked'; end if;
  if v_code.expires_at is not null and v_code.expires_at < now() then raise exception 'Code expired'; end if;
  if v_code.used_count >= v_code.max_uses then raise exception 'Code fully used'; end if;
  if exists (select 1 from public.redemption r where r.code_id = v_code.id and r.user_id = v_uid) then
    raise exception 'Already redeemed';
  end if;

  insert into public.redemption (code_id, user_id) values (v_code.id, v_uid);
  update public.access_code set used_count = used_count + 1 where id = v_code.id;
  update public.profile set is_elite = true where id = v_uid;

  return jsonb_build_object('ok', true, 'grants', v_code.grants);
end;
$$;
revoke all on function public.redeem_code(text) from public, anon;
grant execute on function public.redeem_code(text) to authenticated;

-- unlock_access: also accepts trial codes (grants = 'trial'); everything else behaves as before.
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
  v_code   public.access_code;
  v_prof   public.profile;
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

  -- Free trial codes.
  select * into v_code from public.access_code
   where lower(code) = v_norm and grants = 'trial' for update;
  if found then
    if v_code.revoked or (v_code.expires_at is not null and v_code.expires_at < now())
       or v_code.used_count >= v_code.max_uses then
      insert into public.access_attempt (user_id, ok) values (v_uid, false);
      return false;
    end if;
    select * into v_prof from public.profile where id = v_uid;
    if v_prof.is_elite or v_prof.is_vip or v_prof.is_admin then
      return true; -- already has full access; nothing to start
    end if;
    if v_prof.trial_ends_at is not null then
      raise exception 'You have already used your free trial. Join Elite or VIP to keep learning.';
    end if;
    insert into public.redemption (code_id, user_id) values (v_code.id, v_uid) on conflict do nothing;
    update public.access_code set used_count = used_count + 1 where id = v_code.id;
    update public.profile set trial_ends_at = now() + make_interval(days => coalesce(v_code.trial_days, 14)) where id = v_uid;
    insert into public.access_attempt (user_id, ok) values (v_uid, true);
    return true;
  end if;

  -- Shared library code.
  select lower(trim(value)) into v_shared from public.site_settings where key = 'elite_prompt_code';
  if v_shared is not null and v_shared not in ('', 'changeme') and v_norm = v_shared then
    update public.profile set library_access = true where id = v_uid;
    insert into public.access_attempt (user_id, ok) values (v_uid, true);
    return true;
  end if;

  -- Single-use Elite redeem codes.
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

-- The 14-day trial code (rotate or add more in Admin > Codes).
insert into public.access_code (code, grants, max_uses, trial_days)
values ('NEXTGEN14', 'trial', 1000000, 14)
on conflict (code) do nothing;
