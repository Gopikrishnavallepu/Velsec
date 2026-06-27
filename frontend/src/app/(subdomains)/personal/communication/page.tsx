'use client';

import { useState, useEffect } from 'react';
import { getSubdomainUrl } from '@/utils/navigation';
import ParticleField from '@/components/ui/ParticleField';

export default function CommunicationPage() {
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
  }, []);

  return (
    <main className="relative min-h-screen overflow-x-hidden pt-24 pb-16 px-4 md:px-8 bg-background">
      <ParticleField />
      <div className="fixed inset-0 -z-5 pointer-events-none bg-gradient-to-t from-[#050a18] via-transparent to-[#050a18]/40" />

      <div className="z-10 max-w-5xl mx-auto flex flex-col gap-8">
        
        {/* Header */}
        <div className="relative border border-purple-500/20 bg-card/30 backdrop-blur-md p-6 rounded-2xl flex flex-col md:flex-row md:items-center justify-between gap-4">
          <div>
            <div className="flex items-center gap-2 mb-1">
              <span className="text-[10px] font-mono text-purple-400 tracking-[0.3em] font-bold">MODULE_02</span>
            </div>
            <h1 className="text-3xl font-extrabold font-mono tracking-wider text-foreground">
              EFFECTIVE<span className="text-purple-500">_COMM</span>
            </h1>
            <p className="text-xs text-muted-foreground font-mono mt-1">
              Interpersonal frameworks, presentation skills, and active listening.
            </p>
          </div>
          
          <a
            href={mounted ? getSubdomainUrl('personal') : '/personal'}
            className="px-4 py-2 bg-card border border-border hover:border-purple-500/50 rounded-lg text-xs font-mono text-muted-foreground hover:text-foreground transition-all"
          >
            &lt;-- BACK_TO_HUB
          </a>
        </div>

        {/* Content placeholders */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <div className="border border-border bg-card/25 rounded-xl p-6 min-h-[300px]">
            <h3 className="text-sm font-bold font-mono text-foreground mb-4">COMMUNICATION_FRAMEWORKS</h3>
            <div className="space-y-3">
              <div className="p-3 border border-border rounded-lg bg-card">
                <h4 className="text-sm text-purple-400 font-bold mb-1">STAR Method</h4>
                <p className="text-xs text-muted-foreground">Situation, Task, Action, Result. Used for behavioral interviews and conflict resolution.</p>
              </div>
              <div className="p-3 border border-border rounded-lg bg-card">
                <h4 className="text-sm text-purple-400 font-bold mb-1">Active Listening</h4>
                <p className="text-xs text-muted-foreground">Focusing entirely on the speaker, understanding their message, comprehending the information and responding thoughtfully.</p>
              </div>
            </div>
          </div>
          
          <div className="border border-border bg-card/25 rounded-xl p-6 min-h-[300px]">
            <h3 className="text-sm font-bold font-mono text-foreground mb-4">NETWORKING_LOG</h3>
            <div className="flex items-center justify-center h-[200px] border border-dashed border-border rounded-lg text-xs text-muted-foreground font-mono">
              [CRM_DATABASE_EMPTY]
            </div>
          </div>
        </div>
      </div>
    </main>
  );
}
