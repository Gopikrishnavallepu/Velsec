'use client';

import { createClient } from '@/utils/supabase/client';
import { useState, useEffect } from 'react';

export default function NotesDashboardPage() {
  const [totalNotes, setTotalNotes] = useState(0);
  const supabase = createClient();

  useEffect(() => {
    const fetchTotal = async () => {
      const { count } = await supabase.from('notes').select('*', { count: 'exact', head: true });
      if (count) setTotalNotes(count);
    };
    fetchTotal();
  }, [supabase]);

  return (
    <div className="flex flex-col items-center justify-center h-full max-w-2xl mx-auto px-4 text-center print:hidden">
      <div className="flex items-center gap-2 mb-6">
        <span className="w-3 h-3 bg-secondary rounded-full animate-ping" />
        <span className="text-xs font-mono text-secondary tracking-[0.3em] font-bold">V_INTELLIGENCE</span>
      </div>
      
      <h1 className="text-4xl md:text-5xl font-extrabold font-mono tracking-wider mb-4">
        MIND_PALACE<span className="text-secondary">.ROOT</span>
      </h1>
      
      <p className="text-sm text-muted-foreground font-mono mb-12 max-w-lg leading-relaxed">
        Access comprehensive SecOps Cheat Sheets, Penetration Testing Guides, and Vulnerability Writeups.
      </p>

      <div className="flex gap-12 border border-border bg-black/5 dark:bg-black/20 rounded-xl p-8 backdrop-blur-sm shadow-[inset_0_0_20px_rgba(0,150,255,0.05)]">
        <div className="text-center font-mono">
          <p className="text-[10px] text-muted-foreground font-bold mb-1">WIKI_ENTRIES</p>
          <p className="text-3xl font-extrabold text-secondary">{totalNotes}</p>
        </div>
        <div className="text-center font-mono border-l border-border pl-12">
          <p className="text-[10px] text-muted-foreground font-bold mb-1">REVISION</p>
          <p className="text-3xl font-extrabold text-secondary">v4.0</p>
        </div>
      </div>

      <p className="text-xs text-muted-foreground font-mono mt-12 animate-pulse border border-border px-4 py-2 rounded-full bg-black/5">
        ← SELECT A DIRECTORY FROM THE VAULT EXPLORER
      </p>
    </div>
  );
}
