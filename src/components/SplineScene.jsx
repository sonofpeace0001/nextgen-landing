// Lazy Spline wrapper. Adapted for this project: Vite (no `'use client'`),
// plain JSX (no TypeScript), inline styles (no Tailwind / no `loader` class).
// The scene only ever mounts when a caller renders this component; callers are
// responsible for the desktop / reduced-motion / real-URL gating (see Landing).
import { Suspense, lazy } from "react";

const Spline = lazy(() => import("@splinetool/react-spline"));

export function SplineScene({ scene, className }) {
  return (
    <Suspense
      fallback={
        <div
          style={{
            width: "100%",
            height: "100%",
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
          }}
        >
          {/* solid brand-violet dot — single color, no gradient/glow/shadow */}
          <span
            aria-hidden="true"
            style={{ width: 10, height: 10, borderRadius: "50%", background: "#7C3AED", opacity: 0.5 }}
          />
        </div>
      }
    >
      <Spline scene={scene} className={className} />
    </Suspense>
  );
}
