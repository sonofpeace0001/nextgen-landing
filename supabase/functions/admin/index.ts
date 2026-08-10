// NEXTGEN admin Edge Function (Deno).
// Every call: verify the caller's JWT, confirm is_admin SERVER-SIDE, then act with
// the service_role key (injected by Supabase, never in the browser). RLS is the
// DB-level backstop; this is the second gate. One function, dispatched by `action`.
import { createClient } from "https://esm.sh/@supabase/supabase-js@2.45.4";

const cors = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};

const json = (body: unknown, status = 200) =>
  new Response(JSON.stringify(body), { status, headers: { ...cors, "Content-Type": "application/json" } });

const SETTINGS_KEYS = ["elite_prompt_code", "vip_intake_date", "vip_seats_left", "vip_checkout_url", "vip_waitlist_url"];

const ALPHA = "ABCDEFGHJKMNPQRSTUVWXYZ23456789"; // no ambiguous chars
function genCode(len = 8) {
  const bytes = new Uint8Array(len);
  crypto.getRandomValues(bytes);
  let s = "";
  for (const b of bytes) s += ALPHA[b % ALPHA.length];
  return `NG-${s}`;
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: cors });
  try {
    const url = Deno.env.get("SUPABASE_URL")!;
    const anonKey = Deno.env.get("SUPABASE_ANON_KEY")!;
    const serviceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
    const authHeader = req.headers.get("Authorization") ?? "";

    // 1) Identify the caller from their JWT.
    const asUser = createClient(url, anonKey, { global: { headers: { Authorization: authHeader } } });
    const { data: { user }, error: uErr } = await asUser.auth.getUser();
    if (uErr || !user) return json({ error: "Not authenticated" }, 401);

    // 2) Admin client (service_role) + SERVER-SIDE admin check.
    const db = createClient(url, serviceKey, { auth: { persistSession: false } });
    const { data: prof } = await db.from("profile").select("is_admin").eq("id", user.id).single();
    if (!prof?.is_admin) return json({ error: "Forbidden: admin only" }, 403);

    const { action, payload = {} } = await req.json();

    switch (action) {
      // ── Codes ──
      case "code.generate": {
        const count = Math.min(Math.max(Number(payload.count ?? 1), 1), 100);
        const rows = Array.from({ length: count }, () => ({
          code: genCode(),
          grants: payload.grants ?? "elite",
          max_uses: Number(payload.max_uses ?? 1),
          expires_at: payload.expires_at ?? null,
          created_by: user.id,
        }));
        const { data, error } = await db.from("access_code").insert(rows).select();
        if (error) throw error;
        return json({ codes: data });
      }
      case "code.list": {
        const [{ data: codes }, { data: reds }, { data: profs }] = await Promise.all([
          db.from("access_code").select("*").order("created_at", { ascending: false }),
          db.from("redemption").select("code_id, user_id, redeemed_at"),
          db.from("profile").select("id, email"),
        ]);
        const emailById = new Map((profs ?? []).map((p) => [p.id, p.email]));
        const redsByCode = new Map<string, unknown[]>();
        for (const r of reds ?? []) {
          const list = redsByCode.get(r.code_id) ?? [];
          list.push({ user_id: r.user_id, email: emailById.get(r.user_id), redeemed_at: r.redeemed_at });
          redsByCode.set(r.code_id, list);
        }
        return json({ codes: (codes ?? []).map((c) => ({ ...c, redemptions: redsByCode.get(c.id) ?? [] })) });
      }
      case "code.revoke": {
        const { error } = await db.from("access_code").update({ revoked: true }).eq("id", payload.id);
        if (error) throw error;
        return json({ ok: true });
      }

      // ── Members ──
      case "member.list": {
        const [{ data: members }, { data: enrollments }] = await Promise.all([
          db.from("profile").select("id, email, display_name, is_elite, is_admin, created_at").order("created_at"),
          db.from("enrollment").select("user_id, track_id, entry_level, current_day, total_days, status"),
        ]);
        return json({ members, enrollments });
      }
      case "member.setElite": {
        const { error } = await db.from("profile").update({ is_elite: !!payload.is_elite }).eq("id", payload.user_id);
        if (error) throw error;
        return json({ ok: true });
      }

      // ── Content ──
      case "content.upsertDay": {
        const d = payload.day ?? {};
        let res;
        if (d.id) res = await db.from("day").update(d).eq("id", d.id).select().single();
        else res = await db.from("day").insert(d).select().single();
        if (res.error) throw res.error;
        return json({ day: res.data });
      }
      case "content.publishDay": {
        const { error } = await db.from("day").update({ is_published: !!payload.is_published }).eq("id", payload.id);
        if (error) throw error;
        return json({ ok: true });
      }

      // ── Review queue ──
      case "review.list": {
        const { data: subs } = await db
          .from("submission")
          .select("id, content, self_score, check_score, submitted_at, user_id, day_id, enrollment_id")
          .eq("status", "pending_review")
          .order("submitted_at");
        const dayIds = [...new Set((subs ?? []).map((s) => s.day_id))];
        const userIds = [...new Set((subs ?? []).map((s) => s.user_id))];
        const [{ data: days }, { data: profs }] = await Promise.all([
          db.from("day").select("id, day_number, objective, assignment_md, rubric").in("id", dayIds.length ? dayIds : ["00000000-0000-0000-0000-000000000000"]),
          db.from("profile").select("id, email").in("id", userIds.length ? userIds : ["00000000-0000-0000-0000-000000000000"]),
        ]);
        const dayById = new Map((days ?? []).map((d) => [d.id, d]));
        const emailById = new Map((profs ?? []).map((p) => [p.id, p.email]));
        return json({
          queue: (subs ?? []).map((s) => ({ ...s, day: dayById.get(s.day_id), email: emailById.get(s.user_id) })),
        });
      }
      case "review.score": {
        const score = Number(payload.score);
        if (Number.isNaN(score) || score < 0 || score > 100) return json({ error: "score must be 0-100" }, 400);
        const { data, error } = await db
          .from("submission")
          .update({ score, feedback: payload.feedback ?? null, reviewed_by: user.id, reviewed_at: new Date().toISOString(), status: "scored" })
          .eq("id", payload.submission_id)
          .select()
          .single();
        if (error) throw error;
        return json({ submission: data });
      }

      // ── Settings ──
      case "settings.get": {
        const { data, error } = await db.from("site_settings").select("key, value").in("key", SETTINGS_KEYS);
        if (error) throw error;
        return json({ settings: data });
      }
      case "settings.update": {
        if (!SETTINGS_KEYS.includes(payload.key)) return json({ error: `Unknown setting key: ${payload.key}` }, 400);
        const { error } = await db.from("site_settings").update({ value: String(payload.value ?? "") }).eq("key", payload.key);
        if (error) throw error;
        return json({ ok: true });
      }

      default:
        return json({ error: `Unknown action: ${action}` }, 400);
    }
  } catch (e) {
    return json({ error: (e as Error)?.message ?? String(e) }, 500);
  }
});
