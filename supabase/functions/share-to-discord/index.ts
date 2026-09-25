// NEXTGEN share-to-discord Edge Function (Deno).
//
// A member opts in (one click) to post a passed submission to the community Discord.
// The webhook URL lives only in the DISCORD_WEBHOOK_URL secret and is never sent to
// the browser. Only the member's own, scored (>= 80) work can be shared, once.
import { createClient } from "https://esm.sh/@supabase/supabase-js@2.45.4";

const cors = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};
const json = (body: unknown, status = 200) =>
  new Response(JSON.stringify(body), { status, headers: { ...cors, "Content-Type": "application/json" } });

const MIN_SCORE = 80;
const clip = (s: string, n: number) => (s.length > n ? s.slice(0, n - 1) + "…" : s);
// Neutralise markdown links/mentions so a submission cannot inject formatting or pings.
const plain = (s: string) => s.replace(/[@`*_~|>\[\]]/g, "").replace(/\s+/g, " ").trim();
const IMG = /https:\/\/[^\s)<>"']+\.(?:png|jpe?g|webp|gif)(?:\?[^\s)<>"']*)?/i;

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: cors });

  const hook = Deno.env.get("DISCORD_WEBHOOK_URL") ?? "";
  if (!hook.startsWith("https://discord.com/api/webhooks/")) return json({ error: "Sharing is not switched on yet." }, 503);

  let submissionId = "";
  try {
    ({ submission_id: submissionId } = await req.json());
  } catch {
    return json({ error: "Bad request" }, 400);
  }
  if (!submissionId) return json({ error: "submission_id is required" }, 400);

  const url = Deno.env.get("SUPABASE_URL")!;
  const asUser = createClient(url, Deno.env.get("SUPABASE_ANON_KEY")!, { global: { headers: { Authorization: req.headers.get("Authorization") ?? "" } } });
  const { data: { user } } = await asUser.auth.getUser();
  if (!user) return json({ error: "Not authenticated" }, 401);

  const db = createClient(url, Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!, { auth: { persistSession: false } });
  const { data: sub } = await db.from("submission").select("id, user_id, day_id, status, score, content, ai_feedback, share_status").eq("id", submissionId).maybeSingle();
  if (!sub || sub.user_id !== user.id) return json({ error: "Not found" }, 404);
  if (sub.status !== "scored" || (sub.score ?? 0) < MIN_SCORE) return json({ error: `Only approved work scoring ${MIN_SCORE}+ can be shared.` }, 400);
  if (sub.share_status === "shared") return json({ ok: true, already: true });

  const [{ data: day }, { data: prof }] = await Promise.all([
    db.from("day").select("title, day_number, track_id").eq("id", sub.day_id).maybeSingle(),
    db.from("profile").select("display_name").eq("id", user.id).maybeSingle(),
  ]);
  const { data: track } = day ? await db.from("track").select("title").eq("id", day.track_id).maybeSingle() : { data: null };

  const name = plain(prof?.display_name || "") || "A NEXTGEN member";
  const strength = sub.ai_feedback?.strengths?.[0] ? plain(String(sub.ai_feedback.strengths[0])) : "";
  const image = String(sub.content ?? "").match(IMG)?.[0];
  const embed: Record<string, unknown> = {
    title: clip(`${name} scored ${sub.score}/100`, 250),
    description: clip([`**${plain(track?.title || "NEXTGEN")}** · Day ${day?.day_number ?? ""}: ${plain(day?.title || "")}`, strength ? `What worked: ${strength}` : ""].filter(Boolean).join("\n"), 1000),
    color: 0x7c3aed,
  };
  if (image) embed.image = { url: image };

  const res = await fetch(hook, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ username: "NEXTGEN Wins", content: "🎉 New win from the Academy", embeds: [embed], allowed_mentions: { parse: [] } }),
  });
  if (!res.ok) return json({ error: "Discord did not accept the post. Try again later." }, 502);

  await db.from("submission").update({ share_status: "shared" }).eq("id", sub.id);
  return json({ ok: true });
});
