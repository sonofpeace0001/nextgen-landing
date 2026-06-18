import { HAIR, container } from "./theme.js";

export default function Section({ id, alt, children, style: sx }) {
  return (
    <section
      id={id}
      className="ng-section"
      style={{
        padding: "110px 0",
        background: alt ? "rgba(255,255,255,0.015)" : "transparent",
        borderTop: alt ? HAIR : "none",
        borderBottom: alt ? HAIR : "none",
        position: "relative",
        ...sx,
      }}
    >
      <div style={container}>{children}</div>
    </section>
  );
}
