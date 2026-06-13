'use client';

import { useState, useEffect, useCallback } from 'react';
import { createClient } from '@/utils/supabase/client';
import { useParams } from 'next/navigation';
import ReactMarkdown from 'react-markdown';
import remarkGfm from 'remark-gfm';
import { getSubdomainUrl } from '@/utils/navigation';
import GlassCard from '@/components/ui/GlassCard';
import TiltWrapper from '@/components/ui/TiltWrapper';
import { motion } from 'framer-motion';

interface Note {
  id: string;
  title: string;
  category: string;
  tags: string[];
  last_updated: string;
  content: string;
}

export default function CategoryNotesPage() {
  const supabase = createClient();
  const params = useParams();
  const categoryPath = Array.isArray(params.category) ? params.category.join('/') : params.category || '';
  
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
  }, []);

  const handleGithubLogin = async () => {
    try {
      await supabase.auth.signInWithOAuth({
        provider: 'github',
        options: {
          redirectTo: getSubdomainUrl('home', '/auth/callback?next=' + encodeURIComponent(getSubdomainUrl('notes', `/${categoryPath}`))),
        },
      });
    } catch (err: any) {
      console.error('OAuth handshake failed:', err);
    }
  };

  const [notes, setNotes] = useState<Note[]>([]);
  const [selectedNote, setSelectedNote] = useState<Note | null>(null);
  const [searchQuery, setSearchQuery] = useState<string>('');
  const [loading, setLoading] = useState<boolean>(true);
  const [errorMsg, setErrorMsg] = useState<string | null>(null);
  const [isAuthenticated, setIsAuthenticated] = useState<boolean>(true);

  // Fetch notes directly from Supabase
  const fetchNotes = useCallback(async (search: string) => {
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
      // Use ilike to match category paths that start with this path (for subfolders)
      let query = supabase.from('notes').select('*').ilike('category', `${categoryPath}%`);

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
        // Check for specific note in URL
        const urlParams = new URLSearchParams(window.location.search);
        const requestedNoteId = urlParams.get('note');
        
        setSelectedNote((prev) => {
          if (requestedNoteId) {
            const found = notesData.find(n => n.id === requestedNoteId);
            if (found) return found;
          }
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
      
      setNotes([]);
      setSelectedNote(null);
    } finally {
      setLoading(false);
    }
  }, [supabase, categoryPath]);

  // Debounced search trigger
  useEffect(() => {
    const delayDebounceFn = setTimeout(() => {
      fetchNotes(searchQuery);
    }, 300);

    return () => clearTimeout(delayDebounceFn);
  }, [searchQuery, fetchNotes]);

  // Monitor auth state changes
  useEffect(() => {
    const { data: { subscription } } = supabase.auth.onAuthStateChange(() => {
      fetchNotes(searchQuery);
    });

    return () => subscription.unsubscribe();
  }, [supabase.auth, searchQuery, fetchNotes]);

  return (
    <main className="relative min-h-screen overflow-x-hidden pt-24 pb-16 px-4 md:px-8 z-10">
      <div className="z-10 max-w-6xl mx-auto flex flex-col gap-8">
        
        {/* Page Header */}
        <GlassCard glowColor="purple" className="p-6">
          <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
            <div>
              <div className="flex items-center gap-2 mb-1">
                <span className="w-2 h-2 bg-secondary rounded-full animate-ping" />
                <span className="text-[10px] font-mono text-secondary tracking-[0.3em] font-bold">CATEGORY_VIEW</span>
              </div>
              <h1 className="text-3xl font-extrabold font-mono tracking-wider break-all">
                {categoryPath.toUpperCase()}
              </h1>
              <p className="text-xs text-muted-foreground font-mono mt-1">
                Viewing entries inside {categoryPath}
              </p>
            </div>

            <div className="flex gap-4 border-l border-secondary/15 pl-0 md:pl-6 pt-4 md:pt-0">
              <div className="text-center font-mono">
                <p className="text-[10px] text-muted-foreground font-bold">WIKI_ENTRIES</p>
                <p className="text-lg font-extrabold text-secondary">{notes.length}</p>
              </div>
              <div className="text-center font-mono">
                <a href={mounted ? getSubdomainUrl('notes') : '/'} className="px-4 py-2 bg-secondary/10 hover:bg-secondary/20 text-secondary border border-secondary/30 rounded text-[10px] uppercase font-bold transition-all cursor-pointer inline-block mt-2">
                  &lt;-- DASHBOARD
                </a>
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
                className="w-full bg-black/5 dark:bg-black/40 backdrop-blur-md text-xs font-mono text-foreground placeholder-zinc-500 border border-secondary/20 focus:border-secondary/50 focus:outline-none rounded-lg px-3 py-2 transition-all duration-300"
              />
              
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
                          : 'border-border hover:border-secondary/40 bg-black/5 dark:bg-black/40 hover:bg-black/10 dark:hover:bg-black/60'
                      }`}
                    >
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
                        remarkPlugins={[remarkGfm]}
                        components={{
                          h1: ({node: _, ...props}) => <h1 className="text-xl font-black text-foreground mt-10 mb-5 border-b-2 border-secondary/30 pb-2 tracking-wide" {...props} />,
                          h2: ({node: _, ...props}) => <h2 className="text-lg font-bold text-secondary mt-8 mb-4 tracking-wide" {...props} />,
                          h3: ({node: _, ...props}) => <h3 className="text-[14px] font-bold text-foreground mt-6 mb-3 tracking-wide" {...props} />,
                          p: ({node: _, ...props}) => <p className="mb-4 leading-loose text-muted-foreground" {...props} />,
                          ul: ({node: _, ...props}) => <ul className="list-disc pl-6 mb-4 space-y-2 text-muted-foreground" {...props} />,
                          ol: ({node: _, ...props}) => <ol className="list-decimal pl-6 mb-4 space-y-2 text-muted-foreground" {...props} />,
                          li: ({node: _, ...props}) => <li className="leading-loose" {...props} />,
                          pre: ({node: _, ...props}) => <pre className="bg-black/5 dark:bg-black/60 rounded-xl border border-secondary/20 p-5 text-[12px] text-[#22c55e] dark:text-[#39ff14] overflow-x-auto my-6 whitespace-pre shadow-inner font-mono" {...props} />,
                          code: ({node: _, inline, ...props}: any) => inline 
                            ? <code className="bg-secondary/10 text-secondary px-1.5 py-0.5 rounded border border-secondary/20 text-[12px] font-mono" {...props} />
                            : <code className="font-mono text-[12px]" {...props} />,
                          a: ({node: _, ...props}) => <a className="text-secondary hover:text-white hover:bg-secondary/20 transition-colors px-1 rounded underline decoration-secondary/50 underline-offset-4 font-bold" target="_blank" rel="noreferrer" {...props} />,
                          blockquote: ({node: _, ...props}) => <blockquote className="border-l-4 border-secondary/60 bg-gradient-to-r from-secondary/10 to-transparent px-6 py-4 my-6 rounded-r-lg italic text-foreground/90 font-mono shadow-[inset_4px_0_0_rgba(0,150,255,0.4)]" {...props} />,
                          hr: ({node: _, ...props}) => <hr className="border-secondary/20 my-10" {...props} />,
                          table: ({node: _, ...props}) => (
                            <div className="overflow-x-auto my-8 border border-secondary/30 rounded-xl bg-black/5 dark:bg-black/40 shadow-inner backdrop-blur-sm">
                              <table className="w-full text-left text-[13px] border-collapse font-mono" {...props} />
                            </div>
                          ),
                          thead: ({node: _, ...props}) => <thead className="bg-secondary/10 border-b-2 border-secondary/40 text-secondary tracking-widest uppercase" {...props} />,
                          tbody: ({node: _, ...props}) => <tbody className="divide-y divide-white/10" {...props} />,
                          tr: ({node: _, ...props}) => <tr className="hover:bg-white/5 transition-colors" {...props} />,
                          th: ({node: _, ...props}) => <th className="px-5 py-4 font-black" {...props} />,
                          td: ({node: _, ...props}) => <td className="px-5 py-4 text-muted-foreground align-top" {...props} />,
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

      </div>
    </main>
  );
}
