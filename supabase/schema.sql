
-- =========================================
-- MITHILANCHAL VIVAH MANCH
-- JEEVANSATHI DATABASE SCHEMA
-- =========================================

create extension if not exists pgcrypto;

-- ADMIN TABLE
create table if not exists public.admins (
    user_id uuid primary key references auth.users(id) on delete cascade,
    created_at timestamptz default now()
);

-- ADMIN CHECK FUNCTION
create or replace function public.is_admin()
returns boolean
language sql
security definer
stable
set search_path = ''
as $$
    select exists (
        select 1
        from public.admins
        where user_id = (select auth.uid())
    );
$$;

-- MAIN PROFILE TABLE
create table if not exists public.profiles (
    id uuid primary key default gen_random_uuid(),

    user_id uuid references auth.users(id) on delete set null,

    profile_for text not null
        check (profile_for in ('groom', 'bride')),

    full_name text not null,

    caste text not null
        check (caste in ('Brahmin', 'Rajput', 'Bhumihar', 'Kayastha')),

    gotra text,
    date_of_birth date,
    height text,

    marital_status text,
    education text,
    profession text,

    job_type text
        check (job_type in ('Government', 'Private', 'Business', 'Other')),

    annual_income text,

    state text,
    district text,
    city text,

    father_name text,
    father_occupation text,

    mother_name text,
    mother_occupation text,

    brothers integer default 0
        check (brothers between 0 and 10),

    sisters integer default 0
        check (sisters between 0 and 10),

    about text,

    status text default 'pending'
        check (status in ('pending', 'approved', 'rejected')),

    created_at timestamptz default now(),
    updated_at timestamptz default now()
);

-- PRIVATE INFORMATION TABLE
-- Phone number and original photo are never
-- available to ordinary website visitors.

create table if not exists public.profile_private (
    profile_id uuid primary key
        references public.profiles(id) on delete cascade,

    mobile_number text not null,
    photo_path text,

    created_at timestamptz default now()
);

-- ENABLE ROW LEVEL SECURITY

alter table public.admins enable row level security;
alter table public.profiles enable row level security;
alter table public.profile_private enable row level security;

-- ADMIN POLICIES

drop policy if exists "Admins can view admins"
on public.admins;

create policy "Admins can view admins"
on public.admins
for select
to authenticated
using (public.is_admin());

-- PUBLIC PROFILE POLICIES

drop policy if exists "Anyone can view approved profiles"
on public.profiles;

create policy "Anyone can view approved profiles"
on public.profiles
for select
to anon, authenticated
using (
    status = 'approved'
    or user_id = (select auth.uid())
    or public.is_admin()
);

drop policy if exists "Admin can manage profiles"
on public.profiles;

create policy "Admin can manage profiles"
on public.profiles
for all
to authenticated
using (public.is_admin())
with check (public.is_admin());

drop policy if exists "Users can submit profiles"
on public.profiles;

create policy "Users can submit profiles"
on public.profiles
for insert
to authenticated
with check (
    user_id = (select auth.uid())
    and status = 'pending'
);

-- PRIVATE INFORMATION POLICIES

drop policy if exists "Only admin can view private information"
on public.profile_private;

create policy "Only admin can view private information"
on public.profile_private
for select
to authenticated
using (public.is_admin());

drop policy if exists "Only admin can manage private information"
on public.profile_private;

create policy "Only admin can manage private information"
on public.profile_private
for all
to authenticated
using (public.is_admin())
with check (public.is_admin());

-- PRIVATE STORAGE BUCKET FOR PROFILE PHOTOS

insert into storage.buckets (
    id,
    name,
    public
)
values (
    'private-biodata',
    'private-biodata',
    false
)
on conflict (id)
do update set public = false;

-- ONLY ADMIN CAN VIEW PRIVATE PHOTOS

drop policy if exists "Admin can view private biodata photos"
on storage.objects;

create policy "Admin can view private biodata photos"
on storage.objects
for select
to authenticated
using (
    bucket_id = 'private-biodata'
    and public.is_admin()
);

drop policy if exists "Admin can upload private biodata photos"
on storage.objects;

create policy "Admin can upload private biodata photos"
on storage.objects
for insert
to authenticated
with check (
    bucket_id = 'private-biodata'
    and public.is_admin()
);

drop policy if exists "Admin can update private biodata photos"
on storage.objects;

create policy "Admin can update private biodata photos"
on storage.objects
for update
to authenticated
using (
    bucket_id = 'private-biodata'
    and public.is_admin()
)
with check (
    bucket_id = 'private-biodata'
    and public.is_admin()
);

drop policy if exists "Admin can delete private biodata photos"
on storage.objects;

create policy "Admin can delete private biodata photos"
on storage.objects
for delete
to authenticated
using (
    bucket_id = 'private-biodata'
    and public.is_admin()
);

-- END OF SCHEMA
-- MITHILANCHAL VIVAH MANCH
