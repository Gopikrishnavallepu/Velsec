'use client';

import { useState, useEffect, useCallback } from 'react';
import { createClient } from '@/utils/supabase/client';
import ParticleField from '@/components/ui/ParticleField';

interface Course {
  id: string;
  title: string;
  category: 'web' | 'cloud' | 'malware' | 'defense';
  level: 'Beginner' | 'Intermediate' | 'Advanced' | 'Expert';
  hours: number;
  progress: number;
  description: string;
  modules: string[];
}

const categories = [
  'ALL',
  'WEB',
  'CLOUD',
  'MALWARE',
  'DEFENSE'
];

export default function LearnPage() {
  const supabase = createClient();
  const [courses, setCourses] = useState<Course[]>([]);
  const [selectedCategory, setSelectedCategory] = useState<string>('ALL');
  const [searchQuery, setSearchQuery] = useState<string>('');
  const [activeCourse, setActiveCourse] = useState<Course | null>(null);
  const [loading, setLoading] = useState<boolean>(true);
  const [errorMsg, setErrorMsg] = useState<string | null>(null);
  const [isAuthenticated, setIsAuthenticated] = useState<boolean>(true);

  // Fetch courses from FastAPI backend
  const fetchCourses = useCallback(async () => {
    Promise.resolve().then(() => setLoading(true));
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
      const apiBase = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:8000';
      
      const res = await fetch(`${apiBase}/api/v1/learning/courses`, {
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
        throw new Error(`API returned status code ${res.status}`);
      }

      const data = await res.json();
      setCourses(data);
      if (data.length > 0) {
        // Maintain selected course state if available
        setActiveCourse((prev) => {
          if (prev && data.some((c: Course) => c.id === prev.id)) {
            return data.find((c: Course) => c.id === prev.id) || null;
          }
          return data[0];
        });
      } else {
        setActiveCourse(null);
      }
    } catch (err: any) {
      console.warn(`Backend connection failed: ${err.message}. Loading mock fallback courses.`);
      setErrorMsg('API offline. Decrypting offline cached records...');
      
      // Fallback local courses list
      const fallbackCourses: Course[] = [
        {
          id: 'web-pentest',
          title: 'Web Application Penetration Testing',
          category: 'web',
          level: 'Intermediate',
          hours: 24,
          progress: 65,
          description: 'Learn modern exploitation techniques, from advanced SQL injections to OAuth vulnerabilities, with fully interactive virtual labs.',
          modules: ['Reconnaissance & Mapping', 'Injection Flaws & Exploit Design', 'Bypassing WAF & OAuth Vulnerabilities', 'Final Sandbox Pentest Challenge'],
        },
        {
          id: 'cloud-sec',
          title: 'Cloud Security & IAM Hardening',
          category: 'cloud',
          level: 'Advanced',
          hours: 18,
          progress: 20,
          description: 'Secure AWS, GCP, and Azure workloads. Learn to identify and exploit IAM misconfigurations and build bulletproof Cloud environments.',
          modules: ['IAM Privilege Escalation', 'Securing Kubernetes Clusters', 'Terraform Sentinel Policy Design', 'Cloud Threat Detection & GuardDuty Setup'],
        },
        {
          id: 'rev-eng',
          title: 'Reverse Engineering & Malware Analysis',
          category: 'malware',
          level: 'Expert',
          hours: 32,
          progress: 0,
          description: 'Unpack malware samples, analyze assembly bytecode, and learn to write memory bypasses in Windows and Linux systems.',
          modules: ['Assembly Crash Course', 'Static Analysis with Ghidra & IDA', 'Dynamic Analysis & Debugging', 'Bypassing Anti-Analysis & Sandbox Checks'],
        },
        {
          id: 'threat-hunt',
          title: 'Defensive Security & Threat Hunting',
          category: 'defense',
          level: 'Beginner',
          hours: 15,
          progress: 90,
          description: 'Monitor enterprise logs, detect adversarial persistence techniques using ELK stack, and write defensive Yara rules.',
          modules: ['Log Analysis & SIEM Deployment', 'Detecting Adversary Persistence', 'Yara Rules & Signature Writing', 'Incident Response Runbook Simulation'],
        },
      ];
      setCourses(fallbackCourses);
      if (fallbackCourses.length > 0) {
        setActiveCourse((prev) => {
          if (prev && fallbackCourses.some(c => c.id === prev.id)) {
            return fallbackCourses.find(c => c.id === prev.id) || null;
          }
          return fallbackCourses[0];
        });
      }
    } finally {
      setLoading(false);
    }
  }, [supabase.auth]);

  // Handle Enrollment and Progress increment triggers
  const handleLabAction = async (courseId: string, currentProgress: number) => {
    setLoading(true);
    try {
      const { data: { session } } = await supabase.auth.getSession();
      const token = session?.access_token;
      if (!token) return;

      const apiBase = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:8000';
      
      if (currentProgress === 0) {
        // Enroll
        const res = await fetch(`${apiBase}/api/v1/learning/enroll/${courseId}`, {
          method: 'POST',
          headers: {
            'Authorization': `Bearer ${token}`
          }
        });
        if (res.ok) {
          // Immediately set progress to 10%
          await fetch(`${apiBase}/api/v1/learning/progress/${courseId}`, {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
              'Authorization': `Bearer ${token}`
            },
            body: JSON.stringify({ progress: 10 })
          });
        }
      } else {
        // Increment progress by 20%, max 100%
        const nextProgress = Math.min(currentProgress + 20, 100);
        await fetch(`${apiBase}/api/v1/learning/progress/${courseId}`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${token}`
          },
          body: JSON.stringify({ progress: nextProgress })
        });
      }
      
      // Reload courses
      await fetchCourses();
    } catch (err) {
      console.error("Failed to execute lab action", err);
      // Local fallback simulation if API is offline
      setCourses(prev => prev.map(c => {
        if (c.id === courseId) {
          const nextP = c.progress === 0 ? 10 : Math.min(c.progress + 20, 100);
          return { ...c, progress: nextP };
        }
        return c;
      }));
      setActiveCourse(prev => {
        if (prev && prev.id === courseId) {
          const nextP = prev.progress === 0 ? 10 : Math.min(prev.progress + 20, 100);
          return { ...prev, progress: nextP };
        }
        return prev;
      });
    } finally {
      setLoading(false);
    }
  };

  // Trigger loading
  useEffect(() => {
    fetchCourses();
  }, [fetchCourses]);

  // Monitor auth state changes
  useEffect(() => {
    const { data: { subscription } } = supabase.auth.onAuthStateChange(() => {
      fetchCourses();
    });

    return () => subscription.unsubscribe();
  }, [supabase.auth, fetchCourses]);

  // Filter & Search Logic
  const filteredCourses = courses.filter((c) => {
    const matchesCategory = selectedCategory === 'ALL' || c.category.toUpperCase() === selectedCategory.toUpperCase();
    const matchesSearch = c.title.toLowerCase().includes(searchQuery.toLowerCase()) || 
                          c.description.toLowerCase().includes(searchQuery.toLowerCase());
    return matchesCategory && matchesSearch;
  });

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
              <span className="text-[10px] font-mono text-[#0096ff] tracking-[0.3em] font-bold">V_ACADEMY</span>
            </div>
            <h1 className="text-3xl font-extrabold font-mono tracking-wider">
              LEARN<span className="text-[#0096ff]">.VELSEC</span>
            </h1>
            <p className="text-xs text-zinc-400 font-mono mt-1">
              Advanced Cybersecurity Curriculum &amp; Practical Hands-on Labs
            </p>
          </div>

          {/* Quick Stats */}
          <div className="flex gap-4 border-l border-[#0096ff]/15 pl-0 md:pl-6 pt-4 md:pt-0">
            <div className="text-center font-mono">
              <p className="text-[10px] text-zinc-500 font-bold">ACTIVE LABS</p>
              <p className="text-lg font-extrabold text-[#0096ff]">{courses.filter(c => c.progress > 0).length} / {courses.length}</p>
            </div>
            <div className="text-center font-mono">
              <p className="text-[10px] text-zinc-500 font-bold">XP MULTIPLIER</p>
              <p className="text-lg font-extrabold text-[#0096ff]">1.5x</p>
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
            <p className="text-xs text-zinc-400 font-mono max-w-md leading-relaxed">
              Velsec learning curriculums and interactive lab access keys are encrypted at rest. Please authorize your session credentials at the central security gateway.
            </p>
            <a
              href="http://velsec.com:3000/login"
              className="mt-2 px-6 py-2.5 bg-rose-500/10 hover:bg-rose-500/20 active:scale-98 text-xs font-mono font-bold tracking-widest text-rose-400 border border-rose-500/40 rounded-lg transition-all duration-300"
            >
              AUTHENTICATE_SESSION
            </a>
          </div>
        ) : (
          /* Main Learning Academy Panel */
          <>
            {/* Search & Filter Bar */}
            <div className="flex flex-col sm:flex-row justify-between items-center gap-4 bg-[#0a1432]/10 p-4 rounded-xl border border-[#0096ff]/10">
              {/* Filters */}
              <div className="flex flex-wrap gap-2 w-full sm:w-auto">
                {categories.map((cat) => (
                  <button
                    key={cat}
                    onClick={() => setSelectedCategory(cat)}
                    className={`px-3 py-1.5 rounded-lg text-xs font-mono font-bold tracking-wider transition-all duration-300 ${
                      selectedCategory === cat
                        ? 'bg-[#0096ff]/20 text-[#0096ff] border border-[#0096ff]/40 shadow-[0_0_10px_rgba(0,150,255,0.2)]'
                        : 'text-zinc-400 border border-[#0a1a40] hover:border-[#0096ff]/30 hover:text-zinc-200'
                    }`}
                  >
                    {cat}
                  </button>
                ))}
              </div>

              {/* Search */}
              <div className="relative w-full sm:w-64">
                <input
                  type="text"
                  placeholder="SEARCH_COURSES..."
                  value={searchQuery}
                  onChange={(e) => setSearchQuery(e.target.value)}
                  className="w-full bg-[#050a18]/80 text-xs font-mono text-zinc-200 placeholder-zinc-500 border border-[#0a1a40] focus:border-[#0096ff]/40 focus:outline-none rounded-lg px-3 py-2 transition-colors"
                />
                <span className="absolute right-3 top-2.5 text-zinc-500 text-xs font-mono">🔍</span>
              </div>
            </div>

            {/* main layout: courses grid & detail card side-by-side */}
            <div className="grid grid-cols-1 lg:grid-cols-3 gap-6 items-start">
              
              {/* Courses List Grid */}
              <div className="lg:col-span-2 grid grid-cols-1 md:grid-cols-2 gap-4">
                {loading && courses.length === 0 ? (
                  <div className="col-span-2 text-center py-16 font-mono text-xs text-zinc-500">
                    DECRYPTING_LAB_CURRICULUM_CORES...
                  </div>
                ) : filteredCourses.map((c) => (
                  <div
                    key={c.id}
                    onClick={() => setActiveCourse(c)}
                    className={`group relative flex flex-col p-5 rounded-xl border transition-all duration-500 cursor-pointer ${
                      activeCourse?.id === c.id
                        ? 'border-[#0096ff] bg-[#0a1432]/40 shadow-[0_0_20px_rgba(0,150,255,0.1)]'
                        : 'border-[#0a1a40] hover:border-[#0096ff]/40 bg-[#0a1432]/10 hover:shadow-[0_0_15px_rgba(0,150,255,0.05)]'
                    }`}
                  >
                    {/* Plexus design dots */}
                    <div className="absolute top-0 right-0 w-1.5 h-1.5 bg-[#0096ff]/40 rounded-full m-2 group-hover:scale-125 transition-transform duration-300" />
                    <div className="absolute bottom-0 left-0 w-1.5 h-1.5 bg-[#0096ff]/20 rounded-full m-2" />

                    <div className="flex justify-between items-center mb-3">
                      <span className="px-2 py-0.5 rounded text-[9px] font-mono font-bold tracking-wider bg-[#0a1432] border border-[#0096ff]/25 text-[#0096ff]">
                        {c.level.toUpperCase()}
                      </span>
                      <span className="text-[10px] font-mono text-zinc-500 font-bold">{c.hours} HOURS</span>
                    </div>

                    <h3 className="text-base font-bold font-mono text-zinc-200 group-hover:text-[#0096ff] transition-colors duration-300 mb-2">
                      {c.title}
                    </h3>

                    <p className="text-[11px] text-zinc-400 mb-4 leading-relaxed line-clamp-2">
                      {c.description}
                    </p>

                    {/* Progress bar */}
                    <div className="mt-auto pt-2">
                      <div className="flex justify-between text-[9px] font-mono text-zinc-500 font-bold mb-1">
                        <span>PROGRESS</span>
                        <span className="text-[#0096ff]">{c.progress}%</span>
                      </div>
                      <div className="w-full h-1.5 bg-[#050a18] rounded-full overflow-hidden border border-[#0096ff]/10">
                        <div
                          className="h-full bg-gradient-to-r from-[#0096ff] to-[#00f0ff] transition-all duration-500"
                          style={{ width: `${c.progress}%` }}
                        />
                      </div>
                    </div>
                  </div>
                ))}

                {filteredCourses.length === 0 && !loading && (
                  <div className="col-span-2 text-center p-8 rounded-xl border border-dashed border-[#0a1a40] text-zinc-500 font-mono text-xs">
                    NO_COURSES_FOUND_MATCHING_CRITERIA
                  </div>
                )}
              </div>

              {/* Details / Preview Drawer */}
              <div className="relative border border-[#0096ff]/15 bg-[#0a1432]/25 backdrop-blur-md rounded-xl p-5 min-h-[350px]">
                <div className="absolute top-0 right-0 w-2 h-2 border-t-2 border-r-2 border-[#0096ff]/40" />
                <div className="absolute bottom-0 left-0 w-2 h-2 border-b-2 border-l-2 border-[#0096ff]/40" />

                {activeCourse ? (
                  <div className="flex flex-col h-full font-mono">
                    <span className="text-[9px] text-[#0096ff] font-bold tracking-widest uppercase mb-1">
                      {"//"} {activeCourse.category.toUpperCase()} MODULES
                    </span>
                    <h2 className="text-lg font-bold text-zinc-100 mb-3 border-b border-[#0096ff]/10 pb-2">
                      {activeCourse.title}
                    </h2>
                    
                    <p className="text-[11px] text-zinc-400 mb-5 leading-relaxed">
                      {activeCourse.description}
                    </p>

                    <h4 className="text-[10px] text-zinc-500 font-bold mb-3 tracking-wider">LAB_CURRICULUM:</h4>
                    <ul className="space-y-3 mb-6 flex-1">
                      {activeCourse.modules.map((mod, index) => (
                        <li key={mod} className="flex gap-2 items-start text-[10px]">
                          <span className="text-[#0096ff] font-bold">0{index + 1}.</span>
                          <span className="text-zinc-300 leading-tight">{mod}</span>
                        </li>
                      ))}
                    </ul>

                    <button
                      onClick={() => handleLabAction(activeCourse.id, activeCourse.progress)}
                      disabled={loading}
                      className="w-full py-2 bg-[#0096ff] hover:bg-[#007cdb] active:scale-98 text-xs font-mono font-bold tracking-widest text-[#050a18] rounded-lg transition-all duration-300 shadow-[0_0_15px_rgba(0,150,255,0.3)] disabled:opacity-50"
                    >
                      {activeCourse.progress === 100 ? 'LAB_COMPLETED' : activeCourse.progress > 0 ? 'RESUME_LAB (+20% PROGRESS)' : 'INITIALIZE_LAB'}
                    </button>
                  </div>
                ) : (
                  <div className="flex flex-col items-center justify-center h-full min-h-[310px] text-center text-zinc-500 font-mono text-xs">
                    <span className="text-3xl mb-3">🎓</span>
                    SELECT_A_COURSE_TO_VIEW_CURRICULUM
                  </div>
                )}
              </div>
            </div>
          </>
        )}

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
