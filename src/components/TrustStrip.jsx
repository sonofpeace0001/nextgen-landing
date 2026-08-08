import { useEffect, useRef, useState } from "react";

const prefersReducedMotion =
  typeof window !== "undefined" && window.matchMedia
    ? window.matchMedia("(prefers-reduced-motion: reduce)").matches
    : false;

const POINTS = ["Free to join", "No experience needed", "Beginner-friendly", "Real projects"];

// Thin reassurance band directly under the hero. Quiet on purpose: no icons, no
// cards, no accent color, just four muted proof points.
export function TrustStrip() {
  const ref = useRef(null);
  const [shown, setShown] = useState(prefersReducedMotion);

  useEffect(() => {
    if (prefersReducedMotion || !ref.current) return;
    const observer = new IntersectionObserver(
      ([entry]) => {
        if (entry.isIntersecting) {
          setShown(true);
          observer.disconnect();
        }
      },
      { threshold: 0.15 },
    );
    observer.observe(ref.current);
    return () => observer.disconnect();
  }, []);

  return (
    <div
      ref={ref}
      className="border-b border-border transition-all duration-700 ease-out motion-reduce:transition-none"
      style={prefersReducedMotion ? undefined : { opacity: shown ? 1 : 0, transform: shown ? "none" : "translateY(10px)" }}
    >
      <div className="mx-auto grid max-w-6xl grid-cols-2 divide-x divide-y divide-border sm:grid-cols-4 sm:divide-y-0">
        {POINTS.map((point) => (
          <div key={point} className="px-4 py-5 text-center sm:px-6">
            <span className="text-[11px] font-medium uppercase tracking-[0.12em] text-muted-foreground sm:text-xs">
              {point}
            </span>
          </div>
        ))}
      </div>
    </div>
  );
}
