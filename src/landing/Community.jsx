import { TEXT, VIOLET, CORAL, MUTED, eyebrow } from "./theme.js";
import { DISCORD_URL, FOUNDER_X_URL } from "./data.js";
import { XIcon } from "./Icons.jsx";
import Section from "./Section.jsx";
import FadeUp from "./FadeUp.jsx";
import GlowButton from "./GlowButton.jsx";

export default function Community() {
  const openDiscord = () => {
    if (typeof window !== "undefined") window.open(DISCORD_URL, "_blank", "noopener,noreferrer");
  };

  return (
    <Section id="community">
      <FadeUp>
        <p style={{ ...eyebrow, marginBottom: 40 }}>Community</p>
      </FadeUp>

      <div
        className="ng-grid-2"
        style={{ display: "grid", gridTemplateColumns: "300px 1fr", gap: 56, alignItems: "center" }}
      >
        <FadeUp>
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
            <GlowButton onClick={openDiscord}>Join the community</GlowButton>
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
