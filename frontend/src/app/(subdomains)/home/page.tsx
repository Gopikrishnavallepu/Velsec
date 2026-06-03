import Image from 'next/image';
import Scene from '@/components/3d/Scene';
import SubdomainGrid from '@/components/ui/SubdomainGrid';
import ParticleField from '@/components/ui/ParticleField';

const pillars = [
  { icon: '🔒', label: 'CYBERSECURITY\nSOLUTIONS', href: 'http://velsec.com:3000' },
  { icon: '🎓', label: 'LEARNING\nECOSYSTEM', href: 'http://learn.velsec.com:3000' },
  { icon: '🧠', label: 'AI\nSECURITY', href: 'http://velsec.com:3000' },
  { icon: '♾️', label: 'DEVSECOPS\nEXCELLENCE', href: 'http://projects.velsec.com:3000' },
  { icon: '👤', label: 'PERSONAL &\nCAREER GROWTH', href: 'http://personal.velsec.com:3000' },
  { icon: '💻', label: 'PROJECTS &\nPRACTICAL LABS', href: 'http://projects.velsec.com:3000' },
  { icon: '📰', label: 'TECH NEWS &\nINSIGHTS', href: 'http://news.velsec.com:3000' },
  { icon: '🎯', label: 'PROGRESS\nTRACKER', href: 'http://tracker.velsec.com:3000' },
];

const actionBar = [
  { icon: '📖', label: 'LEARN', href: 'http://learn.velsec.com:3000' },
  { icon: '🔬', label: 'PRACTICE', href: 'http://projects.velsec.com:3000' },
  { icon: '⚙️', label: 'IMPLEMENT', href: 'http://projects.velsec.com:3000' },
  { icon: '📈', label: 'GROW', href: 'http://tracker.velsec.com:3000' },
  { icon: '🛡️', label: 'PROTECT', href: 'http://velsec.com:3000' },
];

export default function HomePage() {
  return (
    <main className="relative min-h-screen overflow-hidden">
      <ParticleField />

      {/* ========== HERO SECTION (Banner Recreation) ========== */}
      <section className="relative min-h-screen flex flex-col items-center justify-center px-4 md:px-8 pt-24 pb-12 scanline-overlay">
        <Scene />
        <div className="cinematic-vignette" />

        <div className="z-10 w-full max-w-6xl flex flex-col items-center">

          {/* ---- Logo + Branding ---- */}
          <div className="flex flex-col items-center gap-2 mb-6">
            {/* Logo */}
            <div className="relative w-28 h-28 md:w-36 md:h-36 drop-shadow-[0_0_30px_rgba(0,150,255,0.4)]">
              <Image
                src="/logo.png"
                alt="Velsec Logo"
                fill
                className="object-contain mix-blend-lighten"
                priority
              />
            </div>

            {/* VELSEC Title */}
            <h1 className="text-6xl md:text-8xl font-black tracking-[0.15em] font-mono leading-none">
              <span className="text-zinc-200">VEL</span>
              <span className="text-[#0096ff] text-glow-blue">SEC</span>
            </h1>

            {/* Tagline */}
            <p className="text-base md:text-xl font-bold tracking-wider mt-2 text-center">
              <span className="text-zinc-300">SECURE TODAY. </span>
              <span className="text-[#0096ff] italic text-glow-blue">EMPOWER TOMORROW.</span>
            </p>

            {/* Subtitle */}
            <p className="text-xs md:text-sm text-zinc-400 italic tracking-wide text-center mt-1">
              The Ultimate Cybersecurity Learning &amp; Solutions Ecosystem
            </p>
          </div>

          {/* Separator */}
          <div className="w-full max-w-4xl h-px bg-gradient-to-r from-transparent via-[#0096ff]/30 to-transparent my-6" />

          {/* ---- 8 Pillar Cards (from the banner) ---- */}
          <div className="w-full grid grid-cols-2 sm:grid-cols-4 lg:grid-cols-8 gap-3 mb-8">
            {pillars.map((p) => (
              <a
                key={p.label}
                href={p.href}
                className="group flex flex-col items-center text-center p-3 rounded-xl border border-[#0a1a40] hover:border-[#0096ff]/40 transition-all duration-500 cursor-pointer hover:shadow-[0_0_25px_rgba(0,150,255,0.08)]"
                style={{
                  background: 'linear-gradient(180deg, rgba(10, 18, 40, 0.5), rgba(5, 10, 24, 0.7))',
                }}
              >
                {/* Icon circle */}
                <div className="w-12 h-12 rounded-full border border-[#0096ff]/30 flex items-center justify-center mb-2 group-hover:border-[#0096ff]/60 group-hover:shadow-[0_0_15px_rgba(0,150,255,0.2)] transition-all duration-500">
                  <span className="text-xl group-hover:scale-110 transition-transform duration-300">{p.icon}</span>
                </div>
                {/* Label */}
                <span className="text-[9px] md:text-[10px] font-mono font-bold text-zinc-400 group-hover:text-[#0096ff] transition-colors duration-300 leading-tight whitespace-pre-line">
                  {p.label}
                </span>
              </a>
            ))}
          </div>

          {/* ---- Action Bar (LEARN | PRACTICE | IMPLEMENT | GROW | PROTECT) ---- */}
          <div
            className="w-full max-w-3xl rounded-xl border border-[#0096ff]/15 px-4 py-3 flex flex-wrap items-center justify-center gap-2 md:gap-0"
            style={{
              background: 'linear-gradient(180deg, rgba(0,150,255,0.04), rgba(5,10,24,0.6))',
            }}
          >
            {actionBar.map((a, i) => (
              <div key={a.label} className="flex items-center">
                <a
                  href={a.href}
                  className="flex items-center gap-2 px-4 py-1.5 text-xs font-mono font-bold tracking-widest text-[#0096ff]/70 hover:text-[#0096ff] hover:bg-[#0096ff]/5 rounded-lg transition-all duration-300"
                >
                  <span>{a.icon}</span>
                  <span>{a.label}</span>
                </a>
                {i < actionBar.length - 1 && (
                  <span className="hidden md:inline text-[#0096ff]/20 mx-1">│</span>
                )}
              </div>
            ))}
          </div>

        </div>
      </section>

      {/* ========== ECOSYSTEM SECTION ========== */}
      <section className="relative py-24 px-6">
        <div className="text-center mb-16">
          <h2 className="text-3xl md:text-4xl font-bold font-mono tracking-wider mb-4">
            <span className="text-zinc-400">THE </span>
            <span className="text-transparent bg-clip-text bg-gradient-to-r from-[#0096ff] to-[#39ff14] text-glow-blue">ECOSYSTEM</span>
          </h2>
          <p className="text-sm text-zinc-500 font-mono max-w-xl mx-auto">
            Six integrated platforms designed to accelerate your cybersecurity career from learning to implementation.
          </p>
          <div className="w-32 h-[2px] bg-gradient-to-r from-transparent via-[#0096ff] to-transparent mx-auto mt-6" />
        </div>

        <SubdomainGrid />
      </section>

      {/* ========== TECH STACK SECTION ========== */}
      <section className="relative py-20 px-6">
        <div className="max-w-5xl mx-auto text-center">
          <h2 className="text-2xl font-bold font-mono tracking-wider mb-12">
            <span className="text-zinc-600">{'//'} </span>
            <span className="text-zinc-400">POWERED_BY</span>
          </h2>
          <div className="flex flex-wrap justify-center gap-3 text-xs font-mono">
            {[
              'Next.js', 'TypeScript', 'FastAPI', 'PostgreSQL', 'Supabase',
              'Redis', 'Docker', 'Kubernetes', 'Terraform', 'GitHub Actions',
              'Cloudflare', 'React Three Fiber', 'Tailwind CSS',
            ].map((tech) => (
              <span
                key={tech}
                className="px-4 py-2 rounded-full border border-[#0a1a40] text-zinc-500 hover:text-[#0096ff] hover:border-[#0096ff]/30 hover:shadow-[0_0_15px_rgba(0,150,255,0.1)] transition-all duration-300 cursor-default"
              >
                {tech}
              </span>
            ))}
          </div>
        </div>
      </section>

      {/* ========== FOOTER ========== */}
      <footer className="relative py-12 px-6 border-t border-[#0a1a40]">
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
            <span className="text-zinc-600 hover:text-[#0096ff] transition-colors cursor-pointer">GitHub</span>
            <span className="text-zinc-600 hover:text-[#0096ff] transition-colors cursor-pointer">Discord</span>
            <span className="text-zinc-600 hover:text-[#0096ff] transition-colors cursor-pointer">Twitter</span>
          </div>
        </div>
      </footer>
    </main>
  );
}
