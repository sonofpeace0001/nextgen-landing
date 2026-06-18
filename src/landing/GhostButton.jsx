import { useState } from "react";
import { TEXT, HAIR } from "./theme.js";

export default function GhostButton({ children, onClick, full }) {
  const [h, setH] = useState(false);
  return (
    <button
      onClick={onClick}
      onMouseEnter={() => setH(true)}
      onMouseLeave={() => setH(false)}
      style={{
        background: h ? "rgba(255,255,255,0.04)" : "transparent",
        color: TEXT,
        border: h ? "1px solid rgba(255,255,255,0.2)" : HAIR,
        borderRadius: 10,
        padding: "13px 24px",
        fontSize: 15,
        fontWeight: 500,
        fontFamily: "inherit",
        cursor: "pointer",
        width: full ? "100%" : "auto",
        transition: "border-color .2s ease, background .2s ease",
      }}
    >
      {children}
    </button>
  );
}
