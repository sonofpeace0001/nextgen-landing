import { useState, useEffect } from "react";
import { Circle, ArrowRight } from "lucide-react";
import { TEXT, TERT, CORAL, BG, container, prefersReducedMotion } from "./theme.js";
import { DISPLAY_CARDS_DATA } from "./data.js";
import ElegantShape from "./ElegantShape.jsx";
import GlowButton from "./GlowButton.jsx";

function DisplayCards() {
  return (
    <div className="ng-display-stack" style={{ minHeight: 320 }}>
      {DISPLAY_CARDS_DATA.map((card, i) => (
        <div key={i} className={`ng-display-card ng-display-card-${i}`}>
          <div style={{ display: "flex", alignItems: "center", gap: 10, position: "relative", zIndex: 2 }}>
            <span
              style={{
                display: "inline-flex",
                alignItems: "center",
                justifyContent: "center",
                width: 28, height: 28,
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
  );
}

export default function Hero() {
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
          position: "absolute", inset: 0,
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
          style={{ display: "grid", gridTemplateColumns: "1fr auto", gap: 64, alignItems: "center" }}
        >
          {/* Left — text */}
          <div style={{ maxWidth: 640 }}>
            {/* Badge */}
            <div
              style={{
                display: "inline-flex", alignItems: "center", gap: 8,
                padding: "5px 14px", borderRadius: 9999,
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
              <span style={{
                background: "linear-gradient(to bottom, #ffffff, rgba(255,255,255,0.80))",
                WebkitBackgroundClip: "text", backgroundClip: "text", WebkitTextFillColor: "transparent",
              }}>
                Learn the skills
              </span>
              <br />
              <span style={{
                background: "linear-gradient(to right, #818CF8, rgba(255,255,255,0.9), #FB7185)",
                WebkitBackgroundClip: "text", backgroundClip: "text", WebkitTextFillColor: "transparent",
              }}>
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
                  display: "inline-flex", alignItems: "center", gap: 8,
                  color: TEXT, fontSize: 15, fontWeight: 500, textDecoration: "none", padding: "13px 4px",
                }}
              >
                Explore tracks
                <ArrowRight size={16} style={{ color: CORAL }} />
              </a>
            </div>
          </div>

          {/* Right — display cards */}
          <div style={{ ...fadeUp(1200) }}>
            <DisplayCards />
          </div>
        </div>
      </div>

      {/* Top & bottom fade */}
      <div
        aria-hidden="true"
        style={{
          position: "absolute", inset: 0,
          background: `linear-gradient(to bottom, ${BG} 0%, transparent 15%, transparent 85%, ${BG} 100%)`,
          pointerEvents: "none",
        }}
      />
    </header>
  );
}
