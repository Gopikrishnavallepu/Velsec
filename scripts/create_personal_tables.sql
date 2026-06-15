-- SQL Migration Script for Personal Dashboard (Habits & Finance)
-- Please execute this in your Supabase SQL Editor.

-- Enable UUID extension if not already enabled
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 1. Habits Table
CREATE TABLE IF NOT EXISTS public.habits (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Habit Logs Table (tracks daily completion)
CREATE TABLE IF NOT EXISTS public.habit_logs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    habit_id UUID REFERENCES public.habits(id) ON DELETE CASCADE,
    log_date DATE NOT NULL,
    completed BOOLEAN DEFAULT TRUE,
    UNIQUE(habit_id, log_date)
);

-- 3. Finance: Expenses
CREATE TABLE IF NOT EXISTS public.finance_expenses (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    exp_date DATE NOT NULL,
    description TEXT NOT NULL,
    category TEXT NOT NULL,
    amount NUMERIC NOT NULL,
    exp_type TEXT DEFAULT 'Variable',
    note TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4. Finance: Loans
CREATE TABLE IF NOT EXISTS public.finance_loans (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    principal NUMERIC NOT NULL,
    rate NUMERIC NOT NULL,
    emi NUMERIC NOT NULL,
    tenure INTEGER NOT NULL,
    paid INTEGER DEFAULT 0,
    due INTEGER NOT NULL,
    bank TEXT,
    closed BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 5. Finance: Budgets
CREATE TABLE IF NOT EXISTS public.finance_budgets (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    category TEXT NOT NULL,
    budget NUMERIC NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(user_id, category)
);

-- 6. Finance: Investments
CREATE TABLE IF NOT EXISTS public.finance_investments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    inv_type TEXT NOT NULL,
    invested NUMERIC NOT NULL,
    current_val NUMERIC NOT NULL,
    sip NUMERIC DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Turn on RLS (Row Level Security) for all tables
ALTER TABLE public.habits ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.habit_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.finance_expenses ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.finance_loans ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.finance_budgets ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.finance_investments ENABLE ROW LEVEL SECURITY;

-- Create Policies to ensure users can only see and edit their own data
DROP POLICY IF EXISTS "Users can manage their own habits" ON public.habits;
CREATE POLICY "Users can manage their own habits" ON public.habits FOR ALL USING (auth.uid() = user_id);

-- Habit logs depend on habit_id which belongs to user
DROP POLICY IF EXISTS "Users can manage their own habit logs" ON public.habit_logs;
CREATE POLICY "Users can manage their own habit logs" ON public.habit_logs FOR ALL USING (
  EXISTS (SELECT 1 FROM public.habits h WHERE h.id = habit_id AND h.user_id = auth.uid())
);

DROP POLICY IF EXISTS "Users can manage their own expenses" ON public.finance_expenses;
CREATE POLICY "Users can manage their own expenses" ON public.finance_expenses FOR ALL USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users can manage their own loans" ON public.finance_loans;
CREATE POLICY "Users can manage their own loans" ON public.finance_loans FOR ALL USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users can manage their own budgets" ON public.finance_budgets;
CREATE POLICY "Users can manage their own budgets" ON public.finance_budgets FOR ALL USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users can manage their own investments" ON public.finance_investments;
CREATE POLICY "Users can manage their own investments" ON public.finance_investments FOR ALL USING (auth.uid() = user_id);
