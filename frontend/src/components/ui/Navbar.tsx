'use client';

import Image from 'next/image';
import { useEffect, useState } from 'react';
import { getSubdomainUrl } from '@/utils/navigation';

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

  useEffect(() => {
    setMounted(true);
  }, []);

  return (
    <nav className="fixed top-0 left-0 w-full z-50 px-6 py-3 flex justify-between items-center border-b border-[#0096ff]/10"
      style={{
        background: 'linear-gradient(180deg, rgba(5, 10, 24, 0.95), rgba(5, 10, 24, 0.8))',
        backdropFilter: 'blur(16px)',
      }}
    >
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
            className="object-contain mix-blend-lighten"
            priority
          />
        </div>
        <span className="text-xl font-bold tracking-widest font-mono">
          <span className="text-zinc-300">VEL</span>
          <span className="text-[#0096ff]">SEC</span>
        </span>
      </a>

      {/* Navigation Links */}
      <div className="hidden md:flex items-center gap-1">
        {navLinks.map((link) => (
          <a
            key={link.label}
            href={mounted ? getSubdomainUrl(link.key) : `/${link.key}`}
            className="px-4 py-2 text-xs font-mono font-bold tracking-wider text-zinc-500 hover:text-[#0096ff] hover:bg-[#0096ff]/5 rounded transition-all duration-300 border border-transparent hover:border-[#0096ff]/15"
          >
            {link.label}
          </a>
        ))}
      </div>
    </nav>
  );
}
