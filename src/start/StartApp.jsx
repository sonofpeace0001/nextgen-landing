import { useEffect, useState } from "react";
import { AnimatePresence, motion, useReducedMotion } from "motion/react";
import { ArrowLeft, ArrowRight, Check, Code2, ExternalLink, HelpCircle, MessageCircle, Palette, PenLine, RotateCcw } from "lucide-react";
import { Navbar } from "@/components/ui/navbar";
import { Footer } from "@/components/ui/footer";

/* Everything on this page reuses facts already stated on the marketing page
   (paths + day counts, the four tiers, the FAQ answers, the signup / Discord /
   partner links). Nothing here invents a claim about the curriculum. */

const EASE = [0.22, 1, 0.36, 1];
const SIGNUP = "#/learn";
const DISCORD_URL = "https://discord.gg/HDgMdVECwF";
const GRAPHICS_ACADEMY_URL = "https://next-gen-graphics-learning-academy.vercel.app/";
const TIERS = ["Basic", "Pro", "Expert", "Grandmaster"];

const PATHS = {
  novice: { name: "Novice", days: 90, blurb: "New to AI. Start from your first prompt and build real skills from zero." },
  intermediate: { name: "Intermediate", days: 60, blurb: "You know the basics. Go deeper into real AI work you can show." },
  advanced: { name: "Advanced", days: 30, blurb: "Already working with AI. Push to expert and Grandmaster level." },
};

const LEVELS = [
  { id: "novice", label: "I have never really used AI", hint: "Or I tried ChatGPT once and stopped" },
  { id: "intermediate", label: "I use AI tools now and then", hint: "I know the basics but want to go deeper" },
  { id: "advanced", label: "I work with AI regularly", hint: "I want to reach expert level" },
];

const INTERESTS = [
  { id: "graphics", label: "Graphics and design", icon: Palette },
  { id: "content", label: "Content and writing", icon: PenLine },
  { id: "apps", label: "Apps and tools", icon: Code2 },
  { id: "unsure", label: "Not sure yet", icon: HelpCircle },
];

const STEPS = [
  { id: "join", title: "Create your free account", desc: "It takes a minute. Tell us where you are starting from.", cta: { label: "Sign up free", href: SIGNUP } },
  { id: "discord", title: "Join the community on Discord", desc: "Say hi and ask anything. Nobody expects you to already know things.", cta: { label: "Open Discord", href: DISCORD_URL, external: true } },
  { id: "win", title: "Make your first win", desc: "One short lesson and one real task, about ten minutes. Rough drafts welcome.", cta: { label: "Start day 1", href: SIGNUP } },
  { id: "return", title: "Come back tomorrow", desc: "One focused day at a time. The daily challenge keeps you moving." },
];

const GOOD_TO_KNOW = [
  { q: "Is it free?", a: "Yes. The core path, the community and the daily challenges are open to everyone at no cost." },
  { q: "Do I need experience?", a: "No. NEXTGEN is built for people starting from zero. It is a place where it is safe to not know things yet." },
  { q: "What is Elite?", a: "A recognition tier you earn by contributing to the community. It cannot be bought." },
];

/* safe localStorage (private windows / blocked storage must not break the page) */
const load = (key, fallback) => {
  try {
    const raw = localStorage.getItem(key);
    return raw ? JSON.parse(raw) : fallback;
  } catch {
    return fallback;
  }
};
const save = (key, value) => {
  try {
    localStorage.setItem(key, JSON.stringify(value));
  } catch {
    /* ignore */
  }
};

const eyebrow = "font-accent text-[11.5px] font-semibold uppercase tracking-[0.2em] text-primary";

/* ── hero ────────────────────────────────────────────────────────────────── */
function StartHero({ reduce }) {
  const fade = (d) => ({
    initial: reduce ? false : { opacity: 0, y: 16 },
    animate: { opacity: 1, y: 0 },
    transition: { duration: 0.7, delay: d, ease: EASE },
  });
  return (
    <section className="relative overflow-hidden pb-16 pt-28 sm:pt-32 lg:pb-24 lg:pt-36" aria-label="Start here">
      {/* immersive violet + coral light, the way the Academy hero feels */}
      <div aria-hidden="true" className="pointer-events-none absolute inset-0">
        <div className="absolute inset-0" style={{ background: "radial-gradient(60% 65% at 78% 38%, color-mix(in srgb, var(--stage-glow) 42%, transparent), transparent 70%)" }} />
        <div className="absolute inset-0" style={{ background: "radial-gradient(38% 42% at 95% 78%, color-mix(in srgb, var(--coral) 24%, transparent), transparent 70%)" }} />
        <div className="absolute inset-0" style={{ background: "radial-gradient(45% 50% at 0% 100%, color-mix(in srgb, var(--primary) 14%, transparent), transparent 70%)" }} />
        <svg viewBox="0 0 600 600" className="absolute -right-32 top-1/2 h-[720px] w-[720px] -translate-y-1/2 opacity-[0.35]">
          <circle cx="300" cy="300" r="290" fill="none" strokeWidth="1" style={{ stroke: "color-mix(in srgb, var(--primary) 60%, transparent)" }} />
          <circle cx="300" cy="300" r="220" fill="none" strokeWidth="1" strokeDasharray="2 10" style={{ stroke: "color-mix(in srgb, var(--primary) 60%, transparent)" }} />
        </svg>
        <div className="absolute inset-x-0 bottom-0 h-40" style={{ background: "linear-gradient(to bottom, transparent, var(--background))" }} />
      </div>

      <div className="relative mx-auto grid max-w-6xl items-center gap-8 px-6 lg:grid-cols-[1.1fr_0.9fr]">
        <div className="max-w-[620px]">
          <motion.p {...fade(0)} className={eyebrow}>
            NEXTGEN · Start here
          </motion.p>
          <motion.h1 {...fade(0.08)} className="mt-5 text-[42px] font-semibold leading-[1.06] tracking-[-0.02em] text-foreground sm:text-[56px] lg:text-[64px]" style={{ textWrap: "balance" }}>
            Your first win in{" "}
            <em
              className="italic"
              style={{
                background: "linear-gradient(100deg, var(--primary) 0%, var(--primary) 40%, var(--coral) 100%)",
                WebkitBackgroundClip: "text",
                backgroundClip: "text",
                WebkitTextFillColor: "transparent",
              }}
            >
              ten minutes.
            </em>
          </motion.h1>
          <motion.p {...fade(0.2)} className="mt-6 max-w-[520px] text-[17px] leading-[1.65] text-muted-foreground sm:text-[18px]">
            New to AI? Answer two quick questions and we will point you to the right path, then walk you through your first day. No experience needed.
          </motion.p>
          <motion.div {...fade(0.32)} className="mt-9 flex flex-wrap items-center gap-3">
            <a
              href="#finder"
              onClick={(e) => {
                e.preventDefault();
                document.getElementById("finder")?.scrollIntoView({ behavior: reduce ? "auto" : "smooth", block: "start" });
              }}
              className="group inline-flex h-12 w-full items-center justify-center gap-2 rounded-xl bg-primary px-6 text-[15px] font-semibold text-primary-foreground transition-[transform,box-shadow] duration-200 hover:-translate-y-0.5 hover:text-primary-foreground motion-reduce:transition-none sm:w-auto"
              style={{ boxShadow: "0 12px 34px -12px color-mix(in srgb, var(--primary) 80%, transparent)" }}
            >
              Find my path
              <ArrowRight size={17} className="transition-transform duration-200 group-hover:translate-x-0.5" aria-hidden="true" />
            </a>
            <a href={SIGNUP} className="inline-flex h-12 w-full items-center justify-center rounded-xl border border-border px-5 text-[15px] font-medium text-foreground transition-colors hover:bg-[color-mix(in_srgb,var(--foreground)_6%,transparent)] sm:w-auto">
              Skip to sign up
            </a>
          </motion.div>
        </div>

        {/* the character acts as your guide */}
        <div className="relative mx-auto h-[400px] w-full max-w-[420px] sm:h-[500px]">
          <motion.div
            className="absolute inset-x-0 bottom-0 flex h-full justify-center"
            initial={reduce ? false : { opacity: 0, y: 40 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 1, delay: 0.2, ease: EASE }}
          >
            <motion.img
              src="/hero-character.webp"
              alt="The NEXTGEN character, your guide"
              width="587"
              height="1481"
              draggable="false"
              className="h-full w-auto select-none"
              style={{ filter: "drop-shadow(0 0 24px color-mix(in srgb, var(--stage-glow) 55%, transparent)) drop-shadow(0 18px 30px rgba(0,0,0,0.35))" }}
              animate={reduce ? undefined : { y: [0, -7, 0] }}
              transition={{ duration: 6.5, repeat: Infinity, ease: "easeInOut", delay: 1.2 }}
            />
          </motion.div>
          <motion.div
            initial={reduce ? false : { opacity: 0, scale: 0.9, y: 10 }}
            animate={{ opacity: 1, scale: 1, y: 0 }}
            transition={{ type: "spring", stiffness: 140, damping: 16, delay: 0.9 }}
            className="absolute -left-2 top-[3%] w-[164px] rounded-2xl rounded-br-md border border-border p-3 text-[12.5px] leading-snug text-foreground backdrop-blur-xl sm:w-[176px] sm:text-[13px]"
            style={{ background: "color-mix(in srgb, var(--background) 76%, transparent)", boxShadow: "0 22px 50px -22px color-mix(in srgb, var(--stage-glow) 55%, transparent)" }}
          >
            <span className="font-semibold">Hey, welcome.</span> Two quick questions and I will show you where to begin.
          </motion.div>
        </div>
      </div>

      <div aria-hidden="true" className="relative mt-4 hidden flex-col items-center gap-2 lg:flex">
        <span className="font-accent text-[10px] font-semibold uppercase tracking-[0.3em] text-muted-foreground">Scroll</span>
        <motion.span
          className="h-8 w-px origin-top bg-primary"
          animate={reduce ? undefined : { scaleY: [0.2, 1, 0.2] }}
          transition={{ duration: 2.2, repeat: Infinity, ease: "easeInOut" }}
        />
      </div>
    </section>
  );
}

/* ── path finder ─────────────────────────────────────────────────────────── */
function Option({ selected, onClick, children }) {
  return (
    <button
      type="button"
      onClick={onClick}
      aria-pressed={selected}
      className="group flex w-full items-center gap-4 rounded-2xl border p-4 text-left transition-[border-color,background-color,transform] duration-200 hover:-translate-y-0.5 motion-reduce:transition-none"
      style={{
        borderColor: selected ? "var(--primary)" : "var(--border)",
        background: selected ? "color-mix(in srgb, var(--primary) 10%, transparent)" : "color-mix(in srgb, var(--foreground) 3%, transparent)",
      }}
    >
      {children}
    </button>
  );
}

function PathFinder({ reduce }) {
  const saved = load("ng-start-v1", null);
  const [step, setStep] = useState(saved?.level && saved?.interest ? 2 : 0);
  const [answers, setAnswers] = useState(saved || { level: null, interest: null });

  const choose = (key, value, next) => {
    const updated = { ...answers, [key]: value };
    setAnswers(updated);
    if (next === 2) save("ng-start-v1", updated);
    setTimeout(() => setStep(next), reduce ? 0 : 220);
  };
  const restart = () => {
    save("ng-start-v1", null);
    setAnswers({ level: null, interest: null });
    setStep(0);
  };

  const path = PATHS[answers.level];
  const anim = {
    initial: reduce ? false : { opacity: 0, x: 24 },
    animate: { opacity: 1, x: 0 },
    exit: reduce ? undefined : { opacity: 0, x: -24 },
    transition: { duration: 0.32, ease: EASE },
  };

  return (
    <section id="finder" className="mx-auto max-w-6xl scroll-mt-24 px-6 py-20 sm:py-28">
      <div className="grid gap-10 lg:grid-cols-[0.8fr_1.2fr] lg:gap-16">
        <div>
          <p className={eyebrow}>Step 1</p>
          <h2 className="mt-4 text-3xl font-semibold tracking-tight text-foreground sm:text-[40px] sm:leading-[1.1]">Find where you should start</h2>
          <p className="mt-4 max-w-sm text-[15.5px] leading-relaxed text-muted-foreground">
            Every path runs from Basic to Grandmaster. The only difference is where you step on. You can change your mind later.
          </p>
        </div>

        <div className="overflow-hidden rounded-3xl border border-border p-6 sm:p-8" style={{ background: "linear-gradient(180deg, color-mix(in srgb, var(--primary) 7%, var(--background)), color-mix(in srgb, var(--foreground) 3%, var(--background)))" }}>
          <div className="mb-6 flex items-center justify-between">
            <span className="font-accent text-[11px] font-semibold uppercase tracking-[0.16em] text-muted-foreground">{step < 2 ? `Question ${step + 1} of 2` : "Your result"}</span>
            <div className="flex gap-1.5" aria-hidden="true">
              {[0, 1, 2].map((i) => (
                <span key={i} className="h-1.5 w-7 rounded-full transition-colors duration-300" style={{ background: i <= step ? "var(--primary)" : "color-mix(in srgb, var(--foreground) 14%, transparent)" }} />
              ))}
            </div>
          </div>

          <AnimatePresence mode="wait" initial={false}>
            {step === 0 && (
              <motion.div key="q1" {...anim}>
                <h3 className="text-2xl font-semibold tracking-tight text-foreground">How much have you used AI?</h3>
                <div className="mt-5 space-y-3">
                  {LEVELS.map((l) => (
                    <Option key={l.id} selected={answers.level === l.id} onClick={() => choose("level", l.id, 1)}>
                      <div>
                        <p className="text-[15px] font-semibold text-foreground">{l.label}</p>
                        <p className="mt-0.5 text-[13px] text-muted-foreground">{l.hint}</p>
                      </div>
                    </Option>
                  ))}
                </div>
              </motion.div>
            )}

            {step === 1 && (
              <motion.div key="q2" {...anim}>
                <h3 className="text-2xl font-semibold tracking-tight text-foreground">What would you love to make first?</h3>
                <div className="mt-5 grid gap-3 sm:grid-cols-2">
                  {INTERESTS.map((it) => {
                    const Icon = it.icon;
                    return (
                      <Option key={it.id} selected={answers.interest === it.id} onClick={() => choose("interest", it.id, 2)}>
                        <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl" style={{ background: "color-mix(in srgb, var(--primary) 14%, transparent)" }}>
                          <Icon size={18} className="text-primary" aria-hidden="true" />
                        </span>
                        <span className="text-[15px] font-semibold text-foreground">{it.label}</span>
                      </Option>
                    );
                  })}
                </div>
                <button type="button" onClick={() => setStep(0)} className="mt-5 inline-flex items-center gap-1.5 text-[13px] text-muted-foreground transition-colors hover:text-foreground">
                  <ArrowLeft size={14} aria-hidden="true" /> Back
                </button>
              </motion.div>
            )}

            {step === 2 && path && (
              <motion.div key="result" {...anim}>
                <p className="text-[13px] text-muted-foreground">We recommend</p>
                <div className="mt-1 flex flex-wrap items-baseline gap-x-4 gap-y-2">
                  <h3 className="text-[44px] font-semibold leading-none tracking-tight text-foreground">{path.name}</h3>
                  <span className="rounded-full border border-primary px-3 py-1 text-[12px] font-semibold text-primary">{path.days} days</span>
                </div>
                <p className="mt-4 max-w-md text-[15.5px] leading-relaxed text-muted-foreground">{path.blurb}</p>

                <div className="mt-5 flex flex-wrap items-center gap-2">
                  {TIERS.map((t, i) => (
                    <span key={t} className="inline-flex items-center gap-2 text-[12.5px] text-foreground">
                      <span className="rounded-lg border border-border px-2.5 py-1">{t}</span>
                      {i < TIERS.length - 1 && <span className="text-muted-foreground" aria-hidden="true">→</span>}
                    </span>
                  ))}
                </div>

                {answers.interest === "graphics" ? (
                  <a href={GRAPHICS_ACADEMY_URL} target="_blank" rel="noopener noreferrer" className="mt-6 flex items-start gap-3 rounded-2xl border border-border p-4 transition-colors hover:border-primary" style={{ background: "color-mix(in srgb, var(--foreground) 3%, transparent)" }}>
                    <Palette size={18} className="mt-0.5 shrink-0 text-primary" aria-hidden="true" />
                    <span className="text-[14px] leading-snug text-muted-foreground">
                      <span className="font-semibold text-foreground">Love graphics? </span>
                      The free NEXTGEN Graphics Learning Academy teaches AI graphic design, from your first prompt to full campaigns.
                      <ExternalLink size={12} className="ml-1.5 inline align-[-1px]" aria-hidden="true" />
                    </span>
                  </a>
                ) : (
                  <p className="mt-6 text-[14px] leading-snug text-muted-foreground">You will pick your focus when you sign up, and you can change your mind at any time.</p>
                )}

                <div className="mt-7 flex flex-wrap items-center gap-3">
                  <a
                    href={SIGNUP}
                    className="group inline-flex h-12 w-full items-center justify-center gap-2 rounded-xl bg-primary px-6 text-[15px] font-semibold text-primary-foreground transition-transform duration-200 hover:-translate-y-0.5 hover:text-primary-foreground sm:w-auto"
                    style={{ boxShadow: "0 12px 34px -12px color-mix(in srgb, var(--primary) 80%, transparent)" }}
                  >
                    Start the {path.name} path
                    <ArrowRight size={17} className="transition-transform duration-200 group-hover:translate-x-0.5" aria-hidden="true" />
                  </a>
                  <button type="button" onClick={restart} className="inline-flex h-12 items-center gap-2 rounded-xl px-4 text-[14px] text-muted-foreground transition-colors hover:text-foreground">
                    <RotateCcw size={14} aria-hidden="true" /> Retake
                  </button>
                </div>
              </motion.div>
            )}
          </AnimatePresence>
        </div>
      </div>
    </section>
  );
}

/* ── first-day checklist (progress is remembered on this device) ──────────── */
function FirstDay({ reduce }) {
  const [done, setDone] = useState(() => load("ng-start-steps", []));
  const toggle = (id) => {
    const next = done.includes(id) ? done.filter((d) => d !== id) : [...done, id];
    setDone(next);
    save("ng-start-steps", next);
  };
  const nextId = STEPS.find((s) => !done.includes(s.id))?.id;
  const pct = Math.round((done.length / STEPS.length) * 100);

  return (
    <section id="first-day" className="mx-auto max-w-6xl scroll-mt-24 px-6 py-20 sm:py-24">
      <div className="grid gap-10 lg:grid-cols-[0.8fr_1.2fr] lg:gap-16">
        <div>
          <p className={eyebrow}>Step 2</p>
          <h2 className="mt-4 text-3xl font-semibold tracking-tight text-foreground sm:text-[40px] sm:leading-[1.1]">Your first day, step by step</h2>
          <p className="mt-4 max-w-sm text-[15.5px] leading-relaxed text-muted-foreground">Four small steps. Tick them off as you go; we remember your progress on this device.</p>
          <div className="mt-8 max-w-sm">
            <div className="flex items-center justify-between text-[12.5px] text-muted-foreground">
              <span>{done.length} of {STEPS.length} done</span>
              <span>{pct}%</span>
            </div>
            <div className="mt-2 h-1.5 overflow-hidden rounded-full" style={{ background: "color-mix(in srgb, var(--foreground) 10%, transparent)" }}>
              <motion.div className="h-full rounded-full" style={{ background: "linear-gradient(90deg, var(--primary), var(--coral))" }} animate={{ width: `${pct}%` }} transition={{ duration: reduce ? 0 : 0.5, ease: EASE }} />
            </div>
          </div>
        </div>

        <ol className="space-y-3">
          {STEPS.map((s, i) => {
            const isDone = done.includes(s.id);
            const isNext = s.id === nextId;
            return (
              <li
                key={s.id}
                className="flex items-start gap-4 rounded-2xl border p-4 sm:p-5"
                style={{
                  borderColor: isNext ? "color-mix(in srgb, var(--primary) 50%, transparent)" : "var(--border)",
                  background: isNext ? "color-mix(in srgb, var(--primary) 8%, transparent)" : "transparent",
                }}
              >
                <button
                  type="button"
                  onClick={() => toggle(s.id)}
                  aria-label={isDone ? `Mark "${s.title}" as not done` : `Mark "${s.title}" as done`}
                  aria-pressed={isDone}
                  className="mt-0.5 flex h-7 w-7 shrink-0 items-center justify-center rounded-full border text-[12px] font-semibold transition-colors"
                  style={{ background: isDone ? "var(--primary)" : "transparent", borderColor: isDone || isNext ? "var(--primary)" : "var(--border)", color: isDone ? "var(--primary-foreground)" : "var(--muted-foreground)" }}
                >
                  {isDone ? <Check size={15} strokeWidth={3} aria-hidden="true" /> : i + 1}
                </button>
                <div className="min-w-0 flex-1">
                  <div className="flex flex-wrap items-center gap-x-3 gap-y-1">
                    <h3 className={`text-[16px] font-semibold ${isDone ? "text-muted-foreground line-through decoration-[1px]" : "text-foreground"}`}>{s.title}</h3>
                    {isNext && <span className="rounded-full bg-primary px-2 py-0.5 text-[10.5px] font-semibold uppercase tracking-wide text-primary-foreground">Do this next</span>}
                  </div>
                  <p className="mt-1 text-[14px] leading-relaxed text-muted-foreground">{s.desc}</p>
                  {s.cta && !isDone && (
                    <a
                      href={s.cta.href}
                      {...(s.cta.external ? { target: "_blank", rel: "noopener noreferrer" } : {})}
                      className="mt-3 inline-flex items-center gap-1.5 text-[14px] font-semibold text-primary transition-opacity hover:opacity-80 hover:text-primary"
                    >
                      {s.id === "discord" && <MessageCircle size={15} aria-hidden="true" />}
                      {s.cta.label}
                      <ArrowRight size={14} aria-hidden="true" />
                    </a>
                  )}
                </div>
              </li>
            );
          })}
        </ol>
      </div>
    </section>
  );
}

/* ── good to know + closing CTA ──────────────────────────────────────────── */
function GoodToKnow() {
  return (
    <section className="mx-auto max-w-6xl px-6 py-16 sm:py-20">
      <p className={eyebrow}>Good to know</p>
      <div className="mt-6 grid gap-4 md:grid-cols-3">
        {GOOD_TO_KNOW.map((g) => (
          <div key={g.q} className="rounded-2xl border border-border p-6" style={{ background: "color-mix(in srgb, var(--foreground) 3%, transparent)" }}>
            <h3 className="text-[19px] font-semibold tracking-tight text-foreground">{g.q}</h3>
            <p className="mt-2.5 text-[14.5px] leading-relaxed text-muted-foreground">{g.a}</p>
          </div>
        ))}
      </div>
      <p className="mt-6 text-[14px] text-muted-foreground">
        More questions? <a href="#faq" className="font-semibold text-primary hover:text-primary hover:underline">Read the full FAQ</a>
      </p>
    </section>
  );
}

function ClosingCta() {
  return (
    <section className="mx-auto max-w-6xl px-6 pb-24 pt-8 sm:pb-32">
      <div className="relative overflow-hidden rounded-[28px] border px-6 py-14 text-center sm:px-12 sm:py-16" style={{ borderColor: "color-mix(in srgb, var(--primary) 35%, transparent)", background: "radial-gradient(70% 120% at 50% 0%, color-mix(in srgb, var(--stage-glow) 30%, transparent), transparent 70%), color-mix(in srgb, var(--foreground) 3%, var(--background))" }}>
        <h2 className="mx-auto max-w-2xl text-3xl font-semibold tracking-tight text-foreground sm:text-[42px] sm:leading-[1.1]" style={{ textWrap: "balance" }}>
          Ready? Your first win is{" "}
          <em className="italic" style={{ background: "linear-gradient(100deg, var(--primary), var(--coral))", WebkitBackgroundClip: "text", backgroundClip: "text", WebkitTextFillColor: "transparent" }}>
            ten minutes
          </em>{" "}
          away.
        </h2>
        <a
          href={SIGNUP}
          className="group mt-8 inline-flex h-12 items-center justify-center gap-2 rounded-xl bg-primary px-7 text-[15px] font-semibold text-primary-foreground transition-transform duration-200 hover:-translate-y-0.5 hover:text-primary-foreground"
          style={{ boxShadow: "0 12px 34px -12px color-mix(in srgb, var(--primary) 80%, transparent)" }}
        >
          Start learning free
          <ArrowRight size={17} className="transition-transform duration-200 group-hover:translate-x-0.5" aria-hidden="true" />
        </a>
      </div>
    </section>
  );
}

export default function StartApp() {
  const reduce = !!useReducedMotion();
  useEffect(() => {
    const prev = document.title;
    document.title = "Start here | NEXTGEN, learn AI from zero";
    window.scrollTo({ top: 0, behavior: "instant" });
    return () => {
      document.title = prev;
    };
  }, []);

  return (
    <div className="min-h-screen bg-background text-foreground">
      <Navbar />
      <main>
        <StartHero reduce={reduce} />
        <PathFinder reduce={reduce} />
        <FirstDay reduce={reduce} />
        <GoodToKnow />
        <ClosingCta />
      </main>
      <Footer />
    </div>
  );
}
