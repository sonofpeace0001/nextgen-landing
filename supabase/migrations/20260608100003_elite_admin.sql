-- Elite/Admin Phase 1 · helper, redeem RPC, review schema, gates, admin policies.

-- Admin check. SECURITY DEFINER so it reads profile bypassing RLS (no policy recursion).
create or replace function public.is_admin(uid uuid default auth.uid())
returns boolean
language sql
security definer
set search_path = public
stable
as $$
  select coalesce((select p.is_admin from public.profile p where p.id = uid), false);
$$;
grant execute on function public.is_admin(uuid) to authenticated, anon;

-- Redeem a code: all validation server-side; flips the caller's is_elite.
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

-- Instructor-review schema.
alter table public.day add column requires_review boolean not null default false;
alter type submission_status add value if not exists 'pending_review';
alter table public.submission
  add column reviewed_by uuid references auth.users(id),
  add column reviewed_at timestamptz;

-- Elite gate (DB-enforced, un-bypassable): non-Novice enrollment requires is_elite.
drop policy if exists "enrollment owner insert" on public.enrollment;
create policy "enrollment owner insert" on public.enrollment
  for insert to authenticated
  with check (
    auth.uid() = user_id
    and (
      entry_level = 'novice'
      or coalesce((select p.is_elite from public.profile p where p.id = auth.uid()), false)
    )
  );

-- Admin reads across user data (for the dashboard).
create policy "profile admin read"    on public.profile    for select to authenticated using (public.is_admin());
create policy "enrollment admin read" on public.enrollment for select to authenticated using (public.is_admin());
create policy "submission admin read" on public.submission for select to authenticated using (public.is_admin());

-- Admin writes on content (RLS backstop; edge functions use service_role).
create policy "track admin write"     on public.track     for all to authenticated using (public.is_admin()) with check (public.is_admin());
create policy "tier admin write"      on public.tier      for all to authenticated using (public.is_admin()) with check (public.is_admin());
create policy "day admin write"       on public.day       for all to authenticated using (public.is_admin()) with check (public.is_admin());
create policy "day_check admin write" on public.day_check for all to authenticated using (public.is_admin()) with check (public.is_admin());

-- Codes: admin-managed; a user may read their own redemptions.
create policy "access_code admin all"   on public.access_code for all    to authenticated using (public.is_admin()) with check (public.is_admin());
create policy "redemption admin read"   on public.redemption  for select to authenticated using (public.is_admin());
create policy "redemption owner read"   on public.redemption  for select to authenticated using (auth.uid() = user_id);
