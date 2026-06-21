import { useState, useEffect, useRef } from "react";
import { SplineScene } from "./components/SplineScene";
import { PricingTable } from "./components/ui/pricing-table";
import { Accordion, AccordionItem, AccordionTrigger, AccordionContent } from "./components/ui/accordion";
import { Navbar } from "./components/ui/navbar";

/* ─────────────────────────────────────────────────────────────
   NEXTGEN — redesigned marketing page (visual layer only).
   Tokens confirmed against the logo: violet #7C3AED, coral #EB97A0,
   lavender glow #A78BFA, bg #120A24 → #0B0612.
   The purple→coral gradient appears on exactly ONE element: the H1.
   ───────────────────────────────────────────────────────────── */

const VIOLET = "#7C3AED";
const CORAL = "#EB97A0";
const TEXT = "#ECE8F5";
const MUTED = "#9B8FC0";
const TERT = "#8A81A6";
const HAIR = "1px solid rgba(255,255,255,0.08)";
const SURFACE = "rgba(255,255,255,0.025)";
const H1_GRADIENT = "linear-gradient(105deg, #7C3AED 0%, #7C3AED 46%, #EB97A0 100%)";

const X_URL = "https://x.com/G_NEXTGEN";
const DISCORD_URL = "https://discord.gg/HDgMdVECwF";
const LEARN = "#/learn";

// Spline hero scene. Replace the placeholder with a real scene URL to enable the
// 3D visual on desktop. While the placeholder is present, the static fallback
// renders instead, so the build never depends on a live scene.
const SCENE_URL = "https://prod.spline.design/kZDDjO5HuC9GJUM2/scene.splinecode";
const HAS_REAL_SCENE = SCENE_URL !== "PASTE_YOUR_SPLINE_SCENE_URL_HERE";

// One focus: AI. Three entry points by experience, each running the full ladder
// from Basic to Grandmaster.
const AI_PATHS = [
  { name: "Novice", blurb: "New to AI. Start from your first prompt and build real skills from zero.", days: 90 },
  { name: "Intermediate", blurb: "You know the basics. Go deeper into real AI work you can show.", days: 60 },
  { name: "Advanced", blurb: "Already working with AI. Push to expert and Grandmaster level.", days: 30 },
];
const TIERS = ["Basic", "Pro", "Expert", "Grandmaster"];

const LOOP_STEPS = [
  { n: "01", title: "Learn", desc: "Each day opens with one clear objective and a focused lesson — what to learn today, no filler." },
  { n: "02", title: "Improve", desc: "A specific skill focus pushes you to get better at one thing that compounds over the path." },
  { n: "03", title: "Assignment", desc: "Apply it the same day. Every day ends with real work, not passive watching." },
  { n: "04", title: "Score", desc: "Your work is scored against a clear rubric, with an auto-graded check to confirm you have it." },
];


const FOUNDER_X_URL = "https://x.com/sonofpeace0001";

const prefersReducedMotion =
  typeof window !== "undefined" && window.matchMedia
    ? window.matchMedia("(prefers-reduced-motion: reduce)").matches
    : false;

// True only at the lg breakpoint and up. Used to keep the Spline runtime off
// mobile entirely — the component never mounts below this width, so no 3D
// payload loads on small screens.
function useIsDesktop() {
  const query = "(min-width: 1024px)";
  const [desktop, setDesktop] = useState(
    typeof window !== "undefined" && window.matchMedia ? window.matchMedia(query).matches : false
  );
  useEffect(() => {
    if (typeof window === "undefined" || !window.matchMedia) return;
    const mq = window.matchMedia(query);
    const h = (e) => setDesktop(e.matches);
    mq.addEventListener ? mq.addEventListener("change", h) : mq.addListener(h);
    return () => (mq.removeEventListener ? mq.removeEventListener("change", h) : mq.removeListener(h));
  }, []);
  return desktop;
}

// Lightweight static visual for mobile, reduced-motion, and the
// placeholder-scene case. Reuses the single brand accent gradient only — no new
// color, no glow, no shadow, no second gradient.
function HeroStaticVisual() {
  return (
    <div
      aria-hidden="true"
      style={{
        width: "100%",
        height: "100%",
        minHeight: 280,
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        pointerEvents: "none",
      }}
    >
      <div
        style={{
          width: "min(360px, 78%)",
          aspectRatio: "1 / 1",
          borderRadius: "50%",
          background: H1_GRADIENT,
          opacity: 0.42,
        }}
      />
    </div>
  );
}

// Decides what the hero's secondary slot shows. Spline mounts only on desktop,
// only with a real scene URL, and only when reduced motion is off. Everything
// else falls back to the static visual. Kept at lower visual weight so the
// headline still wins the squint test.
function HeroVisual() {
  const isDesktop = useIsDesktop();
  const useSpline = isDesktop && HAS_REAL_SCENE && !prefersReducedMotion;
  const [sceneLoaded, setSceneLoaded] = useState(false);

  if (!useSpline) {
    return (
      <div className="ng-hero-visual" style={{ position: "relative", width: "100%", height: 540, minHeight: 540, opacity: 0.95 }}>
        <HeroStaticVisual />
      </div>
    );
  }

  return (
    <div className="ng-hero-visual" style={{ position: "relative", width: "100%", height: 540, minHeight: 540, opacity: 0.95 }}>
      {/* Branded placeholder, shown immediately while the 3D scene streams in */}
      <div
        style={{
          position: "absolute",
          inset: 0,
          opacity: sceneLoaded ? 0 : 1,
          transition: "opacity .6s ease",
          pointerEvents: "none",
        }}
      >
        <HeroStaticVisual />
      </div>
      {/* The 3D scene, cross-faded in only once it has actually loaded */}
      <div style={{ position: "absolute", inset: 0, opacity: sceneLoaded ? 1 : 0, transition: "opacity .9s ease" }}>
        <SplineScene scene={SCENE_URL} className="ng-spline" onLoad={() => setSceneLoaded(true)} />
      </div>
    </div>
  );
}

function FadeUp({ children, delay = 0, as: Tag = "div", style }) {
  const ref = useRef(null);
  const [seen, setSeen] = useState(false);
  useEffect(() => {
    if (prefersReducedMotion || !ref.current) return setSeen(true);
    const o = new IntersectionObserver(
      ([e]) => e.isIntersecting && (setSeen(true), o.disconnect()),
      { threshold: 0.15 }
    );
    o.observe(ref.current);
    return () => o.disconnect();
  }, []);
  const anim = prefersReducedMotion
    ? {}
    : {
        opacity: seen ? 1 : 0,
        transform: seen ? "none" : "translateY(14px)",
        transition: `opacity .6s ease ${delay}ms, transform .6s ease ${delay}ms`,
      };
  return (
    <Tag ref={ref} style={{ ...style, ...anim }}>
      {children}
    </Tag>
  );
}

const container = { maxWidth: 1120, margin: "0 auto", padding: "0 24px" };
const eyebrow = {
  fontSize: 13,
  letterSpacing: "0.14em",
  textTransform: "uppercase",
  color: MUTED,
  fontWeight: 500,
};
const h2 = {
  fontFamily: "'Space Grotesk','Inter',sans-serif",
  fontSize: "clamp(28px,3.4vw,40px)",
  fontWeight: 600,
  letterSpacing: "-0.02em",
  color: TEXT,
  lineHeight: 1.15,
};
const body = { fontSize: 17, lineHeight: 1.6, color: TEXT };

function openDiscord() {
  if (typeof window !== "undefined") window.open(DISCORD_URL, "_blank", "noopener,noreferrer");
}

function PrimaryButton({ children, onClick, full }) {
  const [h, setH] = useState(false);
  return (
    <button
      onClick={onClick}
      onMouseEnter={() => setH(true)}
      onMouseLeave={() => setH(false)}
      style={{
        background: VIOLET,
        color: "#fff",
        border: "none",
        borderRadius: 10,
        padding: "13px 24px",
        fontSize: 15,
        fontWeight: 600,
        fontFamily: "inherit",
        cursor: "pointer",
        width: full ? "100%" : "auto",
        filter: h ? "brightness(1.12)" : "none",
        transition: "filter .15s ease",
      }}
    >
      {children}
    </button>
  );
}

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

function Hero() {
  const [seen, setSeen] = useState(prefersReducedMotion);
  useEffect(() => {
    const t = setTimeout(() => setSeen(true), 60);
    return () => clearTimeout(t);
  }, []);
  const item = (d) =>
    prefersReducedMotion
      ? {}
      : {
          opacity: seen ? 1 : 0,
          transform: seen ? "none" : "translateY(12px)",
          transition: `opacity .55s ease ${d}ms, transform .55s ease ${d}ms`,
        };
  return (
    <header className="ng-hero" style={{ position: "relative", overflow: "hidden", paddingTop: 150, paddingBottom: 110 }}>
      {/* single soft lavender glow, top-left, hero only */}
      <div
        aria-hidden="true"
        style={{
          position: "absolute",
          top: -160,
          left: -160,
          width: 720,
          height: 620,
          background: "radial-gradient(circle at center, rgba(167,139,250,0.22), rgba(167,139,250,0) 68%)",
          pointerEvents: "none",
        }}
      />
      <div style={{ ...container, position: "relative" }}>
        <div
          className="ng-hero-grid"
          style={{ display: "grid", gridTemplateColumns: "1fr 1.1fr", gap: 40, alignItems: "center" }}
        >
          <div style={{ maxWidth: 620 }}>
            <p style={{ ...eyebrow, marginBottom: 26, ...item(0) }}>Beginner-friendly AI community</p>
            <h1
              style={{
                fontFamily: "'Space Grotesk','Inter',sans-serif",
                fontSize: "clamp(40px,6.2vw,72px)",
                fontWeight: 600,
                lineHeight: 1.05,
                letterSpacing: "-0.025em",
                margin: "0 0 26px",
                background: H1_GRADIENT,
                WebkitBackgroundClip: "text",
                backgroundClip: "text",
                WebkitTextFillColor: "transparent",
                ...item(70),
              }}
            >
              Get your first real wins with AI.
            </h1>
            <p style={{ ...body, fontSize: 19, color: TEXT, maxWidth: 560, margin: "0 0 38px", ...item(140) }}>
              NEXTGEN is where beginners learn AI by doing. Start from zero in a place where it is safe to not know
              things yet, and get real wins with people doing the work alongside you.
            </p>
            <div style={{ display: "flex", gap: 14, flexWrap: "wrap", alignItems: "center", ...item(210) }}>
              <PrimaryButton onClick={() => (window.location.hash = "#/learn")}>Start Learning</PrimaryButton>
              <a
                href="#tracks"
                style={{ display: "inline-flex", alignItems: "center", gap: 8, color: TEXT, fontSize: 15, fontWeight: 500, textDecoration: "none" }}
              >
                See the paths
                <span style={{ color: CORAL }}>→</span>
              </a>
            </div>
          </div>
          <div className="ng-hero-visual-wrap" style={{ ...item(140) }}>
            <HeroVisual />
          </div>
        </div>
      </div>
    </header>
  );
}

function Section({ id, alt, children, style }) {
  return (
    <section
      id={id}
      className="ng-section"
      style={{
        padding: "104px 0",
        background: alt ? SURFACE : "transparent",
        borderTop: alt ? HAIR : "none",
        borderBottom: alt ? HAIR : "none",
        ...style,
      }}
    >
      <div style={container}>{children}</div>
    </section>
  );
}

function Tracks() {
  return (
    <Section id="tracks">
      <FadeUp>
        <p style={{ ...eyebrow, marginBottom: 14 }}>Learning paths</p>
        <h2 style={{ ...h2, marginBottom: 12, maxWidth: 640 }}>Three ways into AI. Start where you are.</h2>
        <p style={{ ...body, color: MUTED, maxWidth: 560, marginBottom: 52 }}>
          Pick the level that fits you. Every path runs from Basic to Grandmaster, so you decide how deep you go.
        </p>
      </FadeUp>
      <div className="ng-grid-3" style={{ display: "grid", gridTemplateColumns: "repeat(3,1fr)", gap: 20 }}>
        {AI_PATHS.map((p, i) => (
          <FadeUp key={p.name} delay={i * 70}>
            <div
              style={{
                border: HAIR,
                borderRadius: 14,
                padding: 28,
                height: "100%",
                background: "rgba(255,255,255,0.015)",
                display: "flex",
                flexDirection: "column",
              }}
            >
              <h3 style={{ fontFamily: "'Space Grotesk','Inter',sans-serif", fontSize: 24, fontWeight: 600, color: TEXT, margin: "0 0 10px" }}>
                {p.name}
              </h3>
              <p style={{ fontSize: 15, lineHeight: 1.6, color: MUTED, margin: "0 0 24px", flex: 1 }}>{p.blurb}</p>

              <p style={{ ...eyebrow, fontSize: 11, marginBottom: 10 }}>Tiers</p>
              <div style={{ display: "flex", flexWrap: "wrap", gap: 8, marginBottom: 22 }}>
                {TIERS.map((tier) => (
                  <span
                    key={tier}
                    style={{
                      fontSize: 12.5,
                      color: TEXT,
                      border: HAIR,
                      borderRadius: 8,
                      padding: "5px 10px",
                    }}
                  >
                    {tier}
                  </span>
                ))}
              </div>

              <p style={{ ...eyebrow, fontSize: 11, marginBottom: 10 }}>Your path</p>
              <div style={{ display: "flex", justifyContent: "space-between", fontSize: 14, marginBottom: 24 }}>
                <span style={{ color: MUTED }}>Full journey</span>
                <span style={{ color: TEXT, fontWeight: 600 }}>{p.days} days</span>
              </div>

              <a
                href={LEARN}
                style={{ display: "inline-flex", alignItems: "center", gap: 7, color: TEXT, fontSize: 14, fontWeight: 600, textDecoration: "none" }}
              >
                Start {p.name}
                <span style={{ color: CORAL }}>→</span>
              </a>
            </div>
          </FadeUp>
        ))}
      </div>
    </Section>
  );
}

function HowItWorks() {
  return (
    <Section id="how" alt>
      <FadeUp>
        <p style={{ ...eyebrow, marginBottom: 14 }}>How it works</p>
        <h2 style={{ ...h2, marginBottom: 52, maxWidth: 620 }}>One simple loop, every single day.</h2>
      </FadeUp>
      <div className="ng-grid-4" style={{ display: "grid", gridTemplateColumns: "repeat(4,1fr)", gap: 0 }}>
        {LOOP_STEPS.map((s, i) => (
          <FadeUp key={s.n} delay={i * 70}>
            <div
              style={{
                padding: "0 28px",
                borderLeft: i === 0 ? "none" : HAIR,
                height: "100%",
              }}
              className="ng-loop-cell"
            >
              <div style={{ fontSize: 13, fontWeight: 600, color: CORAL, marginBottom: 16, fontVariantNumeric: "tabular-nums" }}>{s.n}</div>
              <h3 style={{ fontSize: 19, fontWeight: 600, color: TEXT, margin: "0 0 10px" }}>{s.title}</h3>
              <p style={{ fontSize: 14.5, lineHeight: 1.6, color: MUTED, margin: 0 }}>{s.desc}</p>
            </div>
          </FadeUp>
        ))}
      </div>
    </Section>
  );
}

// Social proof: exactly two real figures, stated separately (never summed).
// Primary "400+ builders" lives here next to the Join CTA; secondary "500+ on X"
// is in the footer. No other stats, percentages, earnings, or counters.
function Community() {
  return (
    <Section id="community">
      <FadeUp>
        <p style={{ ...eyebrow, marginBottom: 40 }}>Community</p>
      </FadeUp>
      <div className="ng-grid-2" style={{ display: "grid", gridTemplateColumns: "300px 1fr", gap: 56, alignItems: "center" }}>
        <FadeUp>
          <div style={{ width: "100%", maxWidth: 300, border: HAIR, borderRadius: 14, overflow: "hidden", background: "#000" }}>
            <img
              src="/founder.jpg"
              alt="SON OF PEACE, founder of NEXTGEN"
              width="720"
              height="720"
              loading="lazy"
              style={{ width: "100%", height: "auto", display: "block" }}
            />
          </div>
        </FadeUp>
        <FadeUp delay={80}>
          <div style={{ marginBottom: 26 }}>
            <span
              style={{
                fontFamily: "'Space Grotesk','Inter',sans-serif",
                fontSize: 48,
                fontWeight: 600,
                color: VIOLET,
                letterSpacing: "-0.02em",
              }}
            >
              400+
            </span>
            <span style={{ fontSize: 17, color: TEXT, marginLeft: 12 }}>builders in the community</span>
          </div>
          <p style={{ ...eyebrow, marginBottom: 8 }}>Founder</p>
          <h3
            style={{
              fontFamily: "'Space Grotesk','Inter',sans-serif",
              fontSize: 26,
              fontWeight: 600,
              color: TEXT,
              margin: "0 0 14px",
              letterSpacing: "-0.02em",
            }}
          >
            SON OF PEACE
          </h3>
          <p style={{ ...body, color: MUTED, maxWidth: 480, marginBottom: 24 }}>
            SON OF PEACE started NEXTGEN to give people a real path into AI. Not more theory, but skills, a community,
            and opportunities you can actually act on.
          </p>
          <div style={{ display: "flex", gap: 16, flexWrap: "wrap", alignItems: "center" }}>
            <PrimaryButton onClick={openDiscord}>Join the community</PrimaryButton>
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

function Plans() {
  return (
    <Section id="plans" alt>
      <FadeUp>
        <p style={{ ...eyebrow, marginBottom: 14 }}>Plans</p>
        <h2 style={{ ...h2, marginBottom: 12, maxWidth: 640 }}>Start free. Go deeper when you're ready.</h2>
        <p style={{ ...body, color: MUTED, maxWidth: 600, marginBottom: 48 }}>
          Everyone starts free. Elite is earned through contribution, not a subscription.
        </p>
      </FadeUp>

      <FadeUp delay={70}>
        <PricingTable />
      </FadeUp>
    </Section>
  );
}

const FAQ_ITEMS = [
  {
    q: "What is NEXTGEN?",
    a: "NEXTGEN is a beginner-friendly community for learning AI by doing. You start from zero, work through one focused lesson and a real assignment each day, and grow alongside people doing the same. The whole point is getting you real wins with AI.",
  },
  {
    q: "Do I need experience?",
    a: "No. NEXTGEN is built for people starting from zero. The path begins with your first prompt and builds up one step at a time, so you are never expected to already know things. It is a place where it is safe to not know things yet.",
  },
  {
    q: "Is it free?",
    a: "Yes. You can join and learn for free. The core path, the community, and the daily challenges are open to everyone at no cost.",
  },
  {
    q: "What is Elite?",
    a: "Elite is the deeper tier of NEXTGEN. It adds structured roadmaps, early access to programs and tools, direct guidance, priority for paid roles and leadership, Elite-only channels, and more visibility for your work.",
  },
  {
    q: "Can I pay for Elite?",
    a: "No. Elite is not a paid subscription and you cannot buy your way in. It is earned through contribution: showing up, doing the work, and helping the community.",
  },
  {
    q: "Can Elite be lost?",
    a: "Yes. Elite reflects ongoing contribution, so you keep it by staying active. If you step away and stop contributing, it can be lost, and you can earn it back the same way you earned it.",
  },
  {
    q: "Can I get a job or earn from this?",
    a: "NEXTGEN points you toward real opportunities, including paid roles and projects, and Elite members get priority for them. The skills you build are the kind people pay for. The work and the results are still up to you.",
  },
  {
    q: "How do I get started?",
    a: "Join free and start the path from day one. Pick your level, open the first lesson, and do that day's assignment. From there it is one focused day at a time.",
  },
];

function Faq() {
  return (
    <Section id="faq">
      <FadeUp>
        <h2 style={{ ...h2, marginBottom: 28 }}>Questions</h2>
      </FadeUp>
      <FadeUp delay={70}>
        <div style={{ maxWidth: 760, borderTop: HAIR }}>
          <Accordion type="single" collapsible defaultValue="item-0">
            {FAQ_ITEMS.map((item, i) => (
              <AccordionItem key={item.q} value={`item-${i}`}>
                <AccordionTrigger>{item.q}</AccordionTrigger>
                <AccordionContent>{item.a}</AccordionContent>
              </AccordionItem>
            ))}
          </Accordion>
        </div>
      </FadeUp>
    </Section>
  );
}

function Footer() {
  return (
    <footer style={{ borderTop: HAIR, padding: "52px 0" }}>
      <div
        style={{ ...container, display: "flex", flexWrap: "wrap", justifyContent: "space-between", gap: 36 }}
      >
        <div style={{ maxWidth: 280 }}>
          <Logo size={22} />
          <p style={{ fontSize: 14, color: TERT, lineHeight: 1.6, margin: "14px 0 16px" }}>
            The beginner-friendly AI community. Learn by doing, get real wins, and grow with people doing the work.
          </p>
          <div style={{ display: "flex", gap: 12 }}>
            <a href={X_URL} target="_blank" rel="noopener noreferrer" aria-label="NEXTGEN on X" style={{ color: MUTED }}>
              <XIcon />
            </a>
            <a href={DISCORD_URL} target="_blank" rel="noopener noreferrer" aria-label="NEXTGEN on Discord" style={{ color: MUTED }}>
              <DiscordIcon />
            </a>
          </div>
          <p style={{ fontSize: 13, color: TERT, marginTop: 14 }}>
            <span style={{ color: TEXT, fontWeight: 600 }}>500+</span> following on X
          </p>
        </div>
        <div style={{ display: "flex", gap: 56, flexWrap: "wrap" }}>
          <div style={{ display: "flex", flexDirection: "column", gap: 12 }}>
            <span style={{ ...eyebrow, fontSize: 12 }}>Learn</span>
            <a href="#tracks" style={{ fontSize: 14, color: MUTED, textDecoration: "none" }}>Paths</a>
            <a href="#how" style={{ fontSize: 14, color: MUTED, textDecoration: "none" }}>How it works</a>
            <a href="#plans" style={{ fontSize: 14, color: MUTED, textDecoration: "none" }}>Plans</a>
          </div>
          <div style={{ display: "flex", flexDirection: "column", gap: 12 }}>
            <span style={{ ...eyebrow, fontSize: 12 }}>Community</span>
            <a href={LEARN} style={{ fontSize: 14, color: MUTED, textDecoration: "none" }}>Start Learning</a>
            <a href={X_URL} target="_blank" rel="noopener noreferrer" style={{ fontSize: 14, color: MUTED, textDecoration: "none" }}>X</a>
            <a href={DISCORD_URL} target="_blank" rel="noopener noreferrer" style={{ fontSize: 14, color: MUTED, textDecoration: "none" }}>Discord</a>
          </div>
        </div>
      </div>
      <div style={{ ...container, marginTop: 40 }}>
        <p style={{ fontSize: 13, color: TERT, margin: 0 }}>© {new Date().getFullYear()} NEXTGEN. All rights reserved.</p>
      </div>
    </footer>
  );
}

export default function Landing() {
  return (
    <div
      id="top"
      style={{
        background: "linear-gradient(180deg, #120A24 0%, #0B0612 100%)",
        minHeight: "100vh",
        color: TEXT,
        fontFamily: "'Inter',system-ui,-apple-system,sans-serif",
        overflowX: "hidden",
      }}
    >
      <style>{`
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
        html{scroll-behavior:smooth}
        a:hover{color:#ECE8F5}
        .ng-spline{width:100% !important;height:100% !important;display:block !important}
        .ng-spline canvas{width:100% !important;height:100% !important;display:block !important}
        @media (max-width:820px){
          .ng-navlinks{display:none !important}
          .ng-burger{display:block !important}
          .ng-hero-grid{grid-template-columns:1fr !important;gap:24px !important}
          .ng-hero-visual{height:auto !important;min-height:240px !important;opacity:0.85 !important}
          .ng-grid-2{grid-template-columns:1fr !important;gap:32px !important}
          .ng-grid-3{grid-template-columns:1fr !important}
          .ng-grid-4{grid-template-columns:1fr !important}
          .ng-loop-cell{border-left:none !important;border-top:1px solid rgba(255,255,255,0.08);padding:24px 0 !important}
          .ng-plan-head,.ng-plan-row{grid-template-columns:1fr 56px 56px !important}
          .ng-section{padding:68px 0 !important}
          .ng-hero{padding-top:118px !important;padding-bottom:72px !important}
        }
        @media (prefers-reduced-motion: reduce){*{animation:none !important;transition:none !important}}
      `}</style>
      <Navbar />
      <Hero />
      <Tracks />
      <HowItWorks />
      <Community />
      <Plans />
      <Faq />
      <Footer />
    </div>
  );
}
