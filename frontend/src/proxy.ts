import { createServerClient } from '@supabase/ssr';
import { NextResponse } from 'next/server';
import type { NextRequest } from 'next/server';

export async function proxy(request: NextRequest) {
  const hostname = request.headers.get('host') || '';
  const cleanHost = hostname.split(':')[0];

  let subdomain = '';

  if (
    cleanHost === 'velsec.com' ||
    cleanHost === 'www.velsec.com' ||
    cleanHost === 'localhost' ||
    cleanHost.endsWith('.vercel.app') ||
    cleanHost.endsWith('.now.sh')
  ) {
    subdomain = 'home';
  } else if (cleanHost.endsWith('.velsec.com')) {
    subdomain = cleanHost.replace('.velsec.com', '');
  } else if (cleanHost.endsWith('.velsec.local')) {
    subdomain = cleanHost.replace('.velsec.local', '');
  }

  // 1. Create base response (rewrite or next)
  let response = NextResponse.next();
  if (subdomain) {
    const url = request.nextUrl.clone();
    url.pathname = `/${subdomain}${url.pathname === '/' ? '' : url.pathname}`;
    response = NextResponse.rewrite(url);
  }

  // 2. Initialize Supabase client to sync/refresh active sessions
  const cookieDomain = process.env.NEXT_PUBLIC_COOKIE_DOMAIN || '.velsec.local';
  const supabase = createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL || 'https://placeholder.supabase.co',
    process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || 'placeholder-anon-key',
    {
      cookies: {
        getAll() {
          return request.cookies.getAll();
        },
        setAll(cookiesToSet) {
          cookiesToSet.forEach(({ name, value, options }) => {
            request.cookies.set(name, value);
            response.cookies.set(name, value, {
              ...options,
              domain: cookieDomain,
              path: '/',
            });
          });
        },
      },
    }
  );

  // 3. Trigger session refresh in background if token is near expiration
  try {
    await supabase.auth.getUser();
  } catch {
    // Ignore session verify exceptions inside routing gateway
  }

  return response;
}

export const config = {
  matcher: [
    '/((?!api|_next/static|_next/image|favicon.ico|.*\\..*).*)',
  ],
};
