// Integration smoke tests for RLS / IDOR. Runs against the Supabase project in
// .env.local. Skips automatically if env is absent (e.g. CI without secrets).
//
// Creates two throwaway users + isolated fixtures via service_role, asserts that
// content publish-gating and owner-only access hold, then cleans everything up.

import { describe, it, expect, beforeAll, afterAll } from "vitest";
import { createClient } from "@supabase/supabase-js";

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
const emailA = `rls_a_${stamp}@example.com`;
const emailB = `rls_b_${stamp}@example.com`;

let publishedTrack, unpublishedTrack, tierId, dayId, userA, userB, enrollmentId, submissionId;

async function signedInClient(email) {
  const c = createClient(url, anonKey, { auth: { persistSession: false, autoRefreshToken: false } });
  const { error } = await c.auth.signInWithPassword({ email, password: PW });
  if (error) throw error;
  return c;
}

suite("RLS / IDOR", () => {
  beforeAll(async () => {
    const pub = await admin
      .from("track")
      .insert({ slug: `pub_${stamp}`, title: "Pub", is_published: true })
      .select()
      .single();
    if (pub.error) throw pub.error;
    publishedTrack = pub.data;

    const unp = await admin
      .from("track")
      .insert({ slug: `unp_${stamp}`, title: "Unp", is_published: false })
      .select()
      .single();
    if (unp.error) throw unp.error;
    unpublishedTrack = unp.data;

    const tier = await admin
      .from("tier")
      .insert({ track_id: publishedTrack.id, slug: "basic", title: "Basic", ordinal: 1 })
      .select()
      .single();
    if (tier.error) throw tier.error;
    tierId = tier.data.id;

    const day = await admin
      .from("day")
      .insert({
        track_id: publishedTrack.id,
        tier_id: tierId,
        day_number: 1,
        objective: "o",
        lesson_md: "l",
        skill_focus: "s",
        assignment_md: "a",
        is_published: true,
      })
      .select()
      .single();
    if (day.error) throw day.error;
    dayId = day.data.id;

    const ua = await admin.auth.admin.createUser({ email: emailA, password: PW, email_confirm: true });
    if (ua.error) throw ua.error;
    userA = ua.data.user;
    const ub = await admin.auth.admin.createUser({ email: emailB, password: PW, email_confirm: true });
    if (ub.error) throw ub.error;
    userB = ub.data.user;

    const en = await admin
      .from("enrollment")
      .insert({
        user_id: userA.id,
        track_id: publishedTrack.id,
        entry_level: "novice",
        start_tier_id: tierId,
        total_days: 90,
      })
      .select()
      .single();
    if (en.error) throw en.error;
    enrollmentId = en.data.id;

    const sub = await admin
      .from("submission")
      .insert({ enrollment_id: enrollmentId, user_id: userA.id, day_id: dayId, content: "x" })
      .select()
      .single();
    if (sub.error) throw sub.error;
    submissionId = sub.data.id;
  });

  afterAll(async () => {
    if (!hasEnv) return;
    await admin.from("submission").delete().eq("id", submissionId);
    await admin.from("enrollment").delete().eq("id", enrollmentId);
    await admin.from("day").delete().eq("id", dayId);
    await admin.from("tier").delete().eq("id", tierId);
    await admin.from("track").delete().in("id", [publishedTrack?.id, unpublishedTrack?.id].filter(Boolean));
    if (userA) await admin.auth.admin.deleteUser(userA.id);
    if (userB) await admin.auth.admin.deleteUser(userB.id);
  });

  it("anon can read a published track", async () => {
    const anon = createClient(url, anonKey, { auth: { persistSession: false } });
    const { data } = await anon.from("track").select("id").eq("id", publishedTrack.id);
    expect(data).toHaveLength(1);
  });

  it("anon cannot read an unpublished track", async () => {
    const anon = createClient(url, anonKey, { auth: { persistSession: false } });
    const { data } = await anon.from("track").select("id").eq("id", unpublishedTrack.id);
    expect(data).toHaveLength(0);
  });

  it("user B cannot read user A's enrollment (IDOR)", async () => {
    const cb = await signedInClient(emailB);
    const { data } = await cb.from("enrollment").select("id").eq("id", enrollmentId);
    expect(data).toHaveLength(0);
  });

  it("user B cannot read user A's submission (IDOR)", async () => {
    const cb = await signedInClient(emailB);
    const { data } = await cb.from("submission").select("id").eq("id", submissionId);
    expect(data).toHaveLength(0);
  });

  it("user A can read their own enrollment and submission", async () => {
    const ca = await signedInClient(emailA);
    const e = await ca.from("enrollment").select("id").eq("id", enrollmentId);
    expect(e.data).toHaveLength(1);
    const s = await ca.from("submission").select("id").eq("id", submissionId);
    expect(s.data).toHaveLength(1);
  });

  it("user B cannot insert a submission into user A's enrollment", async () => {
    const cb = await signedInClient(emailB);
    const { error } = await cb
      .from("submission")
      .insert({ enrollment_id: enrollmentId, user_id: userB.id, day_id: dayId, content: "hack" });
    expect(error).toBeTruthy();
  });
});
