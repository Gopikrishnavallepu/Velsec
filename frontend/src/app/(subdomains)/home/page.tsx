'use client';

import Image from 'next/image';
import { useEffect, useState } from 'react';
import { motion, Variants } from 'framer-motion';
import SubdomainGrid from '@/components/ui/SubdomainGrid';
import { getSubdomainUrl } from '@/utils/navigation';
import TiltWrapper from '@/components/ui/TiltWrapper';
import AnimatedButton from '@/components/ui/AnimatedButton';

const pillars = [
  { icon: '🔒', label: 'CYBERSECURITY\nSOLUTIONS', subdomain: 'home' },
  { icon: '🎓', label: 'LEARNING\nECOSYSTEM', subdomain: 'learn' },
  { icon: '🧠', label: 'AI\nSECURITY', subdomain: 'home' },
  { icon: '♾️', label: 'DEVSECOPS\nEXCELLENCE', subdomain: 'projects' },
  { icon: '👤', label: 'PERSONAL &\nCAREER GROWTH', subdomain: 'personal' },
  { icon: '💻', label: 'PROJECTS &\nPRACTICAL LABS', subdomain: 'projects' },
  { icon: '📰', label: 'TECH NEWS &\nINSIGHTS', subdomain: 'news' },
  { icon: '🎯', label: 'PROGRESS\nTRACKER', subdomain: 'tracker' },
];

const actionBar = [
  { icon: '📖', label: 'LEARN', subdomain: 'learn' },
  { icon: '🔬', label: 'PRACTICE', subdomain: 'projects' },
  { icon: '⚙️', label: 'IMPLEMENT', subdomain: 'projects' },
  { icon: '📈', label: 'GROW', subdomain: 'tracker' },
  { icon: '🛡️', label: 'PROTECT', subdomain: 'home' },
];

export default function HomePage() {
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
  }, []);

  const containerVariants: Variants = {
    hidden: { opacity: 0 },
    show: {
      opacity: 1,
      transition: {
        staggerChildren: 0.15,
        delayChildren: 0.2
      }
    }
  };

  const itemVariants: Variants = {
    hidden: { opacity: 0, y: 30 },
    show: { opacity: 1, y: 0, transition: { duration: 0.8, ease: [0.22, 1, 0.36, 1] } }
  };

  return (
    <main className="relative min-h-screen overflow-hidden">
      {/* ========== HERO SECTION ========== */}
      <section className="relative min-h-screen flex flex-col items-center justify-center px-4 md:px-8 pt-24 pb-12">
        <motion.div 
          className="z-10 w-full max-w-6xl flex flex-col items-center"
          variants={containerVariants}
          initial="hidden"
          animate="show"
        >

          {/* ---- Logo + Branding ---- */}
          <motion.div variants={itemVariants} className="flex flex-col items-center gap-2 mb-6">
            <TiltWrapper intensity={20}>
              <div className="relative w-28 h-28 md:w-36 md:h-36 drop-shadow-[0_0_40px_rgba(0,150,255,0.6)]">
                <Image
                  src="/logo.png"
                  alt="Velsec Logo"
                  fill
                  className="object-contain mix-blend-lighten"
                  priority
                />
              </div>
            </TiltWrapper>

            {/* VELSEC Title */}
            <h1 className="text-6xl md:text-8xl font-black tracking-[0.15em] font-mono leading-none mt-4">
              <span className="text-foreground">VEL</span>
              <span className="text-secondary text-glow-blue">SEC</span>
            </h1>

            {/* Tagline */}
            <p className="text-base md:text-xl font-bold tracking-wider mt-2 text-center">
              <span className="text-foreground">SECURE TODAY. </span>
              <span className="text-secondary italic text-glow-blue">EMPOWER TOMORROW.</span>
            </p>

            {/* Subtitle */}
            <p className="text-xs md:text-sm text-muted-foreground italic tracking-wide text-center mt-1">
              The Ultimate Cybersecurity Learning &amp; Solutions Ecosystem
            </p>
          </motion.div>

          {/* Separator */}
          <motion.div variants={itemVariants} className="w-full max-w-4xl h-px bg-gradient-to-r from-transparent via-[#0096ff]/30 to-transparent my-6" />

          {/* ---- 8 Pillar Cards ---- */}
          <motion.div variants={itemVariants} className="w-full grid grid-cols-2 sm:grid-cols-4 lg:grid-cols-8 gap-3 mb-8">
            {pillars.map((p, idx) => (
              <motion.a
                key={p.label}
                href={mounted ? getSubdomainUrl(p.subdomain) : `/${p.subdomain}`}
                whileHover={{ scale: 1.05, y: -5 }}
                whileTap={{ scale: 0.95 }}
                className="group flex flex-col items-center text-center p-3 rounded-xl border border-border/30 hover:border-secondary/60 transition-all duration-300 hover:shadow-[0_0_30px_rgba(0,150,255,0.15)] bg-white/5 dark:bg-black/40 backdrop-blur-md"
              >
                <div className="w-12 h-12 rounded-full border border-secondary/30 flex items-center justify-center mb-2 group-hover:border-secondary group-hover:shadow-[0_0_20px_rgba(0,150,255,0.3)] transition-all duration-300">
                  <span className="text-xl group-hover:scale-110 transition-transform duration-300">{p.icon}</span>
                </div>
                <span className="text-[9px] md:text-[10px] font-mono font-bold text-muted-foreground group-hover:text-secondary transition-colors duration-300 leading-tight whitespace-pre-line">
                  {p.label}
                </span>
              </motion.a>
            ))}
          </motion.div>

          {/* ---- Action Bar ---- */}
          <motion.div variants={itemVariants} className="mt-4 flex flex-wrap justify-center gap-4">
            <a href={mounted ? getSubdomainUrl('learn') : '/learn'}>
              <AnimatedButton glowColor="purple" icon="🚀">
                ENTER ACADEMY
              </AnimatedButton>
            </a>
            <a href={mounted ? getSubdomainUrl('projects') : '/projects'}>
              <AnimatedButton glowColor="green" icon="💻">
                ACCESS LABS
              </AnimatedButton>
            </a>
          </motion.div>

        </motion.div>
      </section>

      {/* ========== ECOSYSTEM SECTION ========== */}
      <section className="relative py-24 px-6 z-10 bg-black/5 dark:bg-black/20 backdrop-blur-lg border-t border-border">
        <motion.div 
          initial={{ opacity: 0, y: 40 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true, margin: "-100px" }}
          transition={{ duration: 0.8 }}
          className="text-center mb-16"
        >
          <h2 className="text-3xl md:text-4xl font-bold font-mono tracking-wider mb-4">
            <span className="text-muted-foreground">THE </span>
            <span className="text-transparent bg-clip-text bg-gradient-to-r from-[#0096ff] to-[#39ff14] text-glow-blue">ECOSYSTEM</span>
          </h2>
          <p className="text-sm text-muted-foreground font-mono max-w-xl mx-auto">
            Six integrated platforms designed to accelerate your cybersecurity career from learning to implementation.
          </p>
          <div className="w-32 h-[2px] bg-gradient-to-r from-transparent via-[#0096ff] to-transparent mx-auto mt-6" />
        </motion.div>

        <SubdomainGrid />
      </section>

      {/* ========== FOOTER ========== */}
      <footer className="relative py-12 px-6 border-t border-border z-10 bg-background/80 backdrop-blur-md">
        <div className="max-w-6xl mx-auto flex flex-col md:flex-row justify-between items-center gap-6">
          <div className="flex items-center gap-3">
            <div className="relative w-8 h-8">
              <Image
                src="/logo.png"
                alt="Velsec"
                fill
                className="object-contain mix-blend-lighten"
              />
            </div>
            <span className="text-sm font-mono text-zinc-600">
              &copy; 2025 Velsec. Secure Today. Empower Tomorrow.
            </span>
          </div>
          <div className="flex gap-6 text-xs font-mono">
            <span className="text-zinc-600 hover:text-secondary transition-colors cursor-pointer">GitHub</span>
            <span className="text-zinc-600 hover:text-secondary transition-colors cursor-pointer">Discord</span>
            <span className="text-zinc-600 hover:text-secondary transition-colors cursor-pointer">Twitter</span>
          </div>
        </div>
      </footer>
    </main>
  );
}
