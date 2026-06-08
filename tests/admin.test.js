// Integration: admin-only enforcement. A non-admin can't read others' profiles or
// write content; an admin can. is_admin() is checked server-side (RLS), not just UI.

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
let plain, adm, cPlain, cAdmin, trackId, tierId;
let createdDayId;

async function signIn(email) {
  const c = createClient(url, anonKey, { auth: { persistSession: false, autoRefreshToken: false } });
  const { error } = await c.auth.signInWithPassword({ email, password: PW });
  if (error) throw error;
  return c;
}

suite("admin-only enforcement", () => {
  beforeAll(async () => {
    trackId = (await admin.from("track").select("id").eq("slug", "ai").single()).data.id;
    tierId = (await admin.from("tier").select("id").eq("track_id", trackId).eq("slug", "basic").single()).data.id;
    plain = (await admin.auth.admin.createUser({ email: mk("ad_plain"), password: PW, email_confirm: true })).data.user;
    adm = (await admin.auth.admin.createUser({ email: mk("ad_admin"), password: PW, email_confirm: true })).data.user;
    await admin.from("profile").update({ is_admin: true }).eq("id", adm.id);
    cPlain = await signIn(mk("ad_plain"));
    cAdmin = await signIn(mk("ad_admin"));
  });

  afterAll(async () => {
    if (!hasEnv) return;
    if (createdDayId) await admin.from("day").delete().eq("id", createdDayId);
    for (const u of [plain, adm]) if (u) await admin.auth.admin.deleteUser(u.id);
  });

  it("is_admin() reflects the flag", async () => {
    expect((await cAdmin.rpc("is_admin")).data).toBe(true);
    expect((await cPlain.rpc("is_admin")).data).toBe(false);
  });

  it("a non-admin sees only their own profile; an admin sees many", async () => {
    const plainRows = (await cPlain.from("profile").select("id")).data ?? [];
    const adminRows = (await cAdmin.from("profile").select("id")).data ?? [];
    expect(plainRows.length).toBe(1);
    expect(adminRows.length).toBeGreaterThan(1);
  });

  it("a non-admin cannot create content", async () => {
    const { error } = await cPlain.from("day").insert({
      track_id: trackId, tier_id: tierId, day_number: 999001,
      objective: "x", lesson_md: "x", skill_focus: "x", assignment_md: "x",
    });
    expect(error).toBeTruthy(); // RLS denies non-admin writes
  });

  it("an admin can create content", async () => {
    const { data, error } = await cAdmin.from("day").insert({
      track_id: trackId, tier_id: tierId, day_number: 999002,
      objective: "x", lesson_md: "x", skill_focus: "x", assignment_md: "x",
    }).select().single();
    expect(error).toBeFalsy();
    createdDayId = data?.id;
  });
});
