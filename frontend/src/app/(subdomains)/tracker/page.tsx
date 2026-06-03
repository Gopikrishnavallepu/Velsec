'use client';

import { useState } from 'react';
import ParticleField from '@/components/ui/ParticleField';

interface Badge {
  id: string;
  name: string;
  icon: string;
  description: string;
  unlocked: boolean;
  unlockedAt?: string;
}

export default function TrackerPage() {
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

  const [activeBadge, setActiveBadge] = useState<Badge | null>(null);

  // Simulate solving a lab
  const solveLabSimulate = () => {
    // Increase lab solved
    const nextSolved = solvedLabs + 1;
    setSolvedLabs(nextSolved);

    // Update history array by appending new count
    setLabHistory([...labHistory, nextSolved]);

    // Increase XP
    const nextXp = xp + 350;
    if (nextXp >= 4000 && level < 4) {
      setLevel(4);
      setXp(nextXp - 4000);
      
      // Unlock Cloud Tamer badge
      setBadges(badges.map(b => b.id === 'cloud_tamer' ? { ...b, unlocked: true, unlockedAt: 'Just Now' } : b));
      alert('[LEVEL UP] Congratulations! You reached Operative Level 4 and unlocked the Cloud Tamer badge!');
    } else {
      setXp(nextXp);
    }
  };

  const xpMax = 4000;
  const xpPercent = Math.min((xp / xpMax) * 100, 100);

  // Generate SVG coordinates for history graph
  // Assume width of graph is 300, height is 100
  const width = 320;
  const height = 110;
  const padding = 15;
  const points = labHistory.map((val, idx) => {
    const x = padding + (idx * (width - padding * 2)) / (labHistory.length - 1);
    const maxVal = Math.max(...labHistory, 20);
    const y = height - padding - (val * (height - padding * 2)) / maxVal;
    return { x, y };
  });
  
  const pathData = points.reduce((acc, p, i) => {
    return i === 0 ? `M ${p.x} ${p.y}` : `${acc} L ${p.x} ${p.y}`;
  }, '');

  return (
    <main className="relative min-h-screen overflow-x-hidden pt-24 pb-16 px-4 md:px-8 bg-[#050a18]">
      <ParticleField />
      
      {/* Background vignette overlay */}
      <div className="fixed inset-0 -z-5 pointer-events-none bg-gradient-to-t from-[#050a18] via-transparent to-[#050a18]/40" />

      <div className="z-10 max-w-6xl mx-auto flex flex-col gap-8">
        
        {/* Page Header */}
        <div className="relative border border-[#0096ff]/20 bg-[#0a1432]/30 backdrop-blur-md p-6 rounded-2xl flex flex-col md:flex-row md:items-center md:justify-between gap-4">
          <div className="absolute top-0 left-0 w-2 h-2 border-t-2 border-l-2 border-[#0096ff]" />
          <div className="absolute top-0 right-0 w-2 h-2 border-t-2 border-r-2 border-[#0096ff]" />
          <div className="absolute bottom-0 left-0 w-2 h-2 border-b-2 border-l-2 border-[#0096ff]" />
          <div className="absolute bottom-0 right-0 w-2 h-2 border-b-2 border-r-2 border-[#0096ff]" />
          
          <div>
            <div className="flex items-center gap-2 mb-1">
              <span className="w-2 h-2 bg-[#0096ff] rounded-full animate-ping" />
              <span className="text-[10px] font-mono text-[#0096ff] tracking-[0.3em] font-bold">V_TRACKER</span>
            </div>
            <h1 className="text-3xl font-extrabold font-mono tracking-wider">
              TRACKER<span className="text-[#0096ff]">.VELSEC</span>
            </h1>
            <p className="text-xs text-zinc-400 font-mono mt-1">
              Operative Experience, Achievement Matrix &amp; Activity Overviews
            </p>
          </div>

          <div className="flex gap-4 border-l border-[#0096ff]/15 pl-0 md:pl-6 pt-4 md:pt-0">
            <div className="text-center font-mono">
              <p className="text-[10px] text-zinc-500 font-bold">SOLVED_LABS</p>
              <p className="text-lg font-extrabold text-[#0096ff]">{solvedLabs}</p>
            </div>
            <div className="text-center font-mono">
              <p className="text-[10px] text-zinc-500 font-bold">OPERATIVE_RANK</p>
              <p className="text-lg font-extrabold text-[#0096ff]">{level >= 4 ? 'ELITE_DEFENDER' : 'APPRENTICE'}</p>
            </div>
          </div>
        </div>

        {/* main tracker dashboard layouts */}
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6 items-stretch">
          
          {/* Column 1: XP Progress & Level card */}
          <div className="relative border border-[#0096ff]/15 bg-[#0a1432]/25 backdrop-blur-md rounded-xl p-5 flex flex-col justify-between min-h-[350px]">
            <div className="absolute top-0 right-0 w-2 h-2 border-t-2 border-r-2 border-[#0096ff]/40" />
            <div className="absolute bottom-0 left-0 w-2 h-2 border-b-2 border-l-2 border-[#0096ff]/40" />

            <div>
              <span className="text-[9px] font-mono text-[#0096ff] tracking-widest block mb-4">// EXPERIENCE_MATRICES</span>
              
              <div className="flex justify-between items-end mb-3 font-mono">
                <div>
                  <span className="text-[10px] text-zinc-500 block font-bold">LEVEL</span>
                  <span className="text-4xl font-extrabold text-zinc-100">{level}</span>
                </div>
                <div className="text-right text-xs font-bold text-zinc-400">
                  <span className="text-[#0096ff]">{xp}</span> / {xpMax} XP
                </div>
              </div>

              {/* Progress bar */}
              <div className="w-full h-3 bg-[#050a18] rounded-full overflow-hidden border border-[#0096ff]/15 mb-6">
                <div
                  className="h-full bg-gradient-to-r from-[#0096ff] to-[#00f0ff] transition-all duration-500 shadow-[0_0_8px_rgba(0,150,255,0.4)]"
                  style={{ width: `${xpPercent}%` }}
                />
              </div>

              <p className="text-[11px] font-mono text-zinc-400 leading-relaxed">
                Complete modules across Learn &amp; Projects subdomains to collect experience logs. Reaching Level 4 unlocks advanced Cloud namespace operations.
              </p>
            </div>

            <button
              onClick={solveLabSimulate}
              className="w-full py-2.5 bg-[#0096ff]/10 hover:bg-[#0096ff]/20 active:scale-98 text-xs font-mono font-bold tracking-widest text-[#0096ff] rounded-lg border border-[#0096ff]/35 transition-all duration-300 shadow-[0_0_12px_rgba(0,150,255,0.05)]"
            >
              SIMULATE_LAB_COMPLETION (+350 XP)
            </button>
          </div>

          {/* Column 2: Solved Labs Graph SVG */}
          <div className="relative border border-[#0096ff]/15 bg-[#0a1432]/25 backdrop-blur-md rounded-xl p-5 flex flex-col justify-between min-h-[350px]">
            <div className="absolute top-0 right-0 w-2 h-2 border-t-2 border-r-2 border-[#0096ff]/40" />
            <div className="absolute bottom-0 left-0 w-2 h-2 border-b-2 border-l-2 border-[#0096ff]/40" />

            <div>
              <span className="text-[9px] font-mono text-[#0096ff] tracking-widest block mb-4">// ACTIVITY_HISTORY</span>
              
              {/* SVG Area graph */}
              <div className="flex justify-center items-center bg-[#050a18]/70 border border-[#0a1a40] rounded-lg p-3">
                <svg width="100%" height={height} viewBox={`0 0 ${width} ${height}`} className="overflow-visible">
                  {/* Grid Lines */}
                  <line x1={padding} y1={padding} x2={width-padding} y2={padding} stroke="#0a1a40" strokeWidth={1} strokeDasharray="3 3" />
                  <line x1={padding} y1={height-padding} x2={width-padding} y2={height-padding} stroke="#0a1a40" strokeWidth={1} />
                  
                  {/* Line Path */}
                  <path
                    d={pathData}
                    fill="none"
                    stroke="#0096ff"
                    strokeWidth={2}
                    className="transition-all duration-500"
                  />

                  {/* Nodes */}
                  {points.map((p, idx) => (
                    <circle
                      key={idx}
                      cx={p.x}
                      cy={p.y}
                      r={4}
                      className="fill-[#050a18] stroke-[#0096ff] stroke-2 hover:scale-125 transition-transform duration-300 cursor-pointer"
                    />
                  ))}
                </svg>
              </div>
            </div>

            <div className="text-[9px] font-mono text-zinc-500 text-center border-t border-[#0096ff]/10 pt-3">
              Real-time activity logs tracked across global Velsec systems.
            </div>
          </div>

          {/* Column 3: Badge Matrix */}
          <div className="relative border border-[#0096ff]/15 bg-[#0a1432]/25 backdrop-blur-md rounded-xl p-5 flex flex-col justify-between min-h-[350px]">
            <div className="absolute top-0 right-0 w-2 h-2 border-t-2 border-r-2 border-[#0096ff]/40" />
            <div className="absolute bottom-0 left-0 w-2 h-2 border-b-2 border-l-2 border-[#0096ff]/40" />

            <div>
              <span className="text-[9px] font-mono text-[#0096ff] tracking-widest block mb-4">// ACHIEVEMENT_MATRIX</span>
              
              <div className="grid grid-cols-4 gap-3">
                {badges.map(b => (
                  <div
                    key={b.id}
                    onMouseEnter={() => setActiveBadge(b)}
                    onMouseLeave={() => setActiveBadge(null)}
                    className={`h-12 rounded-lg border flex items-center justify-center text-xl cursor-help transition-all duration-300 ${
                      b.unlocked
                        ? 'border-[#0096ff]/35 bg-[#0096ff]/10 shadow-[0_0_10px_rgba(0,150,255,0.1)]'
                        : 'border-[#0a1a40] bg-[#0a1432]/5 opacity-30'
                    }`}
                  >
                    {b.icon}
                  </div>
                ))}
              </div>
            </div>

            {/* Hover details container */}
            <div className="border border-[#0a1a40] bg-[#050a18]/80 rounded-lg p-3 min-h-[90px] font-mono text-[10px]">
              {activeBadge ? (
                <div>
                  <h4 className="font-bold text-[#0096ff]">{activeBadge.name}</h4>
                  <p className="text-zinc-400 mt-1">{activeBadge.description}</p>
                  {activeBadge.unlocked && (
                    <span className="text-[8px] text-zinc-500 mt-2 block">UNLOCKED: {activeBadge.unlockedAt}</span>
                  )}
                </div>
              ) : (
                <div className="text-zinc-500 text-center flex items-center justify-center h-full min-h-[66px]">
                  HOVER_OVER_BADGES_FOR_DETAILS
                </div>
              )}
            </div>

          </div>

        </div>

        {/* Back Link */}
        <div className="text-center mt-4">
          <a
            href="http://velsec.com:3000"
            className="inline-flex items-center gap-2 text-xs font-mono font-bold text-zinc-500 hover:text-[#0096ff] transition-colors"
          >
            <span>&lt;--</span>
            <span>SYSTEM_CORE_HOME</span>
          </a>
        </div>
      </div>
    </main>
  );
}
