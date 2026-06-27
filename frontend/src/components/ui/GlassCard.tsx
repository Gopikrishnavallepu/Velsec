"use client";

import { ReactNode, useState, MouseEvent } from "react";
import { clsx, type ClassValue } from "clsx";
import { twMerge } from "tailwind-merge";
import { motion, useMotionTemplate, useMotionValue } from "framer-motion";

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
    blue: "hover:shadow-[0_0_30px_rgba(0,200,255,0.2)] border-[rgba(0,200,255,0.3)]",
    green: "hover:shadow-[0_0_30px_rgba(0,255,136,0.2)] border-[rgba(0,255,136,0.3)]",
    purple: "hover:shadow-[0_0_30px_rgba(122,95,255,0.2)] border-[rgba(122,95,255,0.3)]",
  };

  const mouseX = useMotionValue(0);
  const mouseY = useMotionValue(0);

  function handleMouseMove({ currentTarget, clientX, clientY }: MouseEvent) {
    const { left, top } = currentTarget.getBoundingClientRect();
    mouseX.set(clientX - left);
    mouseY.set(clientY - top);
  }

  const maskImage = useMotionTemplate`radial-gradient(400px at ${mouseX}px ${mouseY}px, white, transparent)`;
  
  return (
    <motion.div
      onMouseMove={handleMouseMove}
      whileHover={{ y: -5, scale: 1.01 }}
      transition={{ type: "spring", stiffness: 400, damping: 30 }}
      className={cn(
        "relative overflow-hidden rounded-md bg-black/60 backdrop-blur-xl border border-border/50 interactive group",
        "transition-colors duration-500",
        glowClasses[glowColor],
        className
      )}
    >
      <motion.div
        className="pointer-events-none absolute -inset-px rounded-md opacity-0 transition duration-300 group-hover:opacity-100"
        style={{
          background: glowColor === 'green' 
            ? "radial-gradient(400px circle at var(--mouse-x) var(--mouse-y), rgba(0,255,136,0.15), transparent 40%)"
            : glowColor === 'blue'
            ? "radial-gradient(400px circle at var(--mouse-x) var(--mouse-y), rgba(0,200,255,0.15), transparent 40%)"
            : glowColor === 'purple'
            ? "radial-gradient(400px circle at var(--mouse-x) var(--mouse-y), rgba(122,95,255,0.15), transparent 40%)"
            : "radial-gradient(400px circle at var(--mouse-x) var(--mouse-y), rgba(255,255,255,0.06), transparent 40%)",
          WebkitMaskImage: maskImage,
          maskImage: maskImage
        }}
      />
      <div className="absolute inset-0 bg-[url('/noise.png')] opacity-10 pointer-events-none mix-blend-overlay" />
      <div className="relative z-10 w-full h-full">
        {children}
      </div>
    </motion.div>
  );
}
