'use client';

import { useState, useEffect } from 'react';
import { getSubdomainUrl } from '@/utils/navigation';
import { createClient } from '@/utils/supabase/client';
import ParticleField from '@/components/ui/ParticleField';

interface Habit {
  id: string;
  name: string;
}

interface HabitLog {
  id: string;
  habit_id: string;
  log_date: string;
  completed: boolean;
}

export default function HabitsPage() {
  const [mounted, setMounted] = useState(false);
  const [session, setSession] = useState<any>(null);
  const [habits, setHabits] = useState<Habit[]>([]);
  const [logs, setLogs] = useState<HabitLog[]>([]);
  const [newHabitName, setNewHabitName] = useState('');
  const [loading, setLoading] = useState(true);
  
  const supabase = createClient();

  useEffect(() => {
    setMounted(true);
    supabase.auth.getSession().then(({ data: { session } }) => {
      setSession(session);
      if (session) {
        fetchHabitsData(session.user.id);
      } else {
        setLoading(false);
      }
    });

    const { data: { subscription } } = supabase.auth.onAuthStateChange((_e, session) => {
      setSession(session);
      if (session) {
        fetchHabitsData(session.user.id);
      }
    });

    return () => subscription.unsubscribe();
  }, []);

  const fetchHabitsData = async (userId: string) => {
    setLoading(true);
    try {
      // 1. Fetch Habits
      const { data: habitsData, error: habitsErr } = await supabase
        .from('habits')
        .select('*')
        .order('created_at', { ascending: true });
        
      if (habitsErr) throw habitsErr;
      setHabits(habitsData || []);

      // 2. Fetch Logs for the last 7 days
      const sevenDaysAgo = new Date();
      sevenDaysAgo.setDate(sevenDaysAgo.getDate() - 7);
      const isoDateStr = sevenDaysAgo.toISOString().split('T')[0];

      const { data: logsData, error: logsErr } = await supabase
        .from('habit_logs')
        .select('*')
        .gte('log_date', isoDateStr);
        
      if (logsErr) throw logsErr;
      setLogs(logsData || []);
    } catch (err: any) {
      console.error('Error fetching habits:', err);
    } finally {
      setLoading(false);
    }
  };

  const addHabit = async () => {
    if (!newHabitName.trim() || !session) return;
    try {
      const { data, error } = await supabase
        .from('habits')
        .insert([{ user_id: session.user.id, name: newHabitName.trim() }])
        .select();
      
      if (error) throw error;
      if (data && data.length > 0) {
        setHabits([...habits, data[0]]);
        setNewHabitName('');
      }
    } catch (err) {
      console.error('Error adding habit:', err);
      alert('Ensure you have executed the SQL migration script first to create the habits table!');
    }
  };

  const toggleLog = async (habitId: string, dateStr: string) => {
    if (!session) return;
    const existingLog = logs.find(l => l.habit_id === habitId && l.log_date === dateStr);
    
    try {
      if (existingLog) {
        // Toggle or delete
        const newVal = !existingLog.completed;
        const { error } = await supabase
          .from('habit_logs')
          .update({ completed: newVal })
          .eq('id', existingLog.id);
        
        if (error) throw error;
        setLogs(logs.map(l => l.id === existingLog.id ? { ...l, completed: newVal } : l));
      } else {
        // Create new log
        const { data, error } = await supabase
          .from('habit_logs')
          .insert([{ habit_id: habitId, log_date: dateStr, completed: true }])
          .select();
          
        if (error) throw error;
        if (data && data.length > 0) {
          setLogs([...logs, data[0]]);
        }
      }
    } catch (err) {
      console.error('Error toggling habit log:', err);
      alert('Database error. Have you run the SQL migration script?');
    }
  };

  // Generate an array of the last 7 date strings [ "YYYY-MM-DD", ... ]
  const getLast7Days = () => {
    const days = [];
    for (let i = 6; i >= 0; i--) {
      const d = new Date();
      d.setDate(d.getDate() - i);
      days.push(d.toISOString().split('T')[0]);
    }
    return days;
  };
  
  const pastDays = getLast7Days();

  return (
    <main className="relative min-h-screen overflow-x-hidden pt-24 pb-16 px-4 md:px-8 bg-background">
      <ParticleField />
      <div className="fixed inset-0 -z-5 pointer-events-none bg-gradient-to-t from-[#050a18] via-transparent to-[#050a18]/40" />

      <div className="z-10 max-w-4xl mx-auto flex flex-col gap-8">
        
        {/* Header */}
        <div className="relative border border-emerald-500/20 bg-card/30 backdrop-blur-md p-6 rounded-2xl flex flex-col md:flex-row md:items-center justify-between gap-4">
          <div>
            <div className="flex items-center gap-2 mb-1">
              <span className="text-[10px] font-mono text-emerald-400 tracking-[0.3em] font-bold">MODULE_03</span>
            </div>
            <h1 className="text-3xl font-extrabold font-mono tracking-wider text-foreground">
              DAILY<span className="text-emerald-500">_HABITS</span>
            </h1>
            <p className="text-xs text-muted-foreground font-mono mt-1">
              Systematic routine tracking wired directly to Supabase.
            </p>
          </div>
          
          <a
            href={mounted ? getSubdomainUrl('personal') : '/personal'}
            className="px-4 py-2 bg-card border border-border hover:border-emerald-500/50 rounded-lg text-xs font-mono text-muted-foreground hover:text-foreground transition-all"
          >
            &lt;-- BACK_TO_HUB
          </a>
        </div>

        {/* Content */}
        {!session && !loading ? (
           <div className="border border-rose-500/25 bg-rose-500/5 p-8 rounded-xl text-center">
             <h2 className="text-xl font-bold font-mono text-rose-400 mb-2">AUTH_REQUIRED</h2>
             <p className="text-sm text-muted-foreground">You must be logged in to track your habits.</p>
           </div>
        ) : loading ? (
           <div className="text-center p-8 text-emerald-400 font-mono animate-pulse">FETCHING_DATABASE_RECORDS...</div>
        ) : (
          <div className="border border-border bg-card/50 rounded-xl p-6 shadow-xl">
            
            {/* Add Habit Bar */}
            <div className="flex gap-2 mb-8">
              <input 
                type="text" 
                value={newHabitName}
                onChange={(e) => setNewHabitName(e.target.value)}
                placeholder="e.g. Read 10 pages, Meditate, Drink 2L water"
                className="flex-1 bg-background border border-border rounded-lg px-4 py-2 text-sm text-foreground focus:outline-none focus:border-emerald-500/50 transition-colors"
                onKeyDown={(e) => e.key === 'Enter' && addHabit()}
              />
              <button 
                onClick={addHabit}
                className="px-4 py-2 bg-emerald-500/10 hover:bg-emerald-500/20 text-emerald-500 font-mono text-xs font-bold border border-emerald-500/30 rounded-lg transition-colors"
              >
                + ADD_HABIT
              </button>
            </div>

            {/* Habits Grid */}
            {habits.length === 0 ? (
              <div className="text-center py-12 text-muted-foreground font-mono text-xs border border-dashed border-border rounded-lg">
                [NO_HABITS_FOUND]
              </div>
            ) : (
              <div className="overflow-x-auto">
                <table className="w-full text-left border-collapse">
                  <thead>
                    <tr>
                      <th className="pb-4 font-mono text-xs text-muted-foreground font-bold tracking-widest min-w-[150px]">HABIT</th>
                      {pastDays.map(dateStr => (
                        <th key={dateStr} className="pb-4 text-center font-mono text-[10px] text-muted-foreground font-bold">
                          {dateStr.slice(5)} {/* MM-DD */}
                        </th>
                      ))}
                    </tr>
                  </thead>
                  <tbody>
                    {habits.map(habit => (
                      <tr key={habit.id} className="border-t border-border/50 group">
                        <td className="py-4 font-mono text-sm text-foreground pr-4">
                          {habit.name}
                        </td>
                        {pastDays.map(dateStr => {
                          const log = logs.find(l => l.habit_id === habit.id && l.log_date === dateStr);
                          const isCompleted = log?.completed || false;
                          const isToday = dateStr === new Date().toISOString().split('T')[0];

                          return (
                            <td key={dateStr} className="py-4 text-center">
                              <button 
                                onClick={() => toggleLog(habit.id, dateStr)}
                                className={`w-8 h-8 rounded-lg flex items-center justify-center transition-all duration-300 mx-auto ${
                                  isCompleted 
                                    ? 'bg-emerald-500/20 text-emerald-500 shadow-[0_0_10px_rgba(16,185,129,0.2)] border border-emerald-500/50' 
                                    : isToday
                                      ? 'bg-card border-2 border-dashed border-emerald-500/30 hover:border-emerald-500/60'
                                      : 'bg-background border border-border hover:bg-card hover:border-emerald-500/30 text-transparent hover:text-emerald-500/50'
                                }`}
                              >
                                {isCompleted ? '✔' : '·'}
                              </button>
                            </td>
                          );
                        })}
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            )}
          </div>
        )}
      </div>
    </main>
  );
}
