'use client';

import { ReactNode, Suspense, useState } from 'react';
import NotesSidebar from '@/components/notes/NotesSidebar';

export default function NotesLayout({ children }: { children: ReactNode }) {
  const [isSidebarOpen, setIsSidebarOpen] = useState(true);

  return (
    <div className="flex h-screen pt-16 overflow-hidden bg-background">
      {/* Sidebar Container */}
      <div 
        className={`relative transition-all duration-300 ease-in-out h-full border-r border-border bg-black/5 dark:bg-black/20 backdrop-blur-md hidden md:block print:hidden shadow-[4px_0_24px_rgba(0,0,0,0.1)] shrink-0 ${
          isSidebarOpen ? 'w-80' : 'w-4'
        }`}
      >
        {/* Toggle Button */}
        <button 
          onClick={() => setIsSidebarOpen(!isSidebarOpen)}
          className="absolute -right-3 top-6 z-50 w-6 h-6 bg-secondary text-white rounded-full flex items-center justify-center text-[10px] shadow-lg hover:scale-110 transition-transform cursor-pointer border border-border"
          title={isSidebarOpen ? "Collapse Vault Explorer" : "Expand Vault Explorer"}
        >
          {isSidebarOpen ? '◀' : '▶'}
        </button>

        {/* Sidebar Content */}
        <div className={`w-80 h-full overflow-y-auto transition-opacity duration-300 ${!isSidebarOpen ? 'opacity-0 pointer-events-none' : 'opacity-100'}`}>
          <Suspense fallback={<div className="p-8 text-center text-xs font-mono text-muted-foreground animate-pulse">LOADING_VAULT...</div>}>
            <NotesSidebar />
          </Suspense>
        </div>
      </div>
      
      {/* Main Content - Takes remaining space, scrollable */}
      <main className="flex-1 h-full overflow-y-auto relative w-full">
        {children}
      </main>
    </div>
  );
}
