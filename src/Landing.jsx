import { useState, useEffect, useRef } from "react";
import { Check, Menu, X } from "lucide-react";

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

const TRACKS = [
  { name: "Freelancing", blurb: "Turn a skill into paid client work, then scale it into a business." },
  { name: "Web3", blurb: "From wallets and self-custody to building and earning on-chain." },
  { name: "AI", blurb: "Every practical AI skill — from your first prompt to shipping agents and selling the work." },
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

const FOUNDER_X_URL = "https://x.com/sonofpeace0001";

const NAV_LINKS = [
  { label: "Freelancing", href: "#tracks" },
  { label: "Web3", href: "#tracks" },
  { label: "AI", href: "#tracks" },
  { label: "Plans", href: "#plans" },
];

const prefersReducedMotion =
  typeof window !== "undefined" && window.matchMedia
    ? window.matchMedia("(prefers-reduced-motion: reduce)").matches
    : false;

function useScrolled(threshold = 32) {
  const [s, setS] = useState(false);
  useEffect(() => {
    const h = () => setS(window.scrollY > threshold);
    window.addEventListener("scroll", h, { passive: true });
    return () => window.removeEventListener("scroll", h);
  }, [threshold]);
  return s;
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
        transition: "border-color .15s ease, background .15s ease",
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
        background: scrolled ? "rgba(11,6,18,0.85)" : "transparent",
        backdropFilter: scrolled ? "saturate(140%) blur(8px)" : "none",
        borderBottom: scrolled ? HAIR : "1px solid transparent",
        transition: "background .2s ease, border-color .2s ease",
      }}
    >
      <div style={{ ...container, display: "flex", alignItems: "center", justifyContent: "space-between", height: 66 }}>
        <a href="#top" style={{ textDecoration: "none" }}>
          <Logo />
        </a>
        <div className="ng-navlinks" style={{ display: "flex", alignItems: "center", gap: 30 }}>
          {NAV_LINKS.map((l) => (
            <a key={l.label} href={l.href} style={{ fontSize: 15, color: MUTED, textDecoration: "none" }}>
              {l.label}
            </a>
          ))}
          <a href={LEARN} style={{ fontSize: 15, color: MUTED, textDecoration: "none" }}>
            Login
          </a>
          <PrimaryButton onClick={() => (window.location.hash = "#/learn")}>Start Learning</PrimaryButton>
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
          className="ng-mobilemenu"
          style={{ background: "#0E0820", borderBottom: HAIR, padding: "16px 24px 24px", display: "flex", flexDirection: "column", gap: 16 }}
        >
          {NAV_LINKS.map((l) => (
            <a key={l.label} href={l.href} onClick={() => setOpen(false)} style={{ color: MUTED, fontSize: 16, textDecoration: "none" }}>
              {l.label}
            </a>
          ))}
          <a href={LEARN} onClick={() => setOpen(false)} style={{ color: MUTED, fontSize: 16, textDecoration: "none" }}>
            Login
          </a>
          <PrimaryButton full onClick={() => (window.location.hash = "#/learn")}>Start Learning</PrimaryButton>
        </div>
      )}
    </nav>
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
        <div style={{ maxWidth: 760 }}>
          <p style={{ ...eyebrow, marginBottom: 26, ...item(0) }}>The future-skills community</p>
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
            Learn the skills the next economy is actually paying for.
          </h1>
          <p style={{ ...body, fontSize: 19, color: TEXT, maxWidth: 560, margin: "0 0 38px", ...item(140) }}>
            NEXTGEN is where builders show up. AI, Web3, content, freelancing — practical skills with a community that is
            doing the work alongside you.
          </p>
          <div style={{ display: "flex", gap: 14, flexWrap: "wrap", alignItems: "center", ...item(210) }}>
            <PrimaryButton onClick={() => (window.location.hash = "#/learn")}>Start Learning</PrimaryButton>
            <a
              href="#tracks"
              style={{ display: "inline-flex", alignItems: "center", gap: 8, color: TEXT, fontSize: 15, fontWeight: 500, textDecoration: "none" }}
            >
              Explore tracks
              <span style={{ color: CORAL }}>→</span>
            </a>
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
        <p style={{ ...eyebrow, marginBottom: 14 }}>Learning tracks</p>
        <h2 style={{ ...h2, marginBottom: 12, maxWidth: 640 }}>Three paths into the new tech economy.</h2>
        <p style={{ ...body, color: MUTED, maxWidth: 560, marginBottom: 52 }}>
          Pick a track and a level. Every track runs from Basic to Grandmaster — choose how deep you go.
        </p>
      </FadeUp>
      <div className="ng-grid-3" style={{ display: "grid", gridTemplateColumns: "repeat(3,1fr)", gap: 20 }}>
        {TRACKS.map((t, i) => (
          <FadeUp key={t.name} delay={i * 70}>
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
                {t.name}
              </h3>
              <p style={{ fontSize: 15, lineHeight: 1.6, color: MUTED, margin: "0 0 24px", flex: 1 }}>{t.blurb}</p>

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

              <p style={{ ...eyebrow, fontSize: 11, marginBottom: 10 }}>Choose your level</p>
              <div style={{ display: "flex", flexDirection: "column", gap: 8, marginBottom: 24 }}>
                {LEVELS.map((lv) => (
                  <div key={lv.name} style={{ display: "flex", justifyContent: "space-between", fontSize: 14 }}>
                    <span style={{ color: MUTED }}>{lv.name}</span>
                    <span style={{ color: TEXT, fontWeight: 600 }}>{lv.days} days</span>
                  </div>
                ))}
              </div>

              <a
                href={LEARN}
                style={{ display: "inline-flex", alignItems: "center", gap: 7, color: TEXT, fontSize: 14, fontWeight: 600, textDecoration: "none" }}
              >
                Start {t.name}
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
            SON OF PEACE started NEXTGEN to give people a real path into the new tech economy — not more theory, but
            skills, a community, and opportunities you can actually act on.
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
        <h2 style={{ ...h2, marginBottom: 12, maxWidth: 640 }}>Free is the foundation. Elite is the accelerator.</h2>
        <p style={{ ...body, color: MUTED, maxWidth: 600, marginBottom: 48 }}>
          Start free and learn for real. Elite is the premium tier — earned through contribution, not just bought — for
          faster growth, deeper access, and real execution.
        </p>
      </FadeUp>

      <FadeUp delay={70}>
        <div style={{ border: HAIR, borderRadius: 14, overflow: "hidden" }}>
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
            <span style={{ textAlign: "center", fontSize: 14, fontWeight: 600, color: CORAL }}>Elite</span>
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
                padding: "13px 24px",
                borderBottom: i < COMPARISON_ROWS.length - 1 ? "1px solid rgba(255,255,255,0.05)" : "none",
              }}
            >
              <span style={{ fontSize: 14.5, color: MUTED }}>{r.label}</span>
              <span style={{ display: "flex", justifyContent: "center" }}>
                {r.free ? <Check size={16} style={{ color: VIOLET }} /> : <span style={{ color: TERT }}>—</span>}
              </span>
              <span style={{ display: "flex", justifyContent: "center" }}>
                <Check size={16} style={{ color: CORAL }} />
              </span>
            </div>
          ))}
        </div>
      </FadeUp>

      <FadeUp delay={120}>
        <div style={{ display: "flex", gap: 14, flexWrap: "wrap", marginTop: 32 }}>
          <PrimaryButton onClick={openDiscord}>Apply for Elite</PrimaryButton>
          <GhostButton onClick={() => (window.location.hash = "#/learn")}>Start free</GhostButton>
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
            The future-skills community. Build, earn, and grow in the new tech economy.
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
            <a href="#tracks" style={{ fontSize: 14, color: MUTED, textDecoration: "none" }}>Tracks</a>
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
        @media (max-width:820px){
          .ng-navlinks{display:none !important}
          .ng-burger{display:block !important}
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
