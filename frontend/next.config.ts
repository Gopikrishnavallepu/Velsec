import type { NextConfig } from "next";

// Force dev server config cache reload
const nextConfig: NextConfig = {
  allowedDevOrigins: [
    'velsec.com',
    'learn.velsec.com',
    'notes.velsec.com',
    'projects.velsec.com',
    'news.velsec.com',
    'personal.velsec.com',
    'tracker.velsec.com'
  ],
};

export default nextConfig;
