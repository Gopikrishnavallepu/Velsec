'use client';

import { useState, useEffect } from 'react';
import { createClient } from '@/utils/supabase/client';
import { useParams } from 'next/navigation';
import ReactMarkdown from 'react-markdown';
import remarkGfm from 'remark-gfm';
import GlassCard from '@/components/ui/GlassCard';

interface Note {
  id: string;
  title: string;
  category: string;
  tags: string[];
  content: string;
  last_updated: string;
}

export default function CategoryNotesPage() {
  const supabase = createClient();
  const params = useParams();
  
  // Safely handle params.category as array or string
  const categoryParams = params.category;
  const rawCategoryPath = Array.isArray(categoryParams) 
    ? categoryParams.join('/') 
    : (categoryParams as string || '');
  
  const categoryPath = decodeURIComponent(rawCategoryPath);
  
  const [selectedNote, setSelectedNote] = useState<Note | null>(null);
  const [loading, setLoading] = useState(true);
  const [errorMsg, setErrorMsg] = useState<string | null>(null);

  useEffect(() => {
    const fetchNotes = async () => {
      setLoading(true);
      try {
        const { data: { session } } = await supabase.auth.getSession();
        if (!session?.access_token) {
          setErrorMsg('Authentication required');
          setLoading(false);
          return;
        }

        const urlParams = new URLSearchParams(window.location.search);
        const requestedNoteId = urlParams.get('note');

        // Fetch just the notes in this category path
        const { data, error } = await supabase
          .from('notes')
          .select('*')
          .ilike('category', `${categoryPath}%`)
          .order('title');
          
        if (error) throw error;

        const notesData: Note[] = (data || []).map((item: Record<string, unknown>) => ({
          id: item.id as string,
          title: item.title as string,
          category: item.category as string,
          tags: (item.tags as string[]) || [],
          content: item.content as string,
          last_updated: (item.last_updated as string) || '2026-06-03',
        }));

        if (notesData.length > 0) {
          if (requestedNoteId) {
            const found = notesData.find(n => n.id === requestedNoteId);
            if (found) {
              setSelectedNote(found);
              return;
            }
          }
          setSelectedNote(notesData[0]);
        } else {
          setSelectedNote(null);
        }
      } catch (err) {
        console.error("Failed to fetch notes:", err);
        setErrorMsg('Failed to load notes');
      } finally {
        setLoading(false);
      }
    };

    fetchNotes();
  }, [supabase, categoryPath]);

  const handleExportMD = () => {
    if (!selectedNote) return;
    const blob = new Blob([selectedNote.content], { type: 'text/markdown' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `${selectedNote.title.replace(/\s+/g, '_')}.md`;
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    URL.revokeObjectURL(url);
  };

  const handleExportPDF = () => {
    window.print();
  };

  if (loading) {
    return (
      <div className="flex h-full items-center justify-center pt-20">
        <div className="flex flex-col items-center gap-4 text-secondary font-mono text-sm">
          <span className="animate-spin text-3xl">⚙️</span>
          DECRYPTING_DOSSIER...
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-full pb-16 px-4 md:px-8 max-w-4xl mx-auto z-10 w-full relative print:p-0 print:m-0 print:max-w-none">
      
      {/* Top action bar - Hidden during print */}
      <div className="flex justify-between items-center py-6 border-b border-border mb-8 print:hidden">
        <div className="flex items-center gap-3">
          <span className="w-2 h-2 bg-secondary rounded-full animate-ping" />
          <h1 className="text-xl font-bold font-mono tracking-widest text-foreground truncate">
            {selectedNote ? selectedNote.title : 'NO_FILE_SELECTED'}
          </h1>
        </div>
        
        {selectedNote && (
          <div className="flex gap-3">
            <button 
              onClick={handleExportMD}
              className="text-[10px] font-bold text-secondary border border-secondary/30 px-3 py-1.5 rounded bg-secondary/10 hover:bg-secondary/20 transition-all font-mono"
            >
              DOWNLOAD .MD
            </button>
            <button 
              onClick={handleExportPDF}
              className="text-[10px] font-bold text-primary border border-primary/30 px-3 py-1.5 rounded bg-primary/10 hover:bg-primary/20 transition-all font-mono"
            >
              PRINT TO PDF
            </button>
          </div>
        )}
      </div>

      {errorMsg ? (
        <GlassCard className="p-8 text-center text-destructive font-mono border-destructive/50">
          ERROR: {errorMsg}
        </GlassCard>
      ) : !selectedNote ? (
        <div className="flex h-64 items-center justify-center text-muted-foreground font-mono text-sm border border-dashed border-border rounded-xl bg-black/5 dark:bg-black/20 print:hidden">
          NO_CONTENT_FOUND_IN_THIS_DIRECTORY
        </div>
      ) : (
        <div className="print:text-black print:bg-white relative">
          
          {/* Tags */}
          {selectedNote.tags && selectedNote.tags.length > 0 && (
            <div className="flex flex-wrap gap-2 mb-8 print:hidden">
              {selectedNote.tags.map(tag => (
                <span key={tag} className="text-[10px] bg-secondary/10 text-secondary px-2 py-1 rounded-full border border-secondary/20 font-mono">
                  #{tag}
                </span>
              ))}
            </div>
          )}

          {/* Markdown Content */}
          <div className="text-sm text-foreground/90 leading-relaxed max-w-none space-y-6 print:text-black">
            <ReactMarkdown
              remarkPlugins={[remarkGfm]}
              components={{
                h1: ({node: _, ...props}) => <h1 className="text-xl font-black text-foreground print:text-black mt-10 mb-5 border-b-2 border-secondary/30 print:border-black/20 pb-2 tracking-wide" {...props} />,
                h2: ({node: _, ...props}) => <h2 className="text-lg font-bold text-secondary print:text-black mt-8 mb-4 tracking-wide" {...props} />,
                h3: ({node: _, ...props}) => <h3 className="text-[14px] font-bold text-foreground print:text-black mt-6 mb-3 tracking-wide" {...props} />,
                p: ({node: _, ...props}) => <p className="mb-4 leading-loose text-muted-foreground print:text-black/80" {...props} />,
                ul: ({node: _, ...props}) => <ul className="list-disc pl-6 mb-4 space-y-2 text-muted-foreground print:text-black/80" {...props} />,
                ol: ({node: _, ...props}) => <ol className="list-decimal pl-6 mb-4 space-y-2 text-muted-foreground print:text-black/80" {...props} />,
                li: ({node: _, ...props}) => <li className="leading-loose" {...props} />,
                pre: ({node: _, ...props}) => <pre className="bg-black/5 dark:bg-black/60 print:bg-gray-100 rounded-xl border border-secondary/20 print:border-gray-300 p-5 text-[12px] text-[#22c55e] dark:text-[#39ff14] print:text-black overflow-x-auto my-6 whitespace-pre shadow-inner font-mono" {...props} />,
                code: ({node: _, inline, ...props}: any) => inline 
                  ? <code className="bg-secondary/10 print:bg-gray-100 text-secondary print:text-black px-1.5 py-0.5 rounded border border-secondary/20 print:border-gray-300 text-[12px] font-mono" {...props} />
                  : <code className="font-mono text-[12px] print:text-black" {...props} />,
                a: ({node: _, ...props}) => <a className="text-secondary print:text-blue-600 hover:text-white hover:bg-secondary/20 transition-colors px-1 rounded underline decoration-secondary/50 underline-offset-4 font-bold" target="_blank" rel="noreferrer" {...props} />,
                blockquote: ({node: _, ...props}) => <blockquote className="border-l-4 border-secondary/60 print:border-gray-400 bg-gradient-to-r from-secondary/10 print:from-gray-50 to-transparent px-6 py-4 my-6 rounded-r-lg italic text-foreground/90 print:text-black font-mono shadow-[inset_4px_0_0_rgba(0,150,255,0.4)] print:shadow-none" {...props} />,
                hr: ({node: _, ...props}) => <hr className="border-secondary/20 print:border-gray-300 my-10" {...props} />,
                table: ({node: _, ...props}) => (
                  <div className="overflow-x-auto my-8 border border-secondary/30 print:border-gray-300 rounded-xl bg-black/5 dark:bg-black/40 print:bg-white shadow-inner backdrop-blur-sm print:shadow-none">
                    <table className="w-full text-left text-[13px] border-collapse font-mono print:text-black" {...props} />
                  </div>
                ),
                thead: ({node: _, ...props}) => <thead className="bg-secondary/10 print:bg-gray-100 border-b-2 border-secondary/40 print:border-gray-300 text-secondary print:text-black tracking-widest uppercase" {...props} />,
                tbody: ({node: _, ...props}) => <tbody className="divide-y divide-white/10 print:divide-gray-200" {...props} />,
                tr: ({node: _, ...props}) => <tr className="hover:bg-white/5 print:hover:bg-transparent transition-colors" {...props} />,
                th: ({node: _, ...props}) => <th className="px-5 py-4 font-black" {...props} />,
                td: ({node: _, ...props}) => <td className="px-5 py-4 text-muted-foreground print:text-black align-top" {...props} />,
              }}
            >
              {selectedNote.content}
            </ReactMarkdown>
          </div>
          
          <div className="mt-16 pt-8 border-t border-border text-xs text-muted-foreground font-mono flex justify-between print:hidden">
            <span>LAST_UPDATED: {new Date(selectedNote.last_updated).toLocaleDateString()}</span>
            <span>CATEGORY: {selectedNote.category}</span>
          </div>
        </div>
      )}
    </div>
  );
}
