'use client';

import { use, useState, useEffect } from 'react';
import Link from 'next/link';

// Mock data to simulate keyword matched notes
const MOCK_NOTES_DATABASE: Record<string, { title: string, date: string, content: string }[]> = {
  'container-security': [
    { title: 'Docker Daemon Attack Surface', date: '2026-05-12', content: 'Ensure Docker daemon socket is not exposed to the public. Use TLS authentication if TCP exposure is required.' },
    { title: 'Kubernetes RBAC Misconfigurations', date: '2026-05-18', content: 'Over-permissive roles like cluster-admin bound to default service accounts can lead to full cluster compromise.' }
  ],
  'sast': [
    { title: 'Integrating Semgrep into CI/CD', date: '2026-06-01', content: 'Configure Semgrep to run on every PR. Fail the build if critical or high severity issues are found.' },
    { title: 'Handling False Positives', date: '2026-06-05', content: 'Establish a process to triage SAST findings. Use inline ignores with specific comments (e.g., // semgrep-ignore: rule-id) strictly for approved exceptions.' }
  ],
  'dast': [
    { title: 'Automated ZAP Scans', date: '2026-06-10', content: 'Run OWASP ZAP baseline scan against staging environments post-deployment.' }
  ],
  'sca': [
    { title: 'Dependency Confusion Attacks', date: '2026-04-20', content: 'Ensure internal packages are not shadowed by public packages on npm/PyPI.' }
  ],
  'penetration-testing': [
    { title: 'OAuth 2.0 State Parameter Bypass', date: '2026-05-30', content: 'Check if the state parameter is properly validated to prevent CSRF in OAuth flows.' },
    { title: 'Blind SSRF via PDF Generators', date: '2026-06-02', content: 'Headless browsers used for PDF generation can be exploited to hit internal AWS metadata endpoints (169.254.169.254).' }
  ]
};

const TOPIC_LABELS: Record<string, string> = {
  'container-security': 'Container Security',
  'sast': 'Static Application Security Testing (SAST)',
  'dast': 'Dynamic Application Security Testing (DAST)',
  'sca': 'Software Composition Analysis (SCA)',
  'penetration-testing': 'Penetration Testing'
};

export default function SecurityTopicPage({ params }: { params: Promise<{ topic: string }> }) {
  const resolvedParams = use(params);
  const topicKey = resolvedParams.topic;
  
  const title = TOPIC_LABELS[topicKey] || topicKey.toUpperCase();
  const notes = MOCK_NOTES_DATABASE[topicKey] || [];

  return (
    <div className="min-h-full p-8 font-mono">
      {/* Header */}
      <div className="mb-8">
        <Link href="/security" className="text-[10px] text-muted-foreground hover:text-secondary transition-colors inline-flex items-center gap-2 mb-4">
          <span>&lt;--</span>
          <span>BACK_TO_DASHBOARD</span>
        </Link>
        <h1 className="text-3xl font-extrabold text-foreground tracking-wider mb-2">
          {title} <span className="text-secondary">NOTES</span>
        </h1>
        <p className="text-xs text-muted-foreground">
          Aggregated vault entries matching keyword: <span className="text-secondary font-bold">[{topicKey}]</span>
        </p>
      </div>

      {/* Notes List */}
      <div className="space-y-6">
        {notes.length === 0 ? (
          <div className="p-8 border border-dashed border-border rounded-xl text-center text-muted-foreground text-xs">
            NO_ENTRIES_FOUND_FOR_KEYWORD
          </div>
        ) : (
          notes.map((note, index) => (
            <div key={index} className="border border-border bg-card/10 rounded-xl p-6 hover:border-secondary/30 transition-colors">
              <div className="flex justify-between items-start mb-4 border-b border-border/50 pb-2">
                <h3 className="text-lg font-bold text-foreground">{note.title}</h3>
                <span className="text-[10px] text-muted-foreground">{note.date}</span>
              </div>
              <p className="text-xs text-zinc-400 leading-relaxed">
                {note.content}
              </p>
            </div>
          ))
        )}
      </div>
    </div>
  );
}
