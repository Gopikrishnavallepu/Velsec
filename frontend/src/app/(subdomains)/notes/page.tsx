'use client';

import { useState, useEffect, useCallback } from 'react';
import { createClient } from '@/utils/supabase/client';
import { getSubdomainUrl } from '@/utils/navigation';
import GlassCard from '@/components/ui/GlassCard';
import { motion, AnimatePresence } from 'framer-motion';

interface Note {
  id: string;
  title: string;
  category: string;
  tags: string[];
  last_updated: string;
}

interface TreeNode {
  name: string;
  path: string;
  notes: Note[];
  children: Record<string, TreeNode>;
}

const TreeRenderer = ({ node, level = 0 }: { node: TreeNode; level?: number }) => {
  const [isOpen, setIsOpen] = useState(level === 0); // Open top-level by default
  const [isHovered, setIsHovered] = useState(false);

  return (
    <div className="flex flex-col font-mono text-sm w-full">
      <div 
        className="flex items-center gap-3 py-2 cursor-pointer hover:bg-white/5 rounded-lg px-2 transition-colors relative group w-full"
        onClick={() => setIsOpen(!isOpen)}
        onMouseEnter={() => setIsHovered(true)}
        onMouseLeave={() => setIsHovered(false)}
        style={{ paddingLeft: `${(level * 24) + 8}px` }}
      >
        <span className={`text-secondary transition-transform duration-300 ${isOpen ? 'rotate-90' : ''}`}>
          ▸
        </span>
        <span className="font-bold tracking-widest uppercase text-foreground">
          {node.name.replace(/_/g, ' ')}
        </span>
        <span className="text-[10px] text-muted-foreground ml-2 bg-black/5 dark:bg-black/40 px-2 py-0.5 rounded-full border border-border">
          {node.notes.length + Object.keys(node.children).length} items
        </span>
        
        <a 
          href={getSubdomainUrl('notes', `/${node.path}`)} 
          className={`ml-auto text-[10px] font-bold text-secondary border border-secondary/30 px-3 py-1 rounded bg-secondary/10 hover:bg-secondary/20 transition-all ${isHovered ? 'opacity-100' : 'opacity-0'}`}
          onClick={(e) => e.stopPropagation()}
        >
          OPEN DIRECTORY
        </a>
      </div>
      
      <AnimatePresence>
        {isOpen && (
          <motion.div
            initial={{ height: 0, opacity: 0 }}
            animate={{ height: 'auto', opacity: 1 }}
            exit={{ height: 0, opacity: 0 }}
            className="overflow-hidden relative"
          >
            {/* Connecting line */}
            <div className="absolute left-0 top-0 bottom-0 border-l border-white/10" style={{ marginLeft: `${(level * 24) + 12}px` }} />

            <div className="py-1">
              {node.notes.map(note => (
                <a 
                  key={note.id}
                  href={getSubdomainUrl('notes', `/${node.path}?note=${note.id}`)}
                  className="flex items-center group/note py-1.5 hover:bg-white/5 pr-4 transition-colors w-full"
                  style={{ paddingLeft: `${((level + 1) * 24) + 8}px` }}
                >
                  <span className="text-secondary/40 mr-3 group-hover/note:text-secondary transition-colors">├─</span>
                  <span className="text-muted-foreground group-hover/note:text-foreground transition-colors truncate">
                    {note.title}
                  </span>
                </a>
              ))}
              
              {Object.values(node.children).map(child => (
                <TreeRenderer key={child.name} node={child} level={level + 1} />
              ))}
            </div>
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
}

export default function NotesDashboardPage() {
  const supabase = createClient();
  const [mounted, setMounted] = useState(false);
  const [loading, setLoading] = useState(true);
  const [treeData, setTreeData] = useState<Record<string, TreeNode>>({});
  const [totalNotes, setTotalNotes] = useState(0);

  useEffect(() => {
    setMounted(true);
  }, []);

  const fetchAndBuildTree = useCallback(async () => {
    setLoading(true);
    try {
      const { data: { session } } = await supabase.auth.getSession();
      if (!session?.access_token) {
        setLoading(false);
        return;
      }

      const { data, error } = await supabase.from('notes').select('id, title, category, tags, last_updated');
      
      if (error) throw error;

      const notes = (data || []) as Note[];
      setTotalNotes(notes.length);

      const root: Record<string, TreeNode> = {};

      notes.forEach((note) => {
        const parts = note.category && note.category !== 'General' 
          ? note.category.split('/') 
          : ['General'];
        
        let currentLevel = root;
        let currentPath = '';

        parts.forEach((part, index) => {
          currentPath = currentPath ? `${currentPath}/${part}` : part;
          
          if (!currentLevel[part]) {
            currentLevel[part] = {
              name: part,
              path: currentPath,
              notes: [],
              children: {}
            };
          }
          
          if (index === parts.length - 1) {
            currentLevel[part].notes.push(note);
          }
          
          currentLevel = currentLevel[part].children;
        });
      });

      setTreeData(root);
    } catch (err) {
      console.error("Failed to build tree:", err);
    } finally {
      setLoading(false);
    }
  }, [supabase]);

  useEffect(() => {
    fetchAndBuildTree();
  }, [fetchAndBuildTree]);

  return (
    <main className="relative min-h-screen overflow-x-hidden pt-24 pb-16 px-4 md:px-8 z-10">
      <div className="z-10 max-w-5xl mx-auto flex flex-col gap-8">
        
        {/* Page Header */}
        <GlassCard glowColor="purple" className="p-6">
          <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
            <div>
              <div className="flex items-center gap-2 mb-1">
                <span className="w-2 h-2 bg-secondary rounded-full animate-ping" />
                <span className="text-[10px] font-mono text-secondary tracking-[0.3em] font-bold">V_INTELLIGENCE</span>
              </div>
              <h1 className="text-3xl font-extrabold font-mono tracking-wider">
                MIND_PALACE<span className="text-secondary">.ROOT</span>
              </h1>
              <p className="text-xs text-muted-foreground font-mono mt-1">
                SecOps Cheat Sheets, Penetration Testing Guides &amp; Vulnerability Writeups
              </p>
            </div>

            <div className="flex gap-4 border-l border-secondary/15 pl-0 md:pl-6 pt-4 md:pt-0">
              <div className="text-center font-mono">
                <p className="text-[10px] text-muted-foreground font-bold">WIKI_ENTRIES</p>
                <p className="text-lg font-extrabold text-secondary">{totalNotes}</p>
              </div>
              <div className="text-center font-mono">
                <p className="text-[10px] text-muted-foreground font-bold">REVISION</p>
                <p className="text-lg font-extrabold text-secondary">v4.0</p>
              </div>
            </div>
          </div>
        </GlassCard>

        {/* Tree Graph Dashboard */}
        <GlassCard glowColor="blue" className="p-8">
          <div className="mb-6 pb-4 border-b border-white/10 flex justify-between items-center">
            <h2 className="text-lg font-mono font-bold text-foreground tracking-wider">DIRECTORY_STRUCTURE</h2>
            <span className="text-xs font-mono text-muted-foreground border border-border px-2 py-1 rounded bg-black/5 dark:bg-black/20">ROOT /</span>
          </div>
          
          {loading ? (
            <div className="py-20 flex flex-col items-center justify-center text-secondary font-mono text-xs gap-3">
              <span className="animate-spin text-2xl">⚙️</span>
              MAPPING_DIRECTORY_STRUCTURE...
            </div>
          ) : Object.keys(treeData).length === 0 ? (
            <div className="py-10 text-center font-mono text-xs text-muted-foreground border border-dashed border-border rounded-xl bg-black/5 dark:bg-black/20">
              NO_DIRECTORIES_FOUND
            </div>
          ) : (
            <div className="bg-black/5 dark:bg-black/40 rounded-xl border border-border p-4 shadow-inner">
              {Object.values(treeData).map((rootNode) => (
                <TreeRenderer key={rootNode.name} node={rootNode} level={0} />
              ))}
            </div>
          )}
        </GlassCard>

        {/* Back Link */}
        <div className="text-center mt-2">
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
