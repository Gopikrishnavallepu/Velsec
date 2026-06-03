import { createBrowserClient } from "@supabase/ssr";

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

export const createClient = () => {
  const cookieDomain = process.env.NEXT_PUBLIC_COOKIE_DOMAIN || '.velsec.local';

  return createBrowserClient(
    supabaseUrl!,
    supabaseKey!,
    {
      cookieOptions: {
        domain: cookieDomain,
        path: '/',
        sameSite: 'lax',
      },
    }
  );
};
