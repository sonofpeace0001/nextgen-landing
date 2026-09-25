import { useEffect, useRef, useState } from "react";
import { motion, useReducedMotion } from "motion/react";
import { Rocket, Users, CalendarCheck, TrendingUp, Check, Crown } from "lucide-react";

const ITEMS = [
  { icon: Rocket, title: "Learn by doing", text: "Practical AI skills, starting with a 10-minute first win." },
  { icon: Users, title: "Real community", text: "Builders and beginners figuring it out together." },
  { icon: CalendarCheck, title: "Daily momentum", text: "A prompt or challenge every day to keep you moving." },
  { icon: TrendingUp, title: "A path upward", text: "Go from novice toward grandmaster at your pace." },
];

// The four tiers every path runs through (same ladder shown in Learning Paths).
// Purely illustrative UI, built in CSS: not a real screenshot, and never claims to be one.
const LADDER = [
  { name: "Basic", state: "done" },
  { name: "Pro", state: "active" },
  { name: "Expert", state: "todo" },
  { name: "Grandmaster", state: "todo" },
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

function PathLadder() {
  const reduce = !!useReducedMotion();
  return (
    <div
      className="rounded-2xl border border-border p-6"
      style={{
        background:
          "linear-gradient(180deg, color-mix(in srgb, var(--primary) 7%, var(--background)), color-mix(in srgb, var(--foreground) 3%, var(--background)))",
      }}
    >
      <div className="flex items-center justify-between">
        <span className="font-accent text-[11px] font-semibold uppercase tracking-[0.12em] text-muted-foreground">Your path</span>
        <span className="rounded-full border border-primary px-2.5 py-0.5 text-[11px] font-semibold text-primary">Novice · 90 days</span>
      </div>

      <ol className="relative mt-6 space-y-2.5">
        <span
          aria-hidden="true"
          className="absolute bottom-6 left-[19px] top-6 w-px"
          style={{ background: "linear-gradient(to bottom, var(--primary), color-mix(in srgb, var(--foreground) 14%, transparent) 55%)" }}
        />
        {LADDER.map((tier, i) => {
          const done = tier.state === "done";
          const active = tier.state === "active";
          return (
            <li
              key={tier.name}
              className="relative flex items-center gap-4 rounded-xl border px-3 py-3"
              style={{
                borderColor: active ? "color-mix(in srgb, var(--primary) 45%, transparent)" : "var(--border)",
                background: active ? "color-mix(in srgb, var(--primary) 9%, transparent)" : "transparent",
              }}
            >
              <span
                className="relative z-10 flex h-[26px] w-[26px] shrink-0 items-center justify-center rounded-full border text-[11px] font-semibold"
                style={{
                  background: done ? "var(--primary)" : "var(--background)",
                  borderColor: done || active ? "var(--primary)" : "var(--border)",
                  color: done ? "var(--primary-foreground)" : active ? "var(--primary)" : "var(--muted-foreground)",
                }}
              >
                {done ? <Check size={14} strokeWidth={3} aria-hidden="true" /> : i === 3 ? <Crown size={13} aria-hidden="true" /> : i + 1}
              </span>
              <div className="min-w-0 flex-1">
                <p className={`text-[14px] font-semibold ${done || active ? "text-foreground" : "text-muted-foreground"}`}>{tier.name}</p>
                {active && (
                  <div className="mt-1.5 h-1.5 overflow-hidden rounded-full" style={{ background: "color-mix(in srgb, var(--foreground) 10%, transparent)" }}>
                    <motion.div
                      className="h-full rounded-full"
                      style={{ background: "linear-gradient(90deg, var(--primary), var(--coral))" }}
                      initial={reduce ? { width: "58%" } : { width: "0%" }}
                      whileInView={{ width: "58%" }}
                      viewport={{ once: true, amount: 0.6 }}
                      transition={{ duration: 1.3, delay: 0.3, ease: [0.22, 1, 0.36, 1] }}
                    />
                  </div>
                )}
              </div>
              <span className="text-[11px] font-medium text-muted-foreground">
                {done ? "Complete" : active ? "In progress" : "Up next"}
              </span>
            </li>
          );
        })}
      </ol>

      <p className="mt-5 border-t border-border pt-4 text-xs text-muted-foreground">Every path runs Basic to Grandmaster, one focused day at a time.</p>
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
          <PathLadder />
        </FadeUp>
      </div>
    </section>
  );
}
