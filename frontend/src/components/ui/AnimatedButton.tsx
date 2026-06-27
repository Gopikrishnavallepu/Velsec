"use client";

import React from "react";
import { motion, HTMLMotionProps } from "framer-motion";
import { cn } from "./GlassCard";

interface AnimatedButtonProps extends HTMLMotionProps<"button"> {
  glowColor?: "blue" | "green" | "purple" | "none";
  icon?: React.ReactNode;
}

export default function AnimatedButton({ 
  children, 
  className, 
  glowColor = "green",
  icon,
  ...props 
}: AnimatedButtonProps) {
  
  const glowVariants = {
    blue: "border-[rgba(0,200,255,0.5)] text-[#00c8ff] hover:shadow-[0_0_15px_rgba(0,200,255,0.6)] hover:bg-[rgba(0,200,255,0.1)] hover:border-[#00c8ff]",
    green: "border-[rgba(0,255,136,0.5)] text-[#00ff88] hover:shadow-[0_0_15px_rgba(0,255,136,0.6)] hover:bg-[rgba(0,255,136,0.1)] hover:border-[#00ff88]",
    purple: "border-[rgba(122,95,255,0.5)] text-[#7a5fff] hover:shadow-[0_0_15px_rgba(122,95,255,0.6)] hover:bg-[rgba(122,95,255,0.1)] hover:border-[#7a5fff]",
    none: "border-border text-foreground hover:bg-white/5 hover:border-foreground/50"
  };

  return (
    <motion.button
      whileHover={{ scale: 1.02 }}
      whileTap={{ scale: 0.98 }}
      className={cn(
        "interactive relative flex items-center justify-center gap-2 px-6 py-3 rounded-md",
        "border bg-cyber-bg font-mono text-xs tracking-widest uppercase transition-all duration-300",
        "overflow-hidden group",
        glowVariants[glowColor],
        className
      )}
      {...props}
    >
      {/* Glint effect on hover */}
      <span className="absolute inset-0 w-[200%] h-full bg-gradient-to-r from-transparent via-white/10 to-transparent -translate-x-[150%] group-hover:animate-[glint_1.5s_ease-in-out_infinite]" />
      
      {icon && <span className="z-10">{icon}</span>}
      <span className="z-10">{children as React.ReactNode}</span>
      
      {/* Terminal cursor blink indicator */}
      <span className="opacity-0 group-hover:opacity-100 animate-pulse ml-1 text-current inline-block w-1.5 h-3 bg-current" />
    </motion.button>
  );
}
