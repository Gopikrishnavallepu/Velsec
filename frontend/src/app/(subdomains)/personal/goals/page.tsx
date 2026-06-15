'use client';

import { useState, useEffect } from 'react';
import { getSubdomainUrl } from '@/utils/navigation';
import ParticleField from '@/components/ui/ParticleField';
import { createClient } from '@/utils/supabase/client';

type GoalPeriod = 'daily' | 'weekly' | 'monthly' | 'yearly';
type GoalCategory = 'personal' | 'professional';
type GoalStatus = 'pending' | 'achieved' | 'lack_of_achieve';

interface Goal {
  id: string;
  title: string;
  description: string | null;
  period: GoalPeriod;
  category: GoalCategory;
  status: GoalStatus;
  created_at: string;
}

export default function GoalsPage() {
  const supabase = createClient();
  const [mounted, setMounted] = useState(false);
  const [goals, setGoals] = useState<Goal[]>([]);
  const [loading, setLoading] = useState(true);
  const [userId, setUserId] = useState<string | null>(null);

  // Form states
  const [newTitle, setNewTitle] = useState('');
  const [newDesc, setNewDesc] = useState('');
  const [newPeriod, setNewPeriod] = useState<GoalPeriod>('daily');
  const [newCategory, setNewCategory] = useState<GoalCategory>('personal');

  useEffect(() => {
    setMounted(true);
    fetchUserAndGoals();
  }, []);

  const fetchUserAndGoals = async () => {
    setLoading(true);
    const { data: { session } } = await supabase.auth.getSession();
    if (!session?.user) {
      setLoading(false);
      return;
    }
    setUserId(session.user.id);
    await loadGoals(session.user.id);
    setLoading(false);
  };

  const loadGoals = async (uid: string) => {
    const { data, error } = await supabase
      .from('goals')
      .select('*')
      .eq('user_id', uid)
      .order('created_at', { ascending: false });
      
    if (data) setGoals(data);
    if (error) console.error('Error fetching goals:', error);
  };

  const createGoal = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!userId || !newTitle.trim()) return;

    const newGoal = {
      user_id: userId,
      title: newTitle,
      description: newDesc,
      period: newPeriod,
      category: newCategory,
      status: 'pending' as GoalStatus
    };

    const { error } = await supabase.from('goals').insert([newGoal]);
    if (!error) {
      setNewTitle('');
      setNewDesc('');
      loadGoals(userId);
    } else {
      console.error("Failed to create goal", error);
    }
  };

  const updateGoalStatus = async (id: string, status: GoalStatus) => {
    if (!userId) return;
    const { error } = await supabase.from('goals').update({ status }).eq('id', id);
    if (!error) loadGoals(userId);
  };

  const deleteGoal = async (id: string) => {
    if (!userId) return;
    const { error } = await supabase.from('goals').delete().eq('id', id);
    if (!error) loadGoals(userId);
  };

  const renderGoalList = (period: GoalPeriod, status: GoalStatus) => {
    const filtered = goals.filter(g => g.period === period && g.status === status);
    if (filtered.length === 0) return <div className="text-[10px] text-muted-foreground p-2 font-mono">NO_DATA_FOUND</div>;
    
    return filtered.map(goal => (
      <div key={goal.id} className="p-3 border border-border rounded-lg bg-card/50 flex flex-col gap-2 group">
        <div className="flex justify-between items-start">
          <div className="flex gap-2 items-center">
            <span className={`w-2 h-2 rounded-full ${goal.category === 'personal' ? 'bg-blue-400' : 'bg-purple-400'}`} title={goal.category} />
            <span className="text-xs font-bold text-foreground">{goal.title}</span>
          </div>
          <button onClick={() => deleteGoal(goal.id)} className="text-[10px] text-rose-500 opacity-0 group-hover:opacity-100 transition-opacity">DELETE</button>
        </div>
        {goal.description && <p className="text-[10px] text-muted-foreground ml-4">{goal.description}</p>}
        
        <div className="flex gap-2 ml-4 mt-2">
          {status !== 'pending' && <button onClick={() => updateGoalStatus(goal.id, 'pending')} className="text-[9px] px-2 py-1 bg-zinc-800 rounded border border-border hover:text-white transition-colors">SET PENDING</button>}
          {status !== 'achieved' && <button onClick={() => updateGoalStatus(goal.id, 'achieved')} className="text-[9px] px-2 py-1 bg-emerald-500/20 text-emerald-400 rounded border border-emerald-500/30 hover:bg-emerald-500/40 transition-colors">MARK ACHIEVED</button>}
          {status !== 'lack_of_achieve' && <button onClick={() => updateGoalStatus(goal.id, 'lack_of_achieve')} className="text-[9px] px-2 py-1 bg-amber-500/20 text-amber-400 rounded border border-amber-500/30 hover:bg-amber-500/40 transition-colors">MARK MISSED</button>}
        </div>
      </div>
    ));
  };

  return (
    <main className="relative min-h-screen overflow-x-hidden pt-24 pb-16 px-4 md:px-8 bg-background">
      <ParticleField />
      <div className="fixed inset-0 -z-5 pointer-events-none bg-gradient-to-t from-[#050a18] via-transparent to-[#050a18]/40" />

      <div className="z-10 max-w-6xl mx-auto flex flex-col gap-8">
        
        {/* Header */}
        <div className="relative border border-blue-500/20 bg-card/30 backdrop-blur-md p-6 rounded-2xl flex flex-col md:flex-row md:items-center justify-between gap-4">
          <div>
            <div className="flex items-center gap-2 mb-1">
              <span className="text-[10px] font-mono text-blue-400 tracking-[0.3em] font-bold">MODULE_01</span>
            </div>
            <h1 className="text-3xl font-extrabold font-mono tracking-wider text-foreground">
              PERSONAL<span className="text-blue-500">_GOALS</span>
            </h1>
            <p className="text-xs text-muted-foreground font-mono mt-1">
              Create, maintain, edit, and track personal & professional milestones.
            </p>
          </div>
          <a
            href={mounted ? getSubdomainUrl('personal') : '/personal'}
            className="px-4 py-2 bg-card border border-border hover:border-blue-500/50 rounded-lg text-xs font-mono text-muted-foreground hover:text-foreground transition-all"
          >
            &lt;-- BACK_TO_HUB
          </a>
        </div>

        {!userId && !loading ? (
          <div className="p-8 border border-rose-500/30 bg-rose-500/10 rounded-xl text-center font-mono text-sm text-rose-400">
            AUTHENTICATION_REQUIRED_TO_ACCESS_GOALS
          </div>
        ) : (
          <div className="grid grid-cols-1 lg:grid-cols-4 gap-6">
            
            {/* Create Goal Form */}
            <div className="lg:col-span-1 border border-border bg-card/25 rounded-xl p-5 h-fit">
              <h3 className="text-sm font-bold font-mono text-secondary mb-4 border-b border-border pb-2">CREATE_GOAL</h3>
              <form onSubmit={createGoal} className="flex flex-col gap-4 font-mono">
                <div>
                  <label className="text-[10px] text-muted-foreground">TITLE</label>
                  <input type="text" value={newTitle} onChange={e=>setNewTitle(e.target.value)} required className="w-full mt-1 bg-background border border-border rounded px-3 py-2 text-xs focus:border-secondary focus:outline-none" />
                </div>
                <div>
                  <label className="text-[10px] text-muted-foreground">DESCRIPTION (OPTIONAL)</label>
                  <textarea value={newDesc} onChange={e=>setNewDesc(e.target.value)} className="w-full mt-1 bg-background border border-border rounded px-3 py-2 text-xs focus:border-secondary focus:outline-none" rows={3}></textarea>
                </div>
                <div className="grid grid-cols-2 gap-2">
                  <div>
                    <label className="text-[10px] text-muted-foreground">PERIOD</label>
                    <select value={newPeriod} onChange={e=>setNewPeriod(e.target.value as GoalPeriod)} className="w-full mt-1 bg-background border border-border rounded px-2 py-2 text-xs focus:border-secondary focus:outline-none">
                      <option value="daily">Daily</option>
                      <option value="weekly">Weekly</option>
                      <option value="monthly">Monthly</option>
                      <option value="yearly">Yearly</option>
                    </select>
                  </div>
                  <div>
                    <label className="text-[10px] text-muted-foreground">CATEGORY</label>
                    <select value={newCategory} onChange={e=>setNewCategory(e.target.value as GoalCategory)} className="w-full mt-1 bg-background border border-border rounded px-2 py-2 text-xs focus:border-secondary focus:outline-none">
                      <option value="personal">Personal</option>
                      <option value="professional">Professional</option>
                    </select>
                  </div>
                </div>
                <button type="submit" disabled={loading} className="mt-2 w-full py-2 bg-secondary/10 hover:bg-secondary/20 text-secondary border border-secondary/40 rounded-lg text-xs font-bold tracking-widest transition-colors disabled:opacity-50">
                  INITIALIZE_GOAL
                </button>
              </form>
            </div>

            {/* Tracker Dashboard */}
            <div className="lg:col-span-3 grid grid-cols-1 md:grid-cols-2 gap-6">
              
              {/* Daily / Weekly Pending */}
              <div className="border border-border bg-card/25 rounded-xl p-5">
                <h3 className="text-sm font-bold font-mono text-foreground mb-4 border-b border-border pb-2">PENDING_SHORT_TERM</h3>
                <div className="space-y-4">
                  <div>
                    <span className="text-[10px] font-bold text-muted-foreground uppercase tracking-widest">Daily Tracker</span>
                    <div className="mt-2 space-y-2">{renderGoalList('daily', 'pending')}</div>
                  </div>
                  <div>
                    <span className="text-[10px] font-bold text-muted-foreground uppercase tracking-widest">Weekly Tracker</span>
                    <div className="mt-2 space-y-2">{renderGoalList('weekly', 'pending')}</div>
                  </div>
                </div>
              </div>

              {/* Monthly / Yearly Pending */}
              <div className="border border-border bg-card/25 rounded-xl p-5">
                <h3 className="text-sm font-bold font-mono text-foreground mb-4 border-b border-border pb-2">PENDING_LONG_TERM</h3>
                <div className="space-y-4">
                  <div>
                    <span className="text-[10px] font-bold text-muted-foreground uppercase tracking-widest">Monthly Tracker</span>
                    <div className="mt-2 space-y-2">{renderGoalList('monthly', 'pending')}</div>
                  </div>
                  <div>
                    <span className="text-[10px] font-bold text-muted-foreground uppercase tracking-widest">Yearly Tracker</span>
                    <div className="mt-2 space-y-2">{renderGoalList('yearly', 'pending')}</div>
                  </div>
                </div>
              </div>

              {/* Achieve List */}
              <div className="border border-emerald-500/20 bg-emerald-500/5 rounded-xl p-5">
                <h3 className="text-sm font-bold font-mono text-emerald-400 mb-4 border-b border-emerald-500/20 pb-2">ACHIEVE_LIST 🏆</h3>
                <div className="space-y-2 max-h-64 overflow-y-auto pr-2 custom-scrollbar">
                  {goals.filter(g => g.status === 'achieved').length === 0 ? (
                    <div className="text-[10px] text-muted-foreground p-2 font-mono">NO_ACHIEVEMENTS_YET</div>
                  ) : (
                    goals.filter(g => g.status === 'achieved').map(goal => (
                      <div key={goal.id} className="p-3 border border-emerald-500/30 rounded-lg bg-emerald-500/10 flex justify-between items-center group">
                         <span className="text-xs font-bold text-emerald-400 line-through opacity-80">{goal.title}</span>
                         <button onClick={() => updateGoalStatus(goal.id, 'pending')} className="text-[9px] text-emerald-500 opacity-0 group-hover:opacity-100 hover:text-emerald-300">UNDO</button>
                      </div>
                    ))
                  )}
                </div>
              </div>

              {/* Lack of Achieve List */}
              <div className="border border-amber-500/20 bg-amber-500/5 rounded-xl p-5">
                <h3 className="text-sm font-bold font-mono text-amber-400 mb-4 border-b border-amber-500/20 pb-2">LACK_OF_ACHIEVE_LIST ⚠️</h3>
                <div className="space-y-2 max-h-64 overflow-y-auto pr-2 custom-scrollbar">
                  {goals.filter(g => g.status === 'lack_of_achieve').length === 0 ? (
                    <div className="text-[10px] text-muted-foreground p-2 font-mono">NO_MISSED_GOALS</div>
                  ) : (
                    goals.filter(g => g.status === 'lack_of_achieve').map(goal => (
                      <div key={goal.id} className="p-3 border border-amber-500/30 rounded-lg bg-amber-500/10 flex justify-between items-center group">
                         <span className="text-xs font-bold text-amber-400 opacity-80">{goal.title}</span>
                         <button onClick={() => updateGoalStatus(goal.id, 'pending')} className="text-[9px] text-amber-500 opacity-0 group-hover:opacity-100 hover:text-amber-300">RETRY</button>
                      </div>
                    ))
                  )}
                </div>
              </div>

            </div>
          </div>
        )}
      </div>
    </main>
  );
}
