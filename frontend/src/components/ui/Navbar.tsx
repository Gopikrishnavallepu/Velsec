'use client';

import Image from 'next/image';
import { useEffect, useState } from 'react';
import { getSubdomainUrl } from '@/utils/navigation';
import { createClient } from '@/utils/supabase/client';
import { useTheme } from 'next-themes';
import { Sun, Moon, Menu, X } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';

const navLinks = [
  { label: 'LEARN', key: 'learn' },
  { label: 'PROJECTS', key: 'projects' },
  { label: 'NOTES', key: 'notes' },
  { label: 'NEWS', key: 'news' },
  { label: 'TRACKER', key: 'tracker' },
  { label: 'PERSONAL', key: 'personal' },
];

export default function Navbar() {
  const [mounted, setMounted] = useState(false);
  const [session, setSession] = useState<any>(null);
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
  const supabase = createClient();
  const { theme, setTheme } = useTheme();

  useEffect(() => {
    setMounted(true);
    
    // Fetch initial session
    supabase.auth.getSession().then(({ data: { session } }) => {
      setSession(session);
    });

    // Listen for auth changes
    const { data: { subscription } } = supabase.auth.onAuthStateChange((_event, session) => {
      setSession(session);
    });

    return () => subscription.unsubscribe();
  }, [supabase.auth]);

  return (
    <>
      <nav className="fixed top-0 left-0 w-full z-50 px-4 py-2 flex justify-between items-center border-b border-cyber-green/20 bg-cyber-bg/95 backdrop-blur-md">
        {/* Logo / Terminal Prompt */}
        <a 
          href={mounted ? getSubdomainUrl('home') : '/'} 
          className="flex items-center gap-2 group"
        >
          <div className="relative w-8 h-8 group-hover:drop-shadow-[0_0_15px_rgba(0,255,136,0.8)] transition-all duration-300">
            <Image src="/logo.png" alt="Velsec Logo" fill className="object-contain" priority />
          </div>
          <span className="text-sm font-bold tracking-widest font-mono hidden sm:inline-block text-cyber-green text-glow-green">
            root@velsec:~$ <span className="text-foreground/80 animate-pulse">_</span>
          </span>
        </a>

        {/* Navigation Links and Auth Button Container */}
        <div className="flex items-center gap-1 md:gap-4">
          {/* Main Links */}
          <div className="hidden lg:flex items-center gap-2 mr-2">
            {navLinks.map((link) => (
              <a
                key={link.label}
                href={mounted ? getSubdomainUrl(link.key) : `/${link.key}`}
                className="group flex items-center gap-1.5 px-3 py-1 text-[10px] font-mono tracking-widest text-muted-foreground hover:text-cyber-green transition-all duration-300 border border-transparent hover:border-cyber-green/30 hover:bg-cyber-green/5"
              >
                <span className="w-1.5 h-1.5 rounded-full bg-muted-foreground group-hover:bg-cyber-green group-hover:animate-ping" />
                {link.label}
              </a>
            ))}
          </div>

          <div className="flex items-center gap-3 lg:border-l lg:border-border lg:pl-4">
            {/* Theme Toggle */}
            {mounted && (
              <button
                onClick={() => setTheme(theme === 'dark' ? 'light' : 'dark')}
                className="p-1.5 rounded-sm bg-black border border-border text-muted-foreground hover:text-cyber-blue hover:border-cyber-blue/50 transition-all"
                aria-label="Toggle Theme"
              >
                {theme === 'dark' ? <Sun size={14} /> : <Moon size={14} />}
              </button>
            )}

            {/* Auth Button */}
            {session ? (
              <a
                href={mounted ? getSubdomainUrl('home', '/profile') : '/profile'}
                className="hidden lg:inline-block px-4 py-1.5 text-[10px] font-mono tracking-widest text-cyber-blue hover:bg-cyber-blue/10 border border-cyber-blue/30 hover:border-cyber-blue hover:shadow-[0_0_10px_rgba(0,200,255,0.3)] transition-all duration-300 whitespace-nowrap"
              >
                [ PROFILE ]
              </a>
            ) : (
              <a
                href={mounted ? getSubdomainUrl('home', '/login') : '/login'}
                className="hidden lg:inline-block px-4 py-1.5 text-[10px] font-mono tracking-widest text-cyber-bg bg-cyber-green hover:bg-cyber-green border border-cyber-green hover:shadow-[0_0_15px_rgba(0,255,136,0.6)] transition-all duration-300 whitespace-nowrap"
              >
                AUTH::LOGIN
              </a>
            )}

            {/* Hamburger Menu for Mobile */}
            <button
              className="lg:hidden p-2 rounded-lg bg-card border border-border text-muted-foreground hover:text-secondary transition-all ml-1"
              onClick={() => setIsMobileMenuOpen(true)}
              aria-label="Open Menu"
            >
              <Menu size={20} />
            </button>
          </div>
        </div>
      </nav>

      {/* Mobile Sidebar Overlay */}
      <AnimatePresence>
        {isMobileMenuOpen && (
          <>
            {/* Backdrop */}
            <motion.div
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              exit={{ opacity: 0 }}
              className="fixed inset-0 bg-black/60 backdrop-blur-sm z-[60] lg:hidden"
              onClick={() => setIsMobileMenuOpen(false)}
            />
            
            {/* Sidebar */}
            <motion.div
              initial={{ x: '100%' }}
              animate={{ x: 0 }}
              exit={{ x: '100%' }}
              transition={{ type: 'spring', damping: 25, stiffness: 200 }}
              className="fixed top-0 right-0 h-full w-[280px] bg-background border-l border-border z-[70] p-6 flex flex-col shadow-2xl lg:hidden"
            >
              <div className="flex justify-between items-center mb-8">
                <span className="text-xl font-bold tracking-widest font-mono">
                  <span className="text-foreground">VEL</span>
                  <span className="text-secondary">SEC</span>
                </span>
                <button
                  onClick={() => setIsMobileMenuOpen(false)}
                  className="p-2 rounded-lg hover:bg-accent text-muted-foreground hover:text-foreground transition-colors"
                >
                  <X size={24} />
                </button>
              </div>

              <div className="flex flex-col gap-2 flex-1">
                {navLinks.map((link) => (
                  <a
                    key={link.label}
                    href={mounted ? getSubdomainUrl(link.key) : `/${link.key}`}
                    className="px-4 py-3 text-sm font-mono font-bold tracking-wider text-muted-foreground hover:text-secondary hover:bg-accent rounded-lg transition-all border border-transparent hover:border-border"
                    onClick={() => setIsMobileMenuOpen(false)}
                  >
                    {link.label}
                  </a>
                ))}
              </div>

              <div className="pt-6 border-t border-border mt-auto">
                {session ? (
                  <a
                    href={mounted ? getSubdomainUrl('home', '/profile') : '/profile'}
                    className="flex justify-center w-full px-4 py-3 text-sm font-mono font-bold tracking-wider text-secondary hover:bg-accent rounded transition-all border border-border"
                  >
                    PROFILE
                  </a>
                ) : (
                  <a
                    href={mounted ? getSubdomainUrl('home', '/login') : '/login'}
                    className="flex justify-center w-full px-4 py-3 text-sm font-mono font-bold tracking-wider text-primary-foreground bg-secondary hover:opacity-90 rounded transition-all shadow-[0_0_15px_rgba(0,150,255,0.3)]"
                  >
                    LOGIN
                  </a>
                )}
              </div>
            </motion.div>
          </>
        )}
      </AnimatePresence>
    </>
  );
}
