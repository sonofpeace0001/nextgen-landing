import { useState, useEffect } from "react";
import { Menu, X } from "lucide-react";
import { TEXT, MUTED, HAIR, container } from "./theme.js";
import { NAV_LINKS, LEARN } from "./data.js";
import { Logo } from "./Icons.jsx";
import GlowButton from "./GlowButton.jsx";

function useScrolled(threshold = 32) {
  const [s, setS] = useState(false);
  useEffect(() => {
    const h = () => setS(window.scrollY > threshold);
    window.addEventListener("scroll", h, { passive: true });
    return () => window.removeEventListener("scroll", h);
  }, [threshold]);
  return s;
}

export default function Nav() {
  const scrolled = useScrolled(32);
  const [open, setOpen] = useState(false);

  return (
    <nav
      style={{
        position: "fixed",
        top: 0, left: 0, right: 0,
        zIndex: 100,
        background: scrolled ? "rgba(3,3,3,0.8)" : "transparent",
        backdropFilter: scrolled ? "saturate(140%) blur(12px)" : "none",
        borderBottom: scrolled ? HAIR : "1px solid transparent",
        transition: "background .3s ease, border-color .3s ease, backdrop-filter .3s ease",
      }}
    >
      <div style={{ ...container, display: "flex", alignItems: "center", justifyContent: "space-between", height: 66 }}>
        <a href="#top" style={{ textDecoration: "none" }}>
          <Logo />
        </a>

        {/* Desktop links */}
        <div className="ng-navlinks" style={{ display: "flex", alignItems: "center", gap: 30 }}>
          {NAV_LINKS.map((l) => (
            <a
              key={l.label}
              href={l.href}
              style={{
                fontSize: 14,
                color: "rgba(255,255,255,0.5)",
                textDecoration: "none",
                fontWeight: 400,
                letterSpacing: "0.01em",
                transition: "color .2s ease",
              }}
            >
              {l.label}
            </a>
          ))}
          <a href={LEARN} style={{ fontSize: 14, color: "rgba(255,255,255,0.5)", textDecoration: "none" }}>
            Login
          </a>
          <GlowButton onClick={() => (window.location.hash = "#/learn")}>
            Start Learning
          </GlowButton>
        </div>

        {/* Mobile burger */}
        <button
          className="ng-burger"
          onClick={() => setOpen(!open)}
          style={{ display: "none", background: "none", border: "none", color: TEXT, cursor: "pointer" }}
          aria-label="Menu"
        >
          {open ? <X size={22} /> : <Menu size={22} />}
        </button>
      </div>

      {/* Mobile menu */}
      {open && (
        <div
          style={{
            background: "rgba(3,3,3,0.95)",
            backdropFilter: "blur(12px)",
            borderBottom: HAIR,
            padding: "16px 24px 24px",
            display: "flex",
            flexDirection: "column",
            gap: 16,
          }}
        >
          {NAV_LINKS.map((l) => (
            <a key={l.label} href={l.href} onClick={() => setOpen(false)} style={{ color: MUTED, fontSize: 16, textDecoration: "none" }}>
              {l.label}
            </a>
          ))}
          <a href={LEARN} onClick={() => setOpen(false)} style={{ color: MUTED, fontSize: 16, textDecoration: "none" }}>
            Login
          </a>
          <GlowButton full onClick={() => (window.location.hash = "#/learn")}>
            Start Learning
          </GlowButton>
        </div>
      )}
    </nav>
  );
}
