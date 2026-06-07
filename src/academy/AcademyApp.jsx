import { useEffect, useState } from "react";
import { supabase } from "../lib/supabase.js";
import { signIn, signUp, signOut, getSession, onAuthChange } from "../lib/auth.js";
import { listPublishedTracks, getMyEnrollments, createEnrollment } from "../lib/enrollment.js";
import { ENTRY_LEVELS } from "../lib/academyConfig.js";

const ACCENT = "linear-gradient(135deg, #E27FE0 0%, #A855F7 50%, #7C3AED 100%)";
const BORDER = "1px solid rgba(255,255,255,0.08)";
const LEVELS = [
  { key: "novice", label: "Novice", hint: "Start from zero — full path" },
  { key: "intermediate", label: "Intermediate", hint: "Some experience — shorter path" },
  { key: "advanced", label: "Advanced", hint: "Already capable — fast track" },
];

const wrap = {
  minHeight: "100vh",
  background: "#0A0A0C",
  color: "#F5F5F7",
  fontFamily: "'Inter',system-ui,-apple-system,sans-serif",
  display: "flex",
  flexDirection: "column",
  alignItems: "center",
  padding: "64px 20px",
};
const card = { width: "100%", maxWidth: 560, border: BORDER, borderRadius: 12, padding: 28, background: "#0E0E12" };
const input = {
  width: "100%",
  padding: "11px 13px",
  borderRadius: 8,
  border: BORDER,
  background: "#0A0A0C",
  color: "#F5F5F7",
  fontSize: 14,
  fontFamily: "inherit",
  marginBottom: 12,
  boxSizing: "border-box",
};
const primaryBtn = {
  background: ACCENT,
  border: "none",
  color: "#fff",
  padding: "11px 20px",
  borderRadius: 8,
  fontSize: 14,
  fontWeight: 500,
  cursor: "pointer",
  fontFamily: "inherit",
};
const ghostBtn = { ...primaryBtn, background: "transparent", border: BORDER, color: "#F5F5F7" };
const label = { fontSize: 12, letterSpacing: "0.12em", textTransform: "uppercase", color: "#6B7280" };

function AuthCard() {
  const [mode, setMode] = useState("signin");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState("");
  const [notice, setNotice] = useState("");

  const submit = async () => {
    setError("");
    setNotice("");
    if (!/^\S+@\S+\.\S+$/.test(email)) return setError("Enter a valid email.");
    if (password.length < 6) return setError("Password must be at least 6 characters.");
    setBusy(true);
    try {
      if (mode === "signup") {
        const data = await signUp(email, password);
        if (!data.session) setNotice("Check your email to confirm your account, then sign in.");
      } else {
        await signIn(email, password);
      }
    } catch (e) {
      setError(e.message || "Something went wrong.");
    } finally {
      setBusy(false);
    }
  };

  return (
    <div style={card}>
      <span style={label}>NEXTGEN Academy</span>
      <h1 style={{ fontSize: 24, fontWeight: 600, margin: "10px 0 20px", letterSpacing: "-0.02em" }}>
        {mode === "signup" ? "Create your account" : "Sign in"}
      </h1>
      <input style={input} type="email" placeholder="you@email.com" value={email} onChange={(e) => setEmail(e.target.value)} />
      <input style={input} type="password" placeholder="Password" value={password} onChange={(e) => setPassword(e.target.value)} />
      {error && <p style={{ color: "#F87171", fontSize: 13, marginBottom: 12 }}>{error}</p>}
      {notice && <p style={{ color: "#34D399", fontSize: 13, marginBottom: 12 }}>{notice}</p>}
      <button style={{ ...primaryBtn, width: "100%", opacity: busy ? 0.6 : 1 }} onClick={submit} disabled={busy}>
        {busy ? "…" : mode === "signup" ? "Sign up" : "Sign in"}
      </button>
      <p style={{ fontSize: 13, color: "#9CA3AF", marginTop: 16, textAlign: "center" }}>
        {mode === "signup" ? "Already have an account?" : "New here?"}{" "}
        <button
          onClick={() => { setMode(mode === "signup" ? "signin" : "signup"); setError(""); setNotice(""); }}
          style={{ background: "none", border: "none", color: "#A855F7", cursor: "pointer", fontSize: 13, fontFamily: "inherit" }}
        >
          {mode === "signup" ? "Sign in" : "Create one"}
        </button>
      </p>
    </div>
  );
}

function EnrollCard({ onEnrolled }) {
  const [tracks, setTracks] = useState([]);
  const [trackId, setTrackId] = useState("");
  const [level, setLevel] = useState("novice");
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState("");

  useEffect(() => {
    listPublishedTracks(supabase).then((t) => {
      setTracks(t);
      if (t[0]) setTrackId(t[0].id);
    }).catch((e) => setError(e.message));
  }, []);

  const enroll = async () => {
    setError("");
    setBusy(true);
    try {
      await createEnrollment(supabase, { trackId, entryLevel: level });
      onEnrolled();
    } catch (e) {
      setError(e.message || "Could not enroll.");
    } finally {
      setBusy(false);
    }
  };

  return (
    <div style={card}>
      <span style={label}>Enroll in a path</span>
      <h2 style={{ fontSize: 20, fontWeight: 600, margin: "10px 0 18px", letterSpacing: "-0.02em" }}>Pick a track and your level</h2>

      <div style={{ display: "flex", flexDirection: "column", gap: 8, marginBottom: 20 }}>
        {tracks.map((t) => (
          <button
            key={t.id}
            onClick={() => setTrackId(t.id)}
            style={{
              textAlign: "left", padding: "14px 16px", borderRadius: 10, cursor: "pointer", fontFamily: "inherit",
              border: trackId === t.id ? "1px solid #A855F7" : BORDER,
              background: trackId === t.id ? "rgba(168,85,247,0.08)" : "transparent", color: "#F5F5F7",
            }}
          >
            <div style={{ fontSize: 15, fontWeight: 600 }}>{t.title}</div>
            {t.description && <div style={{ fontSize: 13, color: "#9CA3AF", marginTop: 3 }}>{t.description}</div>}
          </button>
        ))}
        {tracks.length === 0 && <p style={{ fontSize: 13, color: "#6B7280" }}>No published tracks yet.</p>}
      </div>

      <div style={{ display: "flex", flexDirection: "column", gap: 8, marginBottom: 22 }}>
        {LEVELS.map((l) => (
          <button
            key={l.key}
            onClick={() => setLevel(l.key)}
            style={{
              display: "flex", justifyContent: "space-between", alignItems: "center", gap: 12,
              padding: "12px 16px", borderRadius: 10, cursor: "pointer", fontFamily: "inherit",
              border: level === l.key ? "1px solid #A855F7" : BORDER,
              background: level === l.key ? "rgba(168,85,247,0.08)" : "transparent", color: "#F5F5F7",
            }}
          >
            <span style={{ fontSize: 14, fontWeight: 600 }}>{l.label}</span>
            <span style={{ fontSize: 12, color: "#9CA3AF" }}>{l.hint} · {ENTRY_LEVELS[l.key].totalDays}d</span>
          </button>
        ))}
      </div>

      {error && <p style={{ color: "#F87171", fontSize: 13, marginBottom: 12 }}>{error}</p>}
      <button style={{ ...primaryBtn, width: "100%", opacity: busy || !trackId ? 0.6 : 1 }} onClick={enroll} disabled={busy || !trackId}>
        {busy ? "Enrolling…" : "Enroll"}
      </button>
    </div>
  );
}

function Dashboard({ session }) {
  const [enrollments, setEnrollments] = useState([]);
  const [tracks, setTracks] = useState({});
  const [loading, setLoading] = useState(true);

  const refresh = async () => {
    setLoading(true);
    const [enr, trk] = await Promise.all([getMyEnrollments(supabase), listPublishedTracks(supabase)]);
    setEnrollments(enr);
    setTracks(Object.fromEntries(trk.map((t) => [t.id, t])));
    setLoading(false);
  };
  useEffect(() => { refresh(); }, []);

  return (
    <div style={{ width: "100%", maxWidth: 560, display: "flex", flexDirection: "column", gap: 20 }}>
      <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center" }}>
        <span style={{ fontSize: 13, color: "#9CA3AF" }}>{session.user.email}</span>
        <button style={{ ...ghostBtn, padding: "7px 14px", fontSize: 13 }} onClick={() => signOut()}>Sign out</button>
      </div>

      {!loading && enrollments.length > 0 && (
        <div style={card}>
          <span style={label}>Your paths</span>
          <div style={{ display: "flex", flexDirection: "column", gap: 10, marginTop: 14 }}>
            {enrollments.map((e) => (
              <div key={e.id} style={{ display: "flex", justifyContent: "space-between", alignItems: "center", padding: "14px 16px", border: BORDER, borderRadius: 10 }}>
                <div>
                  <div style={{ fontSize: 15, fontWeight: 600 }}>{tracks[e.track_id]?.title ?? "Track"}</div>
                  <div style={{ fontSize: 13, color: "#9CA3AF", marginTop: 3, textTransform: "capitalize" }}>{e.entry_level} · {e.status}</div>
                </div>
                <div style={{ fontSize: 13, color: "#A855F7", fontWeight: 600 }}>Day {e.current_day} of {e.total_days}</div>
              </div>
            ))}
          </div>
        </div>
      )}

      <EnrollCard onEnrolled={refresh} />
    </div>
  );
}

export default function AcademyApp() {
  const [session, setSession] = useState(undefined); // undefined = loading

  useEffect(() => {
    getSession().then(setSession);
    return onAuthChange(setSession);
  }, []);

  if (session === undefined) {
    return <div style={{ ...wrap, justifyContent: "center", color: "#6B7280" }}>Loading…</div>;
  }

  return (
    <div style={wrap}>
      <a href="#/" style={{ display: "flex", alignItems: "center", gap: 10, marginBottom: 32, textDecoration: "none" }}>
        <img src="/logo.png" alt="" aria-hidden="true" style={{ height: 26, width: "auto" }} />
        <span style={{ fontWeight: 600, fontSize: 16, letterSpacing: "-0.02em", color: "#F5F5F7" }}>NEXTGEN Academy</span>
      </a>
      {session ? <Dashboard session={session} /> : <AuthCard />}
    </div>
  );
}
