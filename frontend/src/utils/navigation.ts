/**
 * Dynamically constructs the URL for a Velsec subdomain based on the current hostname.
 * Supports:
 * - Local development (localhost / .local domains)
 * - Custom domain deployments (velsec.com)
 * - Vercel preview deployments (*.vercel.app) using path-based routing fallbacks.
 */
export function getSubdomainUrl(subdomain: string, path: string = ''): string {
  // If we are on the server (SSR), return a safe fallback or relative link
  if (typeof window === 'undefined') {
    if (subdomain === 'home' || !subdomain) return '/';
    return `/${subdomain}${path}`;
  }

  const hostname = window.location.hostname; // e.g. "learn.velsec.local" or "velsec-org.vercel.app"
  const port = window.location.port; // e.g. "3000"
  const protocol = window.location.protocol; // e.g. "http:" or "https:"
  const cleanHost = hostname.split(':')[0];

  // 1. Localhost fallback
  if (cleanHost.includes('localhost')) {
    if (subdomain === 'home' || !subdomain) return `${protocol}//localhost:${port}${path}`;
    return `${protocol}//${subdomain}.localhost:${port}${path}`;
  }

  // 2. Local velsec.local domain fallback
  if (cleanHost.endsWith('.velsec.local') || cleanHost === 'velsec.local') {
    if (subdomain === 'home' || !subdomain) return `${protocol}//velsec.local:${port}${path}`;
    return `${protocol}//${subdomain}.velsec.local:${port}${path}`;
  }

  // 3. Vercel deployment URLs (which don't support wildcard DNS/SSL certificates on vercel.app)
  // Fall back to path-based routing: https://velsec-org.vercel.app/learn
  if (cleanHost.endsWith('.vercel.app') || cleanHost.endsWith('.now.sh')) {
    const mainHost = window.location.host; // includes port if any
    if (subdomain === 'home' || !subdomain) return `${protocol}//${mainHost}${path}`;
    return `${protocol}//${mainHost}/${subdomain}${path}`;
  }

  // 4. Custom production apex domain (velsec.com) or custom user domain
  let apexDomain = 'velsec.com';
  if (!cleanHost.endsWith('velsec.com')) {
    // Dynamically extract the apex domain if they configured a different custom domain
    const parts = cleanHost.split('.');
    if (parts.length >= 2) {
      apexDomain = parts.slice(-2).join('.');
    }
  }

  if (subdomain === 'home' || !subdomain) {
    return `${protocol}//${apexDomain}${path}`;
  }
  return `${protocol}//${subdomain}.${apexDomain}${path}`;
}
