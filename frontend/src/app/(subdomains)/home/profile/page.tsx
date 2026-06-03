'use client';

import { useState, useEffect } from 'react';
import Image from 'next/image';
import { createClient } from '@/utils/supabase/client';
import ParticleField from '@/components/ui/ParticleField';

interface UserProfile {
  id: string;
  email: string;
  role: string;
  createdAt: string;
}

export default function ProfilePage() {
  const supabase = createClient();
  const [user, setUser] = useState<UserProfile | null>(null);
  const [rawSession, setRawSession] = useState<any>(null);
  const [loading, setLoading] = useState(true);
  const [logs, setLogs] = useState<string[]>([]);
  const [showTokenClaims, setShowTokenClaims] = useState(false);

  useEffect(() => {
    async function loadUser() {
      setLogs(['[SYSTEM] Fetching active session context from browser cookies...']);
      try {
        const { data: { session }, error } = await supabase.auth.getSession();
        
        if (error) {
          setLogs((prev) => [...prev, `[FATAL] Session retrieval failure: ${error.message}`]);
          setLoading(false);
          return;
        }

        if (session && session.user) {
          setRawSession(session);
          setUser({
            id: session.user.id,
            email: session.user.email || 'N/A',
            role: session.user.role || 'authenticated',
            createdAt: new Date(session.user.created_at).toLocaleDateString(),
          });
          setLogs((prev) => [
            ...prev,
            `[SUCCESS] Active session verified for ID: ${session.user.id.slice(0, 8)}...`,
            '[SYSTEM] Credentials mapped to local state. Clearances verified.',
          ]);
        } else {
          setLogs((prev) => [...prev, '[WARN] No active session context found. Clearance: NONE']);
        }
      } catch (err: any) {
        setLogs((prev) => [...prev, `[FATAL] System error: ${err.message}`]);
      }
      setLoading(false);
    }
    loadUser();
  }, []);

  const handleSignOut = async () => {
    setLogs((prev) => [...prev, '[SYSTEM] Revoking session token envelopes...']);
    const { error } = await supabase.auth.signOut();
    if (error) {
      setLogs((prev) => [...prev, `[WARN] Error signing out: ${error.message}`]);
    } else {
      setLogs((prev) => [...prev, '[SUCCESS] Session terminated. Redirecting to gateway...']);
      setTimeout(() => {
        window.location.href = '/login';
      }, 1000);
    }
  };

  return (
    <main className="relative min-h-screen overflow-x-hidden pt-24 pb-16 px-4 flex items-center justify-center bg-[#050a18]">
      <ParticleField />
      
      {/* Background vignette overlay */}
      <div className="fixed inset-0 -z-5 pointer-events-none bg-gradient-to-t from-[#050a18] via-transparent to-[#050a18]/40" />

      <div className="z-10 w-full max-w-lg relative border border-[#0096ff]/20 bg-[#0a1432]/30 backdrop-blur-md p-8 rounded-2xl flex flex-col gap-6 shadow-[0_0_30px_rgba(0,150,255,0.08)]">
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
            OPERATIVE<span className="text-[#0096ff]">_CLEARANCE</span>
          </h1>
          <p className="text-[10px] font-mono text-zinc-500 uppercase tracking-widest">
            Central Credentials Records
          </p>
        </div>

        {loading ? (
          <div className="flex flex-col items-center justify-center py-12 gap-3 font-mono text-xs text-zinc-400">
            <span className="animate-spin text-xl">⏳</span>
            <span>SYNCHRONIZING_SESSION_DATA...</span>
          </div>
        ) : user ? (
          <div className="flex flex-col gap-5 font-mono text-xs">
            {/* Session Info Grid */}
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 bg-[#050a18]/70 border border-[#0a1a40] p-4 rounded-xl">
              <div>
                <span className="text-zinc-500 block uppercase text-[9px] font-bold">OPERATIVE_ID</span>
                <span className="text-zinc-200 block truncate">{user.id}</span>
              </div>
              <div>
                <span className="text-zinc-500 block uppercase text-[9px] font-bold">EMAIL_ADDRESS</span>
                <span className="text-zinc-200 block truncate">{user.email}</span>
              </div>
              <div>
                <span className="text-zinc-500 block uppercase text-[9px] font-bold">CLEARANCE_ROLE</span>
                <span className="text-[#0096ff] block font-bold">{user.role.toUpperCase()}</span>
              </div>
              <div>
                <span className="text-zinc-500 block uppercase text-[9px] font-bold">ENROLLED_DATE</span>
                <span className="text-zinc-200 block">{user.createdAt}</span>
              </div>
            </div>

            {/* Expandable JWT Claims */}
            <div>
              <button
                onClick={() => setShowTokenClaims(!showTokenClaims)}
                className="w-full flex justify-between items-center py-2 px-3 border border-[#0096ff]/20 bg-[#0096ff]/5 text-[10px] font-bold text-[#0096ff] rounded-lg transition-all active:scale-99 hover:bg-[#0096ff]/10"
              >
                <span>{showTokenClaims ? 'HIDE_JWT_TOKEN_CLAIMS' : 'VIEW_JWT_TOKEN_CLAIMS'}</span>
                <span>{showTokenClaims ? '▲' : '▼'}</span>
              </button>

              {showTokenClaims && rawSession && (
                <pre className="mt-2 bg-[#050a18]/90 border border-[#0a1a40] p-4 rounded-lg text-[9px] text-[#00f0ff] overflow-x-auto whitespace-pre max-h-[160px]">
                  <code>{JSON.stringify(rawSession.user, null, 2)}</code>
                </pre>
              )}
            </div>

            <button
              onClick={handleSignOut}
              className="w-full py-2.5 bg-rose-500/10 hover:bg-rose-500/20 text-rose-400 text-xs font-mono font-bold tracking-widest border border-rose-500/35 rounded-lg transition-all duration-300"
            >
              REVOKE_ACCESS_SESSION
            </button>
          </div>
        ) : (
          <div className="flex flex-col items-center justify-center text-center py-8 gap-4 font-mono text-xs">
            <span className="text-3xl">⚠️</span>
            <div className="space-y-1">
              <h3 className="font-bold text-rose-400">CLEARANCE_DENIED</h3>
              <p className="text-[10px] text-zinc-500 max-w-xs">
                No active token session is mapped to this host. Please authenticate to access operative files.
              </p>
            </div>
            <a
              href="/login"
              className="px-6 py-2 border border-[#0096ff] text-[#0096ff] bg-[#0096ff]/5 hover:bg-[#0096ff]/15 rounded-lg transition-colors font-bold tracking-wider"
            >
              SIGN_IN_CREDENTIALS
            </a>
          </div>
        )}

        {/* Interactive audit log console */}
        {logs.length > 0 && (
          <div className="bg-[#050a18]/90 rounded-lg border border-[#0a1a40] p-3.5 font-mono text-[9px] text-zinc-500 min-h-[75px] max-h-[110px] overflow-y-auto space-y-1">
            {logs.map((log, index) => (
              <div key={index} className={log.includes('[SUCCESS]') ? 'text-emerald-500' : log.includes('[FATAL]') ? 'text-rose-500' : 'text-zinc-500'}>
                {log}
              </div>
            ))}
          </div>
        )}
      </div>
    </main>
  );
}
