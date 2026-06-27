'use client';

import Image from 'next/image';
import { useEffect, useState } from 'react';
import { getSubdomainUrl } from '@/utils/navigation';

const subdomains = [
  {
    name: 'LEARN',
    domain: 'learn.velsec.com',
    href: 'http://learn.velsec.com:3000',
    icon: '🎓',
    tagline: 'Cybersecurity Learning Academy',
    description: 'Structured learning paths for Network Security, SOC Analyst, Threat Hunting, DevSecOps, Cloud Security, and AI Security.',
    features: ['Video Courses', 'Hands-on Labs', 'Certification Prep', 'Progress Tracking'],
    accent: '#0096ff',
  },
  {
    name: 'PROJECTS',
    domain: 'projects.velsec.com',
    href: 'http://projects.velsec.com:3000',
    icon: '🔧',
    tagline: 'Practical Implementation Hub',
    description: 'Real-world SOC deployments, secure CI/CD pipelines, cloud security architectures, and AI security projects.',
    features: ['Step-by-Step Tutorials', 'Architecture Diagrams', 'Source Code', 'Deployment Guides'],
    accent: '#39ff14',
  },
  {
    name: 'NOTES',
    domain: 'notes.velsec.com',
    href: 'http://notes.velsec.com:3000',
    icon: '📝',
    tagline: 'Knowledge Management System',
    description: 'Personal technical repository: SIEM queries, detection rules, MITRE ATT&CK mappings, cheat sheets, and runbooks.',
    features: ['SIEM Queries', 'Cheat Sheets', 'Runbooks', 'Quick Reference'],
    accent: '#0096ff',
  },
  {
    name: 'NEWS',
    domain: 'news.velsec.com',
    href: 'http://news.velsec.com:3000',
    icon: '📡',
    tagline: 'Cybersecurity & Tech News',
    description: 'Daily updates on data breaches, ransomware, zero-days, AI breakthroughs, DevSecOps trends, and emerging technologies.',
    features: ['Daily Digest', 'Weekly Newsletter', 'Threat Summaries', 'Industry Reports'],
    accent: '#39ff14',
  },
  {
    name: 'TRACKER',
    domain: 'tracker.velsec.com',
    href: 'http://tracker.velsec.com:3000',
    icon: '📊',
    tagline: 'Progress & Performance Tracking',
    description: 'Track learning progress, project milestones, career growth, certifications, and health metrics in one unified dashboard.',
    features: ['Learning Analytics', 'Career Tracking', 'Weekly Reports', 'Productivity Metrics'],
    accent: '#0096ff',
  },
  {
    name: 'PERSONAL',
    domain: 'personal.velsec.com',
    href: 'http://personal.velsec.com:3000',
    icon: '🧬',
    tagline: 'Personal Growth Dashboard',
    description: 'Your personal operating system: task management, finance tracking, interview prep, health logs, and career management.',
    features: ['Task Planner', 'Finance Tracker', 'Interview Prep', 'Health Management'],
    accent: '#39ff14',
  },
];

const coreFeatures = [
  { icon: '🔒', label: 'Cybersecurity Solutions', desc: 'Consulting & assessments' },
  { icon: '🤖', label: 'AI Security', desc: 'LLM & prompt security' },
  { icon: '☁️', label: 'Cloud Security', desc: 'AWS, Azure, GCP' },
  { icon: '🔄', label: 'DevSecOps', desc: 'Secure pipelines & IaC' },
  { icon: '👥', label: 'Community', desc: 'Forums & mentorship' },
  { icon: '🎯', label: 'Career Growth', desc: 'Roadmaps & certs' },
];

export default function SubdomainGrid() {
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
  }, []);

  return (
    <section className="relative z-10 w-full max-w-7xl mx-auto px-6">

      {/* Core Features Bar */}
      <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-3 mb-16">
        {coreFeatures.map((feat) => (
          <div
            key={feat.label}
            className="glass-panel rounded-xl p-4 text-center border border-secondary/10 hover:border-secondary/40 transition-all duration-500 group cursor-default hover:shadow-[0_0_25px_rgba(0,150,255,0.1)]"
          >
            <div className="text-2xl mb-2 group-hover:scale-110 transition-transform duration-300">{feat.icon}</div>
            <div className="text-[11px] font-mono font-bold text-foreground group-hover:text-secondary transition-colors duration-300">
              {feat.label}
            </div>
            <div className="text-[10px] text-zinc-600 mt-1 leading-tight">{feat.desc}</div>
          </div>
        ))}
      </div>

      {/* Subdomain Cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {subdomains.map((sub) => (
          <a
            key={sub.name}
            href={mounted ? getSubdomainUrl(sub.name.toLowerCase()) : `/${sub.name.toLowerCase()}`}
            className="group relative rounded-2xl p-6 border border-border hover:border-opacity-100 transition-all duration-500 overflow-hidden"
            style={{
              background: 'linear-gradient(145deg, rgba(10, 18, 40, 0.8), rgba(5, 10, 24, 0.9))',
            }}
          >
            {/* Animated border glow */}
            <div
              className="absolute inset-0 opacity-0 group-hover:opacity-100 transition-opacity duration-700 pointer-events-none rounded-2xl"
              style={{
                boxShadow: `inset 0 1px 0 ${sub.accent}40, 0 0 40px ${sub.accent}10`,
              }}
            />

            {/* Top accent line */}
            <div
              className="absolute top-0 left-0 right-0 h-[2px] opacity-40 group-hover:opacity-100 transition-opacity duration-500"
              style={{ background: `linear-gradient(90deg, transparent, ${sub.accent}, transparent)` }}
            />

            {/* Corner node dots (plexus style) */}
            <div
              className="absolute top-3 right-3 w-2 h-2 rounded-full opacity-30 group-hover:opacity-80 transition-opacity duration-500"
              style={{ background: sub.accent, boxShadow: `0 0 8px ${sub.accent}` }}
            />
            <div
              className="absolute bottom-3 left-3 w-1.5 h-1.5 rounded-full opacity-20 group-hover:opacity-60 transition-opacity duration-500"
              style={{ background: sub.accent, boxShadow: `0 0 6px ${sub.accent}` }}
            />

            {/* Header */}
            <div className="relative flex items-center gap-3 mb-4">
              <span className="text-3xl group-hover:scale-110 transition-transform duration-300">{sub.icon}</span>
              <div>
                <h3
                  className="text-lg font-mono font-bold tracking-wider transition-all duration-300"
                  style={{ color: sub.accent }}
                >
                  {sub.name}
                </h3>
                <p className="text-[11px] font-mono text-slate-400">{sub.domain}</p>
              </div>
            </div>

            {/* Tagline */}
            <p className="text-sm font-semibold text-slate-100 mb-2">{sub.tagline}</p>

            {/* Description */}
            <p className="text-xs text-slate-300 leading-relaxed mb-4">{sub.description}</p>

            {/* Feature Pills */}
            <div className="flex flex-wrap gap-2">
              {sub.features.map((f) => (
                <span
                  key={f}
                  className="text-[10px] font-mono px-2.5 py-1 rounded-full border transition-all duration-300"
                  style={{
                    borderColor: `${sub.accent}20`,
                    color: `${sub.accent}aa`,
                    background: `${sub.accent}08`,
                  }}
                >
                  {f}
                </span>
              ))}
            </div>

            {/* Arrow */}
            <div
              className="absolute bottom-4 right-4 text-xs font-mono opacity-0 group-hover:opacity-100 transition-all duration-300 translate-x-[-8px] group-hover:translate-x-0"
              style={{ color: sub.accent }}
            >
              ENTER →
            </div>
          </a>
        ))}
      </div>
    </section>
  );
}
