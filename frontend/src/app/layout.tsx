import type { Metadata } from "next";
import "./globals.css";
import Navbar from "@/components/ui/Navbar";

// Removing next/font/google due to local network fetch issues during build
const geistSansVariable = "font-sans";
const geistMonoVariable = "font-mono";

export const metadata: Metadata = {
  title: "Velsec | Cybersecurity Ecosystem",
  description: "Secure Today. Empower Tomorrow.",
};

import { ThemeProvider } from "@/components/ThemeProvider";
import TransitionProvider from "@/components/TransitionProvider";

import ClientGlobalCanvas from "@/components/3d/ClientGlobalCanvas";

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html
      lang="en"
      suppressHydrationWarning
      className={`${geistSansVariable} ${geistMonoVariable} h-full antialiased bg-background text-foreground`}
    >
      <body className="min-h-full flex flex-col relative overflow-x-hidden">
        <ThemeProvider
          attribute="class"
          defaultTheme="dark"
          enableSystem={false}
          disableTransitionOnChange
        >
          <ClientGlobalCanvas />
          <Navbar />
          <TransitionProvider>
            <main className="flex-1 w-full flex flex-col relative z-10">
              {children}
            </main>
          </TransitionProvider>
        </ThemeProvider>
      </body>
    </html>
  );
}
