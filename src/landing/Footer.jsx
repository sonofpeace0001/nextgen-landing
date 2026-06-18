import { TEXT, MUTED, HAIR, container, eyebrow } from "./theme.js";
import { X_URL, DISCORD_URL, LEARN } from "./data.js";
import { Logo, XIcon, DiscordIcon } from "./Icons.jsx";

function SocialLink({ href, label, children }) {
  return (
    <a
      href={href}
      target="_blank"
      rel="noopener noreferrer"
      aria-label={label}
      style={{
        color: MUTED,
        display: "inline-flex",
        alignItems: "center",
        justifyContent: "center",
        width: 36, height: 36,
        borderRadius: 10,
        border: "1px solid rgba(255,255,255,0.06)",
        background: "rgba(255,255,255,0.02)",
        transition: "border-color 0.3s ease",
      }}
    >
      {children}
    </a>
  );
}

export default function Footer() {
  return (
    <footer style={{ borderTop: HAIR, padding: "56px 0", position: "relative" }}>
      <div style={{ ...container, display: "flex", flexWrap: "wrap", justifyContent: "space-between", gap: 40 }}>
        {/* Brand */}
        <div style={{ maxWidth: 280 }}>
          <Logo size={22} />
          <p style={{ fontSize: 14, color: "rgba(255,255,255,0.3)", lineHeight: 1.65, margin: "16px 0 18px", fontWeight: 300 }}>
            The future-skills community. Build, earn, and grow in the new tech economy.
          </p>
          <div style={{ display: "flex", gap: 14 }}>
            <SocialLink href={X_URL} label="NEXTGEN on X">
              <XIcon />
            </SocialLink>
            <SocialLink href={DISCORD_URL} label="NEXTGEN on Discord">
              <DiscordIcon />
            </SocialLink>
          </div>
          <p style={{ fontSize: 13, color: "rgba(255,255,255,0.3)", marginTop: 16 }}>
            <span style={{ color: TEXT, fontWeight: 600 }}>500+</span> following on X
          </p>
        </div>

        {/* Links */}
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
        <a href="#top" style={{ fontSize: 13, color: "rgba(255,255,255,0.25)", textDecoration: "none" }}>
          Back to top ↑
        </a>
      </div>
    </footer>
  );
}
