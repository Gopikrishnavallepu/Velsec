'use client';

import Image from 'next/image';
import { useEffect, useState } from 'react';
import { getSubdomainUrl } from '@/utils/navigation';
import { createClient } from '@/utils/supabase/client';
import { useTheme } from 'next-themes';
import { Sun, Moon, Menu, X, TerminalSquare } from 'lucide-react';
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
      <nav className="fixed top-0 left-0 w-full z-50 px-6 py-3 flex justify-between items-center border-b border-border bg-dark-glass backdrop-blur-md shadow-[0_4px_30px_rgba(0,255,136,0.05)]">
        {/* Logo */}
        <a 
          href={mounted ? getSubdomainUrl('home') : '/'} 
          className="flex items-center gap-3 group interactive glitch-hover"
        >
          <div className="relative w-12 h-12 drop-shadow-[0_0_12px_rgba(0,255,136,0.4)] group-hover:drop-shadow-[0_0_20px_rgba(0,255,136,0.8)] transition-all duration-300">
            <TerminalSquare className="w-full h-full text-primary" strokeWidth={1.5} />
          </div>
          <span className="text-xl font-bold tracking-widest font-mono hidden sm:inline-block">
            <span className="text-foreground">VEL</span>
            <span className="text-primary text-glow-green">SEC</span>
            <span className="animate-pulse text-primary">_</span>
          </span>
        </a>

        {/* Navigation Links and Auth Button Container */}
        <div className="flex items-center gap-1 md:gap-4">
          {/* Main Links */}
          <div className="hidden lg:flex items-center gap-1">
            {navLinks.map((link) => (
              <a
                key={link.label}
                href={mounted ? getSubdomainUrl(link.key) : `/${link.key}`}
                className="interactive relative px-4 py-2 text-xs font-mono font-bold tracking-wider text-muted-foreground hover:text-primary transition-all duration-300 overflow-hidden group"
              >
                <span className="relative z-10 group-hover:text-glow-green">{link.label}</span>
                <span className="absolute bottom-0 left-0 w-full h-[2px] bg-primary scale-x-0 group-hover:scale-x-100 transform origin-left transition-transform duration-300 ease-out shadow-[0_0_8px_rgba(0,255,136,0.8)]" />
              </a>
            ))}
          </div>

          <div className="flex items-center gap-3 lg:border-l lg:border-border lg:pl-4">
            {/* Theme Toggle */}
            {mounted && (
              <button
                onClick={() => setTheme(theme === 'dark' ? 'light' : 'dark')}
                className="interactive p-2 rounded-none bg-black/40 border border-border text-muted-foreground hover:text-secondary hover:border-secondary hover:box-glow-blue transition-all"
                aria-label="Toggle Theme"
              >
                {theme === 'dark' ? <Sun size={16} /> : <Moon size={16} />}
              </button>
            )}

            {/* Auth Button */}
            {session ? (
              <a
                href={mounted ? getSubdomainUrl('home', '/profile') : '/profile'}
                className="interactive hidden lg:inline-block px-4 py-2 text-xs font-mono font-bold tracking-wider text-secondary hover:text-primary hover:bg-primary/10 transition-all duration-300 border border-secondary hover:border-primary whitespace-nowrap shadow-[0_0_10px_rgba(0,200,255,0.1)] hover:box-glow-green"
              >
                PROFILE
              </a>
            ) : (
              <a
                href={mounted ? getSubdomainUrl('home', '/login') : '/login'}
                className="interactive hidden lg:inline-block px-4 py-2 text-xs font-mono font-bold tracking-wider text-black bg-primary hover:bg-primary/90 transition-all duration-300 shadow-[0_0_15px_rgba(0,255,136,0.4)] hover:shadow-[0_0_25px_rgba(0,255,136,0.6)] whitespace-nowrap"
              >
                INIT_LOGIN()
              </a>
            )}

            {/* Hamburger Menu for Mobile */}
            <button
              className="interactive lg:hidden p-2 rounded-none bg-black/40 border border-border text-muted-foreground hover:text-primary hover:border-primary transition-all ml-1"
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
              className="fixed inset-0 bg-black/80 backdrop-blur-md z-[60] lg:hidden"
              onClick={() => setIsMobileMenuOpen(false)}
            />
            
            {/* Sidebar */}
            <motion.div
              initial={{ x: '100%' }}
              animate={{ x: 0 }}
              exit={{ x: '100%' }}
              transition={{ type: 'spring', damping: 25, stiffness: 200 }}
              className="fixed top-0 right-0 h-full w-[280px] bg-dark-bg border-l border-primary/30 z-[70] p-6 flex flex-col shadow-[-10px_0_30px_rgba(0,255,136,0.1)] lg:hidden"
            >
              <div className="flex justify-between items-center mb-8 pb-4 border-b border-border">
                <span className="text-xl font-bold tracking-widest font-mono">
                  <span className="text-foreground">VEL</span>
                  <span className="text-primary text-glow-green">SEC</span>
                  <span className="animate-pulse text-primary">_</span>
                </span>
                <button
                  onClick={() => setIsMobileMenuOpen(false)}
                  className="interactive p-2 rounded-none hover:bg-primary/10 text-muted-foreground hover:text-primary transition-colors border border-transparent hover:border-primary"
                >
                  <X size={24} />
                </button>
              </div>

              <div className="flex flex-col gap-2 flex-1">
                {navLinks.map((link) => (
                  <a
                    key={link.label}
                    href={mounted ? getSubdomainUrl(link.key) : `/${link.key}`}
                    className="interactive px-4 py-3 text-sm font-mono font-bold tracking-wider text-muted-foreground hover:text-primary hover:bg-primary/10 transition-all border-l-2 border-transparent hover:border-primary"
                    onClick={() => setIsMobileMenuOpen(false)}
                  >
                    &gt; {link.label}
                  </a>
                ))}
              </div>

              <div className="pt-6 border-t border-border mt-auto">
                {session ? (
                  <a
                    href={mounted ? getSubdomainUrl('home', '/profile') : '/profile'}
                    className="interactive flex justify-center w-full px-4 py-3 text-sm font-mono font-bold tracking-wider text-secondary hover:text-primary hover:bg-primary/10 transition-all border border-secondary hover:border-primary"
                  >
                    SYS.PROFILE()
                  </a>
                ) : (
                  <a
                    href={mounted ? getSubdomainUrl('home', '/login') : '/login'}
                    className="interactive flex justify-center w-full px-4 py-3 text-sm font-mono font-bold tracking-wider text-black bg-primary hover:bg-primary/90 transition-all shadow-[0_0_15px_rgba(0,255,136,0.3)] hover:shadow-[0_0_25px_rgba(0,255,136,0.6)]"
                  >
                    SYS.LOGIN()
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
