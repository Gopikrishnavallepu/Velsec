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

  // If host is mapped to 'home' but path starts with a subdomain route (e.g. /learn), don't rewrite it to /home/learn
  const subdomainsList = ['learn', 'notes', 'projects', 'tracker', 'news', 'personal'];
  const firstSegment = request.nextUrl.pathname.split('/')[1];
  
  if (firstSegment === 'auth') {
    subdomain = '';
  } else if (subdomain === 'home' && subdomainsList.includes(firstSegment)) {
    subdomain = '';
  }

  // Handle incoming OAuth callback codes that landed elsewhere (e.g. fallback to homepage)
  if (request.nextUrl.searchParams.has('code') && request.nextUrl.pathname !== '/auth/callback') {
    const callbackUrl = new URL('/auth/callback', request.url);
    // Copy all current search parameters
    request.nextUrl.searchParams.forEach((value, key) => {
      callbackUrl.searchParams.set(key, value);
    });
    // Add next if not already present, representing the current subdomain/path we are on
    if (!callbackUrl.searchParams.has('next')) {
      const proto = request.headers.get('x-forwarded-proto') || 'http';
      const host = request.headers.get('host') || 'localhost:3000';
      const nextUrlObj = new URL(`${proto}://${host}${request.nextUrl.pathname}${request.nextUrl.search}`);
      nextUrlObj.searchParams.delete('code');
      nextUrlObj.searchParams.delete('state');
      
      let nextDest = nextUrlObj.toString();
      if (nextUrlObj.pathname === '/' && (subdomain === 'home' || !subdomain)) {
        // If on home page, default redirect after login is profile page
        nextDest = new URL('/profile', nextUrlObj.toString()).toString();
      }
      callbackUrl.searchParams.set('next', nextDest);
    }
    return NextResponse.redirect(callbackUrl);
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
