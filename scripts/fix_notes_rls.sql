-- Add anon SELECT policy so the backend (using anon key) can read notes
-- Also add anon INSERT/UPDATE for sync operations
DO $$
BEGIN
  -- Drop existing policy if it exists, then recreate
  BEGIN
    DROP POLICY IF EXISTS "Allow anon select access to notes" ON public.notes;
  EXCEPTION WHEN undefined_object THEN NULL;
  END;

  CREATE POLICY "Allow anon select access to notes" ON public.notes
    FOR SELECT TO anon USING (true);

  -- Allow anon to upsert (needed for sync via API with anon key)
  BEGIN
    DROP POLICY IF EXISTS "Allow anon upsert access to notes" ON public.notes;
  EXCEPTION WHEN undefined_object THEN NULL;
  END;

  CREATE POLICY "Allow anon upsert access to notes" ON public.notes
    FOR ALL TO anon USING (true);
END $$;
