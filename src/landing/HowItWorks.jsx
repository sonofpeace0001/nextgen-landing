import { TEXT, VIOLET, CORAL, eyebrow, h2Style } from "./theme.js";
import { LOOP_STEPS } from "./data.js";
import Section from "./Section.jsx";
import FadeUp from "./FadeUp.jsx";

export default function HowItWorks() {
  return (
    <Section id="how" alt>
      <FadeUp>
        <p style={{ ...eyebrow, marginBottom: 14 }}>How it works</p>
        <h2 style={{ ...h2Style, marginBottom: 56, maxWidth: 620 }}>
          One simple loop, every single day.
        </h2>
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
