import { useEffect, useState } from "react";
import { getMyAccess } from "../lib/access.js";
import { onAuthChange } from "../lib/auth.js";

const MIN = 60 * 1000;
const HOUR = 60 * MIN;
const DAY = 24 * HOUR;

function parts(ms) {
  const d = Math.floor(ms / DAY);
  const h = Math.floor((ms % DAY) / HOUR);
  const m = Math.floor((ms % HOUR) / MIN);
  const s = Math.floor((ms % MIN) / 1000);
  return { d, h, m, s };
}

function plural(n, word) {
  return `${n} ${word}${n === 1 ? "" : "s"}`;
}

// Free-trial countdown. Shows while a trial is running and keeps asking members to join Elite or VIP, more
// urgently as the end nears; after it ends it says so. Renders nothing for everyone else.
export function TrialBanner() {
  const [a, setA] = useState(null);
  const [now, setNow] = useState(Date.now());

  const load = () => getMyAccess().then(setA).catch(() => {});
  useEffect(() => {
    load();
    window.addEventListener("ng-access-changed", load);
    const off = onAuthChange(load);
    const t = setInterval(() => setNow(Date.now()), 1000);
    return () => {
      window.removeEventListener("ng-access-changed", load);
      off?.();
      clearInterval(t);
    };
  }, []);

  if (!a || !a.signedIn) return null;
  const ends = a.trialEndsAt ? new Date(a.trialEndsAt).getTime() : null;
  const running = a.source === "trial" && ends && ends > now;
  const expired = !a.full && a.trialUsed;
  if (!running && !expired) return null;

  let tone = { bg: "rgba(124,58,237,0.16)", bd: "rgba(168,85,247,0.55)", fg: "#F5F5F7" };
  let headline;
  let sub;
  if (running) {
    const ms = ends - now;
    const { d, h, m, s } = parts(ms);
    if (ms < DAY) {
      tone = { bg: "rgba(239,68,68,0.16)", bd: "rgba(248,113,113,0.7)", fg: "#FEE2E2" };
      headline = `Your free trial ends in ${h}h ${String(m).padStart(2, "0")}m ${String(s).padStart(2, "0")}s`;
      sub = "Join Elite or VIP now so you do not lose access to your paths, the Library and your progress.";
    } else if (d <= 3) {
      tone = { bg: "rgba(239,68,68,0.14)", bd: "rgba(248,113,113,0.6)", fg: "#FEE2E2" };
      headline = `Your free trial ends in ${plural(d, "day")} ${plural(h, "hour")}`;
      sub = "Join Elite or VIP before it ends so you can keep learning without a break.";
    } else if (d <= 7) {
      tone = { bg: "rgba(245,158,11,0.14)", bd: "rgba(251,191,36,0.6)", fg: "#FEF3C7" };
      headline = `${plural(d, "day")} ${plural(h, "hour")} left of your free trial`;
      sub = "Keep going. Join Elite or VIP to keep every path and the Library after it ends.";
    } else {
      headline = `Free trial: ${plural(d, "day")} ${plural(h, "hour")} left`;
      sub = "You have full access while it lasts. Join Elite or VIP to keep it after it ends.";
    }
  } else {
    tone = { bg: "rgba(239,68,68,0.14)", bd: "rgba(248,113,113,0.6)", fg: "#FEE2E2" };
    headline = "Your free trial has ended";
    sub = "Join Elite or VIP to unlock your paths and the Library again. Your progress is saved.";
  }

  return (
    <div
      role="status"
      aria-live="polite"
      style={{
        position: "sticky", top: 0, zIndex: 20, width: "100%", boxSizing: "border-box",
        display: "flex", flexWrap: "wrap", alignItems: "center", justifyContent: "space-between", gap: 12,
        padding: "12px 16px", borderRadius: 12, border: `1px solid ${tone.bd}`, background: tone.bg, color: tone.fg,
        backdropFilter: "blur(6px)",
      }}
    >
      <div style={{ minWidth: 0, flex: "1 1 260px" }}>
        <div style={{ fontSize: 15, fontWeight: 700 }}>{headline}</div>
        <div style={{ fontSize: 13, opacity: 0.9, marginTop: 2, lineHeight: 1.45 }}>{sub}</div>
      </div>
      <div style={{ display: "flex", gap: 8 }}>
        <a href="#plans" style={{ background: "#7C3AED", color: "#fff", textDecoration: "none", fontWeight: 700, fontSize: 14, padding: "9px 16px", borderRadius: 9 }}>
          Join Elite
        </a>
        <a href="#vip" style={{ border: `1px solid ${tone.bd}`, color: tone.fg, textDecoration: "none", fontWeight: 600, fontSize: 14, padding: "9px 14px", borderRadius: 9 }}>
          See VIP
        </a>
      </div>
    </div>
  );
}
