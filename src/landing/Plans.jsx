import { Check } from "lucide-react";
import { TEXT, VIOLET, CORAL, TERT, HAIR, eyebrow, h2Style } from "./theme.js";
import { COMPARISON_ROWS, DISCORD_URL } from "./data.js";
import Section from "./Section.jsx";
import FadeUp from "./FadeUp.jsx";
import GlowButton from "./GlowButton.jsx";
import GhostButton from "./GhostButton.jsx";

export default function Plans() {
  const openDiscord = () => {
    if (typeof window !== "undefined") window.open(DISCORD_URL, "_blank", "noopener,noreferrer");
  };

  return (
    <Section id="plans" alt>
      <FadeUp>
        <p style={{ ...eyebrow, marginBottom: 14 }}>Plans</p>
        <h2 style={{ ...h2Style, marginBottom: 14, maxWidth: 640 }}>
          Free is the foundation. Elite is the accelerator.
        </h2>
        <p style={{ fontSize: 16, color: "rgba(255,255,255,0.35)", maxWidth: 560, marginBottom: 48, lineHeight: 1.6, fontWeight: 300 }}>
          Start free and learn for real. Elite is the premium tier — earned through contribution, not just bought — for
          faster growth, deeper access, and real execution.
        </p>
      </FadeUp>

      <FadeUp delay={80}>
        <div className="ng-glow-border">
          <div className="ng-glow-border-inner" style={{ borderRadius: 14 }}>
            {/* Header */}
            <div
              className="ng-plan-head"
              style={{
                display: "grid",
                gridTemplateColumns: "1fr 132px 132px",
                gap: 16, padding: "18px 24px",
                borderBottom: HAIR,
                background: "rgba(255,255,255,0.02)",
              }}
            >
              <span />
              <span style={{ textAlign: "center", fontSize: 14, fontWeight: 600, color: TEXT }}>NEXTGEN</span>
              <span
                style={{
                  textAlign: "center", fontSize: 14, fontWeight: 600,
                  background: `linear-gradient(to right, ${VIOLET}, ${CORAL})`,
                  WebkitBackgroundClip: "text", backgroundClip: "text", WebkitTextFillColor: "transparent",
                }}
              >
                Elite
              </span>
            </div>

            {/* Rows */}
            {COMPARISON_ROWS.map((r, i) => (
              <div
                key={i}
                className="ng-plan-row"
                style={{
                  display: "grid",
                  gridTemplateColumns: "1fr 132px 132px",
                  gap: 16, alignItems: "center",
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
          <GlowButton onClick={openDiscord}>Apply for Elite</GlowButton>
          <GhostButton onClick={() => (window.location.hash = "#/learn")}>Start free</GhostButton>
        </div>
      </FadeUp>
    </Section>
  );
}
