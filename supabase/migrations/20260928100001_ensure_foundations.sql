-- Every member is enrolled in Foundations (the 3-day "start here" track) automatically.
-- Called by the Academy on load: safe to call repeatedly, and a no-op until Foundations
-- is published. Keeps total_days in step as days are added.
create or replace function public.ensure_foundations()
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_user uuid := auth.uid();
  v_track uuid;
  v_tier uuid;
  v_days int;
  v_id uuid;
begin
  if v_user is null then
    return null;
  end if;

  select id into v_track from public.track where slug = 'foundations' and is_published;
  if v_track is null then
    return null;
  end if;

  select count(*) into v_days from public.day where track_id = v_track and is_published;
  if v_days = 0 then
    return null;
  end if;

  select id into v_tier from public.tier where track_id = v_track and slug = 'basic';
  if v_tier is null then
    return null;
  end if;

  insert into public.enrollment (user_id, track_id, entry_level, start_tier_id, total_days)
  values (v_user, v_track, 'novice', v_tier, v_days)
  on conflict (user_id, track_id)
  do update set total_days = greatest(public.enrollment.total_days, excluded.total_days)
  returning id into v_id;

  return v_id;
end;
$$;

revoke all on function public.ensure_foundations() from public, anon;
grant execute on function public.ensure_foundations() to authenticated;
