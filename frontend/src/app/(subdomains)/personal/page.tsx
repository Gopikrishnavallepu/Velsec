'use client';

import { useState, useEffect } from 'react';
import ParticleField from '@/components/ui/ParticleField';
import { getSubdomainUrl } from '@/utils/navigation';
import { createClient } from '@/utils/supabase/client';

interface Task {
  id: number;
  text: string;
  completed: boolean;
}

interface Skill {
  name: string;
  level: number; // 0 to 100
}

interface Cert {
  id: string;
  name: string;
  acquired: boolean;
}

export default function PersonalPage() {
  const supabase = createClient();
  const [mounted, setMounted] = useState(false);

  // Profile state variables
  const [xp, setXp] = useState<number>(3450);
  const [level, setLevel] = useState<number>(3);
  const [solvedLabs, setSolvedLabs] = useState<number>(14);
  const [labHistory, setLabHistory] = useState<number[]>([]);
  const [badges, setBadges] = useState<any[]>([]);

  // Tasks list state (local workspace objective checklist)
  const [tasks, setTasks] = useState<Task[]>([
    { id: 1, text: 'Review STRIDE threat profile for API module', completed: false },
    { id: 2, text: 'Complete "Ghidra Assembly analysis" challenge', completed: true },
    { id: 3, text: 'Verify Docker container base layers vulnerabilities', completed: false },
    { id: 4, text: 'Draft updated portfolio CV in Markdown format', completed: false },
  ]);

  // Skills list state
  const [skills, setSkills] = useState<Skill[]>([
    { name: 'Python Scripting', level: 75 },
    { name: 'Docker / Kubernetes Sec', level: 50 },
    { name: 'Linux System Internals', level: 60 },
    { name: 'Threat Hunting (ELK)', level: 40 },
  ]);

  // Certifications list state
  const [certs, setCerts] = useState<Cert[]>([
    { id: 'secplus', name: 'Security+', acquired: true },
    { id: 'oscp', name: 'OSCP', acquired: false },
    { id: 'cissp', name: 'CISSP', acquired: false },
    { id: 'ceh', name: 'CEH', acquired: true },
  ]);

  const [cvCompiling, setCvCompiling] = useState<boolean>(false);
  const [loading, setLoading] = useState<boolean>(true);
  const [errorMsg, setErrorMsg] = useState<string | null>(null);
  const [isAuthenticated, setIsAuthenticated] = useState<boolean>(true);

  const getApiBase = () => {
    return process.env.NEXT_PUBLIC_API_URL !== undefined
      ? process.env.NEXT_PUBLIC_API_URL
      : (typeof window !== 'undefined' && 
         !window.location.hostname.includes('localhost') && 
         !window.location.hostname.endsWith('.local')
          ? ''
          : 'http://localhost:8000');
  };

  const handleGithubLogin = async () => {
    try {
      await supabase.auth.signInWithOAuth({
        provider: 'github',
        options: {
          redirectTo: getSubdomainUrl('home', '/auth/callback?next=' + encodeURIComponent(getSubdomainUrl('personal'))),
        },
      });
    } catch (err: any) {
      console.error('OAuth handshake failed:', err);
    }
  };

  const fetchProfile = async () => {
    setLoading(true);
    setErrorMsg(null);
    try {
      const { data: { session } } = await supabase.auth.getSession();
      const token = session?.access_token;
      if (!token) {
        setIsAuthenticated(false);
        setLoading(false);
        return;
      }

      setIsAuthenticated(true);
      const apiBase = getApiBase();
      const res = await fetch(`${apiBase}/api/v1/tracking/profile`, {
        headers: {
          'Authorization': `Bearer ${token}`
        }
      });

      if (res.status === 401) {
        setIsAuthenticated(false);
        setLoading(false);
        return;
      }

      if (!res.ok) {
        throw new Error(`API status ${res.status}`);
      }

      const data = await res.json();
      setXp(data.xp);
      setLevel(data.level);
      setSolvedLabs(data.solved_labs);
      setLabHistory(data.lab_history);
      setBadges(data.badges);
      if (data.skills && data.skills.length > 0) setSkills(data.skills);
      if (data.certs && data.certs.length > 0) setCerts(data.certs);
    } catch (err: any) {
      console.warn("Failed to connect to API, using default local profile state:", err);
      setErrorMsg("Offline fallback mode active.");
    } finally {
      setLoading(false);
    }
  };

  const saveProfile = async (nextSkills: Skill[], nextCerts: Cert[]) => {
    try {
      const { data: { session } } = await supabase.auth.getSession();
      const token = session?.access_token;
      if (!token) return;

      const apiBase = getApiBase();
      await fetch(`${apiBase}/api/v1/tracking/profile`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        },
        body: JSON.stringify({
          xp,
          level,
          solved_labs: solvedLabs,
          lab_history: labHistory,
          skills: nextSkills,
          certs: nextCerts,
          badges
        })
      });
    } catch (err) {
      console.error("Failed to save profile:", err);
    }
  };

  useEffect(() => {
    setMounted(true);
    fetchProfile();
  }, []);

  useEffect(() => {
    const { data: { subscription } } = supabase.auth.onAuthStateChange(() => {
      fetchProfile();
    });
    return () => subscription.unsubscribe();
  }, [supabase.auth]);

  // Toggle tasks
  const toggleTask = (id: number) => {
    setTasks(tasks.map(t => t.id === id ? { ...t, completed: !t.completed } : t));
  };

  // Toggle certification acquired status
  const toggleCert = (id: string) => {
    const nextCerts = certs.map(c => c.id === id ? { ...c, acquired: !c.acquired } : c);
    setCerts(nextCerts);
    saveProfile(skills, nextCerts);
  };

  // Increment skills level
  const trainSkill = (name: string) => {
    const nextSkills = skills.map(s => {
      if (s.name === name) {
        const nextLvl = Math.min(s.level + 5, 100);
        return { ...s, level: nextLvl };
      }
      return s;
    });
    setSkills(nextSkills);
    saveProfile(nextSkills, certs);
  };

  // Compile CV animation
  const compileCV = () => {
    if (cvCompiling) return;
    setCvCompiling(true);
    setTimeout(() => {
      setCvCompiling(false);
      alert('[SUCCESS] Compiling Completed: Compiled Cyberspace CV exported in PDF layout template!');
    }, 2000);
  };

  const completedCount = tasks.filter(t => t.completed).length;

  return (
    <main className="relative min-h-screen overflow-x-hidden pt-24 pb-16 px-4 md:px-8 bg-background">
      <ParticleField />
      
      {/* Background vignette overlay */}
      <div className="fixed inset-0 -z-5 pointer-events-none bg-gradient-to-t from-[#050a18] via-transparent to-[#050a18]/40" />

      <div className="z-10 max-w-6xl mx-auto flex flex-col gap-8">
        
        {/* Page Header */}
        <div className="relative border border-secondary/20 bg-card/30 backdrop-blur-md p-6 rounded-2xl flex flex-col md:flex-row md:items-center md:justify-between gap-4">
          <div className="absolute top-0 left-0 w-2 h-2 border-t-2 border-l-2 border-secondary" />
          <div className="absolute top-0 right-0 w-2 h-2 border-t-2 border-r-2 border-secondary" />
          <div className="absolute bottom-0 left-0 w-2 h-2 border-b-2 border-l-2 border-secondary" />
          <div className="absolute bottom-0 right-0 w-2 h-2 border-b-2 border-r-2 border-secondary" />
          
          <div>
            <div className="flex items-center gap-2 mb-1">
              <span className="w-2 h-2 bg-secondary rounded-full animate-ping" />
              <span className="text-[10px] font-mono text-secondary tracking-[0.3em] font-bold">V_PERSONAL</span>
            </div>
            <h1 className="text-3xl font-extrabold font-mono tracking-wider">
              PERSONAL<span className="text-secondary">.VELSEC</span>
            </h1>
            <p className="text-xs text-muted-foreground font-mono mt-1">
              Career Milestones, Daily Objectives &amp; Cyber Skill Matrix
            </p>
          </div>

          <div className="flex gap-4 border-l border-secondary/15 pl-0 md:pl-6 pt-4 md:pt-0">
            <div className="text-center font-mono">
              <p className="text-[10px] text-muted-foreground font-bold">SOLVED_TASKS</p>
              <p className="text-lg font-extrabold text-secondary">{completedCount} / {tasks.length}</p>
            </div>
            <div className="text-center font-mono">
              <p className="text-[10px] text-muted-foreground font-bold">OPERATIVE_LVL</p>
              <p className="text-lg font-extrabold text-secondary">0{level}</p>
            </div>
          </div>
        </div>

        {errorMsg && (
          <div className="p-3.5 border border-amber-500/30 bg-amber-500/10 rounded-xl text-xs font-mono text-amber-400 text-center shadow-[0_0_15px_rgba(245,158,11,0.05)]">
            ⚠️ {errorMsg}
          </div>
        )}

        {!isAuthenticated ? (
          /* Authentication Required Alert */
          <div className="relative border border-rose-500/25 bg-rose-500/5 backdrop-blur-md rounded-2xl p-12 text-center flex flex-col items-center justify-center gap-4 max-w-xl mx-auto my-8">
            <div className="absolute top-0 left-0 w-3 h-3 border-t-2 border-l-2 border-rose-500" />
            <div className="absolute top-0 right-0 w-3 h-3 border-t-2 border-r-2 border-rose-500" />
            <div className="absolute bottom-0 left-0 w-3 h-3 border-b-2 border-l-2 border-rose-500" />
            <div className="absolute bottom-0 right-0 w-3 h-3 border-b-2 border-r-2 border-rose-500" />

            <span className="text-4xl">🔒</span>
            <h2 className="text-xl font-bold font-mono text-rose-400 tracking-wider">ACCESS_DENIED_SECURE_GATEWAY</h2>
            <p className="text-xs text-muted-foreground font-mono max-w-md leading-relaxed">
              Velsec career profiles and user details are encrypted at rest. Please authorize your session credentials at the central security gateway.
            </p>
            <button
              onClick={handleGithubLogin}
              className="mt-2 px-6 py-2.5 bg-secondary/10 hover:bg-secondary/20 active:scale-98 text-xs font-mono font-bold tracking-widest text-secondary border border-secondary/40 rounded-lg transition-all duration-300 cursor-pointer shadow-[0_0_15px_rgba(0,150,255,0.05)]"
            >
              CONNECT_WITH_GITHUB
            </button>
            <a
              href={mounted ? getSubdomainUrl('home', '/login') : '/login'}
              className="text-[10px] font-mono text-muted-foreground hover:text-foreground hover:underline mt-1"
            >
              OR_AUTHORIZE_VIA_EMAIL
            </a>
          </div>
        ) : (
          /* Hub Grid */
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            
            {/* 1. Goals Portal */}
            <a href={mounted ? getSubdomainUrl('personal', '/goals') : '/goals'} className="group relative border border-secondary/15 bg-card/25 hover:bg-card/40 backdrop-blur-md rounded-xl p-6 transition-all duration-500 hover:shadow-[0_0_30px_rgba(0,150,255,0.1)] hover:border-secondary/40 overflow-hidden min-h-[220px] flex flex-col justify-between">
              <div className="absolute inset-0 bg-gradient-to-br from-blue-500/5 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-500" />
              <div>
                <span className="text-4xl mb-4 block group-hover:scale-110 transition-transform duration-300 group-hover:-rotate-6">🎯</span>
                <h3 className="text-xl font-bold font-mono text-foreground mb-2 group-hover:text-secondary transition-colors">Personal Goals</h3>
                <p className="text-xs text-muted-foreground leading-relaxed">Track short-term milestones, quarterly objectives, and long-term career aspirations with actionable steps.</p>
              </div>
              <div className="flex justify-end items-center mt-4 text-xs font-mono font-bold text-secondary opacity-0 group-hover:opacity-100 transition-all duration-300 translate-x-[-10px] group-hover:translate-x-0">
                ENTER_MODULE <span className="ml-2">→</span>
              </div>
            </a>

            {/* 2. Communication Portal */}
            <a href={mounted ? getSubdomainUrl('personal', '/communication') : '/communication'} className="group relative border border-purple-500/15 bg-card/25 hover:bg-card/40 backdrop-blur-md rounded-xl p-6 transition-all duration-500 hover:shadow-[0_0_30px_rgba(168,85,247,0.1)] hover:border-purple-500/40 overflow-hidden min-h-[220px] flex flex-col justify-between">
              <div className="absolute inset-0 bg-gradient-to-br from-purple-500/5 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-500" />
              <div>
                <span className="text-4xl mb-4 block group-hover:scale-110 transition-transform duration-300 group-hover:rotate-6">💬</span>
                <h3 className="text-xl font-bold font-mono text-foreground mb-2 group-hover:text-purple-400 transition-colors">Effective Comm</h3>
                <p className="text-xs text-muted-foreground leading-relaxed">Frameworks for active listening, conflict resolution, persuasive speaking, and professional networking.</p>
              </div>
              <div className="flex justify-end items-center mt-4 text-xs font-mono font-bold text-purple-400 opacity-0 group-hover:opacity-100 transition-all duration-300 translate-x-[-10px] group-hover:translate-x-0">
                ENTER_MODULE <span className="ml-2">→</span>
              </div>
            </a>

            {/* 3. Habits Portal */}
            <a href={mounted ? getSubdomainUrl('personal', '/habits') : '/habits'} className="group relative border border-emerald-500/15 bg-card/25 hover:bg-card/40 backdrop-blur-md rounded-xl p-6 transition-all duration-500 hover:shadow-[0_0_30px_rgba(16,185,129,0.1)] hover:border-emerald-500/40 overflow-hidden min-h-[220px] flex flex-col justify-between">
              <div className="absolute inset-0 bg-gradient-to-br from-emerald-500/5 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-500" />
              <div>
                <span className="text-4xl mb-4 block group-hover:scale-110 transition-transform duration-300 group-hover:-rotate-12">🌱</span>
                <h3 className="text-xl font-bold font-mono text-foreground mb-2 group-hover:text-emerald-400 transition-colors">Daily Habitations</h3>
                <p className="text-xs text-muted-foreground leading-relaxed">Visual heatmaps and streaks for daily routines. Build robust systems, not just goals.</p>
              </div>
              <div className="flex justify-end items-center mt-4 text-xs font-mono font-bold text-emerald-400 opacity-0 group-hover:opacity-100 transition-all duration-300 translate-x-[-10px] group-hover:translate-x-0">
                ENTER_MODULE <span className="ml-2">→</span>
              </div>
            </a>

            {/* 4. Finance Portal */}
            <a href={mounted ? getSubdomainUrl('personal', '/finance') : '/finance'} className="group relative border border-amber-500/15 bg-card/25 hover:bg-card/40 backdrop-blur-md rounded-xl p-6 transition-all duration-500 hover:shadow-[0_0_30px_rgba(245,158,11,0.1)] hover:border-amber-500/40 overflow-hidden min-h-[220px] flex flex-col justify-between md:col-span-2 lg:col-span-1">
              <div className="absolute inset-0 bg-gradient-to-br from-amber-500/5 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-500" />
              <div>
                <span className="text-4xl mb-4 block group-hover:scale-110 transition-transform duration-300 group-hover:-translate-y-2">📈</span>
                <h3 className="text-xl font-bold font-mono text-foreground mb-2 group-hover:text-amber-400 transition-colors">FinTrack Pro</h3>
                <p className="text-xs text-muted-foreground leading-relaxed">Comprehensive financial tracking dashboard. Manage expenses, EMIs, budgets, and investment growth portfolios.</p>
              </div>
              <div className="flex justify-end items-center mt-4 text-xs font-mono font-bold text-amber-400 opacity-0 group-hover:opacity-100 transition-all duration-300 translate-x-[-10px] group-hover:translate-x-0">
                ENTER_MODULE <span className="ml-2">→</span>
              </div>
            </a>

            {/* 5. Resume Portal */}
            <a href={mounted ? getSubdomainUrl('personal', '/resume') : '/resume'} className="group relative border border-rose-500/15 bg-card/25 hover:bg-card/40 backdrop-blur-md rounded-xl p-6 transition-all duration-500 hover:shadow-[0_0_30px_rgba(244,63,94,0.1)] hover:border-rose-500/40 overflow-hidden min-h-[220px] flex flex-col justify-between md:col-span-2 lg:col-span-2">
              <div className="absolute inset-0 bg-gradient-to-br from-rose-500/5 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-500" />
              <div>
                <div className="flex justify-between items-start">
                  <span className="text-4xl mb-4 block group-hover:scale-110 transition-transform duration-300">📄</span>
                  <span className="px-2 py-1 bg-rose-500/10 text-rose-400 border border-rose-500/30 text-[9px] font-mono font-bold rounded">EXPORTABLE</span>
                </div>
                <h3 className="text-xl font-bold font-mono text-foreground mb-2 group-hover:text-rose-400 transition-colors">Cyberspace Resume</h3>
                <p className="text-xs text-muted-foreground leading-relaxed max-w-lg">A fully-featured, dynamically generated professional CV. Track your certifications, skills matrix, past experiences, and operative level.</p>
              </div>
              <div className="flex justify-end items-center mt-4 text-xs font-mono font-bold text-rose-400 opacity-0 group-hover:opacity-100 transition-all duration-300 translate-x-[-10px] group-hover:translate-x-0">
                ENTER_MODULE <span className="ml-2">→</span>
              </div>
            </a>

          </div>
        )}

        {/* Back Link */}
        <div className="text-center mt-8">
          <a
            href={mounted ? getSubdomainUrl('home') : '/'}
            className="inline-flex items-center gap-2 text-xs font-mono font-bold text-muted-foreground hover:text-secondary transition-colors group"
          >
            <span className="group-hover:-translate-x-1 transition-transform">&lt;--</span>
            <span>SYSTEM_CORE_HOME</span>
          </a>
        </div>
      </div>
    </main>
  );
}
