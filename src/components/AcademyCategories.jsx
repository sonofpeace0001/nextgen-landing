import { useEffect, useRef, useState } from "react";
import { Palette, PenLine, Blocks, Bot, Clapperboard, Shapes, AudioLines, Search, Briefcase, ArrowRight } from "lucide-react";
import { rememberGoal } from "../lib/goalTracks.js";

// NEXTGEN Academy: one card per goal category. Copy is honest about what a member
// builds; every track runs Basic to Grandmaster (90 days) after Foundations.
const CATEGORIES = [
  { id: "graphics", icon: Palette, name: "Graphics & design", text: "Make posters, brand kits and campaigns that look professional.", makes: "A three-graphic social set and a brand kit" },
  { id: "content", icon: PenLine, name: "Content & writing", text: "Write in a voice people recognise, and fact-check like a pro.", makes: "A published article and a content system" },
  { id: "apps", icon: Blocks, name: "Apps & tools", text: "Turn a real problem into a working tool without writing code.", makes: "A tool a real person uses" },
  { id: "agents", icon: Bot, name: "AI agents & automation", text: "Build agents that handle repetitive work, with you in control.", makes: "A supervised agent that saves you hours" },
  { id: "film", icon: Clapperboard, name: "AI film & video", text: "Plan, direct and edit short films with camera angles and lighting that work.", makes: "A 60-second short or promo" },
  { id: "motion", icon: Shapes, name: "Motion graphics", text: "Animate titles, logos and explainers with clean, purposeful movement.", makes: "An animated brand package" },
  { id: "audio", icon: AudioLines, name: "Audio, music & voice", text: "Narrate, score and mix audio, with consent and rights done right.", makes: "A narrated, mastered audio piece" },
  { id: "research", icon: Search, name: "Research & data", text: "Find, verify and explain the evidence behind a decision.", makes: "A sourced briefing with charts" },
  { id: "business", icon: Briefcase, name: "Earning with AI skills", text: "Package a skill into an offer, win clients and deliver honestly.", makes: "An offer page and your first clients plan" },
];

const prefersReducedMotion =
  typeof window !== "undefined" && window.matchMedia ? window.matchMedia("(prefers-reduced-motion: reduce)").matches : false;

function Reveal({ children, delay = 0 }) {
  const ref = useRef(null);
  const [seen, setSeen] = useState(prefersReducedMotion);
  useEffect(() => {
    if (prefersReducedMotion || !ref.current) return;
    const o = new IntersectionObserver(([e]) => e.isIntersecting && (setSeen(true), o.disconnect()), { threshold: 0.12 });
    o.observe(ref.current);
    return () => o.disconnect();
  }, []);
  return (
    <div
      ref={ref}
      style={prefersReducedMotion ? undefined : { opacity: seen ? 1 : 0, transform: seen ? "none" : "translateY(14px)", transition: `opacity .55s ease ${delay}ms, transform .55s ease ${delay}ms`, height: "100%" }}
    >
      {children}
    </div>
  );
}

export function AcademyCategories() {
  return (
    <section id="academy" className="ng-section" style={{ padding: "104px 0" }}>
      <div style={{ maxWidth: 1120, margin: "0 auto", padding: "0 24px" }}>
        <p style={{ fontSize: 13, letterSpacing: "0.14em", textTransform: "uppercase", color: "var(--muted-foreground)", fontWeight: 500, marginBottom: 14 }}>
          NEXTGEN Academy
        </p>
        <h2 style={{ fontFamily: "'Playfair Display',Georgia,serif", fontSize: "clamp(28px,3.4vw,40px)", fontWeight: 600, letterSpacing: "-0.02em", color: "var(--foreground)", lineHeight: 1.15, marginBottom: 12, maxWidth: 640 }}>
          Pick what you want to build.
        </h2>
        <p style={{ fontSize: 17, lineHeight: 1.6, color: "var(--muted-foreground)", maxWidth: 600, marginBottom: 48 }}>
          Foundations is free for everyone. Every category path then unlocks with Elite or an access code and runs from Basic to Grandmaster, with extra Skill Labs for the skills clients ask for. Each ends with something real you made, scored with clear feedback.
        </p>
        <div className="ng-acad-grid" style={{ display: "grid", gridTemplateColumns: "repeat(3,1fr)", gap: 18 }}>
          {CATEGORIES.map((c, i) => {
            const Icon = c.icon;
            return (
              <Reveal key={c.id} delay={(i % 3) * 70}>
                <a
                  href="#/learn"
                  onClick={() => rememberGoal(c.id)}
                  className="ng-acad-card"
                  style={{
                    display: "flex", flexDirection: "column", height: "100%", textDecoration: "none", color: "inherit",
                    border: "1px solid var(--border)", borderRadius: 14, padding: 24,
                    background: "color-mix(in srgb, var(--foreground) 2.5%, transparent)",
                  }}
                >
                  <span style={{ width: 42, height: 42, borderRadius: 11, display: "grid", placeItems: "center", background: "color-mix(in srgb, var(--primary) 14%, transparent)", color: "var(--primary)", marginBottom: 16 }}>
                    <Icon size={21} aria-hidden="true" />
                  </span>
                  <h3 style={{ fontFamily: "'Playfair Display',Georgia,serif", fontSize: 21, fontWeight: 600, color: "var(--foreground)", margin: "0 0 8px" }}>{c.name}</h3>
                  <p style={{ fontSize: 15, lineHeight: 1.55, color: "var(--muted-foreground)", margin: "0 0 14px", flex: 1 }}>{c.text}</p>
                  <p style={{ fontSize: 13, color: "var(--muted-foreground)", margin: "0 0 16px" }}>
                    <span style={{ color: "var(--foreground)", fontWeight: 600 }}>You will make: </span>
                    {c.makes}
                  </p>
                  <span style={{ display: "inline-flex", alignItems: "center", gap: 6, fontSize: 14, fontWeight: 600, color: "var(--foreground)" }}>
                    Start this path <ArrowRight size={15} aria-hidden="true" style={{ color: "#EB97A0" }} />
                  </span>
                </a>
              </Reveal>
            );
          })}
        </div>
      </div>
      <style>{`
        .ng-acad-card{transition:border-color .2s ease, transform .2s ease}
        .ng-acad-card:hover{border-color:var(--primary);transform:translateY(-2px)}
        @media (max-width:980px){.ng-acad-grid{grid-template-columns:repeat(2,1fr) !important}}
        @media (max-width:620px){.ng-acad-grid{grid-template-columns:1fr !important}}
        @media (prefers-reduced-motion: reduce){.ng-acad-card{transition:none}.ng-acad-card:hover{transform:none}}
      `}</style>
    </section>
  );
}
