// NEXTGEN evaluate-submission Edge Function (Deno).
//
// Scores one 'pending_ai' submission against its day's rubric and writes the
// result with the service role. The member's JWT only proves who is asking; the
// browser can never set a score. Anything uncertain (low confidence, a link the
// model cannot open, an injection attempt, no API key, any error) is parked as
// 'pending_review' so the existing instructor queue picks it up. Nothing here
// ever leaves a submission stuck in 'pending_ai'.
import { createClient } from "https://esm.sh/@supabase/supabase-js@2.45.4";
import {
  EVAL_TOOL,
  PASS_MARK,
  buildSystemPrompt,
  buildUserText,
  computeScore,
  decideOutcome,
  extractImageUrls,
  feedbackText,
  hasUrl,
  nonUrlTextLength,
  parseEvaluation,
  type RubricItem,
} from "./logic.ts";

const cors = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};
const json = (body: unknown, status = 200) =>
  new Response(JSON.stringify(body), { status, headers: { ...cors, "Content-Type": "application/json" } });

const DEFAULT_MODEL = "claude-sonnet-5";
const DAILY_LIMIT = 15; // evaluations per member per rolling 24h (cost + abuse guard)

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: cors });

  const url = Deno.env.get("SUPABASE_URL")!;
  const anonKey = Deno.env.get("SUPABASE_ANON_KEY")!;
  const serviceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
  const apiKey = Deno.env.get("ANTHROPIC_API_KEY") ?? "";
  const model = Deno.env.get("EVAL_MODEL") || DEFAULT_MODEL;

  let submissionId = "";
  try {
    ({ submission_id: submissionId } = await req.json());
  } catch {
    return json({ error: "Bad request" }, 400);
  }
  if (!submissionId) return json({ error: "submission_id is required" }, 400);

  // Who is asking?
  const asUser = createClient(url, anonKey, { global: { headers: { Authorization: req.headers.get("Authorization") ?? "" } } });
  const { data: { user } } = await asUser.auth.getUser();
  if (!user) return json({ error: "Not authenticated" }, 401);

  const db = createClient(url, serviceKey, { auth: { persistSession: false } });

  const { data: sub } = await db.from("submission").select("*").eq("id", submissionId).maybeSingle();
  if (!sub || sub.user_id !== user.id) return json({ error: "Not found" }, 404);
  if (sub.status !== "pending_ai") return json({ ok: true, status: sub.status, skipped: true });

  const log = (outcome: string, result: unknown = null) =>
    db.from("ai_evaluation_log").insert({ user_id: user.id, submission_id: sub.id, day_id: sub.day_id, model, outcome, result });
  const park = async (outcome: string, note: string) => {
    await db.from("submission").update({ status: "pending_review", feedback: note }).eq("id", sub.id);
    await log(outcome, { note });
    return json({ ok: true, status: "pending_review", fallback: true });
  };

  try {
    const { data: day } = await db
      .from("day")
      .select("title, objective, assignment_md, rubric, rubric_version")
      .eq("id", sub.day_id)
      .maybeSingle();
    const rubric: RubricItem[] = Array.isArray(day?.rubric) ? day!.rubric : [];
    if (!day || rubric.length === 0) return await park("skipped", "This day has no rubric, so a person will review it.");

    if (!apiKey) return await park("no_key", "Automatic scoring is not switched on yet, so a person will review your work.");

    // Rolling daily limit.
    const since = new Date(Date.now() - 24 * 3600 * 1000).toISOString();
    const { count } = await db
      .from("ai_evaluation_log")
      .select("id", { count: "exact", head: true })
      .eq("user_id", user.id)
      .in("outcome", ["scored", "needs_revision", "pending_review"])
      .gte("created_at", since);
    if ((count ?? 0) >= DAILY_LIMIT) {
      return await park("rate_limited", "You have reached today's automatic scoring limit, so a person will review this one.");
    }

    const text: string = sub.content ?? "";
    const images = extractImageUrls(text);
    // Only a link to something we cannot open: nothing for the AI to judge.
    if (images.length === 0 && hasUrl(text) && nonUrlTextLength(text) < 60) {
      return await park("skipped", "Your work is a link the scorer cannot open, so a person will review it. Tip: paste the key text or use a direct image link next time.");
    }

    const content: unknown[] = [{ type: "text", text: buildUserText({ ...day, rubric }, text) }];
    for (const u of images) content.push({ type: "image", source: { type: "url", url: u } });

    const ctrl = new AbortController();
    const timer = setTimeout(() => ctrl.abort(), 55000);
    const res = await fetch("https://api.anthropic.com/v1/messages", {
      method: "POST",
      signal: ctrl.signal,
      headers: { "x-api-key": apiKey, "anthropic-version": "2023-06-01", "content-type": "application/json" },
      body: JSON.stringify({
        model,
        max_tokens: 1500,
        system: buildSystemPrompt(),
        tools: [EVAL_TOOL],
        tool_choice: { type: "tool", name: EVAL_TOOL.name },
        messages: [{ role: "user", content }],
      }),
    });
    clearTimeout(timer);
    if (!res.ok) return await park("error", "Automatic scoring is unavailable right now, so a person will review your work.");

    const data = await res.json();
    const toolUse = (data.content ?? []).find((b: { type: string }) => b.type === "tool_use");
    const parsed = parseEvaluation(toolUse?.input, rubric);
    if (!parsed.ok) return await park("error", "Automatic scoring could not read this one, so a person will review it.");

    const ev = parsed.value;
    const score = computeScore(rubric, ev.criteria);
    const outcome = decideOutcome(score, ev.confidence, ev.flags);

    await db
      .from("submission")
      .update({
        status: outcome,
        score,
        feedback: feedbackText(ev),
        ai_scores: { criteria: ev.criteria, total: score, pass_mark: PASS_MARK },
        ai_feedback: { strengths: ev.strengths, fixes: ev.fixes, next_step: ev.next_step, flags: ev.flags },
        ai_model: model,
        ai_confidence: ev.confidence,
        rubric_version: day.rubric_version ?? 1,
        ai_evaluated_at: new Date().toISOString(),
      })
      .eq("id", sub.id)
      .eq("status", "pending_ai");
    await log(outcome, { score, confidence: ev.confidence, flags: ev.flags });

    // Keep the progress pointer honest (only approved/scored work counts).
    const { count: done } = await db
      .from("submission")
      .select("id", { count: "exact", head: true })
      .eq("enrollment_id", sub.enrollment_id)
      .eq("status", "scored");
    const { data: enr } = await db.from("enrollment").select("total_days").eq("id", sub.enrollment_id).maybeSingle();
    if (enr) {
      await db
        .from("enrollment")
        .update({ current_day: Math.min(Math.max((done ?? 0) + 1, 1), enr.total_days) })
        .eq("id", sub.enrollment_id);
    }

    return json({ ok: true, status: outcome, score });
  } catch (_e) {
    // Never leave a member stuck: hand it to a person.
    return await park("error", "Automatic scoring ran into a problem, so a person will review your work.");
  }
});
