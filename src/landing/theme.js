/* ══════════════════════════════════════════════════════════
   NEXTGEN Design Tokens
   ══════════════════════════════════════════════════════════ */

export const VIOLET = "#7C3AED";
export const CORAL = "#EB97A0";
export const INDIGO = "#6366F1";
export const ROSE = "#FB7185";
export const TEXT = "#ECE8F5";
export const MUTED = "#9B8FC0";
export const TERT = "#8A81A6";
export const BG = "#030303";
export const HAIR = "1px solid rgba(255,255,255,0.08)";
export const SURFACE = "rgba(255,255,255,0.025)";

export const container = {
  maxWidth: 1120,
  margin: "0 auto",
  padding: "0 24px",
};

export const eyebrow = {
  fontSize: 13,
  letterSpacing: "0.14em",
  textTransform: "uppercase",
  color: "rgba(255,255,255,0.4)",
  fontWeight: 500,
};

export const h2Style = {
  fontFamily: "'Space Grotesk','Inter',sans-serif",
  fontSize: "clamp(28px,3.4vw,44px)",
  fontWeight: 600,
  letterSpacing: "-0.025em",
  color: TEXT,
  lineHeight: 1.12,
};

export const prefersReducedMotion =
  typeof window !== "undefined" && window.matchMedia
    ? window.matchMedia("(prefers-reduced-motion: reduce)").matches
    : false;
