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
          /* Dashboard Grid */
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            
            {/* Card 1: Agent Profile & Certifications */}
            <div className="relative border border-secondary/15 bg-card/25 backdrop-blur-md rounded-xl p-5 flex flex-col justify-between min-h-[360px]">
              <div className="absolute top-0 right-0 w-2 h-2 border-t-2 border-r-2 border-secondary/40" />
              <div className="absolute bottom-0 left-0 w-2 h-2 border-b-2 border-l-2 border-secondary/40" />

              <div>
                <span className="text-[9px] font-mono text-secondary tracking-widest block mb-2">// AGENT_IDENTIFICATION</span>
                <div className="flex items-center gap-4 border-b border-secondary/10 pb-4 mb-4">
                  <div className="w-14 h-14 rounded-full border-2 border-secondary/50 bg-background flex items-center justify-center text-2xl shadow-[0_0_12px_rgba(0,150,255,0.2)]">
                    👤
                  </div>
                  <div className="font-mono">
                    <h3 className="text-sm font-bold text-foreground">GOPISHEK_VALLEPU</h3>
                    <p className="text-[9px] text-secondary font-bold">TITLE: CYBER_OPERATIVE</p>
                    <p className="text-[9px] text-muted-foreground">SECTOR: DEVSECOPS_SEC</p>
                  </div>
                </div>

                {/* Certifications toggles */}
                <span className="text-[9px] font-mono text-muted-foreground block mb-2 font-bold tracking-wider">CERTIFICATE_DECK (CLICK TO UPDATE):</span>
                <div className="grid grid-cols-2 gap-2">
                  {certs.map(c => (
                    <button
                      key={c.id}
                      onClick={() => toggleCert(c.id)}
                      className={`p-2 rounded text-[10px] font-mono font-bold text-center border transition-all duration-300 ${
                        c.acquired
                          ? 'border-secondary/40 bg-secondary/10 text-secondary shadow-[0_0_8px_rgba(0,150,255,0.15)]'
                          : 'border-border bg-card/5 text-muted-foreground hover:border-secondary/25'
                      }`}
                    >
                      {c.name}
                    </button>
                  ))}
                </div>
              </div>

              <button
                onClick={compileCV}
                disabled={cvCompiling}
                className={`w-full py-2 mt-4 text-xs font-mono font-bold tracking-widest rounded-lg border transition-all duration-300 ${
                  cvCompiling
                    ? 'border-amber-500 text-amber-500 bg-transparent animate-pulse cursor-not-allowed'
                    : 'border-secondary text-secondary bg-secondary/5 hover:bg-secondary/15'
                }`}
              >
                {cvCompiling ? 'COMPILING_CV...' : 'GENERATE_CV_REPORT'}
              </button>
            </div>

            {/* Card 2: Objective Tracker Checklist */}
            <div className="relative border border-secondary/15 bg-card/25 backdrop-blur-md rounded-xl p-5 flex flex-col justify-between min-h-[360px]">
              <div className="absolute top-0 right-0 w-2 h-2 border-t-2 border-r-2 border-secondary/40" />
              <div className="absolute bottom-0 left-0 w-2 h-2 border-b-2 border-l-2 border-secondary/40" />

              <div>
                <span className="text-[9px] font-mono text-secondary tracking-widest block mb-3">// ACTIVE_OBJECTIVES</span>
                <div className="flex flex-col gap-3">
                  {tasks.map(t => (
                    <div
                      key={t.id}
                      onClick={() => toggleTask(t.id)}
                      className="flex items-center gap-3 cursor-pointer group"
                    >
                      <div className={`w-4 h-4 rounded border flex items-center justify-center transition-all ${
                        t.completed
                          ? 'border-secondary bg-secondary/15 text-secondary'
                          : 'border-border group-hover:border-secondary/40'
                      }`}>
                        {t.completed && <span className="text-[9px]">✔</span>}
                      </div>
                      <span className={`text-[11px] font-mono transition-colors ${
                        t.completed ? 'text-muted-foreground line-through' : 'text-foreground group-hover:text-foreground'
                      }`}>
                        {t.text}
                      </span>
                    </div>
                  ))}
                </div>
              </div>

              <div className="text-[9px] font-mono text-muted-foreground text-center border-t border-secondary/10 pt-3 mt-4">
                * Resolving active objectives boosts operative tier levels.
              </div>
            </div>

            {/* Card 3: Skill Matrix Levels */}
            <div className="relative border border-secondary/15 bg-card/25 backdrop-blur-md rounded-xl p-5 flex flex-col justify-between min-h-[360px]">
              <div className="absolute top-0 right-0 w-2 h-2 border-t-2 border-r-2 border-secondary/40" />
              <div className="absolute bottom-0 left-0 w-2 h-2 border-b-2 border-l-2 border-secondary/40" />

              <div>
                <span className="text-[9px] font-mono text-secondary tracking-widest block mb-3">// COGNITIVE_SKILL_MATRIX</span>
                <div className="space-y-4">
                  {skills.map(s => (
                    <div key={s.name} className="flex flex-col gap-1.5 font-mono">
                      <div className="flex justify-between items-center text-[10px] text-muted-foreground">
                        <span>{s.name}</span>
                        <span className="text-secondary font-bold">{s.level}%</span>
                      </div>
                      
                      <div className="flex gap-2 items-center">
                        <div className="flex-1 h-2 bg-background rounded-full overflow-hidden border border-secondary/10">
                          <div
                            className="h-full bg-gradient-to-r from-[#0096ff] to-[#00f0ff] transition-all duration-300"
                            style={{ width: `${s.level}%` }}
                          />
                        </div>
                        <button
                          onClick={() => trainSkill(s.name)}
                          disabled={loading}
                          className="px-2 py-0.5 rounded border border-secondary/30 text-[8px] text-secondary hover:bg-secondary/10 font-bold active:scale-95 transition-all disabled:opacity-50"
                        >
                          TRAIN
                        </button>
                      </div>
                    </div>
                  ))}
                </div>
              </div>

              <div className="text-[9px] font-mono text-muted-foreground text-center border-t border-secondary/10 pt-3 mt-4">
                Train competencies iteratively to secure final sandbox clearances.
              </div>
            </div>

          </div>
        )}

        {/* Back Link */}
        <div className="text-center mt-4">
          <a
            href={mounted ? getSubdomainUrl('home') : '/'}
            className="inline-flex items-center gap-2 text-xs font-mono font-bold text-muted-foreground hover:text-secondary transition-colors"
          >
            <span>&lt;--</span>
            <span>SYSTEM_CORE_HOME</span>
          </a>
        </div>
      </div>
    </main>
  );
}
