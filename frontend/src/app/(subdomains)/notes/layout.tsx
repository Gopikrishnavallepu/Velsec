import { ReactNode, Suspense } from 'react';
import NotesSidebar from '@/components/notes/NotesSidebar';

export default function NotesLayout({ children }: { children: ReactNode }) {
  return (
    <div className="flex h-screen pt-16 overflow-hidden bg-background">
      {/* Sidebar - Fixed width, scrollable */}
      <aside className="w-72 h-full border-r border-border bg-black/5 dark:bg-black/20 backdrop-blur-md overflow-y-auto hidden md:block print:hidden shadow-[4px_0_24px_rgba(0,0,0,0.1)]">
        <Suspense fallback={<div className="p-8 text-center text-xs font-mono text-muted-foreground animate-pulse">LOADING_VAULT...</div>}>
          <NotesSidebar />
        </Suspense>
      </aside>
      
      {/* Main Content - Takes remaining space, scrollable */}
      <main className="flex-1 h-full overflow-y-auto relative w-full">
        {children}
      </main>
    </div>
  );
}
