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
      const supabase = createClient(cookieStore);
      const { error } = await supabase.auth.exchangeCodeForSession(code);
      
      if (!error) {
        // If next is an absolute URL, redirect to it directly.
        if (next.startsWith('http://') || next.startsWith('https://')) {
          return NextResponse.redirect(next);
        }
        // Otherwise redirect using the request origin.
        const { origin } = new URL(request.url);
        return NextResponse.redirect(`${origin}${next}`);
      }
      console.error('exchangeCodeForSession error:', error);
    } catch (err) {
      console.error('Error exchanging code for session:', err);
    }
  }

  const { origin } = new URL(request.url);
  return NextResponse.redirect(`${origin}/login?error=auth_callback_failed`);
}
