"use client";

import { AnimatePresence, motion, Variants } from "framer-motion";
import { usePathname } from "next/navigation";

export default function TransitionProvider({ children }: { children: React.ReactNode }) {
  const pathname = usePathname();

  // Cinematic page transitions (camera sweep / fade / zoom)
  const variants: Variants = {
    hidden: { opacity: 0, scale: 0.98, y: 10 },
    enter: { 
      opacity: 1, 
      scale: 1, 
      y: 0,
      transition: {
        duration: 0.6,
        ease: [0.22, 1, 0.36, 1], // cinematic easing
      }
    },
    exit: { 
      opacity: 0, 
      scale: 1.02, 
      y: -10,
      transition: {
        duration: 0.4,
        ease: [0.22, 1, 0.36, 1],
      }
    },
  };

  return (
    <AnimatePresence mode="wait">
      <motion.div
        key={pathname}
        variants={variants}
        initial="hidden"
        animate="enter"
        exit="exit"
        className="flex-1 w-full h-full relative z-10"
      >
        {children}
      </motion.div>
    </AnimatePresence>
  );
}
