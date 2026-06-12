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
    'tracker.velsec.com',
    'velsec.local',
    'learn.velsec.local',
    'notes.velsec.local',
    'projects.velsec.local',
    'news.velsec.local',
    'personal.velsec.local',
    'tracker.velsec.local',
    'localhost',
  ],
};

export default nextConfig;
