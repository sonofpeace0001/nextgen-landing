// Lazy Spline wrapper. Adapted for this project: Vite (no `'use client'`),
// plain JSX (no TypeScript), inline styles (no Tailwind / no `loader` class).
// The scene only ever mounts when a caller renders this component; callers are
// responsible for the desktop / reduced-motion / real-URL gating (see Landing).
import { Suspense, lazy } from "react";

const Spline = lazy(() => import("@splinetool/react-spline"));

export function SplineScene({ scene, className, onLoad }) {
  // Transparent fallback: while the chunk/scene load, the caller's branded
  // placeholder layer shows through underneath. `onLoad` lets the caller
  // cross-fade the scene in only once it is actually ready.
  return (
    <Suspense fallback={<div style={{ width: "100%", height: "100%" }} />}>
      <Spline scene={scene} className={className} onLoad={onLoad} />
    </Suspense>
  );
}
