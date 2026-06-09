// Integration: the DB-level Elite gate on enrollment. A non-elite user can enroll
// Novice but NOT Intermediate/Advanced; an elite user can. Enforced by RLS with_check.

import { describe, it, expect, beforeAll, afterAll } from "vitest";
import { createClient } from "@supabase/supabase-js";

const url = process.env.SUPABASE_URL;
const anonKey = process.env.SUPABASE_ANON_KEY;
const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
const hasEnv = Boolean(url && anonKey && serviceKey);
const suite = hasEnv ? describe : describe.skip;
const admin = hasEnv ? createClient(url, serviceKey, { auth: { persistSession: false, autoRefreshToken: false } }) : null;

const PW = "Test-Passw0rd!";
const stamp = Date.now();
const mk = (p) => `${p}_${stamp}@example.com`;
let plain, elite, cPlain, cElite, trackId, tierId;

async function signIn(email) {
  const c = createClient(url, anonKey, { auth: { persistSession: false, autoRefreshToken: false } });
  const { error } = await c.auth.signInWithPassword({ email, password: PW });
  if (error) throw error;
  return c;
}

suite("enrollment Elite gate", () => {
  beforeAll(async () => {
    const tr = (await admin.from("track").select("id").eq("slug", "ai").single()).data;
    trackId = tr.id;
    tierId = (await admin.from("tier").select("id").eq("track_id", trackId).eq("slug", "basic").single()).data.id;

    plain = (await admin.auth.admin.createUser({ email: mk("eg_plain"), password: PW, email_confirm: true })).data.user;
    elite = (await admin.auth.admin.createUser({ email: mk("eg_elite"), password: PW, email_confirm: true })).data.user;
    await admin.from("profile").update({ is_elite: true }).eq("id", elite.id); // service_role can set it
    cPlain = await signIn(mk("eg_plain"));
    cElite = await signIn(mk("eg_elite"));
  });

  afterAll(async () => {
    if (!hasEnv) return;
    await admin.from("enrollment").delete().in("user_id", [plain?.id, elite?.id].filter(Boolean));
    for (const u of [plain, elite]) if (u) await admin.auth.admin.deleteUser(u.id);
  });

  const row = (userId, level) => ({
    user_id: userId, track_id: trackId, entry_level: level, start_tier_id: tierId, total_days: 60,
  });

  it("non-elite is blocked from Intermediate", async () => {
    const { error } = await cPlain.from("enrollment").insert(row(plain.id, "intermediate"));
    expect(error).toBeTruthy(); // RLS with_check fails
  });

  it("non-elite is blocked from Advanced", async () => {
    const { error } = await cPlain.from("enrollment").insert(row(plain.id, "advanced"));
    expect(error).toBeTruthy();
  });

  it("non-elite CAN enroll Novice", async () => {
    const { error } = await cPlain.from("enrollment").insert({ ...row(plain.id, "novice"), total_days: 90 });
    expect(error).toBeFalsy();
  });

  it("elite CAN enroll Intermediate", async () => {
    const { error } = await cElite.from("enrollment").insert(row(elite.id, "intermediate"));
    expect(error).toBeFalsy();
  });
});
