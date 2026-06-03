import { cookies } from 'next/headers';
import { NextResponse } from 'next/server';
import { createClient } from '@/utils/supabase/server';

export async function GET(request: Request) {
  const { searchParams } = new URL(request.url);
  const code = searchParams.get('code');
  const next = searchParams.get('next') ?? '/profile';

  if (code) {
    try {
      const cookieStore = await cookies();
      const { hostname } = new URL(request.url);
      const supabase = createClient(cookieStore, hostname);
      const { error } = await supabase.auth.exchangeCodeForSession(code);
      
      if (!error) {
        let safeNext = '/profile';
        if (next.startsWith('/') && !next.startsWith('//')) {
          const { origin } = new URL(request.url);
          safeNext = `${origin}${next}`;
        } else {
          try {
            const nextUrlObj = new URL(next);
            const host = nextUrlObj.hostname;
            const allowedSuffixes = ['.velsec.com', '.velsec.local', '.vercel.app', '.now.sh'];
            const isLocalhost = host === 'localhost' || host === '127.0.0.1';
            const isAllowedDomain = allowedSuffixes.some(suffix => host.endsWith(suffix)) || 
                                    host === 'velsec.com' || 
                                    host === 'velsec.local';
            
            if (isLocalhost || isAllowedDomain) {
              safeNext = `${nextUrlObj.protocol}//${nextUrlObj.host}${nextUrlObj.pathname}${nextUrlObj.search}`;
            }
          } catch (e) {
            // Fallback to default
          }
        }
        return NextResponse.redirect(safeNext);
      }
      console.error('exchangeCodeForSession error:', error);
    } catch (err) {
      console.error('Error exchanging code for session:', err);
    }
  }

  const { origin } = new URL(request.url);
  return NextResponse.redirect(`${origin}/login?error=auth_callback_failed`);
}
