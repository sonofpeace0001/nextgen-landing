import { useEffect, useState } from "react";
import { motion, useReducedMotion, useMotionValue, useSpring, useTransform, animate } from "motion/react";
import { ArrowRight, Flame, BookOpen } from "lucide-react";

const EASE = [0.22, 1, 0.36, 1];
const LEARN_HREF = "#/learn";

/* ── pointer parallax (desktop / fine pointers only) ─────────────────────── */
function usePointerParallax(enabled) {
  const rx = useMotionValue(0);
  const ry = useMotionValue(0);
  useEffect(() => {
    if (!enabled || !window.matchMedia("(pointer: fine)").matches) return;
    const onMove = (e) => {
      rx.set(e.clientX / window.innerWidth - 0.5);
      ry.set(e.clientY / window.innerHeight - 0.5);
    };
    window.addEventListener("pointermove", onMove, { passive: true });
    return () => window.removeEventListener("pointermove", onMove);
  }, [enabled, rx, ry]);
  const spring = { stiffness: 55, damping: 18, mass: 0.7 };
  return { mx: useSpring(rx, spring), my: useSpring(ry, spring) };
}

/* ── background: one aurora, a faint grid, a coral warmth. Nothing else. ─── */
function Backdrop({ reduce }) {
  return (
    <div aria-hidden="true" className="pointer-events-none absolute inset-0 overflow-hidden">
      <div
        className="absolute inset-0"
        style={{
          backgroundImage:
            "linear-gradient(to right, var(--border) 1px, transparent 1px), linear-gradient(to bottom, var(--border) 1px, transparent 1px)",
          backgroundSize: "72px 72px",
          maskImage: "radial-gradient(ellipse 65% 58% at 68% 42%, #000 0%, transparent 78%)",
          WebkitMaskImage: "radial-gradient(ellipse 65% 58% at 68% 42%, #000 0%, transparent 78%)",
        }}
      />
      <motion.div
        className="absolute -right-24 top-[-6%] h-[640px] w-[640px] rounded-full blur-[110px]"
        style={{ background: "color-mix(in srgb, var(--stage-glow) 34%, transparent)" }}
        animate={reduce ? undefined : { x: [0, -30, 0], y: [0, 24, 0] }}
        transition={{ duration: 22, repeat: Infinity, ease: "easeInOut" }}
      />
      <div
        className="absolute -left-32 bottom-[-12%] h-[420px] w-[420px] rounded-full blur-[110px]"
        style={{ background: "color-mix(in srgb, var(--coral) 13%, transparent)" }}
      />
      <div
        className="absolute inset-x-0 bottom-0 h-32"
        style={{ background: "linear-gradient(to bottom, transparent, var(--background))" }}
      />
    </div>
  );
}

/* ── headline: masked line reveal ────────────────────────────────────────── */
function Line({ children, delay, reduce, className, style }) {
  return (
    <span className="block overflow-hidden pb-[0.12em] -mb-[0.12em]">
      <motion.span
        className={`block ${className || ""}`}
        style={{ textWrap: "balance", ...style }}
        initial={reduce ? false : { y: "108%", opacity: 0 }}
        animate={{ y: 0, opacity: 1 }}
        transition={{ duration: 0.85, delay, ease: EASE }}
      >
        {children}
      </motion.span>
    </span>
  );
}

const fade = (reduce, delay) => ({
  initial: reduce ? false : { opacity: 0, y: 14 },
  animate: { opacity: 1, y: 0 },
  transition: { duration: 0.6, delay, ease: EASE },
});

/* ── floating glass cards ────────────────────────────────────────────────── */
function FloatCard({ className, delay, float = 8, dur = 6, reduce, px, children }) {
  return (
    <motion.div className={`absolute ${className}`} style={px}>
      <motion.div
        initial={reduce ? false : { opacity: 0, y: 24, scale: 0.92 }}
        animate={{ opacity: 1, y: 0, scale: 1 }}
        transition={{ type: "spring", stiffness: 120, damping: 16, delay }}
      >
        <motion.div
          animate={reduce ? undefined : { y: [0, -float, 0] }}
          transition={{ duration: dur, repeat: Infinity, ease: "easeInOut", delay: delay + 0.8 }}
          className="rounded-2xl border border-border p-3.5 backdrop-blur-xl"
          style={{
            background: "color-mix(in srgb, var(--background) 74%, transparent)",
            boxShadow: "0 22px 50px -22px color-mix(in srgb, var(--stage-glow) 55%, transparent)",
          }}
        >
          {children}
        </motion.div>
      </motion.div>
    </motion.div>
  );
}

function CountUp({ to, delay, reduce }) {
  const [v, setV] = useState(reduce ? to : 0);
  useEffect(() => {
    if (reduce) return;
    const c = animate(0, to, { duration: 1.5, delay, ease: EASE, onUpdate: (x) => setV(Math.round(x)) });
    return () => c.stop();
  }, [to, delay, reduce]);
  return <>{v}</>;
}

function LessonCard({ reduce }) {
  return (
    <div className="w-[196px]">
      <div className="flex items-center gap-2 text-[11px] font-medium uppercase tracking-[0.1em] text-muted-foreground">
        <BookOpen size={13} className="text-primary" aria-hidden="true" />
        Today · Day 14
      </div>
      <p className="mt-1.5 text-[13.5px] font-semibold leading-snug text-foreground">Prompting for real work</p>
      <div className="mt-3 h-1.5 overflow-hidden rounded-full" style={{ background: "color-mix(in srgb, var(--foreground) 10%, transparent)" }}>
        <motion.div
          className="h-full rounded-full"
          style={{ background: "linear-gradient(90deg, var(--primary), var(--coral))" }}
          initial={reduce ? false : { width: "0%" }}
          animate={{ width: "64%" }}
          transition={{ duration: 1.5, delay: 1.3, ease: EASE }}
        />
      </div>
      <p className="mt-1.5 text-[11px] text-muted-foreground">10 minutes · 1 real task</p>
    </div>
  );
}

function ScoreCard({ reduce }) {
  return (
    <div className="flex items-center gap-3">
      <div className="relative h-11 w-11 shrink-0">
        <svg viewBox="0 0 44 44" className="h-11 w-11 -rotate-90" aria-hidden="true">
          <circle cx="22" cy="22" r="18" fill="none" strokeWidth="4" style={{ stroke: "color-mix(in srgb, var(--foreground) 10%, transparent)" }} />
          <motion.circle
            cx="22"
            cy="22"
            r="18"
            fill="none"
            strokeWidth="4"
            strokeLinecap="round"
            style={{ stroke: "var(--primary)" }}
            initial={reduce ? false : { pathLength: 0 }}
            animate={{ pathLength: 0.92 }}
            transition={{ duration: 1.5, delay: 1.5, ease: EASE }}
          />
        </svg>
        <span className="absolute inset-0 flex items-center justify-center text-[13px] font-semibold text-foreground">
          <CountUp to={92} delay={1.5} reduce={reduce} />
        </span>
      </div>
      <div>
        <p className="text-[13.5px] font-semibold leading-tight text-foreground">Auto-graded</p>
        <p className="mt-0.5 text-[11px] text-muted-foreground">Instant feedback</p>
      </div>
    </div>
  );
}

function StreakCard({ reduce }) {
  return (
    <div>
      <div className="flex items-center gap-2">
        <Flame size={16} style={{ color: "var(--coral)" }} aria-hidden="true" />
        <span className="text-[13.5px] font-semibold text-foreground">6-day streak</span>
      </div>
      <div className="mt-2.5 flex gap-1.5" aria-hidden="true">
        {Array.from({ length: 7 }).map((_, i) => (
          <motion.span
            key={i}
            className="h-2 w-5 rounded-full"
            style={{ background: i < 6 ? "var(--primary)" : "color-mix(in srgb, var(--foreground) 12%, transparent)" }}
            initial={reduce ? false : { scaleX: 0, opacity: 0 }}
            animate={{ scaleX: 1, opacity: 1 }}
            transition={{ duration: 0.35, delay: 1.7 + i * 0.09, ease: EASE }}
          />
        ))}
      </div>
    </div>
  );
}

/* ── the stage: arch + character + orbit + cards ─────────────────────────── */
function Stage({ reduce, mx, my }) {
  const charX = useTransform(mx, [-0.5, 0.5], [-9, 9]);
  const charY = useTransform(my, [-0.5, 0.5], [-5, 5]);
  const cardX = useTransform(mx, [-0.5, 0.5], [14, -14]);
  const cardY = useTransform(my, [-0.5, 0.5], [8, -8]);
  const px = { x: cardX, y: cardY };

  return (
    <div className="relative mx-auto h-[540px] w-full max-w-[520px] sm:h-[600px] lg:h-[clamp(440px,calc(100svh_-_190px),640px)]" role="img" aria-label="A NEXTGEN learner standing in front of today's lesson, an auto-graded score and a learning streak">
      {/* arch */}
      <motion.div
        className="absolute inset-x-[9%] bottom-0 h-[87%]"
        initial={reduce ? false : { opacity: 0, y: 30, scale: 0.97 }}
        animate={{ opacity: 1, y: 0, scale: 1 }}
        transition={{ duration: 1, ease: EASE }}
      >
        <div
          className="relative h-full w-full overflow-hidden rounded-t-[999px] rounded-b-[32px] border"
          style={{
            borderColor: "color-mix(in srgb, var(--primary) 34%, transparent)",
            background:
              "radial-gradient(92% 56% at 50% 26%, color-mix(in srgb, var(--stage-glow) 62%, transparent), transparent 74%), linear-gradient(180deg, var(--stage-top), var(--stage-bottom))",
          }}
        >
          <div
            className="absolute inset-0 opacity-70"
            style={{
              backgroundImage: "radial-gradient(color-mix(in srgb, var(--foreground) 16%, transparent) 1px, transparent 1px)",
              backgroundSize: "18px 18px",
              maskImage: "linear-gradient(to bottom, transparent 8%, #000 60%)",
              WebkitMaskImage: "linear-gradient(to bottom, transparent 8%, #000 60%)",
            }}
          />
        </div>
      </motion.div>

      {/* slow orbit ring */}
      <motion.svg
        aria-hidden="true"
        viewBox="0 0 400 400"
        className="absolute left-1/2 top-[30%] h-[86%] w-[86%] -translate-x-1/2 -translate-y-1/4 opacity-60"
        animate={reduce ? undefined : { rotate: 360 }}
        transition={{ duration: 90, repeat: Infinity, ease: "linear" }}
      >
        <circle cx="200" cy="200" r="190" fill="none" strokeWidth="1" strokeDasharray="2 9" style={{ stroke: "color-mix(in srgb, var(--primary) 70%, transparent)" }} />
        <circle cx="200" cy="10" r="4" style={{ fill: "var(--coral)" }} />
        <circle cx="390" cy="200" r="3" style={{ fill: "var(--primary)" }} />
      </motion.svg>

      {/* floor shadow */}
      <div className="absolute inset-x-[24%] bottom-[-6px] h-8 rounded-[50%] bg-black/70 blur-xl" aria-hidden="true" />

      {/* character */}
      <motion.div className="absolute inset-x-0 bottom-0 flex h-full justify-center" style={{ x: charX, y: charY }}>
        <motion.div
          className="h-full"
          initial={reduce ? false : { opacity: 0, y: 56, scale: 0.96 }}
          animate={{ opacity: 1, y: 0, scale: 1 }}
          transition={{ duration: 1, delay: 0.25, ease: EASE }}
        >
          <motion.img
            src="/hero-character.webp"
            alt=""
            width="587"
            height="1481"
            fetchpriority="high"
            decoding="async"
            draggable="false"
            className="h-full w-auto select-none"
            style={{ filter: "drop-shadow(0 0 22px color-mix(in srgb, var(--stage-glow) 55%, transparent)) drop-shadow(0 18px 30px rgba(0,0,0,0.35))" }}
            animate={reduce ? undefined : { y: [0, -7, 0] }}
            transition={{ duration: 6.5, repeat: Infinity, ease: "easeInOut", delay: 1.2 }}
          />
        </motion.div>
      </motion.div>

      {/* product cards — they explain what NEXTGEN actually is */}
      <FloatCard className="left-0 top-[9%] max-sm:scale-[0.86] max-sm:origin-top-left" delay={0.7} float={8} dur={6} reduce={reduce} px={px}>
        <LessonCard reduce={reduce} />
      </FloatCard>
      <FloatCard className="right-0 top-[41%] max-sm:scale-[0.86] max-sm:origin-right" delay={0.95} float={10} dur={7} reduce={reduce} px={px}>
        <ScoreCard reduce={reduce} />
      </FloatCard>
      <FloatCard className="bottom-[9%] left-0 max-sm:hidden" delay={1.2} float={7} dur={5.5} reduce={reduce} px={px}>
        <StreakCard reduce={reduce} />
      </FloatCard>
    </div>
  );
}

/* ── hero ────────────────────────────────────────────────────────────────── */
export function Hero() {
  const reduce = !!useReducedMotion();
  const { mx, my } = usePointerParallax(!reduce);

  return (
    <section aria-label="Introduction" className="relative overflow-hidden pb-14 pt-28 sm:pt-32 lg:pb-20 lg:pt-36">
      <Backdrop reduce={reduce} />

      <div className="relative mx-auto grid max-w-6xl items-center gap-10 px-6 lg:grid-cols-[1.05fr_0.95fr] lg:gap-6">
        <div className="max-w-[600px]">
          <motion.p
            {...fade(reduce, 0)}
            className="inline-flex items-center gap-2.5 rounded-full border border-border py-1.5 pl-3 pr-4 font-accent text-[10.5px] font-semibold uppercase tracking-[0.11em] text-muted-foreground sm:text-[11.5px] sm:tracking-[0.12em]"
            style={{ background: "color-mix(in srgb, var(--foreground) 4%, transparent)" }}
          >
            <span className="relative flex h-2 w-2">
              <span className="absolute inline-flex h-full w-full animate-ping rounded-full opacity-60 motion-reduce:hidden" style={{ background: "var(--coral)" }} />
              <span className="relative inline-flex h-2 w-2 rounded-full" style={{ background: "var(--coral)" }} />
            </span>
            Free AI community for beginners
          </motion.p>

          <h1 className="mt-6 text-[42px] font-semibold leading-[1.04] tracking-[-0.025em] text-foreground sm:text-[56px] lg:text-[62px]">
            <Line delay={0.1} reduce={reduce}>Learn AI from zero.</Line>
            <Line
              delay={0.24}
              reduce={reduce}
              className="italic"
              style={{
                background: "linear-gradient(100deg, var(--primary) 0%, var(--primary) 38%, var(--coral) 100%)",
                WebkitBackgroundClip: "text",
                backgroundClip: "text",
                WebkitTextFillColor: "transparent",
              }}
            >
              Get real wins daily.
            </Line>
          </h1>

          <motion.p {...fade(reduce, 0.45)} className="mt-6 max-w-[520px] text-[17px] leading-[1.65] text-muted-foreground sm:text-[18px]">
            NEXTGEN is a free community where beginners learn AI by doing: one short lesson and one real task a day,
            auto-graded, with people doing the work alongside you.
          </motion.p>

          <motion.div {...fade(reduce, 0.58)} className="mt-9 flex flex-wrap items-center gap-3">
            <a
              href={LEARN_HREF}
              className="group inline-flex h-12 w-full items-center justify-center gap-2 rounded-xl bg-primary px-6 text-[15px] sm:w-auto font-semibold text-primary-foreground transition-[transform,box-shadow] duration-200 hover:-translate-y-0.5 hover:text-primary-foreground motion-reduce:transition-none"
              style={{ boxShadow: "0 12px 34px -12px color-mix(in srgb, var(--primary) 80%, transparent)" }}
            >
              Start learning free
              <ArrowRight size={17} className="transition-transform duration-200 group-hover:translate-x-0.5 motion-reduce:transition-none" aria-hidden="true" />
            </a>
            <a
              href="#/start"
              className="inline-flex h-12 w-full items-center justify-center gap-2 rounded-xl border border-border px-5 text-[15px] font-medium sm:w-auto text-foreground transition-colors hover:bg-[color-mix(in_srgb,var(--foreground)_6%,transparent)] motion-reduce:transition-none"
            >
              Not sure where to start?
              <ArrowRight size={15} className="text-muted-foreground" aria-hidden="true" />
            </a>
          </motion.div>

          <motion.p {...fade(reduce, 0.72)} className="mt-6 text-[13.5px] text-muted-foreground">
            <span className="font-semibold text-foreground">400+ builders</span> learning together · no experience needed
          </motion.p>
        </div>

        <Stage reduce={reduce} mx={mx} my={my} />
      </div>
    </section>
  );
}
