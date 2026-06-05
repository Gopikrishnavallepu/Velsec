'use client';

import { useState } from 'react';
import Image from 'next/image';
import { createClient } from '@/utils/supabase/client';
import { getSubdomainUrl } from '@/utils/navigation';
import ParticleField from '@/components/ui/ParticleField';

export default function LoginPage() {
  const supabase = createClient();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);
  const [logs, setLogs] = useState<string[]>([]);
  const [errorMsg, setErrorMsg] = useState<string | null>(null);

  const handleEmailLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!email || !password) return;

    setLoading(true);
    setErrorMsg(null);
    setLogs([
      '[SYSTEM] Initializing secure credentials verification protocol...',
      '[NETWORK] Sending encrypted credentials envelope to authorization gateway...',
    ]);

    // Simulate logs with timeouts
    setTimeout(async () => {
      setLogs((prev) => [...prev, '[CRYPTO] Verifying signatures and hashing payload layers...']);
      
      try {
        const { data, error } = await supabase.auth.signInWithPassword({
          email,
          password,
        });

        if (error) {
          setLogs((prev) => [...prev, `[FATAL] Gateway rejected token payload: ${error.message}`]);
          setErrorMsg(error.message);
          setLoading(false);
        } else {
          setLogs((prev) => [
            ...prev,
            '[SUCCESS] Access token mapped successfully. Session verified.',
            '[SYSTEM] Redirecting to operative dashboard...',
          ]);
          setTimeout(() => {
            window.location.href = '/profile';
          }, 1000);
        }
      } catch (err: any) {
        setLogs((prev) => [...prev, `[FATAL] System execution error: ${err.message}`]);
        setErrorMsg('Authentication failed due to system error.');
        setLoading(false);
      }
    }, 1500);
  };

  const handleGithubLogin = async () => {
    setErrorMsg(null);
    setLogs(['[SYSTEM] Initializing GitHub OAuth authorization handshake...']);
    
    try {
      const { error } = await supabase.auth.signInWithOAuth({
        provider: 'github',
        options: {
          redirectTo: getSubdomainUrl('home', '/auth/callback?next=' + encodeURIComponent(getSubdomainUrl('home', '/profile'))),
        },
      });

      if (error) {
        setErrorMsg(error.message);
        setLogs((prev) => [...prev, `[FATAL] GitHub handshake aborted: ${error.message}`]);
      }
    } catch (err: any) {
      setErrorMsg(err.message);
    }
  };

  return (
    <main className="relative min-h-screen overflow-x-hidden pt-24 pb-16 px-4 flex items-center justify-center bg-[#050a18]">
      <ParticleField />
      
      {/* Background vignette overlay */}
      <div className="fixed inset-0 -z-5 pointer-events-none bg-gradient-to-t from-[#050a18] via-transparent to-[#050a18]/40" />

      <div className="z-10 w-full max-w-md relative border border-[#0096ff]/20 bg-[#0a1432]/30 backdrop-blur-md p-8 rounded-2xl flex flex-col gap-6 shadow-[0_0_30px_rgba(0,150,255,0.08)]">
        <div className="absolute top-0 left-0 w-3.5 h-3.5 border-t-2 border-l-2 border-[#0096ff]" />
        <div className="absolute top-0 right-0 w-3.5 h-3.5 border-t-2 border-r-2 border-[#0096ff]" />
        <div className="absolute bottom-0 left-0 w-3.5 h-3.5 border-b-2 border-l-2 border-[#0096ff]" />
        <div className="absolute bottom-0 right-0 w-3.5 h-3.5 border-b-2 border-r-2 border-[#0096ff]" />

        {/* Branding header */}
        <div className="flex flex-col items-center text-center gap-2 mb-2">
          <div className="relative w-16 h-16 mb-2 drop-shadow-[0_0_15px_rgba(0,150,255,0.3)]">
            <Image
              src="/logo.png"
              alt="Velsec Logo"
              fill
              className="object-contain mix-blend-lighten"
            />
          </div>
          <h1 className="text-2xl font-bold font-mono tracking-widest text-zinc-100">
            SECURE<span className="text-[#0096ff]">_GATEWAY</span>
          </h1>
          <p className="text-[10px] font-mono text-zinc-500 uppercase tracking-widest">
            Authentication Required / Level 3 Clearance
          </p>
        </div>

        {errorMsg && (
          <div className="p-3 rounded-lg border border-rose-500/35 bg-rose-500/10 text-rose-400 text-xs font-mono text-center">
            {errorMsg}
          </div>
        )}

        {/* Credentials Form */}
        <form onSubmit={handleEmailLogin} className="flex flex-col gap-4">
          <div className="flex flex-col gap-1.5 font-mono text-xs">
            <label className="text-zinc-400 font-bold tracking-wider uppercase">Email Address</label>
            <input
              type="email"
              placeholder="ENTER_EMAIL..."
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              disabled={loading}
              required
              className="w-full bg-[#050a18]/80 text-zinc-200 placeholder-zinc-600 border border-[#0a1a40] focus:border-[#0096ff]/50 focus:outline-none rounded-lg px-3 py-2.5 transition-all duration-300"
            />
          </div>

          <div className="flex flex-col gap-1.5 font-mono text-xs">
            <div className="flex justify-between items-center">
              <label className="text-zinc-400 font-bold tracking-wider uppercase">Credentials Password</label>
              <span className="text-[#0096ff] text-[10px] hover:underline cursor-pointer">Recover Key?</span>
            </div>
            <input
              type="password"
              placeholder="ENTER_PASSPHRASE..."
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              disabled={loading}
              required
              className="w-full bg-[#050a18]/80 text-zinc-200 placeholder-zinc-600 border border-[#0a1a40] focus:border-[#0096ff]/50 focus:outline-none rounded-lg px-3 py-2.5 transition-all duration-300"
            />
          </div>

          <button
            type="submit"
            disabled={loading}
            className={`w-full py-3 bg-[#0096ff] hover:bg-[#007cdb] text-xs font-mono font-bold tracking-widest text-[#050a18] rounded-lg transition-all duration-300 shadow-[0_0_15px_rgba(0,150,255,0.25)] active:scale-98 ${
              loading ? 'opacity-50 cursor-not-allowed' : ''
            }`}
          >
            AUTHORIZE_ACCESS
          </button>
        </form>

        {/* Separator */}
        <div className="relative flex items-center justify-center my-1 font-mono text-[9px] text-zinc-600">
          <div className="flex-1 border-t border-[#0a1a40]" />
          <span className="px-2">OR_CONNECT_VIA</span>
          <div className="flex-1 border-t border-[#0a1a40]" />
        </div>

        {/* OAuth Buttons */}
        <button
          onClick={handleGithubLogin}
          disabled={loading}
          className="w-full py-2.5 border border-[#0096ff]/30 text-xs font-mono font-bold tracking-wider text-[#0096ff] rounded-lg bg-[#0096ff]/5 hover:bg-[#0096ff]/15 transition-all duration-300 active:scale-98"
        >
          CONNECT_WITH_GITHUB
        </button>

        {/* Interactive audit log console */}
        {logs.length > 0 && (
          <div className="bg-[#050a18]/90 rounded-lg border border-[#0a1a40] p-3.5 font-mono text-[9px] text-zinc-500 min-h-[70px] max-h-[100px] overflow-y-auto space-y-1">
            {logs.map((log, index) => (
              <div key={index} className={log.includes('[SUCCESS]') ? 'text-emerald-500' : log.includes('[FATAL]') ? 'text-rose-500' : 'text-zinc-500'}>
                {log}
              </div>
            ))}
          </div>
        )}

        {/* Navigation bottom */}
        <div className="text-center font-mono text-[10px] text-zinc-500 mt-2">
          New Operative?{' '}
          <a href="/register" className="text-[#0096ff] hover:underline font-bold">
            REGISTER_CREDENTIALS
          </a>
        </div>
      </div>
    </main>
  );
}
