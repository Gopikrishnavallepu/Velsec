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
    none: "",
    blue: "hover:shadow-[0_0_30px_rgba(0,150,255,0.3)] border-[rgba(0,150,255,0.2)]",
    green: "hover:shadow-[0_0_30px_rgba(57,255,20,0.3)] border-[rgba(57,255,20,0.2)]",
    purple: "hover:shadow-[0_0_30px_rgba(255,0,255,0.3)] border-[rgba(255,0,255,0.2)]",
  };

  return (
    <div
      className={cn(
        "relative overflow-hidden rounded-xl bg-white/60 dark:bg-black/40 backdrop-blur-md border border-border/50",
        "backdrop-blur-xl border border-white/10 dark:border-white/5",
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
