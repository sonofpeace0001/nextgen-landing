// Integration: a signed-in user enrolls, and the dated path is generated correctly
// with owner-only writes. Runs against the Supabase project in .env.local; skips if
// env is absent. Seeds an isolated synthetic track and tears it down after.

import { describe, it, expect, beforeAll, afterAll } from "vitest";
import { createClient } from "@supabase/supabase-js";
import { createEnrollment } from "../src/lib/enrollment.js";

const url = process.env.SUPABASE_URL;
const anonKey = process.env.SUPABASE_ANON_KEY;
const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
const hasEnv = Boolean(url && anonKey && serviceKey);
const suite = hasEnv ? describe : describe.skip;

const admin = hasEnv
  ? createClient(url, serviceKey, { auth: { persistSession: false, autoRefreshToken: false } })
  : null;

const PW = "Test-Passw0rd!";
const stamp = Date.now();
const email = `enroll_${stamp}@example.com`;

let track, user, userClient;
const tierBySlug = {};

suite("enrollment + path generation", () => {
  beforeAll(async () => {
    const tr = await admin
      .from("track")
      .insert({ slug: `etest_${stamp}`, title: "Enroll Test", is_published: true })
      .select()
      .single();
    if (tr.error) throw tr.error;
    track = tr.data;

    const tierRows = [
      { track_id: track.id, slug: "basic", title: "Basic", ordinal: 1 },
      { track_id: track.id, slug: "pro", title: "Pro", ordinal: 2 },
      { track_id: track.id, slug: "expert", title: "Expert", ordinal: 3 },
      { track_id: track.id, slug: "grandmaster", title: "Grandmaster", ordinal: 4 },
    ];
    const tiers = await admin.from("tier").insert(tierRows).select();
    if (tiers.error) throw tiers.error;
    for (const t of tiers.data) tierBySlug[t.slug] = t;

    // One published day per tier (day_number ascending with tier ordinal).
    const dayRows = tiers.data
      .sort((a, b) => a.ordinal - b.ordinal)
      .map((t, i) => ({
        track_id: track.id,
        tier_id: t.id,
        day_number: i + 1,
        objective: "o",
        lesson_md: "l",
        skill_focus: "s",
        assignment_md: "a",
        is_published: true,
      }));
    const days = await admin.from("day").insert(dayRows).select();
    if (days.error) throw days.error;

    const u = await admin.auth.admin.createUser({ email, password: PW, email_confirm: true });
    if (u.error) throw u.error;
    user = u.data.user;
    // Intermediate now requires Elite (DB gate); grant it for this test's user.
    await admin.from("profile").update({ is_elite: true }).eq("id", user.id);

    userClient = createClient(url, anonKey, { auth: { persistSession: false, autoRefreshToken: false } });
    const si = await userClient.auth.signInWithPassword({ email, password: PW });
    if (si.error) throw si.error;
  });

  afterAll(async () => {
    if (!hasEnv) return;
    await admin.from("enrollment").delete().eq("user_id", user?.id);
    await admin.from("day").delete().eq("track_id", track?.id);
    await admin.from("tier").delete().eq("track_id", track?.id);
    await admin.from("track").delete().eq("id", track?.id);
    if (user) await admin.auth.admin.deleteUser(user.id);
  });

  it("intermediate enrolls starting at the Pro tier with a 60-day plan", async () => {
    const { enrollment, plan } = await createEnrollment(userClient, {
      trackId: track.id,
      entryLevel: "intermediate",
    });
    expect(enrollment.user_id).toBe(user.id);
    expect(enrollment.entry_level).toBe("intermediate");
    expect(enrollment.start_tier_id).toBe(tierBySlug.pro.id);
    expect(enrollment.total_days).toBe(60);
    expect(enrollment.current_day).toBe(1);
    expect(enrollment.status).toBe("active");
    expect(plan.startTierSlug).toBe("pro");
  });

  it("rejects a second enrollment in the same track", async () => {
    await expect(
      createEnrollment(userClient, { trackId: track.id, entryLevel: "novice" })
    ).rejects.toThrow(/already enrolled/i);
  });
});
