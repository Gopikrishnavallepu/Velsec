'use client';

import Image from 'next/image';
import { useEffect, useState } from 'react';
import { getSubdomainUrl } from '@/utils/navigation';
import { createClient } from '@/utils/supabase/client';
import { useTheme } from 'next-themes';
import { Sun, Moon } from 'lucide-react';

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
    <nav className="fixed top-0 left-0 w-full z-50 px-6 py-3 flex justify-between items-center border-b border-border bg-background/90 backdrop-blur-md">
      {/* Logo */}
      <a 
        href={mounted ? getSubdomainUrl('home') : '/'} 
        className="flex items-center gap-3 group"
      >
        <div className="relative w-12 h-12 drop-shadow-[0_0_12px_rgba(0,150,255,0.4)] group-hover:drop-shadow-[0_0_20px_rgba(0,150,255,0.7)] transition-all duration-500">
          <Image
            src="/logo.png"
            alt="Velsec Logo"
            fill
            className="object-contain dark:mix-blend-lighten"
            priority
          />
        </div>
        <span className="text-xl font-bold tracking-widest font-mono hidden sm:inline-block">
          <span className="text-foreground">VEL</span>
          <span className="text-secondary">SEC</span>
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
              className="px-4 py-2 text-xs font-mono font-bold tracking-wider text-muted-foreground hover:text-secondary hover:bg-accent rounded transition-all duration-300 border border-transparent hover:border-border"
            >
              {link.label}
            </a>
          ))}
        </div>

        <div className="flex items-center gap-3 lg:border-l lg:border-border lg:pl-4">
          {/* Theme Toggle */}
          {mounted && (
            <button
              onClick={() => setTheme(theme === 'dark' ? 'light' : 'dark')}
              className="p-2 rounded-lg bg-card border border-border text-muted-foreground hover:text-secondary transition-all"
              aria-label="Toggle Theme"
            >
              {theme === 'dark' ? <Sun size={16} /> : <Moon size={16} />}
            </button>
          )}

          {/* Auth Button */}
          {session ? (
            <a
              href={mounted ? getSubdomainUrl('home', '/profile') : '/profile'}
              className="px-4 py-2 text-xs font-mono font-bold tracking-wider text-secondary hover:bg-accent rounded transition-all duration-300 border border-border shadow-[0_0_10px_rgba(0,150,255,0.1)] whitespace-nowrap"
            >
              PROFILE
            </a>
          ) : (
            <a
              href={mounted ? getSubdomainUrl('home', '/login') : '/login'}
              className="px-4 py-2 text-xs font-mono font-bold tracking-wider text-primary-foreground bg-secondary hover:opacity-90 rounded transition-all duration-300 shadow-[0_0_15px_rgba(0,150,255,0.3)] whitespace-nowrap"
            >
              LOGIN
            </a>
          )}
        </div>
      </div>
    </nav>
  );
}
