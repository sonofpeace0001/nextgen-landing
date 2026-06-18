import { ArrowRight } from "lucide-react";
import { TEXT, eyebrow } from "./theme.js";
import { TRACKS, TIERS, LEVELS, LEARN } from "./data.js";
import Section from "./Section.jsx";
import FadeUp from "./FadeUp.jsx";

export default function Tracks() {
  return (
    <Section id="tracks">
      <FadeUp>
        <p style={{ ...eyebrow, marginBottom: 14 }}>Learning tracks</p>
        <h2
          style={{
            fontFamily: "'Space Grotesk','Inter',sans-serif",
            fontSize: "clamp(28px,3.4vw,44px)",
            fontWeight: 600,
            letterSpacing: "-0.025em",
            color: TEXT,
            lineHeight: 1.12,
            marginBottom: 14,
            maxWidth: 640,
          }}
        >
          Three paths into the new tech economy.
        </h2>
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
              <p style={{ fontSize: 15, lineHeight: 1.6, color: "rgba(255,255,255,0.4)", margin: "0 0 28px", flex: 1 }}>
                {t.blurb}
              </p>

              <p style={{ ...eyebrow, fontSize: 11, marginBottom: 10 }}>Tiers</p>
              <div style={{ display: "flex", flexWrap: "wrap", gap: 8, marginBottom: 22 }}>
                {TIERS.map((tier) => (
                  <span
                    key={tier}
                    style={{
                      fontSize: 12, color: TEXT,
                      border: "1px solid rgba(255,255,255,0.08)",
                      borderRadius: 8, padding: "5px 10px",
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
                  display: "inline-flex", alignItems: "center", gap: 7,
                  color: TEXT, fontSize: 14, fontWeight: 600, textDecoration: "none",
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
