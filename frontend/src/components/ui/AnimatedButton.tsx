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
  glowColor = "blue",
  icon,
  ...props 
}: AnimatedButtonProps) {
  
  const glowVariants = {
    blue: "bg-blue-500/20 border-blue-500/50 text-blue-300 hover:shadow-[0_0_20px_rgba(0,150,255,0.6)] hover:bg-blue-500/30",
    green: "bg-green-500/20 border-green-500/50 text-green-300 hover:shadow-[0_0_20px_rgba(57,255,20,0.6)] hover:bg-green-500/30",
    purple: "bg-purple-500/20 border-purple-500/50 text-purple-300 hover:shadow-[0_0_20px_rgba(255,0,255,0.6)] hover:bg-purple-500/30",
    none: ""
  };

  return (
    <motion.button
      whileHover={{ scale: 1.05 }}
      whileTap={{ scale: 0.95 }}
      className={cn(
        "relative flex items-center justify-center gap-2 px-6 py-3 rounded-md",
        "border backdrop-blur-md font-medium tracking-wide transition-colors",
        "overflow-hidden group",
        glowVariants[glowColor],
        className
      )}
      {...props}
    >
      {/* Glint effect on hover */}
      <span className="absolute inset-0 w-[200%] h-full bg-gradient-to-r from-transparent via-white/20 to-transparent -translate-x-[150%] group-hover:animate-[glint_1.5s_ease-in-out_infinite]" />
      
      {icon && <span className="z-10">{icon}</span>}
      <span className="z-10">{children as React.ReactNode}</span>
    </motion.button>
  );
}
