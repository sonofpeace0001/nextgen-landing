export default function GlowButton({ children, onClick, full }) {
  return (
    <div
      className="ng-glow-btn"
      onClick={onClick}
      style={{ width: full ? "100%" : "auto" }}
    >
      <span
        className="ng-glow-btn-inner"
        style={{ width: full ? "100%" : "auto", textAlign: "center" }}
      >
        {children}
      </span>
    </div>
  );
}
