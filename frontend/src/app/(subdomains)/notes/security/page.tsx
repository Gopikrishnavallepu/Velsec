'use client';

import { useState, useEffect } from 'react';
import Link from 'next/link';

export default function SecurityNotesDashboard() {
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
  }, []);

  const securityTopics = [
    { id: 'container-security', title: 'Container Security', icon: '🐳', desc: 'Docker & Kubernetes security best practices.' },
    { id: 'sast', title: 'SAST', icon: '🔍', desc: 'Static Application Security Testing.' },
    { id: 'dast', title: 'DAST', icon: '🕸️', desc: 'Dynamic Application Security Testing.' },
    { id: 'sca', title: 'SCA', icon: '📦', desc: 'Software Composition Analysis.' },
    { id: 'penetration-testing', title: 'Penetration Testing', icon: '⚔️', desc: 'Ethical hacking and offensive security notes.' }
  ];

  return (
    <div className="min-h-full p-8 font-mono">
      {/* Header */}
      <div className="mb-10">
        <h1 className="text-3xl font-extrabold text-foreground tracking-wider mb-2">
          DEV_SEC_OPS <span className="text-secondary">VAULT</span>
        </h1>
        <p className="text-xs text-muted-foreground">
          Centralized notes on AIOps, MLOps, Cloud Security, and DevSecOps pipelines.
        </p>
      </div>

      {/* Grid of Subpages */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {securityTopics.map((topic) => (
          <Link href={`/security/${topic.id}`} key={topic.id} className="group block">
            <div className="relative border border-border bg-card/20 p-6 rounded-xl hover:bg-card/40 hover:border-secondary/40 transition-all duration-300">
              <div className="absolute top-0 left-0 w-1.5 h-1.5 bg-secondary/0 group-hover:bg-secondary/40 transition-colors" />
              <div className="text-3xl mb-4">{topic.icon}</div>
              <h2 className="text-lg font-bold text-foreground group-hover:text-secondary transition-colors mb-2">
                {topic.title}
              </h2>
              <p className="text-[11px] text-muted-foreground leading-relaxed">
                {topic.desc}
              </p>
              <div className="mt-4 flex justify-end">
                <span className="text-[10px] text-secondary tracking-widest font-bold opacity-0 group-hover:opacity-100 transition-opacity">
                  ACCESS_VAULT &gt;
                </span>
              </div>
            </div>
          </Link>
        ))}
      </div>
    </div>
  );
}
