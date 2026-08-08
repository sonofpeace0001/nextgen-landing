import { useEffect, useRef, useState } from "react";
import { UserPlus, Compass, Sparkles, TrendingUp } from "lucide-react";

const prefersReducedMotion =
  typeof window !== "undefined" && window.matchMedia
    ? window.matchMedia("(prefers-reduced-motion: reduce)").matches
    : false;

// Reuses the site's existing signup link (same one used by the navbar and hero)
// rather than inventing a new URL.
const START_FREE_HREF = "#/learn";

const STEPS = [
  { n: "01", icon: UserPlus, title: "Join free", desc: "Sign up, tell us where you are starting from. No experience needed." },
  { n: "02", icon: Compass, title: "Pick your path", desc: 'Graphics, content, apps, or "not sure yet". You can change your mind.' },
  { n: "03", icon: Sparkles, title: "Get your first win", desc: "Make something real with AI in about ten minutes. Rough drafts welcome." },
  { n: "04", icon: TrendingUp, title: "Keep building", desc: "Daily challenges, people to ask, and a path that goes as deep as you want." },
];

function FadeUp({ children, delay = 0 }) {
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
      className="transition-all duration-700 ease-out motion-reduce:transition-none"
      style={
        prefersReducedMotion
          ? undefined
          : { opacity: shown ? 1 : 0, transform: shown ? "none" : "translateY(14px)", transitionDelay: `${delay}ms` }
      }
    >
      {children}
    </div>
  );
}

export function HowItWorksSection() {
  return (
    <section id="how" className="mx-auto max-w-6xl px-6 py-24 sm:py-32">
      <FadeUp>
        <h2 className="font-heading text-3xl font-semibold tracking-tight text-foreground sm:text-4xl">
          How it works
        </h2>
        <p className="mt-3 max-w-md text-[15px] text-muted-foreground">
          four steps. you can do the first one in the next ten minutes.
        </p>
      </FadeUp>

      <div className="mt-12 grid grid-cols-1 gap-8 sm:grid-cols-2 lg:grid-cols-4 lg:gap-6">
        {STEPS.map((step, i) => {
          const Icon = step.icon;
          return (
            <FadeUp key={step.n} delay={i * 80}>
              <div className="border-t border-border pt-5">
                <div className="flex items-center gap-3">
                  <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full border border-primary text-primary">
                    <Icon size={18} strokeWidth={2} aria-hidden="true" />
                  </span>
                  <span className="text-sm font-semibold text-muted-foreground">{step.n}</span>
                </div>
                <h3 className="mt-4 text-[15px] font-semibold text-foreground">{step.title}</h3>
                <p className="mt-1.5 text-sm leading-relaxed text-muted-foreground">{step.desc}</p>
              </div>
            </FadeUp>
          );
        })}
      </div>

      <FadeUp delay={120}>
        <a
          href={START_FREE_HREF}
          className="mt-12 inline-flex min-h-[44px] items-center justify-center rounded-xl bg-primary px-6 text-sm font-semibold text-primary-foreground transition-opacity hover:opacity-90 motion-reduce:transition-none"
        >
          Start free
        </a>
      </FadeUp>
    </section>
  );
}
