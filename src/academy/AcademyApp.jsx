import { useEffect, useState } from "react";
import { supabase } from "../lib/supabase.js";
import { signIn, signUp, signOut, getSession, onAuthChange } from "../lib/auth.js";
import { listPublishedTracks, getMyEnrollments, createEnrollment } from "../lib/enrollment.js";
import { resolvePlan, getMySubmissions, getDayByNumber, buildPathView } from "../lib/delivery.js";
import { submitDay } from "../lib/submit.js";
import { currentStreak, tierName, getProgress } from "../lib/progress.js";
import { getMyProfile, redeemCode, trackTierAvailability } from "../lib/profile.js";
import { levelState } from "../lib/levels.js";
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
  const [isElite, setIsElite] = useState(false);
  const [tierHasDays, setTierHasDays] = useState({});
  const [code, setCode] = useState("");
  const [redeemBusy, setRedeemBusy] = useState(false);
  const [redeemMsg, setRedeemMsg] = useState(null); // { ok, text }

  useEffect(() => {
    listPublishedTracks(supabase).then((t) => {
      setTracks(t);
      if (t[0]) setTrackId(t[0].id);
    }).catch((e) => setError(e.message));
    getMyProfile(supabase).then((p) => setIsElite(!!p?.is_elite)).catch(() => {});
  }, []);

  useEffect(() => {
    if (!trackId) return;
    trackTierAvailability(supabase, trackId).then(setTierHasDays).catch(() => setTierHasDays({}));
  }, [trackId]);

  const stateFor = (lvl) => levelState({ entryLevel: lvl, isElite, tierHasDays });
  const selState = trackId ? stateFor(level) : "coming_soon";

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

  const redeem = async () => {
    setRedeemMsg(null);
    setRedeemBusy(true);
    try {
      await redeemCode(supabase, code.trim());
      setIsElite(true);
      setCode("");
      setRedeemMsg({ ok: true, text: "Elite unlocked." });
    } catch (e) {
      setRedeemMsg({ ok: false, text: e.message || "Could not redeem that code." });
    } finally {
      setRedeemBusy(false);
    }
  };

  const enrollLabel = busy
    ? "Enrolling…"
    : selState === "enrollable"
    ? "Enroll"
    : selState === "requires_elite"
    ? "Redeem a code to unlock"
    : "Coming soon";

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

      <div style={{ display: "flex", flexDirection: "column", gap: 8, marginBottom: 18 }}>
        {LEVELS.map((l) => {
          const st = stateFor(l.key);
          const badge = st === "requires_elite" ? "Requires Elite" : st === "coming_soon" ? "Coming soon" : null;
          const badgeColor = st === "requires_elite" ? "#EB97A0" : "#6B7280";
          return (
            <button
              key={l.key}
              onClick={() => setLevel(l.key)}
              style={{
                display: "flex", justifyContent: "space-between", alignItems: "center", gap: 12,
                padding: "12px 16px", borderRadius: 10, cursor: "pointer", fontFamily: "inherit",
                border: level === l.key ? "1px solid #A855F7" : BORDER,
                background: level === l.key ? "rgba(168,85,247,0.08)" : "transparent",
                color: "#F5F5F7", opacity: st === "coming_soon" ? 0.6 : 1,
              }}
            >
              <span style={{ fontSize: 14, fontWeight: 600 }}>
                {l.label} <span style={{ color: "#6B7280", fontWeight: 400 }}>· {ENTRY_LEVELS[l.key].totalDays}d</span>
              </span>
              {badge ? (
                <span style={{ fontSize: 12, fontWeight: 600, color: badgeColor }}>{badge}</span>
              ) : (
                <span style={{ fontSize: 12, color: "#9CA3AF" }}>{l.hint}</span>
              )}
            </button>
          );
        })}
      </div>

      {selState === "requires_elite" && (
        <div style={{ marginBottom: 18 }}>
          <p style={{ fontSize: 13, color: "#9CA3AF", marginBottom: 8 }}>
            Intermediate and Advanced are Elite paths. Have a code?
          </p>
          <div style={{ display: "flex", gap: 8 }}>
            <input
              value={code}
              onChange={(e) => setCode(e.target.value)}
              placeholder="Elite code"
              style={{ ...input, marginBottom: 0 }}
            />
            <button
              style={{ ...primaryBtn, opacity: redeemBusy || !code.trim() ? 0.6 : 1 }}
              onClick={redeem}
              disabled={redeemBusy || !code.trim()}
            >
              {redeemBusy ? "…" : "Redeem"}
            </button>
          </div>
          {redeemMsg && (
            <p style={{ fontSize: 13, color: redeemMsg.ok ? "#34D399" : "#F87171", marginTop: 8 }}>{redeemMsg.text}</p>
          )}
        </div>
      )}

      {error && <p style={{ color: "#F87171", fontSize: 13, marginBottom: 12 }}>{error}</p>}
      <button
        style={{ ...primaryBtn, width: "100%", opacity: busy || selState !== "enrollable" ? 0.6 : 1 }}
        onClick={enroll}
        disabled={busy || selState !== "enrollable"}
      >
        {enrollLabel}
      </button>
    </div>
  );
}

const lessonPre = {
  whiteSpace: "pre-wrap",
  fontFamily: "inherit",
  fontSize: 14,
  lineHeight: 1.6,
  color: "#D1D5DB",
  margin: "10px 0 0",
};

function statusPill(status) {
  if (status === "completed") return { label: "Done", color: "#34D399", bd: "rgba(52,211,153,0.35)" };
  if (status === "unlocked") return { label: "Open", color: "#A855F7", bd: "rgba(168,85,247,0.4)" };
  return { label: "Locked", color: "#6B7280", bd: "rgba(255,255,255,0.08)" };
}

function Section({ title, body }) {
  return (
    <div style={card}>
      <span style={label}>{title}</span>
      <p style={{ fontSize: 15, color: "#F5F5F7", lineHeight: 1.6, margin: "10px 0 0" }}>{body}</p>
    </div>
  );
}

function Stat({ label: lbl, value }) {
  return (
    <div>
      <div style={{ fontSize: 11, letterSpacing: "0.1em", textTransform: "uppercase", color: "#6B7280" }}>{lbl}</div>
      <div style={{ fontSize: 16, fontWeight: 600, color: "#F5F5F7", marginTop: 3 }}>{value}</div>
    </div>
  );
}

function SubmitPanel({ day, enrollmentId, onSubmitted }) {
  const mcq = (day.checks || []).find((c) => c.type === "mcq");
  const [answers, setAnswers] = useState({});
  const [text, setText] = useState("");
  const [self, setSelf] = useState("");
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState("");

  const submit = async () => {
    setError("");
    if (!text.trim()) return setError("Write your assignment response first.");
    const selfNum = self === "" ? null : Number(self);
    if (selfNum !== null && (Number.isNaN(selfNum) || selfNum < 0 || selfNum > 100)) {
      return setError("Self-score must be 0–100.");
    }
    let answersArr = [];
    if (mcq) {
      answersArr = mcq.items.map((_, i) => (i in answers ? answers[i] : null));
      if (answersArr.some((a) => a === null)) return setError("Answer every question.");
    }
    setBusy(true);
    try {
      await submitDay(supabase, { enrollmentId, dayId: day.id, content: text, selfScore: selfNum, answers: answersArr });
      onSubmitted?.();
    } catch (e) {
      setError(e.message);
    } finally {
      setBusy(false);
    }
  };

  return (
    <div style={{ marginTop: 16, display: "flex", flexDirection: "column", gap: 12 }}>
      {mcq && (
        <div style={{ display: "flex", flexDirection: "column", gap: 12 }}>
          {mcq.items.map((q, qi) => (
            <div key={qi}>
              <p style={{ fontSize: 14, color: "#F5F5F7", marginBottom: 6 }}>{q.q}</p>
              <div style={{ display: "flex", flexWrap: "wrap", gap: 6 }}>
                {q.options.map((opt, oi) => (
                  <button
                    key={oi}
                    onClick={() => setAnswers({ ...answers, [qi]: oi })}
                    style={{
                      padding: "7px 12px", borderRadius: 8, fontSize: 13, cursor: "pointer", fontFamily: "inherit",
                      border: answers[qi] === oi ? "1px solid #A855F7" : "1px solid rgba(255,255,255,0.08)",
                      background: answers[qi] === oi ? "rgba(168,85,247,0.1)" : "transparent", color: "#D1D5DB",
                    }}
                  >
                    {opt}
                  </button>
                ))}
              </div>
            </div>
          ))}
        </div>
      )}
      <textarea
        value={text}
        onChange={(e) => setText(e.target.value)}
        rows={4}
        placeholder="Your assignment response…"
        style={{ ...input, resize: "vertical", marginBottom: 0 }}
      />
      <div style={{ display: "flex", alignItems: "center", gap: 10 }}>
        <span style={{ fontSize: 13, color: "#9CA3AF" }}>Self-score (0–100):</span>
        <input
          value={self}
          onChange={(e) => setSelf(e.target.value)}
          type="number"
          min="0"
          max="100"
          style={{ ...input, width: 90, marginBottom: 0 }}
        />
      </div>
      {error && <p style={{ color: "#F87171", fontSize: 13 }}>{error}</p>}
      <button style={{ ...primaryBtn, alignSelf: "flex-start", opacity: busy ? 0.6 : 1 }} onClick={submit} disabled={busy}>
        {busy ? "Submitting…" : "Submit"}
      </button>
    </div>
  );
}

function LessonView({ enrollment, track, onBack }) {
  const [view, setView] = useState([]);
  const [subs, setSubs] = useState([]);
  const [progress, setProgress] = useState(null);
  const [selected, setSelected] = useState(null);
  const [content, setContent] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  async function load() {
    setLoading(true);
    try {
      const { plan, days } = await resolvePlan(supabase, enrollment);
      const mySubs = await getMySubmissions(supabase, enrollment.id);
      setSubs(mySubs);
      const pv = buildPathView({ plan, days, submissions: mySubs, enrollment });
      setView(pv);
      const prog = await getProgress(supabase, enrollment.id);
      const scoredDates = mySubs.filter((s) => s.status === "scored").map((s) => new Date(s.submitted_at));
      setProgress(prog ? { ...prog, streak: currentStreak(scoredDates) } : null);
      const firstOpen = pv.find((d) => d.status === "unlocked");
      const lastDone = [...pv].reverse().find((d) => d.status === "completed");
      const target = selected ?? (firstOpen || lastDone || pv[0])?.dayIndex;
      if (target) await openDay(target, pv);
    } catch (e) {
      setError(e.message);
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => {
    load();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  async function openDay(dayIndex, pv = view) {
    const row = pv.find((d) => d.dayIndex === dayIndex);
    if (!row || row.status === "locked") return;
    setSelected(dayIndex);
    setContent(await getDayByNumber(supabase, enrollment.track_id, row.dayNumber));
  }

  return (
    <div style={{ width: "100%", maxWidth: 720, display: "flex", flexDirection: "column", gap: 18 }}>
      <button style={{ ...ghostBtn, alignSelf: "flex-start", padding: "7px 14px", fontSize: 13 }} onClick={onBack}>
        ← Back
      </button>
      <div>
        <span style={label}>{track?.title ?? "Track"}</span>
        <h2 style={{ fontSize: 22, fontWeight: 600, margin: "8px 0 0", letterSpacing: "-0.02em" }}>
          {selected ? `Day ${selected} of ${enrollment.total_days}` : "Your path"}
        </h2>
      </div>

      {progress && (
        <div style={{ display: "flex", gap: 22, flexWrap: "wrap", padding: "14px 18px", border: BORDER, borderRadius: 12 }}>
          <Stat label="Progress" value={`Day ${progress.current_day} / ${progress.total_days}`} />
          <Stat label="Tier" value={tierName(progress.tier_reached || 1)} />
          <Stat label="Score" value={`${progress.cumulative_score ?? 0} pts`} />
          <Stat label="Streak" value={`${progress.streak} day${progress.streak === 1 ? "" : "s"}`} />
        </div>
      )}

      {error && <p style={{ color: "#F87171", fontSize: 13 }}>{error}</p>}
      {loading && <p style={{ color: "#6B7280", fontSize: 14 }}>Loading…</p>}

      <div style={{ display: "flex", flexWrap: "wrap", gap: 6 }}>
        {view.map((d) => {
          const p = statusPill(d.status);
          const isSel = d.dayIndex === selected;
          return (
            <button
              key={d.dayIndex}
              onClick={() => openDay(d.dayIndex)}
              disabled={d.status === "locked"}
              title={`Day ${d.dayIndex} · ${p.label}`}
              style={{
                width: 34, height: 34, borderRadius: 8, fontSize: 12, fontFamily: "inherit",
                cursor: d.status === "locked" ? "not-allowed" : "pointer",
                border: isSel ? "1px solid #A855F7" : `1px solid ${p.bd}`,
                background: isSel ? "rgba(168,85,247,0.12)" : "transparent",
                color: p.color, opacity: d.status === "locked" ? 0.5 : 1,
              }}
            >
              {d.dayIndex}
            </button>
          );
        })}
      </div>

      {content && (
        <div style={{ display: "flex", flexDirection: "column", gap: 14 }}>
          <Section title="What to learn" body={content.objective} />
          <div style={card}>
            <span style={label}>Lesson</span>
            <pre style={lessonPre}>{content.lesson_md}</pre>
          </div>
          <Section title="What to improve" body={content.skill_focus} />
          <div style={card}>
            <span style={label}>Assignment</span>
            <pre style={lessonPre}>{content.assignment_md}</pre>
            {Array.isArray(content.rubric) && content.rubric.length > 0 && (
              <div style={{ marginTop: 14 }}>
                <span style={label}>Rubric</span>
                <ul style={{ margin: "8px 0 0", paddingLeft: 18, color: "#9CA3AF", fontSize: 13, lineHeight: 1.7 }}>
                  {content.rubric.map((r, i) => (
                    <li key={i}>
                      {r.criterion} <span style={{ color: "#6B7280" }}>({r.max_points} pts)</span>
                    </li>
                  ))}
                </ul>
              </div>
            )}
            {(() => {
              const selRow = view.find((d) => d.dayIndex === selected);
              const existing = subs.find((s) => s.day_id === content.id);
              if (selRow && selRow.status === "completed") {
                return (
                  <p style={{ fontSize: 13, color: "#34D399", marginTop: 14 }}>
                    Completed · score {existing?.score ?? "—"}
                  </p>
                );
              }
              return <SubmitPanel key={content.id} day={content} enrollmentId={enrollment.id} onSubmitted={load} />;
            })()}
          </div>
        </div>
      )}
    </div>
  );
}

function Dashboard({ session }) {
  const [enrollments, setEnrollments] = useState([]);
  const [tracks, setTracks] = useState({});
  const [loading, setLoading] = useState(true);
  const [open, setOpen] = useState(null);

  const refresh = async () => {
    setLoading(true);
    const [enr, trk] = await Promise.all([getMyEnrollments(supabase), listPublishedTracks(supabase)]);
    setEnrollments(enr);
    setTracks(Object.fromEntries(trk.map((t) => [t.id, t])));
    setLoading(false);
  };
  useEffect(() => { refresh(); }, []);

  if (open) {
    return (
      <div style={{ display: "flex", justifyContent: "center", width: "100%" }}>
        <LessonView enrollment={open} track={tracks[open.track_id]} onBack={() => { setOpen(null); refresh(); }} />
      </div>
    );
  }

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
              <div
                key={e.id}
                onClick={() => setOpen(e)}
                style={{ display: "flex", justifyContent: "space-between", alignItems: "center", padding: "14px 16px", border: BORDER, borderRadius: 10, cursor: "pointer" }}
              >
                <div>
                  <div style={{ fontSize: 15, fontWeight: 600 }}>{tracks[e.track_id]?.title ?? "Track"}</div>
                  <div style={{ fontSize: 13, color: "#9CA3AF", marginTop: 3, textTransform: "capitalize" }}>{e.entry_level} · {e.status}</div>
                </div>
                <div style={{ fontSize: 13, color: "#A855F7", fontWeight: 600 }}>Day {e.current_day} of {e.total_days} →</div>
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
