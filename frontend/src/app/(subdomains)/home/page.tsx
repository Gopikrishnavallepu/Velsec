'use client';

import Image from 'next/image';
import { useEffect, useState } from 'react';
import { motion, Variants } from 'framer-motion';
import SubdomainGrid from '@/components/ui/SubdomainGrid';
import { getSubdomainUrl } from '@/utils/navigation';
import AnimatedButton from '@/components/ui/AnimatedButton';
import { Shield, Activity, Cpu, Network, Terminal, Lock, Globe, Server } from 'lucide-react';

const widgets = [
  { icon: <Shield size={16} />, label: 'THREAT_LEVEL', value: 'ELEVATED', color: 'text-destructive' },
  { icon: <Activity size={16} />, label: 'ACTIVE_SESSIONS', value: '1,337', color: 'text-cyber-green' },
  { icon: <Cpu size={16} />, label: 'SYS_LOAD', value: '42.8%', color: 'text-cyber-blue' },
  { icon: <Network size={16} />, label: 'NET_TRAFFIC', value: '8.4 TB/S', color: 'text-cyber-purple' },
];

const modules = [
  { icon: <Terminal size={20} />, label: 'CYBER_ACADEMY', subdomain: 'learn', desc: 'EXECUTE LEARNING MODULES AND MASTER OFFENSIVE/DEFENSIVE OPERATIONS.' },
  { icon: <Server size={20} />, label: 'LAB_ENVIRONMENTS', subdomain: 'projects', desc: 'DEPLOY VIRTUALIZED TARGETS AND PRACTICE LIVE EXPLOITATION.' },
  { icon: <Globe size={20} />, label: 'THREAT_INTEL', subdomain: 'news', desc: 'MONITOR GLOBAL SECURITY EVENTS AND VULNERABILITY DISCLOSURES.' },
  { icon: <Lock size={20} />, label: 'SYS_TRACKER', subdomain: 'tracker', desc: 'ANALYZE SKILL PROGRESSION AND CERTIFICATION READINESS.' },
];

export default function HomePage() {
  const [mounted, setMounted] = useState(false);
  const [logText, setLogText] = useState("");
  const fullLog = `> INIT SYS... [OK]\n> ESTABLISHING SECURE CONNECTION... [OK]\n> BYPASSING MAINFRAME ENCRYPTION... [SUCCESS]\n> WELCOME TO VELSEC CYBER COMMAND.`;

  useEffect(() => {
    setMounted(true);
    let i = 0;
    const typingInterval = setInterval(() => {
      if (i < fullLog.length) {
        setLogText(fullLog.slice(0, i + 1));
        i++;
      } else {
        clearInterval(typingInterval);
      }
    }, 20);
    return () => clearInterval(typingInterval);
  }, []);

  const containerVariants: Variants = {
    hidden: { opacity: 0 },
    show: {
      opacity: 1,
      transition: { staggerChildren: 0.1, delayChildren: 0.1 }
    }
  };

  const itemVariants: Variants = {
    hidden: { opacity: 0, y: 15 },
    show: { opacity: 1, y: 0, transition: { duration: 0.4, ease: "easeOut" } }
  };

  return (
    <main className="relative min-h-screen overflow-hidden pt-20 pb-12 bg-cyber-bg">
      {/* ========== COMMAND CENTER DASHBOARD ========== */}
      <section className="relative min-h-screen flex flex-col items-center px-4 md:px-8">
        <motion.div 
          className="z-10 w-full max-w-7xl flex flex-col gap-6"
          variants={containerVariants}
          initial="hidden"
          animate="show"
        >

          {/* ---- Top Header Bar ---- */}
          <motion.div variants={itemVariants} className="w-full flex flex-col md:flex-row justify-between items-end pb-4">
            <div className="flex items-center gap-4">
              <div className="w-16 h-16 relative">
                <Image src="/logo.png" alt="Velsec" fill className="object-contain" />
              </div>
              <div>
                <h1 
                  className="text-4xl md:text-5xl font-black tracking-widest text-cyber-green text-glow-green uppercase glitch-effect" 
                  data-text="VELSEC_CMD"
                >
                  VELSEC_CMD
                </h1>
                <p className="text-[10px] md:text-xs text-cyber-blue tracking-widest uppercase font-mono mt-1">
                  Global Security Operations Center
                </p>
              </div>
            </div>
            <div className="hidden md:flex flex-col items-end font-mono">
              <span className="text-[10px] text-muted-foreground tracking-widest">
                SYS.STATUS: <span className="text-cyber-green animate-pulse inline-block">ONLINE</span>
              </span>
              <span className="text-[10px] text-muted-foreground tracking-widest">ENCRYPTION: AES-256 GCM</span>
              <span className="text-[10px] text-muted-foreground tracking-widest">TIME: {mounted ? new Date().toISOString() : '...'}</span>
            </div>
          </motion.div>
          
          {/* Thin divider line */}
          <div className="w-full h-px bg-gradient-to-r from-transparent via-cyber-green/30 to-transparent" />

          {/* ---- Dashboard Bento Grid ---- */}
          <div className="grid grid-cols-1 lg:grid-cols-12 gap-4">
            
            {/* Left Column: Logs & Identity (Col Span 4) */}
            <motion.div variants={itemVariants} className="lg:col-span-4 flex flex-col gap-4">
              
              {/* Terminal Window */}
              <div className="bg-cyber-darker border border-cyber-green/20 rounded-md shadow-[0_0_15px_rgba(0,255,136,0.05)] overflow-hidden flex flex-col h-64">
                <div className="bg-cyber-green/10 border-b border-cyber-green/20 px-3 py-1.5 flex items-center justify-between">
                  <span className="text-[10px] text-cyber-green font-mono tracking-widest uppercase">/bin/bash - velsec-sys</span>
                  <div className="flex gap-1.5">
                    <div className="w-2 h-2 rounded-full bg-destructive" />
                    <div className="w-2 h-2 rounded-full bg-[#f59e0b]" />
                    <div className="w-2 h-2 rounded-full bg-cyber-green" />
                  </div>
                </div>
                <div className="p-4 font-mono text-xs text-cyber-green/80 whitespace-pre-wrap flex-1 overflow-y-auto uppercase tracking-wider leading-relaxed">
                  {logText}
                  <span className="animate-pulse">_</span>
                </div>
              </div>

              {/* Action Buttons */}
              <div className="flex flex-col gap-3">
                <a href={mounted ? getSubdomainUrl('learn') : '/learn'} className="w-full">
                  <AnimatedButton glowColor="green" icon={<Terminal size={14}/>} className="w-full justify-start border-cyber-green/30">
                    INIT_ACADEMY()
                  </AnimatedButton>
                </a>
                <a href={mounted ? getSubdomainUrl('projects') : '/projects'} className="w-full">
                  <AnimatedButton glowColor="blue" icon={<Shield size={14}/>} className="w-full justify-start border-cyber-blue/30">
                    DEPLOY_LABS()
                  </AnimatedButton>
                </a>
              </div>

            </motion.div>

            {/* Right Column: Widgets & Modules (Col Span 8) */}
            <motion.div variants={itemVariants} className="lg:col-span-8 flex flex-col gap-4">
              
              {/* Status Widgets */}
              <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
                {widgets.map((w, idx) => (
                  <div key={idx} className="bg-cyber-darker border border-border/50 p-4 rounded-md flex flex-col hover:border-cyber-blue/50 hover:shadow-[0_0_15px_rgba(0,200,255,0.1)] transition-all group">
                    <div className="text-muted-foreground mb-2 group-hover:text-cyber-blue transition-colors">{w.icon}</div>
                    <span className="text-[10px] text-muted-foreground mb-1 font-mono tracking-widest uppercase">{w.label}</span>
                    <span className={`text-base font-bold tracking-widest font-mono ${w.color}`}>{w.value}</span>
                  </div>
                ))}
              </div>

              {/* System Modules Grid */}
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4 flex-1">
                {modules.map((m, idx) => (
                  <a 
                    key={idx}
                    href={mounted ? getSubdomainUrl(m.subdomain) : `/${m.subdomain}`}
                    className="group interactive bg-slate-950/40 border border-cyber-green/10 p-5 rounded-md hover:border-cyber-green/50 hover:bg-cyber-green/5 transition-all duration-300 relative overflow-hidden flex flex-col justify-between"
                  >
                    <div className="absolute top-0 left-0 w-full h-[1px] bg-gradient-to-r from-transparent via-cyber-green/50 to-transparent -translate-x-full group-hover:animate-[glint_2s_ease-in-out_infinite]" />
                    <div>
                      <div className="flex items-center gap-3 mb-3">
                        <div className="text-cyber-green/70 group-hover:text-cyber-green transition-all">{m.icon}</div>
                        <h3 className="text-sm font-bold text-foreground group-hover:text-cyber-green transition-colors font-mono tracking-widest uppercase">{m.label}</h3>
                      </div>
                      <p className="text-[10px] text-muted-foreground group-hover:text-foreground/80 transition-colors font-mono uppercase tracking-widest leading-relaxed">
                        {m.desc}
                      </p>
                    </div>
                    <div className="mt-4 text-[10px] text-cyber-green/40 group-hover:text-cyber-green transition-colors flex items-center gap-1 font-mono uppercase tracking-widest">
                      <span>EXECUTE</span>
                      <span className="group-hover:translate-x-1 transition-transform">-&gt;</span>
                    </div>
                  </a>
                ))}
              </div>

            </motion.div>
          </div>

        </motion.div>
      </section>

      {/* Thin divider line */}
      <div className="w-full max-w-7xl mx-auto h-px bg-gradient-to-r from-transparent via-cyber-blue/30 to-transparent mt-12 mb-12" />

      {/* ========== ECOSYSTEM SECTION ========== */}
      <section className="relative pb-24 px-6 z-10">
        <motion.div 
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true, margin: "-100px" }}
          transition={{ duration: 0.5 }}
          className="max-w-7xl mx-auto mb-10 border-l-2 border-cyber-blue pl-4"
        >
          <h2 
            className="text-lg md:text-xl font-bold font-mono tracking-widest text-cyber-blue uppercase glitch-effect"
            data-text="> SYSTEM.DISCOVER(ECOSYSTEM)"
          >
            &gt; SYSTEM.DISCOVER(ECOSYSTEM)
          </h2>
          <p className="text-[10px] text-muted-foreground font-mono mt-2 uppercase tracking-widest">
            Scanning available network nodes and subdomains...
          </p>
        </motion.div>

        <SubdomainGrid />
      </section>

      {/* ========== FOOTER ========== */}
      <footer className="relative py-8 px-6 border-t border-cyber-green/20 z-10 bg-cyber-darker">
        <div className="max-w-7xl mx-auto flex flex-col md:flex-row justify-between items-center gap-4">
          <div className="flex items-center gap-2">
            <Terminal size={12} className="text-cyber-green" />
            <span className="text-[10px] font-mono text-muted-foreground tracking-widest uppercase">
              ROOT@VELSEC:~# EOF - 2025 SECURE TODAY. EMPOWER TOMORROW.
            </span>
          </div>
          <div className="flex gap-4 text-[10px] font-mono tracking-widest uppercase">
            <span className="text-cyber-green/50 hover:text-cyber-green transition-colors cursor-pointer">[GITHUB]</span>
            <span className="text-cyber-green/50 hover:text-cyber-green transition-colors cursor-pointer">[DISCORD]</span>
            <span className="text-cyber-green/50 hover:text-cyber-green transition-colors cursor-pointer">[TWITTER]</span>
          </div>
        </div>
      </footer>
    </main>
  );
}
