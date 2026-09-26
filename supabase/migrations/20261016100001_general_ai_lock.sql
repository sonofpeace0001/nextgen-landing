-- General AI (the original AI track): renamed, and locked from day 10. Days 1-9 stay free for signed-in
-- members; day 10 onward needs Elite or an access code (same rule as the category paths).

alter table public.track add column if not exists free_days int;  -- null = no day limit

update public.track set title = 'General AI', free_days = 9 where slug = 'ai';

-- Lessons: a day is readable when published and not locked. Locked = the track requires access, or the day
-- number is past the track's free_days. Full access (Elite, admin, code) always reads it.
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
    )
  );

-- Submitting to a locked day is refused too (the lesson is hidden, but never trust the client).
-- Service-role writes (the scorer, admin) have no auth.uid() and pass through.
create or replace function public.enforce_day_access()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  v_locked boolean;
begin
  if auth.uid() is null then
    return new;
  end if;
  select (t.requires_access or (t.free_days is not null and d.day_number > t.free_days))
    into v_locked
    from public.day d
    join public.track t on t.id = d.track_id
   where d.id = new.day_id;
  if coalesce(v_locked, false) and not public.has_full_access(auth.uid()) then
    raise exception 'This lesson is for Elite members and access-code holders.';
  end if;
  return new;
end;
$$;

drop trigger if exists submission_enforce_day_access on public.submission;
create trigger submission_enforce_day_access
  before insert or update of day_id on public.submission
  for each row execute function public.enforce_day_access();
