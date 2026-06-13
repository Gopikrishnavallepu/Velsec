'use client';

import { useState, useEffect, useCallback } from 'react';
import { createClient } from '@/utils/supabase/client';
import ParticleField from '@/components/ui/ParticleField';
import ReactMarkdown from 'react-markdown';
import { getSubdomainUrl } from '@/utils/navigation';
import GlassCard from '@/components/ui/GlassCard';
import TiltWrapper from '@/components/ui/TiltWrapper';
import { motion, AnimatePresence } from 'framer-motion';

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

  // Fetch notes directly from Supabase
  const fetchNotes = useCallback(async (category: string, search: string) => {
    setLoading(true);
    setErrorMsg(null);
    try {
      const { data: { session } } = await supabase.auth.getSession();

      if (!session?.access_token) {
        setIsAuthenticated(false);
        setLoading(false);
        return;
      }

      setIsAuthenticated(true);

      // Query Supabase notes table directly
      let query = supabase.from('notes').select('*');

      if (category && category !== 'ALL') {
        query = query.eq('category', category);
      }

      if (search) {
        query = query.or(`title.ilike.%${search}%,content.ilike.%${search}%`);
      }

      query = query.order('last_updated', { ascending: false });

      const { data, error } = await query;

      if (error) {
        throw new Error(`Supabase query error: ${error.message}`);
      }

      const notesData: Note[] = (data || []).map((item: Record<string, unknown>) => ({
        id: item.id as string,
        title: item.title as string,
        category: item.category as string,
        tags: (item.tags as string[]) || [],
        content: item.content as string,
        last_updated: (item.last_updated as string) || '2026-06-03',
      }));

      setNotes(notesData);
      if (notesData.length > 0) {
        setSelectedNote((prev) => {
          if (prev && notesData.some((n) => n.id === prev.id)) {
            return notesData.find((n) => n.id === prev.id) || null;
          }
          return notesData[0];
        });
      } else {
        setSelectedNote(null);
      }
    } catch (err: unknown) {
      const errorMessage = err instanceof Error ? err.message : 'Unknown error';
      console.warn(`Notes fetch failed: ${errorMessage}. Loading fallback notes.`);
      setErrorMsg('Database offline. Decrypting offline cached records...');
      
      // Fallback local filtering logic
      const fallbackNotes: Note[] = [
        {
          id: "cloud-sec-intro",
          title: "Introduction to Cloud Security",
          category: "Security Engineer",
          tags: ["Cloud", "AWS", "Security"],
          content: "This is a fallback offline note. Please ensure the Supabase database is connected and the notes-vault has been synced.",
          last_updated: "2026-06-03"
        },
        {
          id: "data-analytics-intro",
          title: "Data Analytics Foundations",
          category: "Data Analyst",
          tags: ["Data", "Excel", "PowerBI"],
          content: "This is a fallback offline note. Please ensure the Supabase database is connected and the notes-vault has been synced.",
          last_updated: "2026-06-03"
        },
        {
          id: "interview-prep",
          title: "Security Engineer Interview Guide",
          category: "Career Development",
          tags: ["Interview", "Career", "HR"],
          content: "This is a fallback offline note. Please ensure the Supabase database is connected and the notes-vault has been synced.",
          last_updated: "2026-06-03"
        }
      ];

      let filtered = fallbackNotes;
      if (category !== 'ALL') {
        filtered = filtered.filter(n => n.category.toLowerCase() === category.toLowerCase());
      }
      if (search) {
        const q = search.toLowerCase();
        filtered = filtered.filter(n => 
          n.title.toLowerCase().includes(q) || 
          n.content.toLowerCase().includes(q)
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
  }, [supabase]);

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
    <main className="relative min-h-screen overflow-x-hidden pt-24 pb-16 px-4 md:px-8 z-10">
      
      <div className="z-10 max-w-6xl mx-auto flex flex-col gap-8">
        
        {/* Page Header */}
        <GlassCard glowColor="purple" className="p-6">
          <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
            <div>
              <div className="flex items-center gap-2 mb-1">
                <span className="w-2 h-2 bg-secondary rounded-full animate-ping" />
                <span className="text-[10px] font-mono text-secondary tracking-[0.3em] font-bold">V_INTELLIGENCE</span>
              </div>
              <h1 className="text-3xl font-extrabold font-mono tracking-wider">
                MIND_PALACE<span className="text-secondary">.VELSEC</span>
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
                <p className="text-lg font-extrabold text-secondary">v3.0</p>
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
          </GlassCard>
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
                className="w-full bg-black/40 backdrop-blur-md text-xs font-mono text-foreground placeholder-zinc-500 border border-secondary/20 focus:border-secondary/50 focus:outline-none rounded-lg px-3 py-2 transition-all duration-300"
              />
              
              {/* Categories */}
              <div className="flex flex-wrap gap-1.5 p-2 bg-black/20 backdrop-blur-md rounded-xl border border-secondary/10">
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
              <div className="flex flex-col gap-3 max-h-[500px] overflow-y-auto pr-2 pb-4">
                {loading ? (
                  <div className="text-center py-8 font-mono text-xs text-muted-foreground">
                    SYNCHRONIZING_NOTES_LIST...
                  </div>
                ) : notes.map((n) => (
                  <TiltWrapper key={n.id} intensity={8}>
                    <button
                      onClick={() => setSelectedNote(n)}
                      className={`p-4 rounded-xl border text-left cursor-pointer transition-all duration-300 w-full backdrop-blur-md ${
                        selectedNote?.id === n.id
                          ? 'border-secondary bg-secondary/10 shadow-[0_0_20px_rgba(0,150,255,0.15)]'
                          : 'border-white/10 hover:border-secondary/40 bg-black/40 hover:bg-black/60'
                      }`}
                    >
                      <span className="text-[8px] font-mono text-muted-foreground font-bold uppercase tracking-wider block mb-1">
                        {n.category}
                      </span>
                      <span className="text-xs font-mono font-bold text-foreground block truncate">
                        {n.title}
                      </span>
                    </button>
                  </TiltWrapper>
                ))}

                {!loading && notes.length === 0 && (
                  <div className="text-center py-6 border border-dashed border-border rounded-lg text-zinc-600 font-mono text-xs">
                    NO_INDEXED_ENTRIES_FOUND
                  </div>
                )}
              </div>
            </div>

            {/* Reader Panel */}
            <div className="md:col-span-2">
              <GlassCard glowColor="blue" className="p-6 md:p-10 min-h-[500px] flex flex-col">
                {loading ? (
                  <div className="flex flex-col items-center justify-center flex-1 text-center font-mono text-xs text-muted-foreground gap-2">
                    <span className="animate-spin text-2xl text-secondary">⚙️</span>
                    <span>DECRYPTING_NOTE_DOSSIER...</span>
                  </div>
                ) : selectedNote ? (
                  <motion.div 
                    key={selectedNote.id}
                    initial={{ opacity: 0, y: 10 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ duration: 0.4 }}
                    className="flex flex-col flex-1 font-mono"
                  >
                    <div className="flex flex-wrap gap-2 mb-4">
                      {selectedNote.tags.map((t) => (
                        <span
                          key={t}
                          className="px-2.5 py-1 rounded text-[9px] font-mono font-bold tracking-widest bg-secondary/10 border border-secondary/30 text-secondary"
                        >
                          {t.toUpperCase()}
                        </span>
                      ))}
                    </div>

                    <h2 className="text-2xl font-black text-foreground mb-2 tracking-wide">{selectedNote.title}</h2>
                    <div className="flex justify-between items-center text-[10px] text-muted-foreground border-b border-secondary/20 pb-4 mb-6">
                      <span>SECURITY_MEMORANDUM // CATEGORY: {selectedNote.category.toUpperCase()}</span>
                      <span>LAST_UPDATED: {selectedNote.last_updated}</span>
                    </div>

                    {/* Markdown Renderer */}
                    <div className="text-sm text-foreground/90 leading-relaxed max-w-none space-y-6">
                      <ReactMarkdown
                        components={{
                          h1: ({node: _, ...props}) => <h1 className="text-lg font-bold text-foreground mt-8 mb-4 border-b border-secondary/20 pb-2" {...props} />,
                          h2: ({node: _, ...props}) => <h2 className="text-base font-bold text-secondary mt-6 mb-3" {...props} />,
                          h3: ({node: _, ...props}) => <h3 className="text-[13px] font-bold text-foreground mt-5 mb-2" {...props} />,
                          p: ({node: _, ...props}) => <p className="mb-4 leading-loose text-muted-foreground" {...props} />,
                          ul: ({node: _, ...props}) => <ul className="list-disc pl-5 mb-4 space-y-2" {...props} />,
                          ol: ({node: _, ...props}) => <ol className="list-decimal pl-5 mb-4 space-y-2" {...props} />,
                          li: ({node: _, ...props}) => <li className="text-muted-foreground leading-loose" {...props} />,
                          pre: ({node: _, ...props}) => <pre className="bg-black/60 rounded-xl border border-secondary/20 p-5 text-[11px] text-[#39ff14] overflow-x-auto my-6 whitespace-pre shadow-inner" {...props} />,
                          code: ({node: _, ...props}) => <code className="bg-secondary/10 text-secondary px-1.5 py-0.5 rounded border border-secondary/20 text-[11px]" {...props} />,
                          a: ({node: _, ...props}) => <a className="text-secondary hover:underline decoration-secondary/50 underline-offset-4" target="_blank" rel="noreferrer" {...props} />,
                        }}
                      >
                        {selectedNote.content}
                      </ReactMarkdown>
                    </div>
                  </motion.div>
                ) : (
                  <div className="flex flex-col items-center justify-center flex-1 text-center text-muted-foreground font-mono text-xs">
                    <span className="text-4xl mb-4 opacity-50">📖</span>
                    SELECT_A_DOSSIER_TO_VIEW_INTELLIGENCE
                  </div>
                )}
              </GlassCard>
            </div>

          </div>
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
