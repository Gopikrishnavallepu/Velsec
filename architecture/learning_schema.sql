-- SQL schema for learning platform tables in Supabase / PostgreSQL.
-- Run this in your Supabase SQL editor to create the tables and seed default courses.

CREATE TABLE IF NOT EXISTS public.courses (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    category TEXT NOT NULL,
    level TEXT NOT NULL,
    hours INTEGER NOT NULL,
    modules TEXT[] NOT NULL DEFAULT '{}'
);

CREATE TABLE IF NOT EXISTS public.enrollments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,
    course_id TEXT NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
    progress INTEGER NOT NULL DEFAULT 0,
    enrolled_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    UNIQUE(user_id, course_id)
);

-- Enable RLS (Row Level Security)
ALTER TABLE public.courses ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.enrollments ENABLE ROW LEVEL SECURITY;

-- Allow anonymous and authenticated select reads to courses
CREATE POLICY "Allow public select access to courses" ON public.courses
    FOR SELECT USING (true);

-- Allow all write operations for service role to courses (for seed scripts)
CREATE POLICY "Allow service role write access to courses" ON public.courses
    FOR ALL TO service_role USING (true);

-- Allow authenticated users to select their own enrollments
CREATE POLICY "Allow users to select own enrollments" ON public.enrollments
    FOR SELECT TO authenticated USING (auth.uid() = user_id);

-- Allow authenticated users to insert/update their own enrollments
CREATE POLICY "Allow users to manage own enrollments" ON public.enrollments
    FOR ALL TO authenticated USING (auth.uid() = user_id);

-- Seed default courses
INSERT INTO public.courses (id, title, description, category, level, hours, modules) VALUES
('web-pentest', 'Web Application Penetration Testing', 'Learn modern exploitation techniques, from advanced SQL injections to OAuth vulnerabilities, with fully interactive virtual labs.', 'web', 'Intermediate', 24, ARRAY['Reconnaissance & Mapping', 'Injection Flaws & Exploit Design', 'Bypassing WAF & OAuth Vulnerabilities', 'Final Sandbox Pentest Challenge']),
('cloud-sec', 'Cloud Security & IAM Hardening', 'Secure AWS, GCP, and Azure workloads. Learn to identify and exploit IAM misconfigurations and build bulletproof Cloud environments.', 'cloud', 'Advanced', 18, ARRAY['IAM Privilege Escalation', 'Securing Kubernetes Clusters', 'Terraform Sentinel Policy Design', 'Cloud Threat Detection & GuardDuty Setup']),
('rev-eng', 'Reverse Engineering & Malware Analysis', 'Unpack malware samples, analyze assembly bytecode, and learn to write memory bypasses in Windows and Linux systems.', 'malware', 'Expert', 32, ARRAY['Assembly Crash Course', 'Static Analysis with Ghidra & IDA', 'Dynamic Analysis & Debugging', 'Bypassing Anti-Analysis & Sandbox Checks']),
('threat-hunt', 'Defensive Security & Threat Hunting', 'Monitor enterprise logs, detect adversarial persistence techniques using ELK stack, and write defensive Yara rules.', 'defense', 'Beginner', 15, ARRAY['Log Analysis & SIEM Deployment', 'Detecting Adversary Persistence', 'Yara Rules & Signature Writing', 'Incident Response Runbook Simulation'])
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    category = EXCLUDED.category,
    level = EXCLUDED.level,
    hours = EXCLUDED.hours,
    modules = EXCLUDED.modules;
