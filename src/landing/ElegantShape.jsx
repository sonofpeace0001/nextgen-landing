import { prefersReducedMotion } from "./theme.js";

export default function ElegantShape({ width = 400, height = 100, rotate = 0, color, top, left, right, bottom, delay = 0, alt }) {
  return (
    <div
      className="ng-shape"
      style={{
        top,
        left,
        right,
        bottom,
        width,
        height,
        transform: `rotate(${rotate}deg)`,
        animation: prefersReducedMotion
          ? "none"
          : `ng-shape-entrance 2.4s cubic-bezier(0.23,0.86,0.39,0.96) ${delay}s both, ${alt ? "ng-float-alt" : "ng-float"} 12s ease-in-out ${delay + 2.4}s infinite`,
      }}
    >
      <div
        className="ng-shape-pill"
        style={{
          background: `linear-gradient(to right, ${color || "rgba(129,140,248,0.12)"}, transparent)`,
        }}
      />
    </div>
  );
}
