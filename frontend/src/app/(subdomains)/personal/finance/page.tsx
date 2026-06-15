'use client';

import { useState, useEffect, useRef } from 'react';
import { getSubdomainUrl } from '@/utils/navigation';
import { createClient } from '@/utils/supabase/client';

export default function FinancePage() {
  const [mounted, setMounted] = useState(false);
  const [session, setSession] = useState<any>(null);
  const [iframeLoaded, setIframeLoaded] = useState(false);
  const iframeRef = useRef<HTMLIFrameElement>(null);
  const supabase = createClient();

  useEffect(() => {
    setMounted(true);
    
    // Check auth
    supabase.auth.getSession().then(({ data: { session } }) => {
      setSession(session);
    });
  }, [supabase]);

  useEffect(() => {
    // Only send the credentials when BOTH the session is ready AND the iframe is loaded
    if (session && iframeLoaded && iframeRef.current && iframeRef.current.contentWindow) {
      const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
      const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
      
      iframeRef.current.contentWindow.postMessage({
        type: 'SUPABASE_INIT',
        url,
        key,
        token: session.access_token,
        uid: session.user.id
      }, '*');
    }
  }, [session, iframeLoaded]);

  const handleIframeLoad = () => {
    setIframeLoaded(true);
  };

  return (
    <main className="flex-1 w-full h-[100vh] flex flex-col pt-16 bg-background relative">
      {/* Back to Personal Hub */}
      <div className="absolute top-20 left-4 z-50">
        <a 
          href={mounted ? getSubdomainUrl('personal') : '/'}
          className="inline-flex items-center gap-2 px-3 py-1.5 bg-card/50 backdrop-blur-md border border-border rounded-lg text-xs font-mono text-muted-foreground hover:text-foreground transition-all shadow-[0_0_10px_rgba(0,0,0,0.5)]"
        >
          &lt;-- BACK_TO_HUB
        </a>
      </div>

      {!session && mounted ? (
        <div className="flex-1 flex flex-col items-center justify-center p-8">
          <div className="border border-rose-500/25 bg-rose-500/5 p-8 rounded-xl text-center max-w-md">
            <h2 className="text-xl font-bold font-mono text-rose-400 mb-2">AUTH_REQUIRED</h2>
            <p className="text-sm text-muted-foreground">You must be logged in to access the Finance Dashboard.</p>
          </div>
        </div>
      ) : (
        <iframe 
          ref={iframeRef}
          src="/fintrack.html" 
          onLoad={handleIframeLoad}
          className="w-full flex-1 border-none outline-none"
          title="FinTrack Pro Dashboard"
        />
      )}
    </main>
  );
}
