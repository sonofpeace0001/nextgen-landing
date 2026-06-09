import { useEffect, useState } from "react";
import { supabase } from "../lib/supabase.js";
import { signIn, signOut, getSession, onAuthChange } from "../lib/auth.js";
import { getMyProfile } from "../lib/profile.js";
import { adminApi } from "../lib/admin.js";

const BORDER = "1px solid rgba(255,255,255,0.08)";
const wrap = { minHeight: "100vh", background: "#0A0A0C", color: "#F5F5F7", fontFamily: "'Inter',system-ui,sans-serif", padding: "40px 20px" };
const shell = { maxWidth: 920, margin: "0 auto" };
const card = { border: BORDER, borderRadius: 12, padding: 20, background: "#0E0E12" };
const input = { padding: "9px 12px", borderRadius: 8, border: BORDER, background: "#0A0A0C", color: "#F5F5F7", fontSize: 14, fontFamily: "inherit" };
const btn = { background: "#7C3AED", color: "#fff", border: "none", borderRadius: 8, padding: "9px 16px", fontSize: 14, fontWeight: 600, cursor: "pointer", fontFamily: "inherit" };
const ghost = { ...btn, background: "transparent", border: BORDER, color: "#F5F5F7" };
const th = { textAlign: "left", fontSize: 12, color: "#6B7280", fontWeight: 500, padding: "8px 10px", borderBottom: BORDER };
const td = { fontSize: 13, color: "#D1D5DB", padding: "8px 10px", borderBottom: "1px solid rgba(255,255,255,0.05)" };
const errStyle = { color: "#F87171", fontSize: 13, marginTop: 8 };

function useAsync(fn, deps = []) {
  const [data, setData] = useState(null);
  const [error, setError] = useState("");
  const [tick, setTick] = useState(0);
  const reload = () => setTick((t) => t + 1);
  useEffect(() => {
    let live = true;
    fn().then((d) => live && setData(d)).catch((e) => live && setError(e.message));
    return () => { live = false; };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [...deps, tick]);
  return { data, error, reload, setError };
}

function CodesTab() {
  const { data, error, reload } = useAsync(() => adminApi.listCodes(), []);
  const [count, setCount] = useState(1);
  const [maxUses, setMaxUses] = useState(1);
  const [busy, setBusy] = useState(false);
  const [err, setErr] = useState("");

  const gen = async () => {
    setErr(""); setBusy(true);
    try { await adminApi.generateCodes({ count: Number(count), max_uses: Number(maxUses) }); reload(); }
    catch (e) { setErr(e.message); } finally { setBusy(false); }
  };
  const revoke = async (id) => { try { await adminApi.revokeCode(id); reload(); } catch (e) { setErr(e.message); } };

  return (
    <div style={card}>
      <div style={{ display: "flex", gap: 10, alignItems: "flex-end", flexWrap: "wrap", marginBottom: 18 }}>
        <label style={{ fontSize: 12, color: "#9CA3AF" }}>Count<br /><input style={{ ...input, width: 80, marginTop: 4 }} type="number" min="1" value={count} onChange={(e) => setCount(e.target.value)} /></label>
        <label style={{ fontSize: 12, color: "#9CA3AF" }}>Max uses<br /><input style={{ ...input, width: 90, marginTop: 4 }} type="number" min="1" value={maxUses} onChange={(e) => setMaxUses(e.target.value)} /></label>
        <button style={{ ...btn, opacity: busy ? 0.6 : 1 }} onClick={gen} disabled={busy}>{busy ? "…" : "Generate codes"}</button>
      </div>
      {(err || error) && <p style={errStyle}>{err || error}</p>}
      <div style={{ overflowX: "auto" }}>
        <table style={{ width: "100%", borderCollapse: "collapse" }}>
          <thead><tr><th style={th}>Code</th><th style={th}>Uses</th><th style={th}>Expires</th><th style={th}>Redeemed by</th><th style={th}></th></tr></thead>
          <tbody>
            {(data?.codes ?? []).map((c) => (
              <tr key={c.id} style={{ opacity: c.revoked ? 0.45 : 1 }}>
                <td style={{ ...td, fontFamily: "monospace" }}>{c.code}{c.revoked && " (revoked)"}</td>
                <td style={td}>{c.used_count}/{c.max_uses}</td>
                <td style={td}>{c.expires_at ? new Date(c.expires_at).toLocaleDateString() : "—"}</td>
                <td style={td}>{(c.redemptions ?? []).map((r) => r.email).join(", ") || "—"}</td>
                <td style={td}>{!c.revoked && <button style={{ ...ghost, padding: "5px 10px", fontSize: 12 }} onClick={() => revoke(c.id)}>Revoke</button>}</td>
              </tr>
            ))}
            {data && data.codes.length === 0 && <tr><td style={td} colSpan={5}>No codes yet.</td></tr>}
          </tbody>
        </table>
      </div>
    </div>
  );
}

function MembersTab() {
  const { data, error, reload } = useAsync(() => adminApi.listMembers(), []);
  const [err, setErr] = useState("");
  const enrByUser = {};
  for (const e of data?.enrollments ?? []) (enrByUser[e.user_id] ||= []).push(e);
  const toggle = async (m) => { try { await adminApi.setElite(m.id, !m.is_elite); reload(); } catch (e) { setErr(e.message); } };

  return (
    <div style={card}>
      {(err || error) && <p style={errStyle}>{err || error}</p>}
      <div style={{ overflowX: "auto" }}>
        <table style={{ width: "100%", borderCollapse: "collapse" }}>
          <thead><tr><th style={th}>Email</th><th style={th}>Role</th><th style={th}>Paths</th><th style={th}>Elite</th></tr></thead>
          <tbody>
            {(data?.members ?? []).map((m) => (
              <tr key={m.id}>
                <td style={td}>{m.email || m.id.slice(0, 8)}</td>
                <td style={td}>{m.is_admin ? "admin" : "member"}</td>
                <td style={td}>{(enrByUser[m.id] ?? []).map((e) => `${e.entry_level} (d${e.current_day}/${e.total_days})`).join(", ") || "—"}</td>
                <td style={td}>
                  <button style={{ ...ghost, padding: "5px 10px", fontSize: 12, borderColor: m.is_elite ? "rgba(168,85,247,0.5)" : undefined, color: m.is_elite ? "#A855F7" : "#F5F5F7" }} onClick={() => toggle(m)}>
                    {m.is_elite ? "Elite ✓" : "Make Elite"}
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}

function ContentTab() {
  const { data: tracks } = useAsync(() => supabase.from("track").select("id, slug, title").order("sort_order").then((r) => r.data ?? []), []);
  const [trackId, setTrackId] = useState("");
  const [tierId, setTierId] = useState("");
  const [tiers, setTiers] = useState([]);
  const [days, setDays] = useState([]);
  const [err, setErr] = useState("");
  const blank = { day_number: "", objective: "", lesson_md: "", skill_focus: "", assignment_md: "", rubric: "[]", requires_review: false, est_minutes: "" };
  const [form, setForm] = useState(blank);

  useEffect(() => { if (tracks?.[0] && !trackId) setTrackId(tracks[0].id); }, [tracks, trackId]);
  useEffect(() => {
    if (!trackId) return;
    supabase.from("tier").select("id, slug, title, ordinal").eq("track_id", trackId).order("ordinal").then((r) => { setTiers(r.data ?? []); setTierId((r.data ?? [])[0]?.id ?? ""); });
  }, [trackId]);
  const loadDays = () => { if (trackId && tierId) supabase.from("day").select("*").eq("track_id", trackId).eq("tier_id", tierId).order("day_number").then((r) => setDays(r.data ?? [])); };
  useEffect(loadDays, [trackId, tierId]);

  const edit = (d) => setForm({ ...d, rubric: JSON.stringify(d.rubric ?? [], null, 0), est_minutes: d.est_minutes ?? "" });
  const save = async () => {
    setErr("");
    let rubric;
    try { rubric = JSON.parse(form.rubric || "[]"); } catch { return setErr("Rubric must be valid JSON."); }
    const day = {
      ...(form.id ? { id: form.id } : {}),
      track_id: trackId, tier_id: tierId,
      day_number: Number(form.day_number), objective: form.objective, lesson_md: form.lesson_md,
      skill_focus: form.skill_focus, assignment_md: form.assignment_md, rubric,
      requires_review: !!form.requires_review, est_minutes: form.est_minutes ? Number(form.est_minutes) : null,
    };
    try { await adminApi.upsertDay(day); setForm(blank); loadDays(); } catch (e) { setErr(e.message); }
  };
  const togglePublish = async (d) => { try { await adminApi.publishDay(d.id, !d.is_published); loadDays(); } catch (e) { setErr(e.message); } };

  const F = (k, label, ta) => (
    <label style={{ fontSize: 12, color: "#9CA3AF", display: "block", marginBottom: 10 }}>{label}<br />
      {ta
        ? <textarea style={{ ...input, width: "100%", marginTop: 4, resize: "vertical" }} rows={2} value={form[k]} onChange={(e) => setForm({ ...form, [k]: e.target.value })} />
        : <input style={{ ...input, width: "100%", marginTop: 4 }} value={form[k]} onChange={(e) => setForm({ ...form, [k]: e.target.value })} />}
    </label>
  );

  return (
    <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: 16 }} className="admin-2col">
      <div style={card}>
        <div style={{ display: "flex", gap: 8, marginBottom: 14 }}>
          <select style={input} value={trackId} onChange={(e) => setTrackId(e.target.value)}>{(tracks ?? []).map((t) => <option key={t.id} value={t.id}>{t.title}</option>)}</select>
          <select style={input} value={tierId} onChange={(e) => setTierId(e.target.value)}>{tiers.map((t) => <option key={t.id} value={t.id}>{t.title}</option>)}</select>
        </div>
        {days.map((d) => (
          <div key={d.id} style={{ display: "flex", justifyContent: "space-between", alignItems: "center", padding: "9px 0", borderBottom: "1px solid rgba(255,255,255,0.05)" }}>
            <span style={{ fontSize: 13, cursor: "pointer", color: d.is_published ? "#F5F5F7" : "#9CA3AF" }} onClick={() => edit(d)}>
              Day {d.day_number} · {d.objective?.slice(0, 36)}{d.requires_review ? " · review" : ""}
            </span>
            <button style={{ ...ghost, padding: "4px 9px", fontSize: 12, color: d.is_published ? "#34D399" : "#9CA3AF" }} onClick={() => togglePublish(d)}>{d.is_published ? "Published" : "Publish"}</button>
          </div>
        ))}
        {days.length === 0 && <p style={{ fontSize: 13, color: "#6B7280" }}>No days in this tier.</p>}
      </div>

      <div style={card}>
        <p style={{ fontSize: 13, fontWeight: 600, marginBottom: 12 }}>{form.id ? `Edit day ${form.day_number}` : "New day"}</p>
        {F("day_number", "Day number")}
        {F("objective", "Objective (what to learn)")}
        {F("lesson_md", "Lesson", true)}
        {F("skill_focus", "Skill focus (what to improve)")}
        {F("assignment_md", "Assignment", true)}
        {F("rubric", "Rubric (JSON array)", true)}
        {F("est_minutes", "Est. minutes")}
        <label style={{ fontSize: 13, color: "#D1D5DB", display: "flex", gap: 8, alignItems: "center", margin: "4px 0 14px" }}>
          <input type="checkbox" checked={!!form.requires_review} onChange={(e) => setForm({ ...form, requires_review: e.target.checked })} /> Requires instructor review
        </label>
        {err && <p style={errStyle}>{err}</p>}
        <div style={{ display: "flex", gap: 8 }}>
          <button style={btn} onClick={save}>{form.id ? "Save changes" : "Create day"}</button>
          {form.id && <button style={ghost} onClick={() => setForm(blank)}>New</button>}
        </div>
      </div>
    </div>
  );
}

function ReviewTab() {
  const { data, error, reload } = useAsync(() => adminApi.listReviewQueue(), []);
  const [drafts, setDrafts] = useState({});
  const [err, setErr] = useState("");
  const set = (id, k, v) => setDrafts((d) => ({ ...d, [id]: { ...d[id], [k]: v } }));
  const score = async (s) => {
    const d = drafts[s.id] || {};
    setErr("");
    try { await adminApi.scoreSubmission(s.id, Number(d.score), d.feedback ?? ""); reload(); } catch (e) { setErr(e.message); }
  };
  return (
    <div style={{ display: "flex", flexDirection: "column", gap: 12 }}>
      {(err || error) && <p style={errStyle}>{err || error}</p>}
      {(data?.queue ?? []).map((s) => (
        <div key={s.id} style={card}>
          <div style={{ fontSize: 13, color: "#9CA3AF", marginBottom: 6 }}>{s.email} · Day {s.day?.day_number}</div>
          <div style={{ fontSize: 14, fontWeight: 600, marginBottom: 6 }}>{s.day?.objective}</div>
          <div style={{ fontSize: 13, color: "#D1D5DB", marginBottom: 4 }}><b>Assignment:</b> {s.day?.assignment_md}</div>
          <div style={{ fontSize: 13, color: "#D1D5DB", whiteSpace: "pre-wrap", marginBottom: 10 }}><b>Submission:</b> {s.content || "—"} <span style={{ color: "#6B7280" }}>(self {s.self_score ?? "—"} / check {s.check_score ?? "—"})</span></div>
          <div style={{ display: "flex", gap: 8, alignItems: "center", flexWrap: "wrap" }}>
            <input style={{ ...input, width: 90 }} type="number" min="0" max="100" placeholder="Score" value={drafts[s.id]?.score ?? ""} onChange={(e) => set(s.id, "score", e.target.value)} />
            <input style={{ ...input, flex: 1, minWidth: 180 }} placeholder="Feedback" value={drafts[s.id]?.feedback ?? ""} onChange={(e) => set(s.id, "feedback", e.target.value)} />
            <button style={btn} onClick={() => score(s)}>Score</button>
          </div>
        </div>
      ))}
      {data && data.queue.length === 0 && <div style={card}><p style={{ fontSize: 13, color: "#6B7280" }}>Nothing awaiting review.</p></div>}
    </div>
  );
}

const TABS = [
  { key: "codes", label: "Codes", el: CodesTab },
  { key: "members", label: "Members", el: MembersTab },
  { key: "content", label: "Content", el: ContentTab },
  { key: "review", label: "Review", el: ReviewTab },
];

function Dashboard({ email }) {
  const [tab, setTab] = useState("codes");
  const Active = TABS.find((t) => t.key === tab).el;
  return (
    <div style={shell}>
      <style>{`@media(max-width:760px){.admin-2col{grid-template-columns:1fr !important}}`}</style>
      <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 24 }}>
        <span style={{ fontFamily: "'Space Grotesk','Inter',sans-serif", fontWeight: 600, fontSize: 18 }}>NEXTGEN Admin</span>
        <span style={{ fontSize: 13, color: "#9CA3AF" }}>{email} · <button style={{ background: "none", border: "none", color: "#9CA3AF", cursor: "pointer", fontFamily: "inherit", textDecoration: "underline" }} onClick={() => signOut()}>sign out</button></span>
      </div>
      <div style={{ display: "flex", gap: 8, marginBottom: 20, borderBottom: BORDER, paddingBottom: 0 }}>
        {TABS.map((t) => (
          <button key={t.key} onClick={() => setTab(t.key)} style={{ background: "none", border: "none", borderBottom: tab === t.key ? "2px solid #7C3AED" : "2px solid transparent", color: tab === t.key ? "#F5F5F7" : "#9CA3AF", padding: "8px 6px", marginBottom: -1, cursor: "pointer", fontFamily: "inherit", fontSize: 14, fontWeight: 500 }}>{t.label}</button>
        ))}
      </div>
      <Active />
    </div>
  );
}

function SignInGate() {
  const [email, setEmail] = useState("");
  const [pw, setPw] = useState("");
  const [err, setErr] = useState("");
  const go = async () => { setErr(""); try { await signIn(email, pw); } catch (e) { setErr(e.message); } };
  return (
    <div style={{ ...shell, maxWidth: 360 }}>
      <div style={card}>
        <p style={{ fontSize: 16, fontWeight: 600, marginBottom: 16 }}>Admin sign in</p>
        <input style={{ ...input, width: "100%", marginBottom: 10 }} type="email" placeholder="Email" value={email} onChange={(e) => setEmail(e.target.value)} />
        <input style={{ ...input, width: "100%", marginBottom: 12 }} type="password" placeholder="Password" value={pw} onChange={(e) => setPw(e.target.value)} />
        {err && <p style={errStyle}>{err}</p>}
        <button style={{ ...btn, width: "100%", marginTop: 6 }} onClick={go}>Sign in</button>
      </div>
    </div>
  );
}

export default function AdminApp() {
  const [session, setSession] = useState(undefined);
  const [isAdmin, setIsAdmin] = useState(null);

  useEffect(() => {
    getSession().then(setSession);
    return onAuthChange(setSession);
  }, []);
  useEffect(() => {
    if (!session) { setIsAdmin(session === null ? false : null); return; }
    getMyProfile(supabase).then((p) => setIsAdmin(!!p?.is_admin)).catch(() => setIsAdmin(false));
  }, [session]);

  let body;
  if (session === undefined) body = <p style={{ color: "#6B7280" }}>Loading…</p>;
  else if (!session) body = <SignInGate />;
  else if (isAdmin === null) body = <p style={{ color: "#6B7280" }}>Checking access…</p>;
  else if (!isAdmin)
    body = (
      <div style={{ ...shell, maxWidth: 420 }}>
        <div style={card}>
          <p style={{ fontSize: 15, fontWeight: 600, marginBottom: 8 }}>Not authorized</p>
          <p style={{ fontSize: 13, color: "#9CA3AF" }}>This account is not an admin.</p>
          <button style={{ ...ghost, marginTop: 14 }} onClick={() => signOut()}>Sign out</button>
        </div>
      </div>
    );
  else body = <Dashboard email={session.user.email} />;

  return <div style={wrap}>{body}</div>;
}
