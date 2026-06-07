// Integration: secure submission + auto-grading via the submit_day RPC.
// Verifies server-side scoring, that students CANNOT overwrite their own score,
// and IDOR/auth guards. Runs against the project in .env.local; skips without env.

import { describe, it, expect, beforeAll, afterAll } from "vitest";
import { createClient } from "@supabase/supabase-js";
import { submitDay } from "../src/lib/submit.js";

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
const emailA = `sub_a_${stamp}@example.com`;
const emailB = `sub_b_${stamp}@example.com`;

let track, basicTier, day1, day2, userA, userB, enrollment, clientA, clientB;

async function signIn(email) {
  const c = createClient(url, anonKey, { auth: { persistSession: false, autoRefreshToken: false } });
  const { error } = await c.auth.signInWithPassword({ email, password: PW });
  if (error) throw error;
  return c;
}

suite("submit_day RPC", () => {
  beforeAll(async () => {
    const tr = await admin.from("track").insert({ slug: `sub_${stamp}`, title: "Sub", is_published: true }).select().single();
    if (tr.error) throw tr.error;
    track = tr.data;

    const ti = await admin.from("tier").insert({ track_id: track.id, slug: "basic", title: "Basic", ordinal: 1 }).select().single();
    if (ti.error) throw ti.error;
    basicTier = ti.data;

    const dayRows = [1, 2].map((n) => ({
      track_id: track.id, tier_id: basicTier.id, day_number: n,
      objective: "o", lesson_md: "l", skill_focus: "s", assignment_md: "a", is_published: true,
    }));
    const days = await admin.from("day").insert(dayRows).select();
    if (days.error) throw days.error;
    [day1, day2] = days.data.sort((a, b) => a.day_number - b.day_number);

    await admin.from("day_check").insert([
      { day_id: day1.id, type: "mcq", pass_pct: 70, items: [
        { q: "q1", options: ["a", "b"], answer: 1 },
        { q: "q2", options: ["x", "y"], answer: 0 },
      ] },
      { day_id: day2.id, type: "mcq", pass_pct: 70, items: [
        { q: "q1", options: ["a", "b"], answer: 0 },
      ] },
    ]);

    const ua = await admin.auth.admin.createUser({ email: emailA, password: PW, email_confirm: true });
    if (ua.error) throw ua.error;
    userA = ua.data.user;
    const ub = await admin.auth.admin.createUser({ email: emailB, password: PW, email_confirm: true });
    if (ub.error) throw ub.error;
    userB = ub.data.user;

    const en = await admin.from("enrollment").insert({
      user_id: userA.id, track_id: track.id, entry_level: "novice", start_tier_id: basicTier.id, total_days: 90,
    }).select().single();
    if (en.error) throw en.error;
    enrollment = en.data;

    clientA = await signIn(emailA);
    clientB = await signIn(emailB);
  });

  afterAll(async () => {
    if (!hasEnv) return;
    await admin.from("submission").delete().eq("enrollment_id", enrollment?.id);
    await admin.from("enrollment").delete().eq("id", enrollment?.id);
    await admin.from("day").delete().eq("track_id", track?.id); // cascades day_check
    await admin.from("tier").delete().eq("track_id", track?.id);
    await admin.from("track").delete().eq("id", track?.id);
    if (userA) await admin.auth.admin.deleteUser(userA.id);
    if (userB) await admin.auth.admin.deleteUser(userB.id);
  });

  it("auto-grades correct answers and composes the final score", async () => {
    const sub = await submitDay(clientA, {
      enrollmentId: enrollment.id, dayId: day1.id, content: "my answer", selfScore: 80, answers: [1, 0],
    });
    expect(Number(sub.check_score)).toBe(100); // both correct
    expect(Number(sub.self_score)).toBe(80);
    expect(Number(sub.score)).toBe(90); // round((100 + 80) / 2)
    expect(sub.status).toBe("scored");
  });

  it("marks a failing check as needs_revision", async () => {
    const sub = await submitDay(clientA, {
      enrollmentId: enrollment.id, dayId: day2.id, content: "x", answers: [1], // wrong (answer is 0)
    });
    expect(Number(sub.check_score)).toBe(0);
    expect(sub.status).toBe("needs_revision");
  });

  it("does NOT let a student overwrite their own score", async () => {
    const before = await clientA.from("submission").select("score").eq("id", (await submitDay(clientA, {
      enrollmentId: enrollment.id, dayId: day1.id, content: "again", selfScore: 80, answers: [1, 0],
    })).id).single();
    // attempt a direct update (no UPDATE policy exists -> silently affects 0 rows)
    await clientA.from("submission").update({ score: 100, check_score: 100 }).eq("enrollment_id", enrollment.id);
    const after = await clientA.from("submission").select("score").eq("day_id", day1.id).single();
    expect(Number(after.data.score)).toBe(Number(before.data.score)); // unchanged (still 90)
    expect(Number(after.data.score)).toBe(90);
  });

  it("rejects submitting to someone else's enrollment (IDOR)", async () => {
    await expect(
      submitDay(clientB, { enrollmentId: enrollment.id, dayId: day1.id, content: "hack", answers: [1, 0] })
    ).rejects.toThrow(/not authorized/i);
  });

  it("rejects an unauthenticated caller", async () => {
    // anon lacks EXECUTE on the function (only 'authenticated' is granted), so it's
    // blocked at the permission layer — even stronger than the in-body auth check.
    const anon = createClient(url, anonKey, { auth: { persistSession: false } });
    await expect(
      submitDay(anon, { enrollmentId: enrollment.id, dayId: day1.id, content: "x", answers: [1, 0] })
    ).rejects.toThrow(/permission denied|not authenticated/i);
  });
});
