-- Small editable key/value settings read by the marketing site (currently the
-- VIP section: intake date, seats left, checkout/waitlist URLs). Values are
-- edited ONLY via the Supabase dashboard (Studio -> Table editor), where the
-- service role bypasses RLS. The browser (anon) gets read-only access via the
-- single SELECT policy below; there are deliberately NO insert/update/delete
-- policies for anon or authenticated.
create table public.site_settings (
  key        text primary key,
  value      text not null,
  updated_at timestamptz default now()
);

alter table public.site_settings enable row level security;

create policy "site_settings readable by all"
  on public.site_settings for select
  to anon, authenticated
  using (true);

insert into public.site_settings (key, value) values
  ('vip_intake_date', 'TBA'),
  ('vip_seats_left',  '8'),
  ('vip_checkout_url', '#'),
  ('vip_waitlist_url', '#');
