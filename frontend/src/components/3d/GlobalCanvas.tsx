"use client";

import { Canvas, useFrame } from "@react-three/fiber";
import { Float, Stars, Points, PointMaterial } from "@react-three/drei";
import * as THREE from "three";
import { useMemo, useRef } from "react";
import { usePathname } from "next/navigation";

// Anti-gravity particles that react slightly to scroll/mouse can be added here
function ParticleField() {
  const pointsRef = useRef<THREE.Points>(null!);
  const pathname = usePathname();

  // Generate random particles
  const count = 2000;
  const positions = useMemo(() => {
    const positions = new Float32Array(count * 3);
    for (let i = 0; i < count; i++) {
      positions[i * 3] = (Math.random() - 0.5) * 50;     // x
      positions[i * 3 + 1] = (Math.random() - 0.5) * 50; // y
      positions[i * 3 + 2] = (Math.random() - 0.5) * 50; // z
    }
    return positions;
  }, [count]);

  useFrame((state, delta) => {
    if (pointsRef.current) {
      pointsRef.current.rotation.x -= delta / 20;
      pointsRef.current.rotation.y -= delta / 30;
      
      // Slight parallax based on mouse
      const mouseX = (state.pointer.x * Math.PI) / 10;
      const mouseY = (state.pointer.y * Math.PI) / 10;
      
      pointsRef.current.rotation.x += (mouseY - pointsRef.current.rotation.x) * 0.05;
      pointsRef.current.rotation.y += (mouseX - pointsRef.current.rotation.y) * 0.05;
    }
  });

  // Change color theme based on subdomain/path implicitly
  const color = pathname.includes("tracker") 
    ? "#39ff14" // neon green
    : pathname.includes("learn") 
      ? "#ff00ff" // purple
      : "#0096ff"; // cyan

  return (
    <Points ref={pointsRef} positions={positions} stride={3} frustumCulled={false}>
      <PointMaterial
        transparent
        color={color}
        size={0.05}
        sizeAttenuation={true}
        depthWrite={false}
      />
    </Points>
  );
}

// Geometric abstract shapes that float
function FloatingGeometries() {
  return (
    <>
      <Float speed={1.5} rotationIntensity={1.5} floatIntensity={2}>
        <mesh position={[4, 2, -5]} rotation={[0.5, 0.5, 0]}>
          <octahedronGeometry args={[1, 0]} />
          <meshStandardMaterial color="#0096ff" wireframe opacity={0.3} transparent />
        </mesh>
      </Float>
      
      <Float speed={2} rotationIntensity={2} floatIntensity={3}>
        <mesh position={[-5, -2, -10]} rotation={[0.2, 0.8, 0]}>
          <torusGeometry args={[1.5, 0.4, 16, 100]} />
          <meshStandardMaterial color="#39ff14" wireframe opacity={0.15} transparent />
        </mesh>
      </Float>

      <Float speed={1} rotationIntensity={1} floatIntensity={1}>
        <mesh position={[0, -4, -8]} rotation={[0, 0.5, 0]}>
          <icosahedronGeometry args={[2, 0]} />
          <meshStandardMaterial color="#ff00ff" wireframe opacity={0.1} transparent />
        </mesh>
      </Float>
    </>
  );
}

export default function GlobalCanvas() {
  return (
    <div className="fixed inset-0 z-0 pointer-events-none">
      <Canvas camera={{ position: [0, 0, 10], fov: 60 }}>
        <ambientLight intensity={0.5} />
        <directionalLight position={[10, 10, 5]} intensity={1} />
        
        {/* Anti-gravity features */}
        <ParticleField />
        <FloatingGeometries />
        
        {/* Background stars */}
        <Stars radius={100} depth={50} count={5000} factor={4} saturation={0} fade speed={1} />
      </Canvas>
      
      /* Cinematic vignette overlay */
      <div className="cinematic-vignette" />
      <div className="scanline-overlay" />
    </div>
  );
}
