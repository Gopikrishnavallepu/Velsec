'use client';

import Image from 'next/image';
import { useEffect, useState } from 'react';
import { motion, Variants } from 'framer-motion';
import SubdomainGrid from '@/components/ui/SubdomainGrid';
import { getSubdomainUrl } from '@/utils/navigation';
import TiltWrapper from '@/components/ui/TiltWrapper';
import AnimatedButton from '@/components/ui/AnimatedButton';
import { Shield, Activity, Cpu, Network, Terminal, Lock, Globe, Server } from 'lucide-react';

const widgets = [
  { icon: <Shield size={20} />, label: 'THREAT_LEVEL', value: 'ELEVATED', color: 'text-warning' },
  { icon: <Activity size={20} />, label: 'ACTIVE_SESSIONS', value: '1,337', color: 'text-primary' },
  { icon: <Cpu size={20} />, label: 'SYS_LOAD', value: '42.8%', color: 'text-secondary' },
  { icon: <Network size={20} />, label: 'NET_TRAFFIC', value: '8.4 TB/s', color: 'text-primary' },
];

const modules = [
  { icon: <Terminal size={24} />, label: 'CYBER_ACADEMY', subdomain: 'learn', desc: 'Execute learning modules and master offensive/defensive operations.' },
  { icon: <Server size={24} />, label: 'LAB_ENVIRONMENTS', subdomain: 'projects', desc: 'Deploy virtualized targets and practice live exploitation.' },
  { icon: <Globe size={24} />, label: 'THREAT_INTEL', subdomain: 'news', desc: 'Monitor global security events and vulnerability disclosures.' },
  { icon: <Lock size={24} />, label: 'SYS_TRACKER', subdomain: 'tracker', desc: 'Analyze skill progression and certification readiness.' },
];

export default function HomePage() {
  const [mounted, setMounted] = useState(false);
  const [logText, setLogText] = useState("");
  const fullLog = `> INIT SYS... OK\n> ESTABLISHING SECURE CONNECTION... OK\n> BYPASSING MAINFRAME ENCRYPTION... [SUCCESS]\n> WELCOME TO VELSEC CYBER COMMAND.`;

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
    }, 30);
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
    hidden: { opacity: 0, y: 20 },
    show: { opacity: 1, y: 0, transition: { duration: 0.5, ease: "easeOut" } }
  };

  return (
    <main className="relative min-h-screen overflow-hidden pt-20 pb-12 font-mono">
      {/* ========== COMMAND CENTER DASHBOARD ========== */}
      <section className="relative min-h-screen flex flex-col items-center px-4 md:px-8">
        <motion.div 
          className="z-10 w-full max-w-7xl flex flex-col gap-6"
          variants={containerVariants}
          initial="hidden"
          animate="show"
        >

          {/* ---- Top Header Bar ---- */}
          <motion.div variants={itemVariants} className="w-full flex flex-col md:flex-row justify-between items-end border-b border-primary/30 pb-4">
            <div className="flex items-center gap-4">
              <div className="w-16 h-16 relative">
                <Image src="/logo.png" alt="Velsec" fill className="object-contain" />
              </div>
              <div>
                <h1 className="text-3xl md:text-5xl font-black tracking-widest text-primary text-glow-green">
                  VELSEC_CMD
                </h1>
                <p className="text-xs md:text-sm text-secondary tracking-widest uppercase">
                  Global Security Operations Center
                </p>
              </div>
            </div>
            <div className="hidden md:flex flex-col items-end">
              <span className="text-xs text-muted-foreground">STATUS: <span className="text-primary animate-pulse">ONLINE</span></span>
              <span className="text-xs text-muted-foreground">ENCRYPTION: AES-256 GCM</span>
              <span className="text-xs text-muted-foreground">TIME: {mounted ? new Date().toISOString() : '...'}</span>
            </div>
          </motion.div>

          {/* ---- Dashboard Grid ---- */}
          <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
            
            {/* Left Column: Logs & Identity */}
            <motion.div variants={itemVariants} className="lg:col-span-1 flex flex-col gap-6">
              
              {/* Terminal Window */}
              <div className="bg-black/80 border border-primary/40 rounded-sm shadow-[0_0_15px_rgba(0,255,136,0.1)] overflow-hidden flex flex-col h-64">
                <div className="bg-primary/20 border-b border-primary/40 px-3 py-1 flex items-center justify-between">
                  <span className="text-[10px] text-primary">/bin/bash - velsec-sys</span>
                  <div className="flex gap-1">
                    <div className="w-2 h-2 rounded-full bg-destructive" />
                    <div className="w-2 h-2 rounded-full bg-warning" />
                    <div className="w-2 h-2 rounded-full bg-primary" />
                  </div>
                </div>
                <div className="p-4 font-mono text-xs text-primary/80 whitespace-pre-wrap flex-1 overflow-y-auto">
                  {logText}
                  <span className="animate-pulse">_</span>
                </div>
              </div>

              {/* Action Buttons */}
              <div className="flex flex-col gap-3">
                <a href={mounted ? getSubdomainUrl('learn') : '/learn'} className="w-full">
                  <AnimatedButton glowColor="green" icon={<Terminal size={16}/>} className="w-full justify-start">
                    INIT_ACADEMY()
                  </AnimatedButton>
                </a>
                <a href={mounted ? getSubdomainUrl('projects') : '/projects'} className="w-full">
                  <AnimatedButton glowColor="blue" icon={<Shield size={16}/>} className="w-full justify-start">
                    DEPLOY_LABS()
                  </AnimatedButton>
                </a>
              </div>

            </motion.div>

            {/* Right Column: Widgets & Modules */}
            <motion.div variants={itemVariants} className="lg:col-span-2 flex flex-col gap-6">
              
              {/* Status Widgets */}
              <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
                {widgets.map((w, idx) => (
                  <div key={idx} className="bg-black/60 border border-secondary/30 p-4 rounded-sm flex flex-col hover:border-secondary hover:shadow-[0_0_20px_rgba(0,200,255,0.2)] transition-all group">
                    <div className="text-secondary/70 mb-2 group-hover:text-secondary transition-colors">{w.icon}</div>
                    <span className="text-[10px] text-muted-foreground mb-1">{w.label}</span>
                    <span className={`text-lg font-bold tracking-wider ${w.color}`}>{w.value}</span>
                  </div>
                ))}
              </div>

              {/* System Modules Grid */}
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4 flex-1">
                {modules.map((m, idx) => (
                  <a 
                    key={idx}
                    href={mounted ? getSubdomainUrl(m.subdomain) : `/${m.subdomain}`}
                    className="group interactive bg-black/40 border border-primary/20 p-5 rounded-sm hover:border-primary hover:bg-primary/5 transition-all duration-300 relative overflow-hidden flex flex-col justify-between"
                  >
                    <div className="absolute top-0 left-0 w-full h-[1px] bg-gradient-to-r from-transparent via-primary/50 to-transparent -translate-x-full group-hover:animate-[glint_2s_ease-in-out_infinite]" />
                    <div>
                      <div className="flex items-center gap-3 mb-3">
                        <div className="text-primary group-hover:text-glow-green transition-all">{m.icon}</div>
                        <h3 className="text-sm font-bold text-foreground group-hover:text-primary transition-colors">{m.label}</h3>
                      </div>
                      <p className="text-xs text-muted-foreground group-hover:text-foreground/80 transition-colors">
                        {m.desc}
                      </p>
                    </div>
                    <div className="mt-4 text-[10px] text-primary/50 group-hover:text-primary transition-colors flex items-center gap-1">
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

      {/* ========== ECOSYSTEM SECTION (Terminal Styled) ========== */}
      <section className="relative py-24 px-6 z-10 bg-black/90 border-t border-secondary/30">
        <motion.div 
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true, margin: "-100px" }}
          transition={{ duration: 0.5 }}
          className="max-w-7xl mx-auto mb-10 border-l-2 border-secondary pl-4"
        >
          <h2 className="text-xl md:text-2xl font-bold font-mono tracking-wider text-secondary">
            &gt; SYSTEM.DISCOVER(ECOSYSTEM)
          </h2>
          <p className="text-xs text-muted-foreground font-mono mt-2 uppercase">
            Scanning available network nodes and subdomains...
          </p>
        </motion.div>

        <SubdomainGrid />
      </section>

      {/* ========== FOOTER ========== */}
      <footer className="relative py-8 px-6 border-t border-primary/30 z-10 bg-black/80">
        <div className="max-w-7xl mx-auto flex flex-col md:flex-row justify-between items-center gap-4">
          <div className="flex items-center gap-2">
            <Terminal size={14} className="text-primary" />
            <span className="text-[10px] font-mono text-muted-foreground">
              ROOT@VELSEC:~# EOF - 2025 SECURE TODAY. EMPOWER TOMORROW.
            </span>
          </div>
          <div className="flex gap-4 text-[10px] font-mono">
            <span className="text-primary/60 hover:text-primary transition-colors cursor-pointer">[GITHUB]</span>
            <span className="text-primary/60 hover:text-primary transition-colors cursor-pointer">[DISCORD]</span>
            <span className="text-primary/60 hover:text-primary transition-colors cursor-pointer">[TWITTER]</span>
          </div>
        </div>
      </footer>
    </main>
  );
}
