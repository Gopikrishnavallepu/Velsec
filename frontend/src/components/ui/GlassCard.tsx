import { ReactNode } from "react";
import { clsx, type ClassValue } from "clsx";
import { twMerge } from "tailwind-merge";

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}

interface GlassCardProps {
  children: ReactNode;
  className?: string;
  glowColor?: "blue" | "green" | "purple" | "none";
}

export default function GlassCard({ children, className, glowColor = "none" }: GlassCardProps) {
  const glowClasses = {
    none: "border-border hover:border-border/80",
    blue: "border-[rgba(0,200,255,0.2)] hover:border-[rgba(0,200,255,1)] hover:shadow-[0_0_15px_rgba(0,200,255,0.2)]",
    green: "border-[rgba(0,255,136,0.2)] hover:border-[rgba(0,255,136,1)] hover:shadow-[0_0_15px_rgba(0,255,136,0.2)]",
    purple: "border-[rgba(122,95,255,0.2)] hover:border-[rgba(122,95,255,1)] hover:shadow-[0_0_15px_rgba(122,95,255,0.2)]",
  };

  return (
    <div
      className={cn(
        "relative overflow-hidden rounded-md bg-slate-950/80 backdrop-blur-md border",
        "transition-all duration-300",
        glowClasses[glowColor],
        className
      )}
    >
      <div className="absolute inset-0 bg-gradient-to-br from-white/5 to-transparent pointer-events-none" />
      {children}
    </div>
  );
}
