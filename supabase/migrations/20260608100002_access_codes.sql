-- Elite/Admin Phase 1 · per-user single-use redemption codes.

create table public.access_code (
  id         uuid primary key default gen_random_uuid(),
  code       text not null unique,
  grants     text not null default 'elite',
  max_uses   int  not null default 1 check (max_uses >= 1),
  used_count int  not null default 0 check (used_count >= 0),
  expires_at timestamptz,
  revoked    boolean not null default false,
  created_by uuid references auth.users(id),
  created_at timestamptz not null default now()
);

create table public.redemption (
  id          uuid primary key default gen_random_uuid(),
  code_id     uuid not null references public.access_code(id) on delete cascade,
  user_id     uuid not null references auth.users(id) on delete cascade,
  redeemed_at timestamptz not null default now(),
  unique (code_id, user_id)
);

create index redemption_user_idx on public.redemption (user_id);
create index redemption_code_idx on public.redemption (code_id);

-- RLS on; policies added in the next migration (need is_admin()). Until then RLS
-- denies all to anon/authenticated => only service_role / definer functions touch these.
alter table public.access_code enable row level security;
alter table public.redemption  enable row level security;
