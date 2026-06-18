import { useState, useEffect, useRef } from "react";
import { Check, Menu, X, Circle, Sparkles, ArrowRight, ChevronLeft, ChevronRight } from "lucide-react";

/* ══════════════════════════════════════════════════════════════
   NEXTGEN — Premium redesign.
   Visual layer inspired by geometric hero, animated glowing
   borders, display cards, gallery carousel, and glass effects.
   ══════════════════════════════════════════════════════════════ */

const VIOLET = "#7C3AED";
const CORAL = "#EB97A0";
const INDIGO = "#6366F1";
const ROSE = "#FB7185";
const TEXT = "#ECE8F5";
const MUTED = "#9B8FC0";
const TERT = "#8A81A6";
const HAIR = "1px solid rgba(255,255,255,0.08)";
const SURFACE = "rgba(255,255,255,0.025)";
const BG = "#030303";
const H1_GRADIENT = "linear-gradient(to bottom, #ffffff, rgba(255,255,255,0.80))";
const H1_ACCENT = "linear-gradient(to right, #818CF8, rgba(255,255,255,0.9), #FB7185)";

const X_URL = "https://x.com/G_NEXTGEN";
const DISCORD_URL = "https://discord.gg/HDgMdVECwF";
const LEARN = "#/learn";

const TRACKS = [
  {
    name: "Freelancing",
    blurb: "Turn a skill into paid client work, then scale it into a business.",
    icon: "💼",
    gradient: "from-violet-500/[0.15]",
    color: VIOLET,
  },
  {
    name: "Web3",
    blurb: "From wallets and self-custody to building and earning on-chain.",
    icon: "⛓️",
    gradient: "from-rose-500/[0.15]",
    color: ROSE,
  },
  {
    name: "AI",
    blurb: "Every practical AI skill — from your first prompt to shipping agents and selling the work.",
    icon: "🤖",
    gradient: "from-indigo-500/[0.15]",
    color: INDIGO,
  },
];

const TIERS = ["Basic", "Pro", "Expert", "Grandmaster"];
const LEVELS = [
  { name: "Novice", days: 90 },
  { name: "Intermediate", days: 60 },
  { name: "Advanced", days: 30 },
];

const LOOP_STEPS = [
  { n: "01", title: "Learn", desc: "Each day opens with one clear objective and a focused lesson — what to learn today, no filler." },
  { n: "02", title: "Improve", desc: "A specific skill focus pushes you to get better at one thing that compounds over the path." },
  { n: "03", title: "Assignment", desc: "Apply it the same day. Every day ends with real work, not passive watching." },
  { n: "04", title: "Score", desc: "Your work is scored against a clear rubric, with an auto-graded check to confirm you have it." },
];

const COMPARISON_ROWS = [
  { label: "Learning paths for in-demand skills", free: true },
  { label: "A community of builders", free: true },
  { label: "Access to opportunities (jobs, gigs)", free: true },
  { label: "Start from zero, no experience needed", free: true },
  { label: "Advanced structured roadmaps", free: false },
  { label: "Exclusive and early-access opportunities", free: false },
  { label: "Direct mentorship and guidance", free: false },
  { label: "Priority access to tools and resources", free: false },
  { label: "Elite-only channels and strategy calls", free: false },
  { label: "Priority for paid roles and ambassador slots", free: false },
  { label: "Increased visibility for your personal brand", free: false },
];

const DISPLAY_CARDS_DATA = [
  { icon: "🎯", title: "Daily Lessons", desc: "Real skills, one day at a time", color: "#818CF8" },
  { icon: "⚡", title: "Live Community", desc: "400+ builders doing the work", color: "#FB7185" },
  { icon: "🏆", title: "Scored Work", desc: "Auto-graded, real feedback", color: "#A78BFA" },
];

const FOUNDER_X_URL = "https://x.com/sonofpeace0001";

const NAV_LINKS = [
  { label: "Tracks", href: "#tracks" },
  { label: "How it works", href: "#how" },
  { label: "Community", href: "#community" },
  { label: "Plans", href: "#plans" },
];

const prefersReducedMotion =
  typeof window !== "undefined" && window.matchMedia
    ? window.matchMedia("(prefers-reduced-motion: reduce)").matches
    : false;

/* ──────────────────────────────────────────────────────────────
   CSS — keyframes, animations, responsive, glow borders
   ────────────────────────────────────────────────────────────── */

const STYLES = `
  *,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
  html{scroll-behavior:smooth}
  a:hover{color:${TEXT}}

  /* ── Keyframes ── */
  @keyframes ng-float {
    0%, 100% { transform: translateY(0px); }
    50% { transform: translateY(15px); }
  }
  @keyframes ng-float-alt {
    0%, 100% { transform: translateY(0px); }
    50% { transform: translateY(-12px); }
  }
  @keyframes ng-fadeUp {
    from { opacity: 0; transform: translateY(30px); }
    to { opacity: 1; transform: translateY(0); }
  }
  @keyframes ng-fadeIn {
    from { opacity: 0; }
    to { opacity: 1; }
  }
  @keyframes ng-spin {
    from { transform: translate(-50%, -50%) rotate(0deg); }
    to { transform: translate(-50%, -50%) rotate(360deg); }
  }
  @keyframes ng-shimmer {
    0% { background-position: -200% 0; }
    100% { background-position: 200% 0; }
  }
  @keyframes ng-pulse-glow {
    0%, 100% { box-shadow: 0 0 20px rgba(124,58,237,0.15), 0 0 40px rgba(124,58,237,0.05); }
    50% { box-shadow: 0 0 30px rgba(124,58,237,0.25), 0 0 60px rgba(124,58,237,0.1); }
  }
  @keyframes ng-shape-entrance {
    from { opacity: 0; transform: translateY(-80px) scale(0.9); }
    to { opacity: 1; transform: translateY(0) scale(1); }
  }
  @keyframes ng-chromatic {
    0%, 100% { filter: hue-rotate(0deg); }
    50% { filter: hue-rotate(20deg); }
  }

  /* ── Animated border (rotating conic gradient) ── */
  .ng-glow-border {
    position: relative;
    border-radius: 14px;
    overflow: hidden;
    padding: 1.5px;
  }
  .ng-glow-border::before {
    content: '';
    position: absolute;
    top: 50%;
    left: 50%;
    width: 300%;
    height: 300%;
    background: conic-gradient(
      from 0deg,
      transparent 0%,
      ${VIOLET} 8%,
      transparent 16%,
      transparent 42%,
      ${CORAL} 50%,
      transparent 58%,
      transparent 84%,
      ${VIOLET} 92%,
      transparent 100%
    );
    animation: ng-spin 4s linear infinite;
  }
  .ng-glow-border-inner {
    position: relative;
    z-index: 1;
    background: ${BG};
    border-radius: 12.5px;
  }

  /* ── Glow button ── */
  .ng-glow-btn {
    position: relative;
    border-radius: 12px;
    overflow: hidden;
    padding: 2px;
    cursor: pointer;
    display: inline-block;
  }
  .ng-glow-btn::before {
    content: '';
    position: absolute;
    top: 50%;
    left: 50%;
    width: 400%;
    height: 400%;
    background: conic-gradient(
      from 0deg,
      transparent 0%,
      ${VIOLET} 6%,
      transparent 12%,
      transparent 44%,
      ${CORAL} 50%,
      transparent 56%,
      transparent 94%,
      ${VIOLET} 100%
    );
    animation: ng-spin 3s linear infinite;
  }
  .ng-glow-btn-inner {
    position: relative;
    z-index: 1;
    background: ${VIOLET};
    border-radius: 10px;
    padding: 14px 28px;
    color: #fff;
    font-size: 15px;
    font-weight: 600;
    font-family: inherit;
    border: none;
    display: block;
    white-space: nowrap;
    transition: filter 0.15s ease;
  }
  .ng-glow-btn:hover .ng-glow-btn-inner {
    filter: brightness(1.15);
  }

  /* ── Display cards (stacked) ── */
  .ng-display-stack {
    display: grid;
    grid-template-areas: 'stack';
    place-items: center;
  }
  .ng-display-card {
    grid-area: stack;
    width: 320px;
    height: 150px;
    transform: skewY(-8deg);
    border-radius: 16px;
    border: 2px solid rgba(255,255,255,0.06);
    background: rgba(255,255,255,0.03);
    backdrop-filter: blur(8px);
    padding: 20px 24px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    transition: transform 0.7s cubic-bezier(0.23,0.86,0.39,0.96), border-color 0.5s ease, background 0.5s ease;
    cursor: default;
    position: relative;
    overflow: hidden;
  }
  .ng-display-card::before {
    content: '';
    position: absolute;
    right: -1px;
    top: -5%;
    height: 110%;
    width: 260px;
    background: linear-gradient(to left, ${BG}, transparent);
    pointer-events: none;
  }
  .ng-display-card-0 { }
  .ng-display-card-0::after {
    content: '';
    position: absolute; inset: 0;
    border-radius: 16px;
    background: rgba(3,3,3,0.5);
    transition: opacity 0.7s ease;
  }
  .ng-display-card-0:hover::after { opacity: 0; }
  .ng-display-card-0:hover { transform: skewY(-8deg) translateY(-40px); border-color: rgba(255,255,255,0.15); }

  .ng-display-card-1 {
    transform: skewY(-8deg) translateX(56px) translateY(40px);
  }
  .ng-display-card-1::after {
    content: '';
    position: absolute; inset: 0;
    border-radius: 16px;
    background: rgba(3,3,3,0.5);
    transition: opacity 0.7s ease;
  }
  .ng-display-card-1:hover::after { opacity: 0; }
  .ng-display-card-1:hover { transform: skewY(-8deg) translateX(56px) translateY(0px); border-color: rgba(255,255,255,0.15); }

  .ng-display-card-2 {
    transform: skewY(-8deg) translateX(112px) translateY(80px);
  }
  .ng-display-card-2:hover { transform: skewY(-8deg) translateX(112px) translateY(40px); border-color: rgba(255,255,255,0.2); background: rgba(255,255,255,0.05); }

  /* ── Track card hover ── */
  .ng-track-card {
    border: 1px solid rgba(255,255,255,0.06);
    border-radius: 16px;
    padding: 32px;
    background: rgba(255,255,255,0.015);
    backdrop-filter: blur(4px);
    transition: border-color 0.4s ease, box-shadow 0.4s ease, transform 0.4s ease, background 0.4s ease;
    height: 100%;
    display: flex;
    flex-direction: column;
  }
  .ng-track-card:hover {
    border-color: rgba(124,58,237,0.3);
    box-shadow: 0 0 30px rgba(124,58,237,0.12), 0 0 60px rgba(124,58,237,0.04);
    transform: translateY(-4px);
    background: rgba(255,255,255,0.025);
  }

  /* ── Step card ── */
  .ng-step-card {
    border: 1px solid rgba(255,255,255,0.06);
    border-radius: 16px;
    padding: 32px;
    background: rgba(255,255,255,0.015);
    backdrop-filter: blur(4px);
    transition: border-color 0.4s ease, box-shadow 0.4s ease, transform 0.3s ease;
    height: 100%;
  }
  .ng-step-card:hover {
    border-color: rgba(235,151,160,0.3);
    box-shadow: 0 0 24px rgba(235,151,160,0.1);
    transform: translateY(-2px);
  }

  /* ── Gallery card ── */
  .ng-gallery-card {
    flex: 0 0 300px;
    height: 340px;
    border-radius: 20px;
    overflow: hidden;
    border: 1px solid rgba(255,255,255,0.06);
    background: rgba(255,255,255,0.02);
    position: relative;
    cursor: pointer;
    transition: border-color 0.4s ease, box-shadow 0.4s ease;
    scroll-snap-align: start;
  }
  .ng-gallery-card:hover {
    border-color: rgba(124,58,237,0.3);
    box-shadow: 0 0 30px rgba(124,58,237,0.1);
  }
  .ng-gallery-img {
    width: 100%;
    height: 100%;
    transition: height 0.5s cubic-bezier(0.4,0,0.2,1);
    position: relative;
  }
  .ng-gallery-card:hover .ng-gallery-img {
    height: 50%;
  }
  .ng-gallery-text {
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
    padding: 20px;
    opacity: 0;
    transform: translateY(10px);
    transition: opacity 0.5s ease, transform 0.5s ease;
    background: linear-gradient(to top, ${BG}, rgba(3,3,3,0.95));
  }
  .ng-gallery-card:hover .ng-gallery-text {
    opacity: 1;
    transform: translateY(0);
  }

  /* ── Plan table ── */
  .ng-plan-table {
    border: 1px solid rgba(255,255,255,0.06);
    border-radius: 16px;
    overflow: hidden;
    backdrop-filter: blur(4px);
  }

  /* ── Founder image glow ── */
  .ng-founder-wrap {
    position: relative;
    border-radius: 16px;
    overflow: hidden;
    padding: 2px;
  }
  .ng-founder-wrap::before {
    content: '';
    position: absolute;
    top: 50%;
    left: 50%;
    width: 300%;
    height: 300%;
    background: conic-gradient(
      from 0deg,
      transparent 20%,
      rgba(124,58,237,0.4) 25%,
      transparent 30%,
      transparent 70%,
      rgba(235,151,160,0.4) 75%,
      transparent 80%
    );
    animation: ng-spin 6s linear infinite;
  }
  .ng-founder-inner {
    position: relative;
    z-index: 1;
    border-radius: 14px;
    overflow: hidden;
    background: #000;
  }

  /* ── Shapes ── */
  .ng-shape {
    position: absolute;
    border-radius: 9999px;
    pointer-events: none;
  }
  .ng-shape-pill {
    background: linear-gradient(to right, var(--shape-color, rgba(129,140,248,0.12)), transparent);
    border: 2px solid rgba(255,255,255,0.08);
    box-shadow: 0 8px 32px rgba(255,255,255,0.06);
    backdrop-filter: blur(2px);
  }
  .ng-shape-pill::after {
    content: '';
    position: absolute;
    inset: 0;
    border-radius: 9999px;
    background: radial-gradient(circle at 50% 50%, rgba(255,255,255,0.15), transparent 70%);
  }

  /* ── Responsive ── */
  @media (max-width: 820px) {
    .ng-navlinks { display: none !important; }
    .ng-burger { display: block !important; }
    .ng-grid-2 { grid-template-columns: 1fr !important; gap: 32px !important; }
    .ng-grid-3 { grid-template-columns: 1fr !important; }
    .ng-grid-4 { grid-template-columns: 1fr 1fr !important; }
    .ng-hero { padding-top: 120px !important; padding-bottom: 80px !important; }
    .ng-section { padding: 72px 0 !important; }
    .ng-display-stack { transform: scale(0.85); }
    .ng-hero-split { grid-template-columns: 1fr !important; gap: 48px !important; }
    .ng-plan-head, .ng-plan-row { grid-template-columns: 1fr 56px 56px !important; }
    .ng-gallery-scroll { gap: 16px !important; }
    .ng-gallery-card { flex: 0 0 260px !important; height: 300px !important; }
  }
  @media (max-width: 540px) {
    .ng-grid-4 { grid-template-columns: 1fr !important; }
    .ng-display-stack { transform: scale(0.7); }
  }
  @media (prefers-reduced-motion: reduce) {
    *, *::before, *::after { animation: none !important; transition: none !important; }
  }
`;

/* ──────────────────────────────────────────────────────────────
   UTILITY COMPONENTS
   ────────────────────────────────────────────────────────────── */

const container = { maxWidth: 1120, margin: "0 auto", padding: "0 24px" };

function useScrolled(threshold = 32) {
  const [s, setS] = useState(false);
  useEffect(() => {
    const h = () => setS(window.scrollY > threshold);
    window.addEventListener("scroll", h, { passive: true });
    return () => window.removeEventListener("scroll", h);
  }, [threshold]);
  return s;
}

function FadeUp({ children, delay = 0, as: Tag = "div", style, className }) {
  const ref = useRef(null);
  const [seen, setSeen] = useState(false);
  useEffect(() => {
    if (prefersReducedMotion || !ref.current) return setSeen(true);
    const o = new IntersectionObserver(
      ([e]) => e.isIntersecting && (setSeen(true), o.disconnect()),
      { threshold: 0.1 }
    );
    o.observe(ref.current);
    return () => o.disconnect();
  }, []);
  const anim = prefersReducedMotion
    ? {}
    : {
        opacity: seen ? 1 : 0,
        transform: seen ? "none" : "translateY(24px)",
        transition: `opacity .7s cubic-bezier(0.25,0.4,0.25,1) ${delay}ms, transform .7s cubic-bezier(0.25,0.4,0.25,1) ${delay}ms`,
      };
  return (
    <Tag ref={ref} style={{ ...style, ...anim }} className={className}>
      {children}
    </Tag>
  );
}

/* ── Elegant floating shape ── */
function ElegantShape({ width = 400, height = 100, rotate = 0, color, top, left, right, bottom, delay = 0, alt }) {
  return (
    <div
      className="ng-shape"
      style={{
        top,
        left,
        right,
        bottom,
        width,
        height,
        transform: `rotate(${rotate}deg)`,
        animation: prefersReducedMotion
          ? "none"
          : `ng-shape-entrance 2.4s cubic-bezier(0.23,0.86,0.39,0.96) ${delay}s both, ${alt ? "ng-float-alt" : "ng-float"} 12s ease-in-out ${delay + 2.4}s infinite`,
      }}
    >
      <div
        className="ng-shape-pill"
        style={{
          width: "100%",
          height: "100%",
          "--shape-color": color || "rgba(129,140,248,0.12)",
        }}
      />
    </div>
  );
}

/* ──────────────────────────────────────────────────────────────
   BUTTONS
   ────────────────────────────────────────────────────────────── */

function GlowButton({ children, onClick, full }) {
  return (
    <div className="ng-glow-btn" onClick={onClick} style={{ width: full ? "100%" : "auto" }}>
      <span className="ng-glow-btn-inner" style={{ width: full ? "100%" : "auto", textAlign: "center" }}>
        {children}
      </span>
    </div>
  );
}

function GhostButton({ children, onClick, full }) {
  const [h, setH] = useState(false);
  return (
    <button
      onClick={onClick}
      onMouseEnter={() => setH(true)}
      onMouseLeave={() => setH(false)}
      style={{
        background: h ? "rgba(255,255,255,0.04)" : "transparent",
        color: TEXT,
        border: h ? "1px solid rgba(255,255,255,0.2)" : HAIR,
        borderRadius: 10,
        padding: "13px 24px",
        fontSize: 15,
        fontWeight: 500,
        fontFamily: "inherit",
        cursor: "pointer",
        width: full ? "100%" : "auto",
        transition: "border-color .2s ease, background .2s ease",
      }}
    >
      {children}
    </button>
  );
}

/* ──────────────────────────────────────────────────────────────
   ICONS & LOGO
   ────────────────────────────────────────────────────────────── */

function Logo({ size = 26 }) {
  return (
    <span style={{ display: "flex", alignItems: "center", gap: 10 }}>
      <img src="/logo.png" alt="" aria-hidden="true" style={{ height: size, width: "auto", display: "block" }} />
      <span
        style={{
          fontFamily: "'Space Grotesk','Inter',sans-serif",
          fontWeight: 600,
          fontSize: 17,
          letterSpacing: "-0.02em",
          color: TEXT,
        }}
      >
        NEXTGEN
      </span>
    </span>
  );
}

function XIcon({ size = 16 }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="currentColor" aria-hidden="true">
      <path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z" />
    </svg>
  );
}
function DiscordIcon({ size = 17 }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="currentColor" aria-hidden="true">
      <path d="M20.317 4.3698a19.7913 19.7913 0 00-4.8851-1.5152.0741.0741 0 00-.0785.0371c-.211.3753-.4447.8648-.6083 1.2495-1.8447-.2762-3.68-.2762-5.4868 0-.1636-.3933-.4058-.8742-.6177-1.2495a.077.077 0 00-.0785-.037 19.7363 19.7363 0 00-4.8852 1.515.0699.0699 0 00-.0321.0277C.5334 9.0458-.319 13.5799.0992 18.0578a.0824.0824 0 00.0312.0561c2.0528 1.5076 4.0413 2.4228 5.9929 3.0294a.0777.0777 0 00.0842-.0276c.4616-.6304.8731-1.2952 1.226-1.9942a.076.076 0 00-.0416-.1057c-.6528-.2476-1.2743-.5495-1.8722-.8923a.077.077 0 01-.0076-.1277c.1258-.0943.2517-.1923.3718-.2914a.0743.0743 0 01.0776-.0105c3.9278 1.7933 8.18 1.7933 12.0614 0a.0739.0739 0 01.0785.0095c.1202.099.246.1981.3728.2924a.077.077 0 01-.0066.1276 12.2986 12.2986 0 01-1.873.8914.0766.0766 0 00-.0407.1067c.3604.698.7719 1.3628 1.225 1.9932a.076.076 0 00.0842.0286c1.961-.6067 3.9495-1.5219 6.0023-3.0294a.077.077 0 00.0313-.0552c.5004-5.177-.8382-9.6739-3.5485-13.6604a.061.061 0 00-.0312-.0286zM8.02 15.3312c-1.1825 0-2.1569-1.0857-2.1569-2.419 0-1.3332.9555-2.4189 2.157-2.4189 1.2108 0 2.1757 1.0952 2.1568 2.419 0 1.3332-.9555 2.4189-2.1569 2.4189zm7.9748 0c-1.1825 0-2.1569-1.0857-2.1569-2.419 0-1.3332.9554-2.4189 2.1569-2.4189 1.2108 0 2.1757 1.0952 2.1568 2.419 0 1.3332-.946 2.4189-2.1568 2.4189Z" />
    </svg>
  );
}

/* ──────────────────────────────────────────────────────────────
   NAV
   ────────────────────────────────────────────────────────────── */

function Nav() {
  const scrolled = useScrolled(32);
  const [open, setOpen] = useState(false);
  return (
    <nav
      style={{
        position: "fixed",
        top: 0,
        left: 0,
        right: 0,
        zIndex: 100,
        background: scrolled ? "rgba(3,3,3,0.8)" : "transparent",
        backdropFilter: scrolled ? "saturate(140%) blur(12px)" : "none",
        borderBottom: scrolled ? HAIR : "1px solid transparent",
        transition: "background .3s ease, border-color .3s ease, backdrop-filter .3s ease",
      }}
    >
      <div style={{ ...container, display: "flex", alignItems: "center", justifyContent: "space-between", height: 66 }}>
        <a href="#top" style={{ textDecoration: "none" }}>
          <Logo />
        </a>
        <div className="ng-navlinks" style={{ display: "flex", alignItems: "center", gap: 30 }}>
          {NAV_LINKS.map((l) => (
            <a
              key={l.label}
              href={l.href}
              style={{ fontSize: 14, color: "rgba(255,255,255,0.5)", textDecoration: "none", fontWeight: 400, letterSpacing: "0.01em", transition: "color .2s ease" }}
            >
              {l.label}
            </a>
          ))}
          <a href={LEARN} style={{ fontSize: 14, color: "rgba(255,255,255,0.5)", textDecoration: "none" }}>
            Login
          </a>
          <GlowButton onClick={() => (window.location.hash = "#/learn")}>Start Learning</GlowButton>
        </div>
        <button
          className="ng-burger"
          onClick={() => setOpen(!open)}
          style={{ display: "none", background: "none", border: "none", color: TEXT, cursor: "pointer" }}
          aria-label="Menu"
        >
          {open ? <X size={22} /> : <Menu size={22} />}
        </button>
      </div>
      {open && (
        <div
          style={{
            background: "rgba(3,3,3,0.95)",
            backdropFilter: "blur(12px)",
            borderBottom: HAIR,
            padding: "16px 24px 24px",
            display: "flex",
            flexDirection: "column",
            gap: 16,
          }}
        >
          {NAV_LINKS.map((l) => (
            <a key={l.label} href={l.href} onClick={() => setOpen(false)} style={{ color: MUTED, fontSize: 16, textDecoration: "none" }}>
              {l.label}
            </a>
          ))}
          <a href={LEARN} onClick={() => setOpen(false)} style={{ color: MUTED, fontSize: 16, textDecoration: "none" }}>
            Login
          </a>
          <GlowButton full onClick={() => (window.location.hash = "#/learn")}>Start Learning</GlowButton>
        </div>
      )}
    </nav>
  );
}

/* ──────────────────────────────────────────────────────────────
   HERO — geometric shapes, gradient text, animated entrance
   ────────────────────────────────────────────────────────────── */

function Hero() {
  const [loaded, setLoaded] = useState(prefersReducedMotion);
  useEffect(() => {
    const t = setTimeout(() => setLoaded(true), 100);
    return () => clearTimeout(t);
  }, []);

  const fadeUp = (d) =>
    prefersReducedMotion
      ? {}
      : {
          opacity: loaded ? 1 : 0,
          transform: loaded ? "none" : "translateY(30px)",
          transition: `opacity 1s cubic-bezier(0.25,0.4,0.25,1) ${d}ms, transform 1s cubic-bezier(0.25,0.4,0.25,1) ${d}ms`,
        };

  return (
    <header
      className="ng-hero"
      style={{
        position: "relative",
        minHeight: "100vh",
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        overflow: "hidden",
        paddingTop: 140,
        paddingBottom: 100,
      }}
    >
      {/* Subtle gradient overlay */}
      <div
        aria-hidden="true"
        style={{
          position: "absolute",
          inset: 0,
          background: "linear-gradient(to bottom right, rgba(99,102,241,0.04), transparent, rgba(251,113,133,0.04))",
          filter: "blur(60px)",
          pointerEvents: "none",
        }}
      />

      {/* Geometric floating shapes */}
      <div aria-hidden="true" style={{ position: "absolute", inset: 0, overflow: "hidden" }}>
        <ElegantShape width={520} height={120} rotate={12} color="rgba(129,140,248,0.12)" top="18%" left="-6%" delay={0.3} />
        <ElegantShape width={440} height={100} rotate={-15} color="rgba(251,113,133,0.12)" top="72%" right="-2%" delay={0.5} />
        <ElegantShape width={260} height={70} rotate={-8} color="rgba(167,139,250,0.12)" bottom="8%" left="8%" delay={0.4} alt />
        <ElegantShape width={180} height={50} rotate={20} color="rgba(251,191,36,0.10)" top="12%" right="18%" delay={0.6} />
        <ElegantShape width={140} height={38} rotate={-25} color="rgba(56,189,248,0.10)" top="6%" left="22%" delay={0.7} alt />
      </div>

      {/* Content */}
      <div style={{ ...container, position: "relative", zIndex: 10 }}>
        <div
          className="ng-hero-split"
          style={{
            display: "grid",
            gridTemplateColumns: "1fr auto",
            gap: 64,
            alignItems: "center",
          }}
        >
          {/* Left — text */}
          <div style={{ maxWidth: 640 }}>
            {/* Badge */}
            <div
              style={{
                display: "inline-flex",
                alignItems: "center",
                gap: 8,
                padding: "5px 14px",
                borderRadius: 9999,
                background: "rgba(255,255,255,0.03)",
                border: "1px solid rgba(255,255,255,0.08)",
                marginBottom: 32,
                ...fadeUp(500),
              }}
            >
              <Circle size={7} fill="rgba(251,113,133,0.8)" stroke="none" />
              <span style={{ fontSize: 13, color: "rgba(255,255,255,0.5)", letterSpacing: "0.04em", fontWeight: 400 }}>
                The future-skills community
              </span>
            </div>

            {/* Title */}
            <h1
              style={{
                fontFamily: "'Space Grotesk','Inter',sans-serif",
                fontSize: "clamp(36px,5.8vw,72px)",
                fontWeight: 700,
                lineHeight: 1.05,
                letterSpacing: "-0.03em",
                margin: "0 0 8px",
                ...fadeUp(700),
              }}
            >
              <span style={{ background: H1_GRADIENT, WebkitBackgroundClip: "text", backgroundClip: "text", WebkitTextFillColor: "transparent" }}>
                Learn the skills
              </span>
              <br />
              <span style={{ background: H1_ACCENT, WebkitBackgroundClip: "text", backgroundClip: "text", WebkitTextFillColor: "transparent" }}>
                the next economy is paying for.
              </span>
            </h1>

            {/* Subtitle */}
            <p
              style={{
                fontSize: "clamp(16px, 1.8vw, 19px)",
                lineHeight: 1.65,
                color: "rgba(255,255,255,0.35)",
                fontWeight: 300,
                letterSpacing: "0.01em",
                maxWidth: 520,
                margin: "28px 0 40px",
                ...fadeUp(900),
              }}
            >
              AI, Web3, content, freelancing — practical skills with a community that is doing the work alongside you.
            </p>

            {/* CTAs */}
            <div style={{ display: "flex", gap: 16, flexWrap: "wrap", alignItems: "center", ...fadeUp(1100) }}>
              <GlowButton onClick={() => (window.location.hash = "#/learn")}>Start Learning</GlowButton>
              <a
                href="#tracks"
                style={{
                  display: "inline-flex",
                  alignItems: "center",
                  gap: 8,
                  color: TEXT,
                  fontSize: 15,
                  fontWeight: 500,
                  textDecoration: "none",
                  padding: "13px 4px",
                }}
              >
                Explore tracks
                <ArrowRight size={16} style={{ color: CORAL }} />
              </a>
            </div>
          </div>

          {/* Right — display cards */}
          <div style={{ ...fadeUp(1200) }}>
            <div className="ng-display-stack" style={{ minHeight: 320 }}>
              {DISPLAY_CARDS_DATA.map((card, i) => (
                <div key={i} className={`ng-display-card ng-display-card-${i}`}>
                  <div style={{ display: "flex", alignItems: "center", gap: 10, position: "relative", zIndex: 2 }}>
                    <span
                      style={{
                        display: "inline-flex",
                        alignItems: "center",
                        justifyContent: "center",
                        width: 28,
                        height: 28,
                        borderRadius: 9999,
                        background: "rgba(129,140,248,0.15)",
                        fontSize: 14,
                      }}
                    >
                      {card.icon}
                    </span>
                    <span style={{ fontSize: 16, fontWeight: 600, color: card.color }}>{card.title}</span>
                  </div>
                  <p style={{ fontSize: 16, color: TEXT, position: "relative", zIndex: 2 }}>{card.desc}</p>
                  <p style={{ fontSize: 13, color: TERT, position: "relative", zIndex: 2 }}>NEXTGEN</p>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>

      {/* Top & bottom fade */}
      <div
        aria-hidden="true"
        style={{
          position: "absolute",
          inset: 0,
          background: `linear-gradient(to bottom, ${BG} 0%, transparent 15%, transparent 85%, ${BG} 100%)`,
          pointerEvents: "none",
        }}
      />
    </header>
  );
}

/* ──────────────────────────────────────────────────────────────
   SECTION WRAPPER
   ────────────────────────────────────────────────────────────── */

function Section({ id, alt, children, style: sx }) {
  return (
    <section
      id={id}
      className="ng-section"
      style={{
        padding: "110px 0",
        background: alt ? "rgba(255,255,255,0.015)" : "transparent",
        borderTop: alt ? HAIR : "none",
        borderBottom: alt ? HAIR : "none",
        position: "relative",
        ...sx,
      }}
    >
      <div style={container}>{children}</div>
    </section>
  );
}

const eyebrow = {
  fontSize: 13,
  letterSpacing: "0.14em",
  textTransform: "uppercase",
  color: "rgba(255,255,255,0.4)",
  fontWeight: 500,
};
const h2Style = {
  fontFamily: "'Space Grotesk','Inter',sans-serif",
  fontSize: "clamp(28px,3.4vw,44px)",
  fontWeight: 600,
  letterSpacing: "-0.025em",
  color: TEXT,
  lineHeight: 1.12,
};
const bodyStyle = { fontSize: 17, lineHeight: 1.65, color: TEXT };

/* ──────────────────────────────────────────────────────────────
   TRACKS
   ────────────────────────────────────────────────────────────── */

function Tracks() {
  return (
    <Section id="tracks">
      <FadeUp>
        <p style={{ ...eyebrow, marginBottom: 14 }}>Learning tracks</p>
        <h2 style={{ ...h2Style, marginBottom: 14, maxWidth: 640 }}>Three paths into the new tech economy.</h2>
        <p style={{ fontSize: 16, color: "rgba(255,255,255,0.35)", maxWidth: 520, marginBottom: 56, lineHeight: 1.6, fontWeight: 300 }}>
          Pick a track and a level. Every track runs from Basic to Grandmaster — choose how deep you go.
        </p>
      </FadeUp>
      <div className="ng-grid-3" style={{ display: "grid", gridTemplateColumns: "repeat(3,1fr)", gap: 20 }}>
        {TRACKS.map((t, i) => (
          <FadeUp key={t.name} delay={i * 100}>
            <div className="ng-track-card">
              <div style={{ fontSize: 36, marginBottom: 16 }}>{t.icon}</div>
              <h3 style={{ fontFamily: "'Space Grotesk','Inter',sans-serif", fontSize: 24, fontWeight: 600, color: TEXT, margin: "0 0 10px" }}>
                {t.name}
              </h3>
              <p style={{ fontSize: 15, lineHeight: 1.6, color: "rgba(255,255,255,0.4)", margin: "0 0 28px", flex: 1 }}>{t.blurb}</p>

              <p style={{ ...eyebrow, fontSize: 11, marginBottom: 10 }}>Tiers</p>
              <div style={{ display: "flex", flexWrap: "wrap", gap: 8, marginBottom: 22 }}>
                {TIERS.map((tier) => (
                  <span
                    key={tier}
                    style={{
                      fontSize: 12,
                      color: TEXT,
                      border: "1px solid rgba(255,255,255,0.08)",
                      borderRadius: 8,
                      padding: "5px 10px",
                      background: "rgba(255,255,255,0.02)",
                    }}
                  >
                    {tier}
                  </span>
                ))}
              </div>

              <p style={{ ...eyebrow, fontSize: 11, marginBottom: 10 }}>Levels</p>
              <div style={{ display: "flex", flexDirection: "column", gap: 8, marginBottom: 26 }}>
                {LEVELS.map((lv) => (
                  <div key={lv.name} style={{ display: "flex", justifyContent: "space-between", fontSize: 14 }}>
                    <span style={{ color: "rgba(255,255,255,0.4)" }}>{lv.name}</span>
                    <span style={{ color: TEXT, fontWeight: 600 }}>{lv.days} days</span>
                  </div>
                ))}
              </div>

              <a
                href={LEARN}
                style={{
                  display: "inline-flex",
                  alignItems: "center",
                  gap: 7,
                  color: TEXT,
                  fontSize: 14,
                  fontWeight: 600,
                  textDecoration: "none",
                  transition: "gap 0.2s ease",
                }}
              >
                Start {t.name}
                <ArrowRight size={15} style={{ color: t.color }} />
              </a>
            </div>
          </FadeUp>
        ))}
      </div>
    </Section>
  );
}

/* ──────────────────────────────────────────────────────────────
   HOW IT WORKS
   ────────────────────────────────────────────────────────────── */

function HowItWorks() {
  return (
    <Section id="how" alt>
      <FadeUp>
        <p style={{ ...eyebrow, marginBottom: 14 }}>How it works</p>
        <h2 style={{ ...h2Style, marginBottom: 56, maxWidth: 620 }}>One simple loop, every single day.</h2>
      </FadeUp>
      <div className="ng-grid-4" style={{ display: "grid", gridTemplateColumns: "repeat(4,1fr)", gap: 20 }}>
        {LOOP_STEPS.map((s, i) => (
          <FadeUp key={s.n} delay={i * 100}>
            <div className="ng-step-card">
              <div
                style={{
                  fontSize: 28,
                  fontWeight: 700,
                  fontFamily: "'Space Grotesk','Inter',sans-serif",
                  marginBottom: 20,
                  background: `linear-gradient(135deg, ${VIOLET}, ${CORAL})`,
                  WebkitBackgroundClip: "text",
                  backgroundClip: "text",
                  WebkitTextFillColor: "transparent",
                  fontVariantNumeric: "tabular-nums",
                }}
              >
                {s.n}
              </div>
              <h3 style={{ fontSize: 19, fontWeight: 600, color: TEXT, margin: "0 0 10px" }}>{s.title}</h3>
              <p style={{ fontSize: 14.5, lineHeight: 1.6, color: "rgba(255,255,255,0.4)", margin: 0 }}>{s.desc}</p>
            </div>
          </FadeUp>
        ))}
      </div>
    </Section>
  );
}

/* ──────────────────────────────────────────────────────────────
   COMMUNITY
   ────────────────────────────────────────────────────────────── */

function Community() {
  return (
    <Section id="community">
      <FadeUp>
        <p style={{ ...eyebrow, marginBottom: 40 }}>Community</p>
      </FadeUp>
      <div className="ng-grid-2" style={{ display: "grid", gridTemplateColumns: "300px 1fr", gap: 56, alignItems: "center" }}>
        <FadeUp>
          {/* Founder image with animated border */}
          <div className="ng-founder-wrap" style={{ width: "100%", maxWidth: 300 }}>
            <div className="ng-founder-inner">
              <img
                src="/founder.jpg"
                alt="SON OF PEACE, founder of NEXTGEN"
                width="720"
                height="720"
                loading="lazy"
                style={{ width: "100%", height: "auto", display: "block" }}
              />
            </div>
          </div>
        </FadeUp>
        <FadeUp delay={100}>
          <div style={{ marginBottom: 28 }}>
            <span
              style={{
                fontFamily: "'Space Grotesk','Inter',sans-serif",
                fontSize: 52,
                fontWeight: 700,
                letterSpacing: "-0.03em",
                background: `linear-gradient(135deg, ${VIOLET}, ${CORAL})`,
                WebkitBackgroundClip: "text",
                backgroundClip: "text",
                WebkitTextFillColor: "transparent",
              }}
            >
              400+
            </span>
            <span style={{ fontSize: 17, color: TEXT, marginLeft: 14 }}>builders in the community</span>
          </div>
          <p style={{ ...eyebrow, marginBottom: 8 }}>Founder</p>
          <h3
            style={{
              fontFamily: "'Space Grotesk','Inter',sans-serif",
              fontSize: 28,
              fontWeight: 600,
              color: TEXT,
              margin: "0 0 14px",
              letterSpacing: "-0.02em",
            }}
          >
            SON OF PEACE
          </h3>
          <p style={{ fontSize: 16, lineHeight: 1.65, color: "rgba(255,255,255,0.4)", maxWidth: 480, marginBottom: 28, fontWeight: 300 }}>
            SON OF PEACE started NEXTGEN to give people a real path into the new tech economy — not more theory, but
            skills, a community, and opportunities you can actually act on.
          </p>
          <div style={{ display: "flex", gap: 16, flexWrap: "wrap", alignItems: "center" }}>
            <GlowButton onClick={() => { if (typeof window !== "undefined") window.open(DISCORD_URL, "_blank", "noopener,noreferrer"); }}>
              Join the community
            </GlowButton>
            <a
              href={FOUNDER_X_URL}
              target="_blank"
              rel="noopener noreferrer"
              style={{ display: "inline-flex", alignItems: "center", gap: 8, color: MUTED, fontSize: 14, textDecoration: "none" }}
            >
              <XIcon size={14} />
              @sonofpeace0001
            </a>
          </div>
        </FadeUp>
      </div>
    </Section>
  );
}

/* ──────────────────────────────────────────────────────────────
   PLANS
   ────────────────────────────────────────────────────────────── */

function Plans() {
  return (
    <Section id="plans" alt>
      <FadeUp>
        <p style={{ ...eyebrow, marginBottom: 14 }}>Plans</p>
        <h2 style={{ ...h2Style, marginBottom: 14, maxWidth: 640 }}>Free is the foundation. Elite is the accelerator.</h2>
        <p style={{ fontSize: 16, color: "rgba(255,255,255,0.35)", maxWidth: 560, marginBottom: 48, lineHeight: 1.6, fontWeight: 300 }}>
          Start free and learn for real. Elite is the premium tier — earned through contribution, not just bought — for
          faster growth, deeper access, and real execution.
        </p>
      </FadeUp>

      <FadeUp delay={80}>
        <div className="ng-glow-border">
          <div className="ng-glow-border-inner" style={{ borderRadius: 14 }}>
            <div
              className="ng-plan-head"
              style={{
                display: "grid",
                gridTemplateColumns: "1fr 132px 132px",
                gap: 16,
                padding: "18px 24px",
                borderBottom: HAIR,
                background: "rgba(255,255,255,0.02)",
              }}
            >
              <span />
              <span style={{ textAlign: "center", fontSize: 14, fontWeight: 600, color: TEXT }}>NEXTGEN</span>
              <span
                style={{
                  textAlign: "center",
                  fontSize: 14,
                  fontWeight: 600,
                  background: `linear-gradient(to right, ${VIOLET}, ${CORAL})`,
                  WebkitBackgroundClip: "text",
                  backgroundClip: "text",
                  WebkitTextFillColor: "transparent",
                }}
              >
                Elite
              </span>
            </div>
            {COMPARISON_ROWS.map((r, i) => (
              <div
                key={i}
                className="ng-plan-row"
                style={{
                  display: "grid",
                  gridTemplateColumns: "1fr 132px 132px",
                  gap: 16,
                  alignItems: "center",
                  padding: "14px 24px",
                  borderBottom: i < COMPARISON_ROWS.length - 1 ? "1px solid rgba(255,255,255,0.04)" : "none",
                }}
              >
                <span style={{ fontSize: 14.5, color: "rgba(255,255,255,0.45)" }}>{r.label}</span>
                <span style={{ display: "flex", justifyContent: "center" }}>
                  {r.free ? <Check size={16} style={{ color: VIOLET }} /> : <span style={{ color: TERT, fontSize: 16 }}>—</span>}
                </span>
                <span style={{ display: "flex", justifyContent: "center" }}>
                  <Check size={16} style={{ color: CORAL }} />
                </span>
              </div>
            ))}
          </div>
        </div>
      </FadeUp>

      <FadeUp delay={140}>
        <div style={{ display: "flex", gap: 14, flexWrap: "wrap", marginTop: 36 }}>
          <GlowButton onClick={() => { if (typeof window !== "undefined") window.open(DISCORD_URL, "_blank", "noopener,noreferrer"); }}>
            Apply for Elite
          </GlowButton>
          <GhostButton onClick={() => (window.location.hash = "#/learn")}>Start free</GhostButton>
        </div>
      </FadeUp>
    </Section>
  );
}

/* ──────────────────────────────────────────────────────────────
   FOOTER
   ────────────────────────────────────────────────────────────── */

function Footer() {
  return (
    <footer style={{ borderTop: HAIR, padding: "56px 0", position: "relative" }}>
      <div style={{ ...container, display: "flex", flexWrap: "wrap", justifyContent: "space-between", gap: 40 }}>
        <div style={{ maxWidth: 280 }}>
          <Logo size={22} />
          <p style={{ fontSize: 14, color: "rgba(255,255,255,0.3)", lineHeight: 1.65, margin: "16px 0 18px", fontWeight: 300 }}>
            The future-skills community. Build, earn, and grow in the new tech economy.
          </p>
          <div style={{ display: "flex", gap: 14 }}>
            <a
              href={X_URL}
              target="_blank"
              rel="noopener noreferrer"
              aria-label="NEXTGEN on X"
              style={{
                color: MUTED,
                display: "inline-flex",
                alignItems: "center",
                justifyContent: "center",
                width: 36,
                height: 36,
                borderRadius: 10,
                border: "1px solid rgba(255,255,255,0.06)",
                background: "rgba(255,255,255,0.02)",
                transition: "border-color 0.3s ease",
              }}
            >
              <XIcon />
            </a>
            <a
              href={DISCORD_URL}
              target="_blank"
              rel="noopener noreferrer"
              aria-label="NEXTGEN on Discord"
              style={{
                color: MUTED,
                display: "inline-flex",
                alignItems: "center",
                justifyContent: "center",
                width: 36,
                height: 36,
                borderRadius: 10,
                border: "1px solid rgba(255,255,255,0.06)",
                background: "rgba(255,255,255,0.02)",
                transition: "border-color 0.3s ease",
              }}
            >
              <DiscordIcon />
            </a>
          </div>
          <p style={{ fontSize: 13, color: "rgba(255,255,255,0.3)", marginTop: 16 }}>
            <span style={{ color: TEXT, fontWeight: 600 }}>500+</span> following on X
          </p>
        </div>
        <div style={{ display: "flex", gap: 56, flexWrap: "wrap" }}>
          <div style={{ display: "flex", flexDirection: "column", gap: 12 }}>
            <span style={{ ...eyebrow, fontSize: 12 }}>Learn</span>
            <a href="#tracks" style={{ fontSize: 14, color: "rgba(255,255,255,0.4)", textDecoration: "none" }}>Tracks</a>
            <a href="#how" style={{ fontSize: 14, color: "rgba(255,255,255,0.4)", textDecoration: "none" }}>How it works</a>
            <a href="#plans" style={{ fontSize: 14, color: "rgba(255,255,255,0.4)", textDecoration: "none" }}>Plans</a>
          </div>
          <div style={{ display: "flex", flexDirection: "column", gap: 12 }}>
            <span style={{ ...eyebrow, fontSize: 12 }}>Community</span>
            <a href={LEARN} style={{ fontSize: 14, color: "rgba(255,255,255,0.4)", textDecoration: "none" }}>Start Learning</a>
            <a href={X_URL} target="_blank" rel="noopener noreferrer" style={{ fontSize: 14, color: "rgba(255,255,255,0.4)", textDecoration: "none" }}>X</a>
            <a href={DISCORD_URL} target="_blank" rel="noopener noreferrer" style={{ fontSize: 14, color: "rgba(255,255,255,0.4)", textDecoration: "none" }}>Discord</a>
          </div>
        </div>
      </div>

      {/* Bottom bar */}
      <div style={{ ...container, marginTop: 44, paddingTop: 20, borderTop: HAIR, display: "flex", justifyContent: "space-between", alignItems: "center", flexWrap: "wrap", gap: 12 }}>
        <p style={{ fontSize: 13, color: "rgba(255,255,255,0.25)", margin: 0 }}>
          © {new Date().getFullYear()} NEXTGEN. All rights reserved.
        </p>
        <div style={{ display: "flex", gap: 20 }}>
          <a href="#top" style={{ fontSize: 13, color: "rgba(255,255,255,0.25)", textDecoration: "none" }}>Back to top ↑</a>
        </div>
      </div>
    </footer>
  );
}

/* ──────────────────────────────────────────────────────────────
   LANDING — Main export
   ────────────────────────────────────────────────────────────── */

export default function Landing() {
  return (
    <div
      id="top"
      style={{
        background: BG,
        minHeight: "100vh",
        color: TEXT,
        fontFamily: "'Inter',system-ui,-apple-system,sans-serif",
        overflowX: "hidden",
      }}
    >
      <style>{STYLES}</style>
      <Nav />
      <Hero />
      <Tracks />
      <HowItWorks />
      <Community />
      <Plans />
      <Footer />
    </div>
  );
}
