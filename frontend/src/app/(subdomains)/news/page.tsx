'use client';

import { useState, useEffect } from 'react';
import ParticleField from '@/components/ui/ParticleField';
import { getSubdomainUrl } from '@/utils/navigation';

import GlassCard from '@/components/ui/GlassCard';
import TiltWrapper from '@/components/ui/TiltWrapper';
import { motion, AnimatePresence } from 'framer-motion';

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
  const [mounted, setMounted] = useState(false);
  useEffect(() => {
    setMounted(true);
  }, []);

  const [selectedCategory, setSelectedCategory] = useState<string>('all');
  const [activeItem, setActiveItem] = useState<NewsItem | null>(newsData[0]);

  const filteredNews = newsData.filter(item => {
    return selectedCategory === 'all' || item.category === selectedCategory;
  });

  return (
    <main className="relative min-h-screen overflow-x-hidden pt-24 pb-16 px-4 md:px-8 z-10">
      
      <div className="z-10 max-w-6xl mx-auto flex flex-col gap-8">
        
        {/* Page Header */}
        <GlassCard glowColor="green" className="p-6">
          <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
            <div>
              <div className="flex items-center gap-2 mb-1">
                <span className="w-2 h-2 bg-secondary rounded-full animate-ping" />
                <span className="text-[10px] font-mono text-secondary tracking-[0.3em] font-bold">V_INTELLIGENCE</span>
              </div>
              <h1 className="text-3xl font-extrabold font-mono tracking-wider">
                BROADCAST<span className="text-secondary">.VELSEC</span>
              </h1>
              <p className="text-xs text-muted-foreground font-mono mt-1">
                Real-time Threat Intelligence, Exploitation Bulletins &amp; CVE Feeds
              </p>
            </div>

            <div className="flex gap-4 border-l border-secondary/15 pl-0 md:pl-6 pt-4 md:pt-0">
              <div className="text-center font-mono">
                <p className="text-[10px] text-muted-foreground font-bold">FEEDS_ONLINE</p>
                <p className="text-lg font-extrabold text-secondary">8 / 8</p>
              </div>
              <div className="text-center font-mono">
                <p className="text-[10px] text-muted-foreground font-bold">SYSTEM_STATE</p>
                <p className="text-lg font-extrabold text-secondary">SECURE</p>
              </div>
            </div>
          </div>
        </GlassCard>

        {/* Scrolling Marquee Alert Banner */}
        <div className="w-full bg-black/5 dark:bg-black/40 backdrop-blur-md border border-secondary/20 rounded-lg p-2.5 overflow-hidden whitespace-nowrap font-mono text-[10px] text-foreground relative shadow-[0_0_20px_rgba(0,150,255,0.05)]">
          <div className="absolute left-0 top-0 bottom-0 bg-background/80 px-3 flex items-center text-secondary font-bold border-r border-secondary/20 z-10 backdrop-blur-md">
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
            <div className="flex gap-2 border-b border-border pb-2">
              {['all', 'intel', 'exploit', 'news'].map(cat => (
                <button
                  key={cat}
                  onClick={() => setSelectedCategory(cat)}
                  className={`px-3 py-1 text-xs font-mono font-bold tracking-wider transition-all ${
                    selectedCategory === cat
                      ? 'text-secondary border-b-2 border-secondary pb-2'
                      : 'text-muted-foreground hover:text-foreground'
                  }`}
                >
                  {cat.toUpperCase() === 'INTEL' ? 'THREAT_INTEL' : cat.toUpperCase() === 'EXPLOIT' ? 'EXPLOITS' : cat.toUpperCase() === 'NEWS' ? 'GLOBAL_NEWS' : 'ALL_FEEDS'}
                </button>
              ))}
            </div>

            {/* News Cards */}
            <div className="flex flex-col gap-3">
              <AnimatePresence>
                {filteredNews.map(item => (
                  <motion.div
                    key={item.id}
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    exit={{ opacity: 0, scale: 0.95 }}
                    transition={{ duration: 0.3 }}
                  >
                    <TiltWrapper intensity={5}>
                      <div
                        onClick={() => setActiveItem(item)}
                        className={`group relative p-5 rounded-xl border cursor-pointer transition-all duration-300 backdrop-blur-md ${
                          activeItem?.id === item.id
                            ? 'border-secondary bg-secondary/10 shadow-[0_0_20px_rgba(0,150,255,0.15)]'
                            : 'border-border hover:border-secondary/40 bg-black/5 dark:bg-black/40 hover:bg-black/10 dark:hover:bg-black/60'
                        }`}
                      >
                        <div className="flex justify-between items-center mb-2">
                          <span className="text-[8px] font-mono text-muted-foreground font-bold">{item.source.toUpperCase()} • {item.date}</span>
                          {item.cvss && (
                            <span className={`text-[8px] font-mono font-bold px-1.5 py-0.5 rounded ${
                              item.severity === 'critical' ? 'bg-rose-500/10 border border-rose-500/30 text-rose-400' :
                              item.severity === 'high' ? 'bg-orange-500/10 border border-orange-500/30 text-orange-400' :
                              'bg-zinc-500/10 border border-zinc-500/30 text-muted-foreground'
                            }`}>
                              CVSS {item.cvss}
                            </span>
                          )}
                        </div>
                        <h3 className="text-sm font-bold font-mono text-foreground group-hover:text-secondary transition-colors">{item.title}</h3>
                        <p className="text-[11px] font-mono text-muted-foreground line-clamp-2 mt-2 leading-relaxed">{item.summary}</p>
                      </div>
                    </TiltWrapper>
                  </motion.div>
                ))}
              </AnimatePresence>
            </div>

          </div>

          {/* Details Drawer */}
          <div className="lg:col-span-1">
            <GlassCard glowColor="blue" className="p-6 min-h-[350px]">
              {activeItem ? (
                <motion.div 
                  key={activeItem.id}
                  initial={{ opacity: 0, x: 20 }}
                  animate={{ opacity: 1, x: 0 }}
                  transition={{ duration: 0.3 }}
                  className="flex flex-col h-full font-mono text-xs"
                >
                  <span className="text-[8px] text-secondary font-bold tracking-widest block mb-2">{"//"} INTEL_SPECIFICATION</span>
                  <h2 className="text-sm font-bold text-foreground border-b border-secondary/20 pb-3 mb-4">{activeItem.title}</h2>
                  
                  <span className="text-[9px] text-muted-foreground font-bold uppercase block mb-1">threat_vector_summary:</span>
                  <p className="text-[11px] text-foreground/80 leading-relaxed mb-6">{activeItem.summary}</p>

                  <span className="text-[9px] text-muted-foreground font-bold uppercase block mb-1">recommended_mitigation:</span>
                  <div className="p-4 bg-black/5 dark:bg-black/60 border border-border rounded-lg text-[10px] text-[#007cdb] dark:text-[#00f0ff] leading-relaxed mb-4 shadow-inner">
                    {activeItem.mitigation}
                  </div>

                  <div className="text-[9px] text-muted-foreground text-right mt-auto pt-4 border-t border-white/5">
                    REF_ID: {activeItem.id.toUpperCase()}
                  </div>
                </motion.div>
              ) : (
                <div className="flex flex-col items-center justify-center h-full min-h-[310px] text-center text-muted-foreground font-mono text-xs">
                  SELECT_NEWS_ENTRY_FOR_FULL_REPORT
                </div>
              )}
            </GlassCard>
          </div>

        </div>

        {/* Back Link */}
        <div className="text-center mt-6">
          <a
            href={mounted ? getSubdomainUrl('home') : '/'}
            className="inline-flex items-center gap-2 text-xs font-mono font-bold text-muted-foreground hover:text-secondary transition-colors"
          >
            <span>&lt;--</span>
            <span>SYSTEM_CORE_HOME</span>
          </a>
        </div>
      </div>
    </main>
  );
}
