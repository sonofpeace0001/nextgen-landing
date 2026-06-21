import { useEffect, useRef, useState } from "react";
import { Rocket, Users, CalendarCheck, TrendingUp } from "lucide-react";

const ITEMS = [
  { icon: Rocket, title: "Learn by doing", text: "Practical AI skills, starting with a 10-minute first win." },
  { icon: Users, title: "Real community", text: "Builders and beginners figuring it out together." },
  { icon: CalendarCheck, title: "Daily momentum", text: "A prompt or challenge every day to keep you moving." },
  { icon: TrendingUp, title: "A path upward", text: "Go from novice toward grandmaster at your pace." },
];

const prefersReducedMotion =
  typeof window !== "undefined" && window.matchMedia
    ? window.matchMedia("(prefers-reduced-motion: reduce)").matches
    : false;

function FadeUp({ children, delay = 0 }) {
  const ref = useRef(null);
  const [shown, setShown] = useState(prefersReducedMotion);
  useEffect(() => {
    if (prefersReducedMotion || !ref.current) return;
    const obs = new IntersectionObserver(
      ([entry]) => {
        if (entry.isIntersecting) {
          setShown(true);
          obs.disconnect();
        }
      },
      { threshold: 0.15 },
    );
    obs.observe(ref.current);
    return () => obs.disconnect();
  }, []);
  return (
    <div
      ref={ref}
      style={
        prefersReducedMotion
          ? undefined
          : {
              opacity: shown ? 1 : 0,
              transform: shown ? "none" : "translateY(16px)",
              transition: `opacity 0.6s ease ${delay}ms, transform 0.6s ease ${delay}ms`,
            }
      }
    >
      {children}
    </div>
  );
}

export function WhatYouGet() {
  return (
    <section id="what-you-get" className="mx-auto max-w-6xl px-6 py-20 sm:py-24">
      <FadeUp>
        <h2 className="font-heading text-3xl font-semibold tracking-tight text-foreground sm:text-4xl">
          What you get
        </h2>
      </FadeUp>
      <div className="mt-10 grid grid-cols-1 gap-4 sm:grid-cols-2">
        {ITEMS.map((item, i) => {
          const Icon = item.icon;
          return (
            <FadeUp key={item.title} delay={i * 80}>
              <div className="h-full rounded-xl border border-border bg-[color-mix(in_srgb,var(--foreground)_5%,var(--background))] p-6">
                <Icon className="h-6 w-6 text-primary" strokeWidth={2} aria-hidden="true" />
                <h3 className="mt-4 text-lg font-semibold text-foreground">{item.title}</h3>
                <p className="mt-1.5 text-sm leading-relaxed text-muted-foreground">{item.text}</p>
              </div>
            </FadeUp>
          );
        })}
      </div>
    </section>
  );
}
