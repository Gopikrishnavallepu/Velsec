'use client';

import { useState, useEffect, useCallback } from 'react';
import { createClient } from '@/utils/supabase/client';
import ParticleField from '@/components/ui/ParticleField';
import ReactMarkdown from 'react-markdown';
import { getSubdomainUrl } from '@/utils/navigation';

interface Note {
  id: string;
  title: string;
  category: string;
  tags: string[];
  last_updated: string;
  content: string;
}

const categories = [
  'ALL',
  'Security Engineer',
  'Data Analyst',
  'Career Development',
  'General'
];

export default function NotesPage() {
  const supabase = createClient();
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
  }, []);

  const handleGithubLogin = async () => {
    try {
      await supabase.auth.signInWithOAuth({
        provider: 'github',
        options: {
          redirectTo: getSubdomainUrl('home', '/auth/callback?next=' + encodeURIComponent(getSubdomainUrl('notes'))),
        },
      });
    } catch (err: any) {
      console.error('OAuth handshake failed:', err);
    }
  };

  const [notes, setNotes] = useState<Note[]>([]);
  const [selectedNote, setSelectedNote] = useState<Note | null>(null);
  const [searchQuery, setSearchQuery] = useState<string>('');
  const [activeCategory, setActiveCategory] = useState<string>('ALL');
  const [loading, setLoading] = useState<boolean>(true);
  const [errorMsg, setErrorMsg] = useState<string | null>(null);
  const [isAuthenticated, setIsAuthenticated] = useState<boolean>(true);

  // Fetch notes from FastAPI backend
  const fetchNotes = useCallback(async (category: string, search: string) => {
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
      const apiBase = process.env.NEXT_PUBLIC_API_URL !== undefined
        ? process.env.NEXT_PUBLIC_API_URL
        : (typeof window !== 'undefined' && 
           !window.location.hostname.includes('localhost') && 
           !window.location.hostname.endsWith('.local')
            ? ''
            : 'http://localhost:8000');
      const categoryParam = category !== 'ALL' ? encodeURIComponent(category) : 'all';
      const searchParam = search ? encodeURIComponent(search) : '';
      
      const res = await fetch(
        `${apiBase}/api/v1/notes/?category=${categoryParam}&search=${searchParam}`,
        {
          headers: {
            'Authorization': `Bearer ${token}`
          }
        }
      );

      if (res.status === 401) {
        setIsAuthenticated(false);
        setLoading(false);
        return;
      }

      if (!res.ok) {
        throw new Error(`API returned status code ${res.status}`);
      }

      const data = await res.json();
      setNotes(data);
      if (data.length > 0) {
        // Keep selected note if it still exists in the list, otherwise select first
        setSelectedNote((prev) => {
          if (prev && data.some((n: Note) => n.id === prev.id)) {
            return data.find((n: Note) => n.id === prev.id);
          }
          return data[0];
        });
      } else {
        setSelectedNote(null);
      }
    } catch (err: any) { // eslint-disable-line @typescript-eslint/no-explicit-any
      console.warn(`Backend connection failed: ${err.message}. Loading mock fallback notes.`);
      setErrorMsg('API offline. Decrypting offline cached records...');
      
      // Fallback local filtering logic
      const fallbackNotes = [
        {
          id: "cloud-sec-intro",
          title: "Introduction to Cloud Security",
          category: "Security Engineer",
          tags: ["Cloud", "AWS", "Security"],
          content: "This is a fallback offline note. Please ensure the backend API is running to fetch your full library of notes.",
          last_updated: "2026-06-03"
        },
        {
          id: "data-analytics-intro",
          title: "Data Analytics Foundations",
          category: "Data Analyst",
          tags: ["Data", "Excel", "PowerBI"],
          content: "This is a fallback offline note. Please ensure the backend API is running to fetch your full library of notes.",
          last_updated: "2026-06-03"
        },
        {
          id: "interview-prep",
          title: "Security Engineer Interview Guide",
          category: "Career Development",
          tags: ["Interview", "Career", "HR"],
          content: "This is a fallback offline note. Please ensure the backend API is running to fetch your full library of notes.",
          last_updated: "2026-06-03"
        }
      ];

      let filtered = fallbackNotes;
      if (category !== 'ALL') {
        filtered = filtered.filter(n => n.category.toLowerCase() === category.toLowerCase());
      }
      if (search) {
        const query = search.toLowerCase();
        filtered = filtered.filter(n => 
          n.title.toLowerCase().includes(query) || 
          n.content.toLowerCase().includes(query)
        );
      }

      setNotes(filtered);
      if (filtered.length > 0) {
        setSelectedNote((prev) => {
          if (prev && filtered.some(n => n.id === prev.id)) {
            return filtered.find(n => n.id === prev.id) || null;
          }
          return filtered[0];
        });
      } else {
        setSelectedNote(null);
      }
    } finally {
      setLoading(false);
    }
  }, [supabase.auth]);

  // Debounced search trigger
  useEffect(() => {
    const delayDebounceFn = setTimeout(() => {
      fetchNotes(activeCategory, searchQuery);
    }, 300);

    return () => clearTimeout(delayDebounceFn);
  }, [activeCategory, searchQuery, fetchNotes]);

  // Monitor auth state changes
  useEffect(() => {
    const { data: { subscription } } = supabase.auth.onAuthStateChange(() => {
      fetchNotes(activeCategory, searchQuery);
    });

    return () => subscription.unsubscribe();
  }, [supabase.auth, activeCategory, searchQuery, fetchNotes]);

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
              <span className="text-[10px] font-mono text-secondary tracking-[0.3em] font-bold">V_INTELLIGENCE</span>
            </div>
            <h1 className="text-3xl font-extrabold font-mono tracking-wider">
              NOTES<span className="text-secondary">.VELSEC</span>
            </h1>
            <p className="text-xs text-muted-foreground font-mono mt-1">
              SecOps Cheat Sheets, Penetration Testing Guides &amp; Vulnerability Writeups
            </p>
          </div>

          <div className="flex gap-4 border-l border-secondary/15 pl-0 md:pl-6 pt-4 md:pt-0">
            <div className="text-center font-mono">
              <p className="text-[10px] text-muted-foreground font-bold">WIKI_ENTRIES</p>
              <p className="text-lg font-extrabold text-secondary">{notes.length}</p>
            </div>
            <div className="text-center font-mono">
              <p className="text-[10px] text-muted-foreground font-bold">REVISION</p>
              <p className="text-lg font-extrabold text-secondary">v2.5</p>
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
              Velsec intelligence dossiers and SecOps playbooks are encrypted at rest. Please authorize your session credentials at the central security gateway.
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
          /* Main Wiki Layout */
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6 items-start">
            
            {/* Sidebar Navigation */}
            <div className="flex flex-col gap-4">
              {/* Search */}
              <input
                type="text"
                placeholder="SEARCH_NOTES..."
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                className="w-full bg-card/25 text-xs font-mono text-foreground placeholder-zinc-500 border border-secondary/20 focus:border-secondary/50 focus:outline-none rounded-lg px-3 py-2 transition-all duration-300"
              />
              
              {/* Categories */}
              <div className="flex flex-wrap gap-1.5 p-2 bg-card/10 rounded-xl border border-secondary/10">
                {categories.map((cat) => (
                  <button
                    key={cat}
                    onClick={() => setActiveCategory(cat)}
                    className={`px-2.5 py-1 rounded text-[9px] font-mono font-bold uppercase transition-all duration-300 ${
                      activeCategory === cat
                        ? 'bg-secondary/20 text-secondary border border-secondary/40'
                        : 'text-muted-foreground border border-transparent hover:text-foreground'
                    }`}
                  >
                    {cat}
                  </button>
                ))}
              </div>
              
              {/* Notes List */}
              <div className="flex flex-col gap-2 max-h-[400px] overflow-y-auto pr-1">
                {loading ? (
                  <div className="text-center py-8 font-mono text-xs text-muted-foreground">
                    SYNCHRONIZING_NOTES_LIST...
                  </div>
                ) : notes.map((n) => (
                  <button
                    key={n.id}
                    onClick={() => setSelectedNote(n)}
                    className={`p-3 rounded-lg border text-left cursor-pointer transition-all duration-300 w-full ${
                      selectedNote?.id === n.id
                        ? 'border-secondary bg-card/35 shadow-[0_0_12px_rgba(0,150,255,0.06)]'
                        : 'border-border hover:border-secondary/20 bg-card/5'
                    }`}
                  >
                    <span className="text-[8px] font-mono text-muted-foreground font-bold uppercase tracking-wider block mb-1">
                      {n.category}
                    </span>
                    <span className="text-xs font-mono font-bold text-foreground block truncate">
                      {n.title}
                    </span>
                  </button>
                ))}

                {!loading && notes.length === 0 && (
                  <div className="text-center py-6 border border-dashed border-border rounded-lg text-zinc-600 font-mono text-xs">
                    NO_INDEXED_ENTRIES_FOUND
                  </div>
                )}
              </div>
            </div>

            {/* Reader Panel */}
            <div className="md:col-span-2 relative border border-secondary/15 bg-card/20 backdrop-blur-md rounded-xl p-6 min-h-[450px] flex flex-col">
              <div className="absolute top-0 right-0 w-2 h-2 border-t-2 border-r-2 border-secondary/40" />
              <div className="absolute bottom-0 left-0 w-2 h-2 border-b-2 border-l-2 border-secondary/40" />

              {loading ? (
                <div className="flex flex-col items-center justify-center flex-1 text-center font-mono text-xs text-muted-foreground gap-2">
                  <span className="animate-spin">⏳</span>
                  <span>DECRYPTING_NOTE_DOSSIER...</span>
                </div>
              ) : selectedNote ? (
                <div className="flex flex-col flex-1 font-mono">
                  <div className="flex flex-wrap gap-2 mb-3">
                    {selectedNote.tags.map((t) => (
                      <span
                        key={t}
                        className="px-2 py-0.5 rounded text-[8px] font-mono font-bold tracking-widest bg-card border border-secondary/20 text-secondary"
                      >
                        {t.toUpperCase()}
                      </span>
                    ))}
                  </div>

                  <h2 className="text-xl font-bold text-foreground mb-2">{selectedNote.title}</h2>
                  <div className="flex justify-between items-center text-[9px] text-muted-foreground border-b border-secondary/10 pb-4 mb-4">
                    <span>SECURITY_MEMORANDUM // CATEGORY: {selectedNote.category.toUpperCase()}</span>
                    <span>LAST_UPDATED: {selectedNote.last_updated}</span>
                  </div>

                  {/* Markdown Renderer */}
                  <div className="text-xs text-foreground leading-relaxed max-w-none mb-4 space-y-4">
                    <ReactMarkdown
                      components={{
                        h1: ({node: _, ...props}) => <h1 className="text-sm font-bold text-foreground mt-4 mb-2 border-b border-secondary/10 pb-1" {...props} />,
                        h2: ({node: _, ...props}) => <h2 className="text-xs font-bold text-foreground mt-4 mb-2" {...props} />,
                        h3: ({node: _, ...props}) => <h3 className="text-[11px] font-bold text-foreground mt-3 mb-1" {...props} />,
                        p: ({node: _, ...props}) => <p className="mb-4 leading-relaxed text-muted-foreground" {...props} />,
                        ul: ({node: _, ...props}) => <ul className="list-disc pl-4 mb-4 space-y-1" {...props} />,
                        ol: ({node: _, ...props}) => <ol className="list-decimal pl-4 mb-4 space-y-1" {...props} />,
                        li: ({node: _, ...props}) => <li className="text-muted-foreground" {...props} />,
                        pre: ({node: _, ...props}) => <pre className="bg-background/90 rounded-lg border border-border p-4 text-[10px] text-[#00f0ff] overflow-x-auto my-4 whitespace-pre" {...props} />,
                        code: ({node: _, ...props}) => <code className="bg-background/60 text-[#00f0ff] px-1 py-0.5 rounded border border-border text-[10px]" {...props} />,
                        a: ({node: _, ...props}) => <a className="text-secondary hover:underline" target="_blank" rel="noreferrer" {...props} />,
                      }}
                    >
                      {selectedNote.content}
                    </ReactMarkdown>
                  </div>
                </div>
              ) : (
                <div className="flex flex-col items-center justify-center flex-1 text-center text-muted-foreground font-mono text-xs">
                  <span className="text-3xl mb-3">📖</span>
                  SELECT_A_DOSSIER_TO_VIEW_INTELLIGENCE
                </div>
              )}
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
