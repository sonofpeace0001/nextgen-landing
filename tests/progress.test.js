import { describe, it, expect, beforeAll, afterAll } from "vitest";
import { createClient } from "@supabase/supabase-js";
import { currentStreak, tierName, getProgress } from "../src/lib/progress.js";
import { submitDay } from "../src/lib/submit.js";

const day = (n) => new Date(2026, 0, n, 12, 0, 0);

describe("currentStreak", () => {
  it("counts consecutive days ending today", () => {
    expect(currentStreak([day(3), day(4), day(5)], day(5))).toBe(3);
  });
  it("is 1 for activity only today", () => {
    expect(currentStreak([day(5)], day(5))).toBe(1);
  });
  it("breaks on a gap", () => {
    expect(currentStreak([day(5), day(3)], day(5))).toBe(1); // missing day 4
  });
  it("holds if active yesterday but not yet today", () => {
    expect(currentStreak([day(4)], day(5))).toBe(1);
  });
  it("is 0 once two+ days have passed with no activity", () => {
    expect(currentStreak([day(3)], day(5))).toBe(0);
  });
  it("dedupes multiple completions on the same day", () => {
    expect(currentStreak([day(5), day(5), day(4)], day(5))).toBe(2);
  });
  it("is 0 for no activity", () => {
    expect(currentStreak([], day(5))).toBe(0);
  });
});

describe("tierName", () => {
  it("maps ordinals to names", () => {
    expect(tierName(1)).toBe("Basic");
    expect(tierName(2)).toBe("Pro");
    expect(tierName(4)).toBe("Grandmaster");
  });
  it("falls back to Basic for 0/undefined", () => {
    expect(tierName(0)).toBe("Basic");
    expect(tierName(undefined)).toBe("Basic");
  });
});

// ---- Integration: the progress view aggregates and stays owner-only ----
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
const emailA = `prog_a_${stamp}@example.com`;
const emailB = `prog_b_${stamp}@example.com`;

let track, tier, d1, userA, userB, enrollment, clientA, clientB;

async function signIn(email) {
  const c = createClient(url, anonKey, { auth: { persistSession: false, autoRefreshToken: false } });
  const { error } = await c.auth.signInWithPassword({ email, password: PW });
  if (error) throw error;
  return c;
}

suite("progress view", () => {
  beforeAll(async () => {
    track = (await admin.from("track").insert({ slug: `prog_${stamp}`, title: "Prog", is_published: true }).select().single()).data;
    tier = (await admin.from("tier").insert({ track_id: track.id, slug: "basic", title: "Basic", ordinal: 1 }).select().single()).data;
    d1 = (await admin.from("day").insert({
      track_id: track.id, tier_id: tier.id, day_number: 1,
      objective: "o", lesson_md: "l", skill_focus: "s", assignment_md: "a", is_published: true,
    }).select().single()).data;
    await admin.from("day_check").insert({ day_id: d1.id, type: "mcq", pass_pct: 70, items: [{ q: "q", options: ["a", "b"], answer: 0 }] });

    userA = (await admin.auth.admin.createUser({ email: emailA, password: PW, email_confirm: true })).data.user;
    userB = (await admin.auth.admin.createUser({ email: emailB, password: PW, email_confirm: true })).data.user;
    enrollment = (await admin.from("enrollment").insert({
      user_id: userA.id, track_id: track.id, entry_level: "novice", start_tier_id: tier.id, total_days: 90,
    }).select().single()).data;

    clientA = await signIn(emailA);
    clientB = await signIn(emailB);
    await submitDay(clientA, { enrollmentId: enrollment.id, dayId: d1.id, content: "x", selfScore: 80, answers: [0] });
  });

  afterAll(async () => {
    if (!hasEnv) return;
    await admin.from("submission").delete().eq("enrollment_id", enrollment?.id);
    await admin.from("enrollment").delete().eq("id", enrollment?.id);
    await admin.from("day").delete().eq("track_id", track?.id);
    await admin.from("tier").delete().eq("track_id", track?.id);
    await admin.from("track").delete().eq("id", track?.id);
    if (userA) await admin.auth.admin.deleteUser(userA.id);
    if (userB) await admin.auth.admin.deleteUser(userB.id);
  });

  it("aggregates the owner's completed work", async () => {
    const p = await getProgress(clientA, enrollment.id);
    expect(p).toBeTruthy();
    expect(Number(p.days_scored)).toBe(1);
    expect(Number(p.cumulative_score)).toBe(90); // (100 + 80) / 2
    expect(Number(p.tier_reached)).toBe(1);
    expect(Number(p.current_day)).toBe(2); // advanced after the submission
  });

  it("is not visible to another user", async () => {
    const p = await getProgress(clientB, enrollment.id);
    expect(p).toBeNull();
  });
});
