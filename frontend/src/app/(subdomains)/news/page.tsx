'use client';

import { useState } from 'react';
import ParticleField from '@/components/ui/ParticleField';

interface NewsItem {
  id: string;
  title: string;
  source: string;
  date: string;
  category: 'intel' | 'exploit' | 'news';
  severity?: 'critical' | 'high' | 'medium' | 'low';
  cvss?: number;
  summary: string;
  mitigation: string;
}

const newsData: NewsItem[] = [
  {
    id: 'cve-2026-rce',
    title: 'Critical RCE discovered in popular Node.js HTTP wrapper library',
    source: 'NVD Vuln Feed',
    date: '2026-06-02',
    category: 'exploit',
    severity: 'critical',
    cvss: 9.8,
    summary: 'A stack buffer overflow vulnerability exists in the HTTP header validation logic. This allows remote unauthenticated attackers to execute arbitrary shell payloads by sending crafted request headers.',
    mitigation: 'Upgrade NPM package dependency to >= v3.12.8. Apply WAF rules filtering HTTP headers larger than 8KB.',
  },
  {
    id: 'apt-cloud-campaign',
    title: 'New APT Campaign "BlueMesh" targets cloud-native containers',
    source: 'CrowdStrike Intelligence',
    date: '2026-06-01',
    category: 'intel',
    severity: 'high',
    cvss: 8.4,
    summary: 'State-sponsored threat actors are exploiting Kubernetes IAM role policies to escape pod environments and establish host-level daemon persistence across AWS EKS instances.',
    mitigation: 'Implement IAM boundary controls. Activate AWS GuardDuty and restrict container write access to host directory paths.',
  },
  {
    id: 'cyber-quantum-news',
    title: 'Post-Quantum cryptography standards declared by NIST',
    source: 'NIST Bulletin',
    date: '2026-05-30',
    category: 'news',
    severity: 'low',
    cvss: 2.1,
    summary: 'NIST has officially approved the primary algorithm suites for post-quantum key encapsulation mechanism standards. Enterprises are advised to begin drafting system inventories.',
    mitigation: 'Audit legacy TLS suites and outline migration path strategies to incorporate Kyber-1024 algorithms by Q4.',
  },
];

export default function NewsPage() {
  const [selectedCategory, setSelectedCategory] = useState<string>('all');
  const [activeItem, setActiveItem] = useState<NewsItem | null>(newsData[0]);

  const filteredNews = newsData.filter(item => {
    return selectedCategory === 'all' || item.category === selectedCategory;
  });

  return (
    <main className="relative min-h-screen overflow-x-hidden pt-24 pb-16 px-4 md:px-8 bg-[#050a18]">
      <ParticleField />
      
      {/* Background vignette overlay */}
      <div className="fixed inset-0 -z-5 pointer-events-none bg-gradient-to-t from-[#050a18] via-transparent to-[#050a18]/40" />

      <div className="z-10 max-w-6xl mx-auto flex flex-col gap-8">
        
        {/* Page Header */}
        <div className="relative border border-[#0096ff]/20 bg-[#0a1432]/30 backdrop-blur-md p-6 rounded-2xl flex flex-col md:flex-row md:items-center md:justify-between gap-4">
          <div className="absolute top-0 left-0 w-2 h-2 border-t-2 border-l-2 border-[#0096ff]" />
          <div className="absolute top-0 right-0 w-2 h-2 border-t-2 border-r-2 border-[#0096ff]" />
          <div className="absolute bottom-0 left-0 w-2 h-2 border-b-2 border-l-2 border-[#0096ff]" />
          <div className="absolute bottom-0 right-0 w-2 h-2 border-b-2 border-r-2 border-[#0096ff]" />
          
          <div>
            <div className="flex items-center gap-2 mb-1">
              <span className="w-2 h-2 bg-[#0096ff] rounded-full animate-ping" />
              <span className="text-[10px] font-mono text-[#0096ff] tracking-[0.3em] font-bold">V_INTELLIGENCE</span>
            </div>
            <h1 className="text-3xl font-extrabold font-mono tracking-wider">
              NEWS<span className="text-[#0096ff]">.VELSEC</span>
            </h1>
            <p className="text-xs text-zinc-400 font-mono mt-1">
              Real-time Threat Intelligence, Exploitation Bulletins &amp; CVE Feeds
            </p>
          </div>

          <div className="flex gap-4 border-l border-[#0096ff]/15 pl-0 md:pl-6 pt-4 md:pt-0">
            <div className="text-center font-mono">
              <p className="text-[10px] text-zinc-500 font-bold">FEEDS_ONLINE</p>
              <p className="text-lg font-extrabold text-[#0096ff]">8 / 8</p>
            </div>
            <div className="text-center font-mono">
              <p className="text-[10px] text-zinc-500 font-bold">SYSTEM_STATE</p>
              <p className="text-lg font-extrabold text-[#0096ff]">SECURE</p>
            </div>
          </div>
        </div>

        {/* Scrolling Marquee Alert Banner */}
        <div className="w-full bg-[#0a1432]/35 border border-[#0096ff]/20 rounded-lg p-2.5 overflow-hidden whitespace-nowrap font-mono text-[10px] text-zinc-300 relative">
          <div className="absolute left-0 top-0 bottom-0 bg-[#050a18] px-3 flex items-center text-[#0096ff] font-bold border-r border-[#0096ff]/20 z-10">
            🚨 ACTIVE_ALERTS:
          </div>
          <div className="inline-block animate-marquee pl-[12%] space-x-12">
            <span>[CRITICAL] CVE-2026-0814: RCE detected in Enterprise Authentication layer (CVSS 9.8)</span>
            <span>[THREAT_INTEL] APT-42 active credentials scanning detected across regional infrastructure nodes</span>
            <span>[EXPLOIT_DB] New proof-of-concept payload released for container orchestration bypasses</span>
          </div>
        </div>

        {/* Feed layout grid */}
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6 items-start">
          
          {/* Main Feed Column */}
          <div className="lg:col-span-2 flex flex-col gap-4">
            
            {/* Tab Controls */}
            <div className="flex gap-2 border-b border-[#0a1a40] pb-2">
              {['all', 'intel', 'exploit', 'news'].map(cat => (
                <button
                  key={cat}
                  onClick={() => setSelectedCategory(cat)}
                  className={`px-3 py-1 text-xs font-mono font-bold tracking-wider transition-all ${
                    selectedCategory === cat
                      ? 'text-[#0096ff] border-b-2 border-[#0096ff] pb-2'
                      : 'text-zinc-500 hover:text-zinc-300'
                  }`}
                >
                  {cat.toUpperCase() === 'INTEL' ? 'THREAT_INTEL' : cat.toUpperCase() === 'EXPLOIT' ? 'EXPLOITS' : cat.toUpperCase() === 'NEWS' ? 'GLOBAL_NEWS' : 'ALL_FEEDS'}
                </button>
              ))}
            </div>

            {/* News Cards */}
            <div className="flex flex-col gap-3">
              {filteredNews.map(item => (
                <div
                  key={item.id}
                  onClick={() => setActiveItem(item)}
                  className={`group relative p-4 rounded-xl border cursor-pointer transition-all duration-300 ${
                    activeItem?.id === item.id
                      ? 'border-[#0096ff] bg-[#0a1432]/30 shadow-[0_0_15px_rgba(0,150,255,0.08)]'
                      : 'border-[#0a1a40] hover:border-[#0096ff]/35 bg-[#0a1432]/5'
                  }`}
                >
                  <div className="flex justify-between items-center mb-2">
                    <span className="text-[8px] font-mono text-zinc-500 font-bold">{item.source.toUpperCase()} • {item.date}</span>
                    {item.cvss && (
                      <span className={`text-[8px] font-mono font-bold px-1.5 py-0.5 rounded ${
                        item.severity === 'critical' ? 'bg-rose-500/10 border border-rose-500/30 text-rose-400' :
                        item.severity === 'high' ? 'bg-orange-500/10 border border-orange-500/30 text-orange-400' :
                        'bg-zinc-500/10 border border-zinc-500/30 text-zinc-400'
                      }`}>
                        CVSS {item.cvss}
                      </span>
                    )}
                  </div>
                  <h3 className="text-sm font-bold font-mono text-zinc-200 group-hover:text-[#0096ff] transition-colors">{item.title}</h3>
                  <p className="text-[11px] font-mono text-zinc-400 line-clamp-2 mt-2 leading-relaxed">{item.summary}</p>
                </div>
              ))}
            </div>

          </div>

          {/* Details Drawer */}
          <div className="relative border border-[#0096ff]/15 bg-[#0a1432]/25 backdrop-blur-md rounded-xl p-5 min-h-[350px]">
            <div className="absolute top-0 right-0 w-2 h-2 border-t-2 border-r-2 border-[#0096ff]/40" />
            <div className="absolute bottom-0 left-0 w-2 h-2 border-b-2 border-l-2 border-[#0096ff]/40" />

            {activeItem ? (
              <div className="flex flex-col h-full font-mono text-xs">
                <span className="text-[8px] text-[#0096ff] font-bold tracking-widest block mb-2">{"//"} INTEL_SPECIFICATION</span>
                <h2 className="text-sm font-bold text-zinc-100 border-b border-[#0096ff]/10 pb-3 mb-3">{activeItem.title}</h2>
                
                <span className="text-[9px] text-zinc-500 font-bold uppercase block mb-1">threat_vector_summary:</span>
                <p className="text-[10px] text-zinc-400 leading-relaxed mb-5">{activeItem.summary}</p>

                <span className="text-[9px] text-zinc-500 font-bold uppercase block mb-1">recommended_mitigation:</span>
                <div className="p-3 bg-[#050a18] border border-[#0a1a40] rounded-lg text-[10px] text-[#00f0ff] leading-relaxed mb-4">
                  {activeItem.mitigation}
                </div>

                <div className="text-[9px] text-zinc-500 text-right mt-auto">
                  REF_ID: {activeItem.id.toUpperCase()}
                </div>
              </div>
            ) : (
              <div className="flex flex-col items-center justify-center h-full min-h-[310px] text-center text-zinc-500 font-mono text-xs">
                SELECT_NEWS_ENTRY_FOR_FULL_REPORT
              </div>
            )}
          </div>

        </div>

        {/* Back Link */}
        <div className="text-center mt-4">
          <a
            href="http://velsec.com:3000"
            className="inline-flex items-center gap-2 text-xs font-mono font-bold text-zinc-500 hover:text-[#0096ff] transition-colors"
          >
            <span>&lt;--</span>
            <span>SYSTEM_CORE_HOME</span>
          </a>
        </div>
      </div>
    </main>
  );
}
