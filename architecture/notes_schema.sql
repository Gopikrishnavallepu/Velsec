-- SQL schema for notes table in Supabase / PostgreSQL.
-- Run this in your Supabase SQL editor to create the table and enable full-text search.

CREATE TABLE IF NOT EXISTS public.notes (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    category TEXT NOT NULL,
    tags TEXT[] NOT NULL DEFAULT '{}',
    content TEXT NOT NULL,
    last_updated TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    fts tsvector GENERATED ALWAYS AS (
        to_tsvector('english', coalesce(title, '') || ' ' || coalesce(content, ''))
    ) STORED
);

-- Index the generated full-text search column for fast retrieval
CREATE INDEX IF NOT EXISTS notes_fts_idx ON public.notes USING gin(fts);

-- Enable RLS (Row Level Security) - optional but recommended
ALTER TABLE public.notes ENABLE ROW LEVEL SECURITY;

-- Allow anonymous and authenticated select reads
CREATE POLICY "Allow public select access to notes" ON public.notes
    FOR SELECT USING (true);

-- Allow all operations for service role (used during sync script update)
CREATE POLICY "Allow service role write access to notes" ON public.notes
    FOR ALL TO service_role USING (true);
