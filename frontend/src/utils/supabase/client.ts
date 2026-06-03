import { createBrowserClient } from "@supabase/ssr";
import { getCookieDomain } from "../navigation";

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || 'https://placeholder.supabase.co';
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || 'placeholder-key';

export const createClient = () => {
  const host = typeof window !== 'undefined' ? window.location.hostname : 'velsec.local';
  const cookieDomain = getCookieDomain(host);

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
