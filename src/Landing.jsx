import { useState, useEffect, useRef } from "react";
import { PricingTable } from "./components/ui/pricing-table";
import { Accordion, AccordionItem, AccordionTrigger, AccordionContent } from "./components/ui/accordion";
import { Navbar } from "./components/ui/navbar";
import { Footer } from "./components/ui/footer";
import { WhatYouGet } from "./components/ui/what-you-get";
import { Testimonials } from "./components/ui/testimonials";
import { Hero } from "./components/Hero";
import { VipSection } from "./components/VipSection";
import { TrustStrip } from "./components/TrustStrip";
import { HowItWorksSection } from "./components/HowItWorksSection";
import { CommunityShowcase } from "./components/CommunityShowcase";

/* ─────────────────────────────────────────────────────────────
   NEXTGEN — redesigned marketing page (visual layer only).
   Tokens confirmed against the logo: violet #7C3AED, coral #EB97A0,
   lavender glow #A78BFA, bg #120A24 → #0B0612.
   The purple→coral gradient appears on exactly ONE element: the H1.
   ───────────────────────────────────────────────────────────── */

const VIOLET = "var(--primary)";
const CORAL = "#EB97A0";
const TEXT = "var(--foreground)";
const MUTED = "var(--muted-foreground)";
const HAIR = "1px solid var(--border)";
const SURFACE = "color-mix(in srgb, var(--foreground) 2.5%, transparent)";
const H1_GRADIENT = "linear-gradient(105deg, var(--primary) 0%, var(--primary) 46%, #EB97A0 100%)";

const X_URL = "https://x.com/G_NEXTGEN";
const DISCORD_URL = "https://discord.gg/HDgMdVECwF";
const LEARN = "#/learn";

// One focus: AI. Three entry points by experience, each running the full ladder
// from Basic to Grandmaster.
const AI_PATHS = [
  { name: "Novice", blurb: "New to AI. Start from your first prompt and build real skills from zero.", days: 90, featured: true },
  { name: "Intermediate", blurb: "You know the basics. Go deeper into real AI work you can show.", days: 60 },
  { name: "Advanced", blurb: "Already working with AI. Push to expert and Grandmaster level.", days: 30 },
];
const TIERS = ["Basic", "Pro", "Expert", "Grandmaster"];

// External partner resources, shown as link-out cards. First live card is the
// Graphics Learning Academy; additional cards will be added here as more
// partner resources launch.
const PARTNER_RESOURCES = [
  {
    tag: "AI GRAPHIC DESIGN ACADEMY",
    name: "NEXTGEN Graphics Learning Academy",
    blurb: "A free, beginner-friendly course on AI graphic design — prompts, characters, campaigns and professional design principles.",
    href: "https://next-gen-graphics-learning-academy.vercel.app/",
    live: true,
  },
  {
    tag: "MORE COMING SOON",
    name: "New resource",
    blurb: "Another partner resource is on the way. Check back soon.",
    href: null,
    live: false,
  },
];

const FOUNDER_X_URL = "https://x.com/sonofpeace0001";

const prefersReducedMotion =
  typeof window !== "undefined" && window.matchMedia
    ? window.matchMedia("(prefers-reduced-motion: reduce)").matches
    : false;

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
  fontFamily: "'Playfair Display',Georgia,serif",
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

function XIcon({ size = 16 }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="currentColor" aria-hidden="true">
      <path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z" />
    </svg>
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
                position: "relative",
                border: p.featured ? `1px solid ${VIOLET}` : HAIR,
                borderRadius: 14,
                padding: 28,
                height: "100%",
                background: p.featured ? "color-mix(in srgb, var(--primary) 7%, transparent)" : SURFACE,
                display: "flex",
                flexDirection: "column",
              }}
            >
              {p.featured && (
                <span
                  style={{
                    position: "absolute",
                    top: -12,
                    left: 24,
                    fontSize: 11,
                    fontWeight: 700,
                    letterSpacing: "0.06em",
                    color: "#fff",
                    background: VIOLET,
                    borderRadius: 999,
                    padding: "4px 12px",
                  }}
                >
                  RECOMMENDED
                </span>
              )}
              <h3 style={{ fontFamily: "'Playfair Display',Georgia,serif", fontSize: 24, fontWeight: 600, color: TEXT, margin: "0 0 10px" }}>
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

              {p.featured ? (
                <a
                  href={LEARN}
                  style={{
                    display: "inline-flex",
                    alignItems: "center",
                    justifyContent: "center",
                    gap: 7,
                    background: VIOLET,
                    color: "#fff",
                    fontSize: 14,
                    fontWeight: 600,
                    textDecoration: "none",
                    borderRadius: 10,
                    padding: "11px 18px",
                  }}
                >
                  Start {p.name}
                  <span>→</span>
                </a>
              ) : (
                <a
                  href={LEARN}
                  style={{ display: "inline-flex", alignItems: "center", gap: 7, color: TEXT, fontSize: 14, fontWeight: 600, textDecoration: "none" }}
                >
                  Start {p.name}
                  <span style={{ color: CORAL }}>→</span>
                </a>
              )}
            </div>
          </FadeUp>
        ))}
      </div>
    </Section>
  );
}

// Partner resources: external link-out cards, starting with the AI Graphic
// Design Academy. Built to grow — add more entries to PARTNER_RESOURCES and
// this grid picks them up automatically.
function Resources() {
  return (
    <Section id="resources" alt>
      <FadeUp>
        <p style={{ ...eyebrow, marginBottom: 14 }}>Partner resources</p>
        <h2 style={{ ...h2, marginBottom: 12, maxWidth: 640 }}>Free resources to go deeper.</h2>
        <p style={{ ...body, color: MUTED, maxWidth: 560, marginBottom: 52 }}>
          Extra, free training from the NEXTGEN network — more cards land here as new resources ship.
        </p>
      </FadeUp>
      <div className="ng-grid-3" style={{ display: "grid", gridTemplateColumns: "repeat(3,1fr)", gap: 20 }}>
        {PARTNER_RESOURCES.map((r, i) => {
          const CardTag = r.live ? "a" : "div";
          return (
            <FadeUp key={r.name} delay={i * 70}>
              <CardTag
                {...(r.live ? { href: r.href, target: "_blank", rel: "noopener noreferrer" } : {})}
                style={{
                  position: "relative",
                  display: "flex",
                  flexDirection: "column",
                  height: "100%",
                  border: HAIR,
                  borderRadius: 14,
                  padding: 28,
                  background: SURFACE,
                  textDecoration: "none",
                  color: "inherit",
                  opacity: r.live ? 1 : 0.6,
                  cursor: r.live ? "pointer" : "default",
                  transition: "border-color .15s ease, transform .15s ease",
                }}
                onMouseEnter={(e) => r.live && (e.currentTarget.style.borderColor = VIOLET)}
                onMouseLeave={(e) => r.live && (e.currentTarget.style.borderColor = "var(--border)")}
              >
                <span
                  style={{
                    display: "inline-block",
                    alignSelf: "flex-start",
                    fontFamily: "'Montserrat',system-ui,-apple-system,sans-serif",
                    fontSize: 11,
                    fontWeight: 800,
                    letterSpacing: "0.08em",
                    color: r.live ? "#fff" : TEXT,
                    background: r.live ? VIOLET : "transparent",
                    border: r.live ? "none" : HAIR,
                    borderRadius: 999,
                    padding: "5px 12px",
                    marginBottom: 18,
                  }}
                >
                  {r.tag}
                </span>
                <h3 style={{ fontFamily: "'Playfair Display',Georgia,serif", fontSize: 22, fontWeight: 600, color: TEXT, margin: "0 0 10px" }}>
                  {r.name}
                </h3>
                <p style={{ fontSize: 15, lineHeight: 1.6, color: MUTED, margin: "0 0 24px", flex: 1 }}>{r.blurb}</p>
                {r.live && (
                  <span style={{ display: "inline-flex", alignItems: "center", gap: 7, color: TEXT, fontSize: 14, fontWeight: 600 }}>
                    Visit the academy
                    <span style={{ color: CORAL }}>→</span>
                  </span>
                )}
              </CardTag>
            </FadeUp>
          );
        })}
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
                fontFamily: "'Montserrat',system-ui,-apple-system,sans-serif",
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
              fontFamily: "'Playfair Display',Georgia,serif",
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
      <FadeUp delay={100}>
        <p style={{ fontSize: 13, color: MUTED, marginTop: 18 }}>
          want 1-on-1 with the founder?{" "}
          <a href="#vip" style={{ color: MUTED, textDecoration: "underline" }}>
            see NEXTGEN VIP below
          </a>
          .
        </p>
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
  {
    q: "What's the difference between Elite and VIP?",
    a: "Elite is a recognition tier you earn by contributing to the community. It can't be bought. VIP is a paid 8-week 1-on-1 program with the founder for people who want the fast track. Different things: one is earned status, the other is paid direct guidance.",
  },
  {
    q: "What do I get in VIP?",
    a: "Eight weeks of 1-on-1. Two live 45-minute calls a month, async feedback on your work between calls, and a clear path from zero to building real things with AI. $150 one-time, 8 seats per intake, everyone starts together.",
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

export default function Landing() {
  // Scroll to an in-page anchor on first mount when arriving from a different
  // top-level app (e.g. the Prompts library's "how do I become Elite?" link,
  // which sets the hash to #plans before this component exists). Plain
  // in-page anchor clicks already work natively once Landing is mounted.
  useEffect(() => {
    const id = window.location.hash.replace(/^#/, "");
    if (!id || id.startsWith("/")) return;
    const el = document.getElementById(id);
    if (el) el.scrollIntoView({ block: "start" });
  }, []);

  return (
    <>
      <div
        id="top"
        style={{
          minHeight: "100vh",
          color: TEXT,
          fontFamily: "'Inter',system-ui,-apple-system,sans-serif",
          overflowX: "hidden",
        }}
      >
      <style>{`
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
        html{scroll-behavior:smooth}
        a:hover{color:var(--foreground)}
        a[class*="bg-primary"]:hover{color:var(--primary-foreground)}
        @media (max-width:820px){
          .ng-navlinks{display:none !important}
          .ng-burger{display:block !important}
          .ng-grid-2{grid-template-columns:1fr !important;gap:32px !important}
          .ng-grid-3{grid-template-columns:1fr !important}
          .ng-plan-head,.ng-plan-row{grid-template-columns:1fr 56px 56px !important}
          .ng-section{padding:68px 0 !important}
        }
        @media (prefers-reduced-motion: reduce){*{animation:none !important;transition:none !important}}
      `}</style>
      <Navbar />
      <Hero />
      <TrustStrip />
      <HowItWorksSection />
      <Tracks />
      <Resources />
      <WhatYouGet />
      <CommunityShowcase />
      <Community />
      <Testimonials />
      <Plans />
      <VipSection />
      <Faq />
      <Footer />
      </div>
    </>
  );
}
