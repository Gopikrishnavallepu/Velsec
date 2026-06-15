'use client';

import { useState, useEffect } from 'react';
import ParticleField from '@/components/ui/ParticleField';
import { getSubdomainUrl } from '@/utils/navigation';
import LearningGoalCard from '@/components/learn/LearningGoalCard';

export default function AISecurityPage() {
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
  }, []);

  return (
    <main className="relative min-h-screen overflow-x-hidden pt-24 pb-16 px-4 md:px-8 bg-background">
      <ParticleField />
      
      {/* Background vignette overlay */}
      <div className="fixed inset-0 -z-5 pointer-events-none bg-gradient-to-t from-[#050a18] via-transparent to-[#050a18]/40" />

      <div className="z-10 max-w-6xl mx-auto flex flex-col gap-8">
        
        {/* Page Header */}
        <div className="relative border border-secondary/20 bg-card/30 backdrop-blur-md p-6 rounded-2xl flex flex-col md:flex-row md:items-center md:justify-between gap-4">
          <div className="absolute top-0 left-0 w-2 h-2 border-t-2 border-l-2 border-secondary" />
          <div className="absolute top-0 right-0 w-2 h-2 border-t-2 border-r-2 border-secondary" />
          <div className="absolute bottom-0 left-0 w-2 h-2 border-b-2 border-l-2 border-secondary" />
          <div className="absolute bottom-0 right-0 w-2 h-2 border-b-2 border-r-2 border-secondary" />
          
          <div>
            <div className="flex items-center gap-2 mb-1">
              <span className="w-2 h-2 bg-secondary rounded-full animate-ping" />
              <span className="text-[10px] font-mono text-secondary tracking-[0.3em] font-bold">V_ACADEMY_SPECIALIZATION</span>
            </div>
            <h1 className="text-3xl font-extrabold font-mono tracking-wider">
              AI_SECURITY<span className="text-secondary">.LEARN</span>
            </h1>
            <p className="text-xs text-muted-foreground font-mono mt-1">
              Securing Machine Learning Models, Data Pipelines, and GenAI Infrastructure
            </p>
          </div>
        </div>

        {/* Dashboard Grid */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          
          {/* Resources Panel */}
          <div className="relative border border-secondary/15 bg-card/25 backdrop-blur-md rounded-xl p-5">
            <div className="absolute top-0 left-0 w-1.5 h-1.5 border-t border-l border-secondary/40" />
            <h2 className="text-lg font-bold font-mono text-secondary mb-4 border-b border-secondary/10 pb-2">
              {"//"} ALL_RESOURCES
            </h2>
            <ul className="space-y-4 font-mono">
              <li className="flex flex-col gap-1 p-3 bg-background/50 border border-border rounded-lg hover:border-secondary/30 transition-colors">
                <span className="text-xs font-bold text-foreground">OWASP Machine Learning Security Top 10</span>
                <span className="text-[10px] text-muted-foreground">Comprehensive guide to the most critical vulnerabilities in ML systems.</span>
              </li>
              <li className="flex flex-col gap-1 p-3 bg-background/50 border border-border rounded-lg hover:border-secondary/30 transition-colors">
                <span className="text-xs font-bold text-foreground">Adversarial Robustness Toolbox (ART)</span>
                <span className="text-[10px] text-muted-foreground">Python library for defending and evaluating ML models against evasion, poisoning, and extraction.</span>
              </li>
              <li className="flex flex-col gap-1 p-3 bg-background/50 border border-border rounded-lg hover:border-secondary/30 transition-colors">
                <span className="text-xs font-bold text-foreground">Google Secure AI Framework (SAIF)</span>
                <span className="text-[10px] text-muted-foreground">Conceptual framework for securing AI systems by design.</span>
              </li>
            </ul>
          </div>

          {/* Future Learning Roadmap */}
          <div className="relative border border-secondary/15 bg-card/25 backdrop-blur-md rounded-xl p-5">
            <div className="absolute top-0 right-0 w-1.5 h-1.5 border-t border-r border-secondary/40" />
            <h2 className="text-lg font-bold font-mono text-secondary mb-4 border-b border-secondary/10 pb-2">
              {"//"} FUTURE_LEARNING
            </h2>
            <div className="relative pl-4 border-l border-secondary/20 space-y-6 mt-4">
              <div className="relative">
                <div className="absolute -left-[21px] top-1 w-2.5 h-2.5 rounded-full bg-secondary shadow-[0_0_10px_rgba(0,150,255,0.8)]" />
                <h3 className="text-xs font-bold font-mono text-foreground">LLM Prompt Injection Mitigation</h3>
                <p className="text-[10px] font-mono text-muted-foreground mt-1">Implement guardrails, input validation, and semantic analysis to prevent prompt hijacking.</p>
              </div>
              <div className="relative">
                <div className="absolute -left-[21px] top-1 w-2.5 h-2.5 rounded-full bg-border" />
                <h3 className="text-xs font-bold font-mono text-muted-foreground">Model Inversion & Data Privacy</h3>
                <p className="text-[10px] font-mono text-zinc-600 mt-1">Understanding how attackers reconstruct training data and applying differential privacy.</p>
              </div>
              <div className="relative">
                <div className="absolute -left-[21px] top-1 w-2.5 h-2.5 rounded-full bg-border" />
                <h3 className="text-xs font-bold font-mono text-muted-foreground">Data Poisoning Detection</h3>
                <p className="text-[10px] font-mono text-zinc-600 mt-1">Monitoring training pipelines for malicious data injections and dataset manipulation.</p>
              </div>
            </div>
          </div>

          {/* To Do List */}
          <div className="relative border border-secondary/15 bg-card/25 backdrop-blur-md rounded-xl p-5 lg:col-span-1">
            <div className="absolute bottom-0 left-0 w-1.5 h-1.5 border-b border-l border-secondary/40" />
            <h2 className="text-lg font-bold font-mono text-secondary mb-4 border-b border-secondary/10 pb-2">
              {"//"} TO_DO_LIST
            </h2>
            <div className="space-y-3 font-mono">
              <label className="flex items-start gap-3 p-2 hover:bg-white/5 rounded cursor-pointer transition-colors group">
                <input type="checkbox" className="mt-1 bg-background border-secondary/50 rounded-sm text-secondary focus:ring-secondary/50 focus:ring-offset-background" />
                <div className="flex flex-col">
                  <span className="text-xs text-foreground group-hover:text-secondary transition-colors">Complete OWASP LLM Top 10 Module</span>
                  <span className="text-[9px] text-muted-foreground">Review all 10 critical vulnerabilities and associated mitigations.</span>
                </div>
              </label>
              <label className="flex items-start gap-3 p-2 hover:bg-white/5 rounded cursor-pointer transition-colors group">
                <input type="checkbox" className="mt-1 bg-background border-secondary/50 rounded-sm text-secondary focus:ring-secondary/50 focus:ring-offset-background" />
                <div className="flex flex-col">
                  <span className="text-xs text-foreground group-hover:text-secondary transition-colors">Setup Local LLM Sandbox</span>
                  <span className="text-[9px] text-muted-foreground">Deploy an open-source model locally to practice prompt injections safely.</span>
                </div>
              </label>
              <label className="flex items-start gap-3 p-2 hover:bg-white/5 rounded cursor-pointer transition-colors group">
                <input type="checkbox" className="mt-1 bg-background border-secondary/50 rounded-sm text-secondary focus:ring-secondary/50 focus:ring-offset-background" />
                <div className="flex flex-col">
                  <span className="text-xs text-foreground group-hover:text-secondary transition-colors">Audit RAG Architecture</span>
                  <span className="text-[9px] text-muted-foreground">Review the retrieval-augmented generation pipeline for data leakage risks.</span>
                </div>
              </label>
            </div>
          </div>

          {/* Ultimate Goal & Final Output */}
          <LearningGoalCard 
            goal="To become a leading AI Security Architect capable of designing, auditing, and defending enterprise-grade AI infrastructure and Large Language Models against advanced adversarial attacks."
            certificationName="Velsec AI Security Certification"
            progressPercent={15}
          />

        </div>

        {/* Back Link */}
        <div className="text-center mt-4">
          <a
            href={mounted ? getSubdomainUrl('learn') : '/'}
            className="inline-flex items-center gap-2 text-xs font-mono font-bold text-muted-foreground hover:text-secondary transition-colors"
          >
            <span>&lt;--</span>
            <span>BACK_TO_LEARN_ACADEMY</span>
          </a>
        </div>
      </div>
    </main>
  );
}
