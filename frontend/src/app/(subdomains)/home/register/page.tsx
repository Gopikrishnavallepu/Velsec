'use client';

import { useState } from 'react';
import Image from 'next/image';
import { createClient } from '@/utils/supabase/client';
import ParticleField from '@/components/ui/ParticleField';

export default function RegisterPage() {
  const supabase = createClient();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [loading, setLoading] = useState(false);
  const [logs, setLogs] = useState<string[]>([]);
  const [errorMsg, setErrorMsg] = useState<string | null>(null);
  const [successMsg, setSuccessMsg] = useState<string | null>(null);

  const handleRegister = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!email || !password || !confirmPassword) return;

    if (password !== confirmPassword) {
      setErrorMsg('Passphrases do not match!');
      return;
    }

    setLoading(true);
    setErrorMsg(null);
    setSuccessMsg(null);
    setLogs([
      '[SYSTEM] Commencing security profile allocation protocols...',
      '[NETWORK] Routing cryptographic keys to security registrar...',
    ]);

    setTimeout(async () => {
      setLogs((prev) => [...prev, '[CRYPTO] Generating credential schemas and password entropy maps...']);

      try {
        const { data, error } = await supabase.auth.signUp({
          email,
          password,
          options: {
            emailRedirectTo: `${window.location.origin}/login`,
          },
        });

        if (error) {
          setErrorMsg(error.message);
          setLogs((prev) => [...prev, `[FATAL] Registrar registration aborted: ${error.message}`]);
          setLoading(false);
        } else {
          setLogs((prev) => [
            ...prev,
            '[SUCCESS] Operative credential directory initialized.',
            '[SYSTEM] Verification dispatch queued to target email inbox.',
          ]);
          setSuccessMsg('Profile created! Please verify your account via email to authorize login.');
          setLoading(false);
        }
      } catch (err: any) {
        setErrorMsg(err.message);
        setLogs((prev) => [...prev, `[FATAL] System error: ${err.message}`]);
        setLoading(false);
      }
    }, 1500);
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
            CREATE<span className="text-[#0096ff]">_PROFILE</span>
          </h1>
          <p className="text-[10px] font-mono text-zinc-500 uppercase tracking-widest">
            Register Operative Credentials / Level 3 Access
          </p>
        </div>

        {errorMsg && (
          <div className="p-3 rounded-lg border border-rose-500/35 bg-rose-500/10 text-rose-400 text-xs font-mono text-center">
            {errorMsg}
          </div>
        )}

        {successMsg && (
          <div className="p-3 rounded-lg border border-emerald-500/35 bg-emerald-500/10 text-emerald-400 text-xs font-mono text-center">
            {successMsg}
          </div>
        )}

        {/* Registration Form */}
        <form onSubmit={handleRegister} className="flex flex-col gap-4">
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
            <label className="text-zinc-400 font-bold tracking-wider uppercase">Credentials Passphrase</label>
            <input
              type="password"
              placeholder="CREATE_PASSPHRASE..."
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              disabled={loading}
              required
              className="w-full bg-[#050a18]/80 text-zinc-200 placeholder-zinc-600 border border-[#0a1a40] focus:border-[#0096ff]/50 focus:outline-none rounded-lg px-3 py-2.5 transition-all duration-300"
            />
          </div>

          <div className="flex flex-col gap-1.5 font-mono text-xs">
            <label className="text-zinc-400 font-bold tracking-wider uppercase">Confirm Passphrase</label>
            <input
              type="password"
              placeholder="RE_ENTER_PASSPHRASE..."
              value={confirmPassword}
              onChange={(e) => setConfirmPassword(e.target.value)}
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
            INITIALIZE_CREDENTIALS
          </button>
        </form>

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
          Already registered?{' '}
          <a href="/login" className="text-[#0096ff] hover:underline font-bold">
            AUTHORIZE_SESSION
          </a>
        </div>
      </div>
    </main>
  );
}
