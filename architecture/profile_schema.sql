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

-- Trigger to automatically create a profile for new users when they register
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
BEGIN
  INSERT INTO public.profiles (user_id, xp, level, solved_labs, lab_history, skills, certs, badges)
  VALUES (
    new.id,
    0,   -- Starting XP
    1,   -- Starting level
    0,   -- Solved labs count
    '{}',
    '[]',
    '[]',
    '[]'
  );
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Recreate trigger
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();
