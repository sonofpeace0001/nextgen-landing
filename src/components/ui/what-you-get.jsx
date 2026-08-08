import { useEffect, useRef, useState } from "react";
import { Rocket, Users, CalendarCheck, TrendingUp } from "lucide-react";

const ITEMS = [
  { icon: Rocket, title: "Learn by doing", text: "Practical AI skills, starting with a 10-minute first win." },
  { icon: Users, title: "Real community", text: "Builders and beginners figuring it out together." },
  { icon: CalendarCheck, title: "Daily momentum", text: "A prompt or challenge every day to keep you moving." },
  { icon: TrendingUp, title: "A path upward", text: "Go from novice toward grandmaster at your pace." },
];

// Purely illustrative UI, built in CSS — not a real screenshot, and never
// claims to be one. Reuses the initials-avatar language already established
// in Testimonials rather than stock photos.
const MEMBER_INITIALS = ["AM", "DK", "PR", "TU", "LN"];

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

function DashboardPreview() {
  return (
    <div className="rounded-2xl border border-border bg-[color-mix(in_srgb,var(--foreground)_4%,var(--background))] p-6">
      <div className="flex items-center justify-between">
        <span className="text-[11px] font-medium uppercase tracking-[0.12em] text-muted-foreground">Your day</span>
        <span className="rounded-full border border-primary px-2.5 py-0.5 text-[11px] font-semibold text-primary">
          Day 14
        </span>
      </div>
      <h3 className="mt-3 text-[15px] font-semibold text-foreground">Prompting for real work</h3>
      <div className="mt-4 h-2 w-full overflow-hidden rounded-full bg-[color-mix(in_srgb,var(--foreground)_10%,var(--background))]">
        <div className="h-full w-[62%] rounded-full bg-primary" />
      </div>
      <div className="mt-4 flex flex-wrap gap-2">
        <span className="rounded-full border border-border px-3 py-1 text-xs text-muted-foreground">6-day streak</span>
        <span className="rounded-full border border-border px-3 py-1 text-xs text-muted-foreground">auto-graded · 92</span>
      </div>
      <div className="mt-6 border-t border-border pt-4">
        <span className="text-xs text-muted-foreground">400+ builders online</span>
        <div className="mt-2.5 flex -space-x-2">
          {MEMBER_INITIALS.map((initials) => (
            <span
              key={initials}
              className="flex h-8 w-8 items-center justify-center rounded-full border-2 border-background bg-[color-mix(in_srgb,var(--foreground)_8%,var(--background))] text-[10px] font-semibold text-muted-foreground"
            >
              {initials}
            </span>
          ))}
        </div>
      </div>
    </div>
  );
}

export function WhatYouGet() {
  return (
    <section id="what-you-get" className="mx-auto max-w-6xl px-6 py-20 sm:py-24">
      <div className="grid grid-cols-1 items-center gap-10 lg:grid-cols-2 lg:gap-16">
        <FadeUp>
          <h2 className="font-heading text-3xl font-semibold tracking-tight text-foreground sm:text-4xl">
            What you get
          </h2>
          <div className="mt-8 divide-y divide-border border-t border-border">
            {ITEMS.map((item) => {
              const Icon = item.icon;
              return (
                <div key={item.title} className="flex items-start gap-4 py-5">
                  <Icon className="mt-0.5 h-5 w-5 shrink-0 text-primary" strokeWidth={2} aria-hidden="true" />
                  <div>
                    <h3 className="text-[15px] font-semibold text-foreground">{item.title}</h3>
                    <p className="mt-1 text-sm leading-relaxed text-muted-foreground">{item.text}</p>
                  </div>
                </div>
              );
            })}
          </div>
        </FadeUp>
        <FadeUp delay={100}>
          <DashboardPreview />
        </FadeUp>
      </div>
    </section>
  );
}
