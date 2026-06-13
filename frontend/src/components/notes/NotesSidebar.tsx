'use client';

import { useState, useEffect, useCallback } from 'react';
import { createClient } from '@/utils/supabase/client';
import { getSubdomainUrl } from '@/utils/navigation';
import { motion, AnimatePresence } from 'framer-motion';
import { usePathname, useSearchParams } from 'next/navigation';

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

const TreeRenderer = ({ node, level = 0, currentPath, currentNoteId }: { node: TreeNode; level?: number; currentPath: string; currentNoteId: string | null }) => {
  // Auto-expand if the current path matches this node's path
  const isNodeInPath = currentPath.includes(node.path);
  const [isOpen, setIsOpen] = useState(level === 0 || isNodeInPath);

  useEffect(() => {
    if (isNodeInPath) setIsOpen(true);
  }, [isNodeInPath]);

  return (
    <div className="flex flex-col font-mono text-sm w-full">
      <div 
        className="flex items-center gap-2 py-2 cursor-pointer hover:bg-black/5 dark:hover:bg-white/5 rounded-lg px-2 transition-colors relative group w-full"
        onClick={() => setIsOpen(!isOpen)}
        style={{ paddingLeft: `${(level * 16) + 8}px` }}
      >
        <span className={`text-secondary transition-transform duration-300 ${isOpen ? 'rotate-90' : ''}`}>
          ▸
        </span>
        <span className="font-bold tracking-widest uppercase text-foreground text-xs truncate">
          {node.name.replace(/_/g, ' ')}
        </span>
        <span className="text-[9px] text-muted-foreground ml-auto bg-black/5 dark:bg-black/40 px-1.5 py-0.5 rounded-full border border-border">
          {node.notes.length + Object.keys(node.children).length}
        </span>
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
            <div className="absolute left-0 top-0 bottom-0 border-l border-border" style={{ marginLeft: `${(level * 16) + 12}px` }} />

            <div className="py-1">
              {node.notes.map(note => {
                const isActive = currentNoteId === note.id;
                return (
                  <a 
                    key={note.id}
                    href={getSubdomainUrl('notes', `/${node.path}?note=${note.id}`)}
                    className={`flex items-center group/note py-1.5 pr-4 transition-colors w-full rounded-r-lg ${isActive ? 'bg-secondary/20 border-l-2 border-secondary' : 'hover:bg-black/5 dark:hover:bg-white/5 border-l-2 border-transparent'}`}
                    style={{ paddingLeft: `${((level + 1) * 16) + 6}px` }} // -2 for border compensation
                  >
                    <span className={`mr-2 transition-colors ${isActive ? 'text-secondary' : 'text-secondary/40 group-hover/note:text-secondary'}`}>├─</span>
                    <span className={`text-xs transition-colors truncate ${isActive ? 'text-secondary font-bold' : 'text-muted-foreground group-hover/note:text-foreground'}`}>
                      {note.title}
                    </span>
                  </a>
                );
              })}
              
              {Object.values(node.children).map(child => (
                <TreeRenderer key={child.name} node={child} level={level + 1} currentPath={currentPath} currentNoteId={currentNoteId} />
              ))}
            </div>
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
}

export default function NotesSidebar() {
  const supabase = createClient();
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const currentNoteId = searchParams.get('note');
  
  // Extract path without the /notes prefix to match against node.path
  const currentPath = pathname.replace('/notes', '').replace(/^\//, '');

  const [loading, setLoading] = useState(true);
  const [treeData, setTreeData] = useState<Record<string, TreeNode>>({});

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
      const root: Record<string, TreeNode> = {};

      notes.forEach((note) => {
        const parts = note.category && note.category !== 'General' 
          ? note.category.split('/') 
          : ['General'];
        
        let currentLevel = root;
        let currentPathBuild = '';

        parts.forEach((part, index) => {
          currentPathBuild = currentPathBuild ? `${currentPathBuild}/${part}` : part;
          
          if (!currentLevel[part]) {
            currentLevel[part] = {
              name: part,
              path: currentPathBuild,
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
    <div className="flex flex-col h-full py-6 px-4">
      <div className="mb-6 pb-4 border-b border-border flex flex-col gap-2">
        <h2 className="text-sm font-mono font-bold text-foreground tracking-wider flex items-center gap-2">
          <span className="w-2 h-2 bg-secondary rounded-full animate-pulse" />
          VAULT_EXPLORER
        </h2>
      </div>
      
      {loading ? (
        <div className="py-10 flex flex-col items-center justify-center text-secondary font-mono text-xs gap-3">
          <span className="animate-spin text-xl">⚙️</span>
          SYNCING...
        </div>
      ) : Object.keys(treeData).length === 0 ? (
        <div className="py-4 text-center font-mono text-xs text-muted-foreground">
          NO_DIRECTORIES_FOUND
        </div>
      ) : (
        <div className="flex-1 overflow-y-auto pr-2 pb-10">
          {Object.values(treeData).map((rootNode) => (
            <TreeRenderer 
              key={rootNode.name} 
              node={rootNode} 
              level={0} 
              currentPath={currentPath}
              currentNoteId={currentNoteId}
            />
          ))}
        </div>
      )}
    </div>
  );
}
