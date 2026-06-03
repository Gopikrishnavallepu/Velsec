'use client';

import { useState, useEffect } from 'react';
import ParticleField from '@/components/ui/ParticleField';
import { getSubdomainUrl } from '@/utils/navigation';

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
  const [mounted, setMounted] = useState(false);
  useEffect(() => {
    setMounted(true);
  }, []);

  // Tasks list state
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

  // Toggle tasks
  const toggleTask = (id: number) => {
    setTasks(tasks.map(t => t.id === id ? { ...t, completed: !t.completed } : t));
  };

  // Toggle certification acquired status
  const toggleCert = (id: string) => {
    setCerts(certs.map(c => c.id === id ? { ...c, acquired: !c.acquired } : c));
  };

  // Increment skills level
  const trainSkill = (name: string) => {
    setSkills(skills.map(s => {
      if (s.name === name) {
        const nextLvl = Math.min(s.level + 5, 100);
        return { ...s, level: nextLvl };
      }
      return s;
    }));
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
              <span className="text-[10px] font-mono text-[#0096ff] tracking-[0.3em] font-bold">V_PERSONAL</span>
            </div>
            <h1 className="text-3xl font-extrabold font-mono tracking-wider">
              PERSONAL<span className="text-[#0096ff]">.VELSEC</span>
            </h1>
            <p className="text-xs text-zinc-400 font-mono mt-1">
              Career Milestones, Daily Objectives &amp; Cyber Skill Matrix
            </p>
          </div>

          <div className="flex gap-4 border-l border-[#0096ff]/15 pl-0 md:pl-6 pt-4 md:pt-0">
            <div className="text-center font-mono">
              <p className="text-[10px] text-zinc-500 font-bold">SOLVED_TASKS</p>
              <p className="text-lg font-extrabold text-[#0096ff]">{completedCount} / {tasks.length}</p>
            </div>
            <div className="text-center font-mono">
              <p className="text-[10px] text-zinc-500 font-bold">OPERATIVE_LVL</p>
              <p className="text-lg font-extrabold text-[#0096ff]">03</p>
            </div>
          </div>
        </div>

        {/* Dashboard Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          
          {/* Card 1: Agent Profile & Certifications */}
          <div className="relative border border-[#0096ff]/15 bg-[#0a1432]/25 backdrop-blur-md rounded-xl p-5 flex flex-col justify-between min-h-[360px]">
            <div className="absolute top-0 right-0 w-2 h-2 border-t-2 border-r-2 border-[#0096ff]/40" />
            <div className="absolute bottom-0 left-0 w-2 h-2 border-b-2 border-l-2 border-[#0096ff]/40" />

            <div>
              <span className="text-[9px] font-mono text-[#0096ff] tracking-widest block mb-2">// AGENT_IDENTIFICATION</span>
              <div className="flex items-center gap-4 border-b border-[#0096ff]/10 pb-4 mb-4">
                <div className="w-14 h-14 rounded-full border-2 border-[#0096ff]/50 bg-[#050a18] flex items-center justify-center text-2xl shadow-[0_0_12px_rgba(0,150,255,0.2)]">
                  👤
                </div>
                <div className="font-mono">
                  <h3 className="text-sm font-bold text-zinc-200">GOPISHEK_VALLEPU</h3>
                  <p className="text-[9px] text-[#0096ff] font-bold">TITLE: CYBER_OPERATIVE</p>
                  <p className="text-[9px] text-zinc-500">SECTOR: DEVSECOPS_SEC</p>
                </div>
              </div>

              {/* Certifications toggles */}
              <span className="text-[9px] font-mono text-zinc-500 block mb-2 font-bold tracking-wider">CERTIFICATE_DECK (CLICK TO UPDATE):</span>
              <div className="grid grid-cols-2 gap-2">
                {certs.map(c => (
                  <button
                    key={c.id}
                    onClick={() => toggleCert(c.id)}
                    className={`p-2 rounded text-[10px] font-mono font-bold text-center border transition-all duration-300 ${
                      c.acquired
                        ? 'border-[#0096ff]/40 bg-[#0096ff]/10 text-[#0096ff] shadow-[0_0_8px_rgba(0,150,255,0.15)]'
                        : 'border-[#0a1a40] bg-[#0a1432]/5 text-zinc-500 hover:border-[#0096ff]/25'
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
                  : 'border-[#0096ff] text-[#0096ff] bg-[#0096ff]/5 hover:bg-[#0096ff]/15'
              }`}
            >
              {cvCompiling ? 'COMPILING_CV...' : 'GENERATE_CV_REPORT'}
            </button>
          </div>

          {/* Card 2: Objective Tracker Checklist */}
          <div className="relative border border-[#0096ff]/15 bg-[#0a1432]/25 backdrop-blur-md rounded-xl p-5 flex flex-col justify-between min-h-[360px]">
            <div className="absolute top-0 right-0 w-2 h-2 border-t-2 border-r-2 border-[#0096ff]/40" />
            <div className="absolute bottom-0 left-0 w-2 h-2 border-b-2 border-l-2 border-[#0096ff]/40" />

            <div>
              <span className="text-[9px] font-mono text-[#0096ff] tracking-widest block mb-3">// ACTIVE_OBJECTIVES</span>
              <div className="flex flex-col gap-3">
                {tasks.map(t => (
                  <div
                    key={t.id}
                    onClick={() => toggleTask(t.id)}
                    className="flex items-center gap-3 cursor-pointer group"
                  >
                    <div className={`w-4 h-4 rounded border flex items-center justify-center transition-all ${
                      t.completed
                        ? 'border-[#0096ff] bg-[#0096ff]/15 text-[#0096ff]'
                        : 'border-[#0a1a40] group-hover:border-[#0096ff]/40'
                    }`}>
                      {t.completed && <span className="text-[9px]">✔</span>}
                    </div>
                    <span className={`text-[11px] font-mono transition-colors ${
                      t.completed ? 'text-zinc-500 line-through' : 'text-zinc-300 group-hover:text-zinc-200'
                    }`}>
                      {t.text}
                    </span>
                  </div>
                ))}
              </div>
            </div>

            <div className="text-[9px] font-mono text-zinc-500 text-center border-t border-[#0096ff]/10 pt-3 mt-4">
              * Resolving active objectives boosts operative tier levels.
            </div>
          </div>

          {/* Card 3: Skill Matrix Levels */}
          <div className="relative border border-[#0096ff]/15 bg-[#0a1432]/25 backdrop-blur-md rounded-xl p-5 flex flex-col justify-between min-h-[360px]">
            <div className="absolute top-0 right-0 w-2 h-2 border-t-2 border-r-2 border-[#0096ff]/40" />
            <div className="absolute bottom-0 left-0 w-2 h-2 border-b-2 border-l-2 border-[#0096ff]/40" />

            <div>
              <span className="text-[9px] font-mono text-[#0096ff] tracking-widest block mb-3">// COGNITIVE_SKILL_MATRIX</span>
              <div className="space-y-4">
                {skills.map(s => (
                  <div key={s.name} className="flex flex-col gap-1.5 font-mono">
                    <div className="flex justify-between items-center text-[10px] text-zinc-400">
                      <span>{s.name}</span>
                      <span className="text-[#0096ff] font-bold">{s.level}%</span>
                    </div>
                    
                    <div className="flex gap-2 items-center">
                      <div className="flex-1 h-2 bg-[#050a18] rounded-full overflow-hidden border border-[#0096ff]/10">
                        <div
                          className="h-full bg-gradient-to-r from-[#0096ff] to-[#00f0ff] transition-all duration-300"
                          style={{ width: `${s.level}%` }}
                        />
                      </div>
                      <button
                        onClick={() => trainSkill(s.name)}
                        className="px-2 py-0.5 rounded border border-[#0096ff]/30 text-[8px] text-[#0096ff] hover:bg-[#0096ff]/10 font-bold active:scale-95 transition-all"
                      >
                        TRAIN
                      </button>
                    </div>
                  </div>
                ))}
              </div>
            </div>

            <div className="text-[9px] font-mono text-zinc-500 text-center border-t border-[#0096ff]/10 pt-3 mt-4">
              Train competencies iteratively to secure final sandbox clearances.
            </div>
          </div>

        </div>

        {/* Back Link */}
        <div className="text-center mt-4">
          <a
            href={mounted ? getSubdomainUrl('home') : '/'}
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
