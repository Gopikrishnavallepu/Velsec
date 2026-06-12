"use client";

import React, { useRef } from "react";
import { motion, useMotionValue, useSpring, useTransform } from "framer-motion";

interface TiltWrapperProps {
  children: React.ReactNode;
  className?: string;
  intensity?: number;
}

export default function TiltWrapper({ children, className = "", intensity = 15 }: TiltWrapperProps) {
  const ref = useRef<HTMLDivElement>(null);
  
  // Motion values for mouse coordinates
  const x = useMotionValue(0);
  const y = useMotionValue(0);

  // Smooth the mouse values
  const mouseXSpring = useSpring(x, { stiffness: 300, damping: 30 });
  const mouseYSpring = useSpring(y, { stiffness: 300, damping: 30 });

  // Transform coordinates into rotation angles
  const rotateX = useTransform(mouseYSpring, [-0.5, 0.5], [intensity, -intensity]);
  const rotateY = useTransform(mouseXSpring, [-0.5, 0.5], [-intensity, intensity]);

  const handleMouseMove = (e: React.MouseEvent<HTMLDivElement>) => {
    if (!ref.current) return;
    
    const rect = ref.current.getBoundingClientRect();
    
    // Calculate normalized mouse position (-0.5 to 0.5)
    const width = rect.width;
    const height = rect.height;
    
    const mouseX = e.clientX - rect.left;
    const mouseY = e.clientY - rect.top;
    
    const xPct = mouseX / width - 0.5;
    const yPct = mouseY / height - 0.5;
    
    x.set(xPct);
    y.set(yPct);
  };

  const handleMouseLeave = () => {
    // Reset to center smoothly
    x.set(0);
    y.set(0);
  };

  return (
    <motion.div
      ref={ref}
      onMouseMove={handleMouseMove}
      onMouseLeave={handleMouseLeave}
      style={{
        rotateX,
        rotateY,
        transformStyle: "preserve-3d",
      }}
      className={`relative perspective-1000 ${className}`}
    >
      {/* 
        This child wrapper gets pushed out on the Z-axis 
        to enhance the 3D parallax effect 
      */}
      <div 
        style={{ transform: "translateZ(30px)" }}
        className="w-full h-full"
      >
        {children}
      </div>
    </motion.div>
  );
}
