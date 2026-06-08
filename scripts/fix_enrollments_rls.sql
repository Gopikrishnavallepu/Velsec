-- Add policies for anon role to allow backend to select and manage enrollments
DO $$
BEGIN
  BEGIN
    DROP POLICY IF EXISTS "Allow anon select enrollments" ON public.enrollments;
  EXCEPTION WHEN undefined_object THEN NULL;
  END;

  CREATE POLICY "Allow anon select enrollments" ON public.enrollments
    FOR SELECT TO anon USING (true);

  BEGIN
    DROP POLICY IF EXISTS "Allow anon manage enrollments" ON public.enrollments;
  EXCEPTION WHEN undefined_object THEN NULL;
  END;

  CREATE POLICY "Allow anon manage enrollments" ON public.enrollments
    FOR ALL TO anon USING (true);
END $$;
