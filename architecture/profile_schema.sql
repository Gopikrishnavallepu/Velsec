-- SQL schema for user profiles and progress tracking in Supabase / PostgreSQL.
-- Run this in your Supabase SQL editor to create the profiles table.

CREATE TABLE IF NOT EXISTS public.profiles (
    user_id UUID PRIMARY KEY,
    xp INTEGER NOT NULL DEFAULT 0,
    level INTEGER NOT NULL DEFAULT 1,
    solved_labs INTEGER NOT NULL DEFAULT 0,
    lab_history INTEGER[] NOT NULL DEFAULT '{}',
    skills JSONB NOT NULL DEFAULT '[]',
    certs JSONB NOT NULL DEFAULT '[]',
    badges JSONB NOT NULL DEFAULT '[]',
    last_updated TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Enable Row Level Security (RLS)
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

-- Allow users to select their own profile
CREATE POLICY "Allow users to read own profile" ON public.profiles
    FOR SELECT TO authenticated USING (auth.uid() = user_id);

-- Allow users to update/insert their own profile
CREATE POLICY "Allow users to update own profile" ON public.profiles
    FOR ALL TO authenticated USING (auth.uid() = user_id);
