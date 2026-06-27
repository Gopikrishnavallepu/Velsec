'use client';

import { useState, useEffect } from 'react';
import { getSubdomainUrl } from '@/utils/navigation';
import ParticleField from '@/components/ui/ParticleField';

export default function ResumePage() {
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
  }, []);

  return (
    <main className="relative min-h-screen overflow-x-hidden pt-24 pb-16 px-4 md:px-8 bg-background">
      <ParticleField />
      <div className="fixed inset-0 -z-5 pointer-events-none bg-gradient-to-t from-[#050a18] via-transparent to-[#050a18]/40" />

      <div className="z-10 max-w-4xl mx-auto flex flex-col gap-8">
        
        {/* Header */}
        <div className="relative border border-rose-500/20 bg-card/30 backdrop-blur-md p-6 rounded-2xl flex flex-col md:flex-row md:items-center justify-between gap-4">
          <div>
            <div className="flex items-center gap-2 mb-1">
              <span className="text-[10px] font-mono text-rose-400 tracking-[0.3em] font-bold">MODULE_05</span>
            </div>
            <h1 className="text-3xl font-extrabold font-mono tracking-wider text-foreground">
              CYBER<span className="text-rose-500">_RESUME</span>
            </h1>
            <p className="text-xs text-muted-foreground font-mono mt-1">
              Dynamic CV generation and experience tracking.
            </p>
          </div>
          
          <div className="flex gap-2">
            <button className="px-4 py-2 bg-rose-500 hover:bg-rose-600 text-white rounded-lg text-xs font-mono transition-colors">
              EXPORT_PDF
            </button>
            <a
              href={mounted ? getSubdomainUrl('personal') : '/personal'}
              className="px-4 py-2 bg-card border border-border hover:border-rose-500/50 rounded-lg text-xs font-mono text-muted-foreground hover:text-foreground transition-all"
            >
              &lt;-- BACK_TO_HUB
            </a>
          </div>
        </div>

        {/* Content placeholders */}
        <div className="border border-border bg-card/50 rounded-xl p-8 md:p-12 min-h-[800px] shadow-2xl relative">
          <div className="absolute top-0 right-0 p-8 opacity-10">
            <span className="text-8xl">📄</span>
          </div>

          <header className="mb-10 border-b border-border pb-8">
            <h2 className="text-3xl font-bold font-mono text-foreground mb-2">GOPISHEK VALLEPU</h2>
            <p className="text-sm text-rose-400 font-mono tracking-widest mb-4">CYBERSECURITY PROFESSIONAL</p>
            <div className="flex flex-wrap gap-4 text-xs text-muted-foreground font-mono">
              <span>📧 gopishek@velsec.com</span>
              <span>🔗 linkedin.com/in/gopishek</span>
              <span>🐙 github.com/gopishek</span>
            </div>
          </header>

          <section className="mb-10">
            <h3 className="text-sm font-bold font-mono text-foreground mb-4 tracking-widest uppercase border-l-2 border-rose-500 pl-3">Professional Experience</h3>
            <div className="space-y-6 pl-4">
              <div>
                <div className="flex justify-between items-center mb-1">
                  <h4 className="font-bold text-foreground">Security Analyst <span className="text-muted-foreground font-normal">@ Velsec</span></h4>
                  <span className="text-xs font-mono text-muted-foreground">2023 - Present</span>
                </div>
                <ul className="list-disc list-outside ml-4 text-xs text-muted-foreground space-y-1">
                  <li>Managed and responded to SIEM alerts, reducing false positives by 40%.</li>
                  <li>Conducted vulnerability assessments and penetration testing on web applications.</li>
                </ul>
              </div>
            </div>
          </section>

          <section className="mb-10">
            <h3 className="text-sm font-bold font-mono text-foreground mb-4 tracking-widest uppercase border-l-2 border-rose-500 pl-3">Certifications</h3>
            <div className="grid grid-cols-2 gap-4 pl-4">
              <div className="p-3 bg-background rounded border border-border">
                <p className="font-bold text-sm text-foreground">CompTIA Security+</p>
                <p className="text-[10px] text-muted-foreground font-mono">Issued: 2023</p>
              </div>
              <div className="p-3 bg-background rounded border border-border">
                <p className="font-bold text-sm text-foreground">Certified Ethical Hacker (CEH)</p>
                <p className="text-[10px] text-muted-foreground font-mono">Issued: 2024</p>
              </div>
            </div>
          </section>

        </div>
      </div>
    </main>
  );
}
