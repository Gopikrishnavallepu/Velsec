'use client';

import { useState, useEffect } from 'react';
import ParticleField from '@/components/ui/ParticleField';
import { getSubdomainUrl } from '@/utils/navigation';
import { createClient } from '@/utils/supabase/client';

import GlassCard from '@/components/ui/GlassCard';
import TiltWrapper from '@/components/ui/TiltWrapper';
import AnimatedButton from '@/components/ui/AnimatedButton';
import { motion, Variants, AnimatePresence } from 'framer-motion';

interface Badge {
  id: string;
  name: string;
  icon: string;
  description: string;
  unlocked: boolean;
  unlockedAt?: string;
}

export default function TrackerPage() {
  const supabase = createClient();
  const [mounted, setMounted] = useState(false);

  const [xp, setXp] = useState<number>(3450);
  const [level, setLevel] = useState<number>(3);
  const [solvedLabs, setSolvedLabs] = useState<number>(14);
  const [labHistory, setLabHistory] = useState<number[]>([2, 5, 8, 12, 14]); // Solved labs over time

  const [badges, setBadges] = useState<Badge[]>([
    { id: 'first_blood', name: 'First Blood', icon: '🩸', description: 'Solve your first practical lab sandbox.', unlocked: true, unlockedAt: '2026-05-10' },
    { id: 'buffer_buster', name: 'Buffer Buster', icon: '💥', description: 'Complete stack overflow binary execution.', unlocked: true, unlockedAt: '2026-05-18' },
    { id: 'cloud_tamer', name: 'Cloud Tamer', icon: '☁️', description: 'Resolve container namespace escapes.', unlocked: false },
    { id: 'secops_master', name: 'SecOps Master', icon: '👑', description: 'Configure secure automated staging pipelines.', unlocked: false },
  ]);

  const [skills, setSkills] = useState<any[]>([]);
  const [certs, setCerts] = useState<any[]>([]);

  const [activeBadge, setActiveBadge] = useState<Badge | null>(null);
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
          redirectTo: getSubdomainUrl('home', '/auth/callback?next=' + encodeURIComponent(getSubdomainUrl('tracker'))),
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
      setSkills(data.skills);
      setCerts(data.certs);
    } catch (err: any) {
      console.warn("Failed to connect to API, using default local tracker state:", err);
      setErrorMsg("Offline fallback mode active.");
    } finally {
      setLoading(false);
    }
  };

  const saveProfile = async (nextXp: number, nextLvl: number, nextSolved: number, nextHistory: number[], nextBadges: Badge[]) => {
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
          xp: nextXp,
          level: nextLvl,
          solved_labs: nextSolved,
          lab_history: nextHistory,
          skills: skills.length > 0 ? skills : [
            {"name": "Python Scripting", "level": 75},
            {"name": "Docker / Kubernetes Sec", "level": 50},
            {"name": "Linux System Internals", "level": 60},
            {"name": "Threat Hunting (ELK)", "level": 40}
          ],
          certs: certs.length > 0 ? certs : [
            {"id": "secplus", "name": "Security+", "acquired": true},
            {"id": "oscp", "name": "OSCP", "acquired": false},
            {"id": "cissp", "name": "CISSP", "acquired": false},
            {"id": "ceh", "name": "CEH", "acquired": true}
          ],
          badges: nextBadges
        })
      });
    } catch (err) {
      console.error("Failed to persist profile updates:", err);
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

  // Simulate solving a lab
  const solveLabSimulate = () => {
    // Increase lab solved
    const nextSolved = solvedLabs + 1;
    setSolvedLabs(nextSolved);

    // Update history array by appending new count
    const nextHistory = [...labHistory, nextSolved];
    setLabHistory(nextHistory);

    // Increase XP
    const nextXp = xp + 350;
    let nextLvl = level;
    let nextBadges = [...badges];

    if (nextXp >= 4000 && level < 4) {
      nextLvl = 4;
      setLevel(4);
      setXp(nextXp - 4000);
      
      // Unlock Cloud Tamer badge
      nextBadges = badges.map(b => b.id === 'cloud_tamer' ? { ...b, unlocked: true, unlockedAt: 'Just Now' } : b);
      setBadges(nextBadges);
      alert('[LEVEL UP] Congratulations! You reached Operative Level 4 and unlocked the Cloud Tamer badge!');
      saveProfile(nextXp - 4000, 4, nextSolved, nextHistory, nextBadges);
    } else {
      setXp(nextXp);
      saveProfile(nextXp, nextLvl, nextSolved, nextHistory, nextBadges);
    }
  };

  const xpMax = 4000;
  const xpPercent = Math.min((xp / xpMax) * 100, 100);

  // Generate SVG coordinates for history graph
  // Assume width of graph is 320, height is 110
  const width = 320;
  const height = 110;
  const padding = 15;
  
  // Guard divisor to prevent divide-by-zero NaN coordinates when labHistory length is <= 1
  const divisor = labHistory.length > 1 ? labHistory.length - 1 : 1;

  const points = labHistory.map((val, idx) => {
    const x = padding + (idx * (width - padding * 2)) / divisor;
    const maxVal = Math.max(...labHistory, 20);
    const y = height - padding - (val * (height - padding * 2)) / maxVal;
    return { x, y };
  });
  
  const pathData = points.reduce((acc, p, i) => {
    return i === 0 ? `M ${p.x} ${p.y}` : `${acc} L ${p.x} ${p.y}`;
  }, '');

  const containerVariants: Variants = {
    hidden: { opacity: 0 },
    show: {
      opacity: 1,
      transition: {
        staggerChildren: 0.1
      }
    }
  };

  const itemVariants: Variants = {
    hidden: { opacity: 0, y: 20 },
    show: { opacity: 1, y: 0, transition: { duration: 0.6 } }
  };

  return (
    <main className="relative min-h-screen overflow-x-hidden pt-24 pb-16 px-4 md:px-8 z-10">
      
      <div className="z-10 max-w-6xl mx-auto flex flex-col gap-8">
        
        {/* Page Header */}
        <GlassCard glowColor="blue" className="p-6">
          <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
            <div>
              <div className="flex items-center gap-2 mb-1">
                <span className="w-2 h-2 bg-secondary rounded-full animate-ping" />
                <span className="text-[10px] font-mono text-secondary tracking-[0.3em] font-bold">V_TRACKER</span>
              </div>
              <h1 className="text-3xl font-extrabold font-mono tracking-wider">
                TRACKER<span className="text-secondary">.VELSEC</span>
              </h1>
              <p className="text-xs text-muted-foreground font-mono mt-1">
                Operative Experience, Achievement Matrix &amp; Activity Overviews
              </p>
            </div>

            <div className="flex gap-4 border-l border-secondary/15 pl-0 md:pl-6 pt-4 md:pt-0">
              <div className="text-center font-mono">
                <p className="text-[10px] text-muted-foreground font-bold">SOLVED_LABS</p>
                <p className="text-lg font-extrabold text-secondary">{solvedLabs}</p>
              </div>
              <div className="text-center font-mono">
                <p className="text-[10px] text-muted-foreground font-bold">OPERATIVE_RANK</p>
                <p className="text-lg font-extrabold text-secondary">{level >= 4 ? 'ELITE_DEFENDER' : 'APPRENTICE'}</p>
              </div>
            </div>
          </div>
        </GlassCard>

        {errorMsg && (
          <div className="p-3.5 border border-amber-500/30 bg-amber-500/10 rounded-xl text-xs font-mono text-amber-400 text-center shadow-[0_0_15px_rgba(245,158,11,0.05)]">
            ⚠️ {errorMsg}
          </div>
        )}

        {!isAuthenticated ? (
          /* Authentication Required Alert */
          <GlassCard glowColor="none" className="p-12 text-center flex flex-col items-center justify-center gap-4 max-w-xl mx-auto my-8 border-rose-500/25 bg-rose-500/5">
            <span className="text-4xl">🔒</span>
            <h2 className="text-xl font-bold font-mono text-rose-400 tracking-wider">ACCESS_DENIED_SECURE_GATEWAY</h2>
            <p className="text-xs text-muted-foreground font-mono max-w-md leading-relaxed">
              Velsec operative tracker and experience logs are encrypted at rest. Please authorize your session credentials at the central security gateway.
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
          </GlassCard>
        ) : (
          /* Main Tracker Dashboard Layouts */
          <motion.div 
            variants={containerVariants} 
            initial="hidden" 
            animate="show"
            className="grid grid-cols-1 lg:grid-cols-3 gap-6 items-stretch"
          >
            
            {/* Column 1: XP Progress & Level card */}
            <motion.div variants={itemVariants}>
              <TiltWrapper intensity={8} className="h-full">
                <div className="relative border border-white/10 hover:border-secondary/40 bg-black/5 dark:bg-black/40 hover:bg-black/10 dark:hover:bg-black/60 transition-colors backdrop-blur-md rounded-xl p-6 flex flex-col justify-between min-h-[350px]">
                  
                  <div>
                    <span className="text-[9px] font-mono text-secondary tracking-widest block mb-4">// EXPERIENCE_MATRICES</span>
                    
                    <div className="flex justify-between items-end mb-3 font-mono">
                      <div>
                        <span className="text-[10px] text-muted-foreground block font-bold">LEVEL</span>
                        <span className="text-5xl font-black text-foreground drop-shadow-[0_0_15px_rgba(255,255,255,0.3)]">{level}</span>
                      </div>
                      <div className="text-right text-xs font-bold text-muted-foreground">
                        <span className="text-secondary">{xp}</span> / {xpMax} XP
                      </div>
                    </div>

                    {/* Progress bar */}
                    <div className="w-full h-4 bg-background/50 rounded-full overflow-hidden border border-white/10 mb-6 shadow-inner">
                      <div
                        className="h-full bg-gradient-to-r from-[#0096ff] to-[#39ff14] transition-all duration-700 ease-out shadow-[0_0_15px_rgba(0,150,255,0.6)] relative"
                        style={{ width: `${xpPercent}%` }}
                      >
                        <div className="absolute top-0 right-0 bottom-0 w-8 bg-gradient-to-l from-white/40 to-transparent" />
                      </div>
                    </div>

                    <p className="text-[11px] font-mono text-muted-foreground leading-relaxed">
                      Complete modules across Learn &amp; Projects subdomains to collect experience logs. Reaching Level 4 unlocks advanced Cloud namespace operations.
                    </p>
                  </div>

                  <AnimatedButton
                    onClick={solveLabSimulate}
                    disabled={loading}
                    glowColor="blue"
                    className="w-full mt-6"
                  >
                    SIMULATE_LAB (+350 XP)
                  </AnimatedButton>
                </div>
              </TiltWrapper>
            </motion.div>

            {/* Column 2: Solved Labs Graph SVG */}
            <motion.div variants={itemVariants}>
              <TiltWrapper intensity={5} className="h-full">
                <div className="relative border border-white/10 hover:border-secondary/40 bg-black/5 dark:bg-black/40 hover:bg-black/10 dark:hover:bg-black/60 transition-colors backdrop-blur-md rounded-xl p-6 flex flex-col justify-between min-h-[350px]">
                  
                  <div>
                    <span className="text-[9px] font-mono text-secondary tracking-widest block mb-4">// ACTIVITY_HISTORY</span>
                    
                    {/* SVG Area graph */}
                    <div className="flex justify-center items-center bg-black/5 dark:bg-black/50 border border-white/10 rounded-xl p-4 shadow-inner">
                      <svg width="100%" height={height} viewBox={`0 0 ${width} ${height}`} className="overflow-visible">
                        {/* Grid Lines */}
                        <line x1={padding} y1={padding} x2={width-padding} y2={padding} stroke="#ffffff" strokeOpacity={0.05} strokeWidth={1} strokeDasharray="4 4" />
                        <line x1={padding} y1={height-padding} x2={width-padding} y2={height-padding} stroke="#ffffff" strokeOpacity={0.1} strokeWidth={1} />
                        
                        {/* Line Path */}
                        {points.length > 0 && (
                          <path
                            d={pathData}
                            fill="none"
                            stroke="#0096ff"
                            strokeWidth={3}
                            className="transition-all duration-500 drop-shadow-[0_0_8px_rgba(0,150,255,0.8)]"
                          />
                        )}

                        {/* Nodes */}
                        {points.map((p, idx) => (
                          <circle
                            key={idx}
                            cx={p.x}
                            cy={p.y}
                            r={5}
                            className="fill-[#0096ff] stroke-black stroke-[3px] hover:scale-150 transition-transform duration-300 cursor-pointer drop-shadow-[0_0_5px_rgba(0,150,255,1)]"
                          />
                        ))}
                      </svg>
                    </div>
                  </div>

                  <div className="text-[10px] font-mono text-muted-foreground text-center border-t border-white/10 pt-4 mt-4">
                    Real-time activity logs tracked across global Velsec systems.
                  </div>
                </div>
              </TiltWrapper>
            </motion.div>

            {/* Column 3: Badge Matrix */}
            <motion.div variants={itemVariants}>
              <TiltWrapper intensity={8} className="h-full">
                <div className="relative border border-white/10 hover:border-secondary/40 bg-black/5 dark:bg-black/40 hover:bg-black/10 dark:hover:bg-black/60 transition-colors backdrop-blur-md rounded-xl p-6 flex flex-col justify-between min-h-[350px]">
                  
                  <div>
                    <span className="text-[9px] font-mono text-secondary tracking-widest block mb-4">// ACHIEVEMENT_MATRIX</span>
                    
                    <div className="grid grid-cols-4 gap-3">
                      {badges.map(b => (
                        <div
                          key={b.id}
                          onMouseEnter={() => setActiveBadge(b)}
                          onMouseLeave={() => setActiveBadge(null)}
                          className={`h-14 rounded-xl border flex items-center justify-center text-2xl cursor-help transition-all duration-300 ${
                            b.unlocked
                              ? 'border-secondary/50 bg-secondary/20 shadow-[0_0_15px_rgba(0,150,255,0.3)] scale-100 hover:scale-110'
                              : 'border-white/5 bg-black/5 dark:bg-black/50 opacity-40 grayscale'
                          }`}
                        >
                          {b.icon}
                        </div>
                      ))}
                    </div>
                  </div>

                  {/* Hover details container */}
                  <div className="border border-white/10 bg-black/5 dark:bg-black/50 rounded-xl p-4 min-h-[110px] font-mono text-[10px] mt-6 shadow-inner">
                    <AnimatePresence mode="wait">
                      {activeBadge ? (
                        <motion.div
                          key={activeBadge.id}
                          initial={{ opacity: 0, y: 5 }}
                          animate={{ opacity: 1, y: 0 }}
                          exit={{ opacity: 0, y: -5 }}
                          transition={{ duration: 0.2 }}
                        >
                          <h4 className="font-bold text-secondary text-xs">{activeBadge.name}</h4>
                          <p className="text-muted-foreground mt-1.5 text-[11px] leading-relaxed">{activeBadge.description}</p>
                          {activeBadge.unlocked && (
                            <span className="text-[9px] text-[#39ff14] mt-2 block font-bold">UNLOCKED: {activeBadge.unlockedAt}</span>
                          )}
                        </motion.div>
                      ) : (
                        <motion.div
                          key="empty"
                          initial={{ opacity: 0 }}
                          animate={{ opacity: 1 }}
                          exit={{ opacity: 0 }}
                          className="text-muted-foreground text-center flex items-center justify-center h-full min-h-[76px]"
                        >
                          HOVER_OVER_BADGES_FOR_DETAILS
                        </motion.div>
                      )}
                    </AnimatePresence>
                  </div>

                </div>
              </TiltWrapper>
            </motion.div>

          </motion.div>
        )}

        {/* Back Link */}
        <div className="text-center mt-6">
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
