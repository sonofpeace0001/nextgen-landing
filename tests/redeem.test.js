// Integration: Elite code redemption + the "is_elite is not self-settable" guard.
// Runs against the project in .env.local; skips without env.

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
let A, B, C, cA, cB, cC;
const codes = {};

async function signIn(email) {
  const c = createClient(url, anonKey, { auth: { persistSession: false, autoRefreshToken: false } });
  const { error } = await c.auth.signInWithPassword({ email, password: PW });
  if (error) throw error;
  return c;
}
const isElite = async (id) => (await admin.from("profile").select("is_elite").eq("id", id).single()).data?.is_elite;

suite("redeem_code + is_elite guard", () => {
  beforeAll(async () => {
    A = (await admin.auth.admin.createUser({ email: mk("rd_a"), password: PW, email_confirm: true })).data.user;
    B = (await admin.auth.admin.createUser({ email: mk("rd_b"), password: PW, email_confirm: true })).data.user;
    C = (await admin.auth.admin.createUser({ email: mk("rd_c"), password: PW, email_confirm: true })).data.user;
    cA = await signIn(mk("rd_a")); cB = await signIn(mk("rd_b")); cC = await signIn(mk("rd_c"));

    const ins = async (row) => (await admin.from("access_code").insert(row).select().single()).data;
    codes.valid = await ins({ code: `valid_${stamp}`, max_uses: 1 });
    codes.revoked = await ins({ code: `revoked_${stamp}`, revoked: true });
    codes.expired = await ins({ code: `expired_${stamp}`, expires_at: new Date(Date.now() - 86400000).toISOString() });
    codes.full = await ins({ code: `full_${stamp}`, max_uses: 1, used_count: 1 });
    codes.multi = await ins({ code: `multi_${stamp}`, max_uses: 2 });
  });

  afterAll(async () => {
    if (!hasEnv) return;
    await admin.from("redemption").delete().in("user_id", [A?.id, B?.id, C?.id].filter(Boolean));
    await admin.from("access_code").delete().in("id", Object.values(codes).map((c) => c.id));
    for (const u of [A, B, C]) if (u) await admin.auth.admin.deleteUser(u.id);
  });

  it("a valid code makes the caller elite", async () => {
    const { error } = await cA.rpc("redeem_code", { p_code: `valid_${stamp}` });
    expect(error).toBeFalsy();
    expect(await isElite(A.id)).toBe(true);
  });

  it("the same user cannot redeem the same code twice (multi-use code)", async () => {
    const first = await cA.rpc("redeem_code", { p_code: `multi_${stamp}` });
    expect(first.error).toBeFalsy();
    const second = await cA.rpc("redeem_code", { p_code: `multi_${stamp}` });
    expect(second.error?.message).toMatch(/already redeemed/i);
  });

  it("rejects an invalid code", async () => {
    const { error } = await cB.rpc("redeem_code", { p_code: "does-not-exist" });
    expect(error?.message).toMatch(/invalid/i);
  });

  it("rejects a revoked code", async () => {
    const { error } = await cB.rpc("redeem_code", { p_code: `revoked_${stamp}` });
    expect(error?.message).toMatch(/revoked/i);
  });

  it("rejects an expired code", async () => {
    const { error } = await cB.rpc("redeem_code", { p_code: `expired_${stamp}` });
    expect(error?.message).toMatch(/expired/i);
  });

  it("rejects a fully-used code", async () => {
    const { error } = await cB.rpc("redeem_code", { p_code: `full_${stamp}` });
    expect(error?.message).toMatch(/fully used/i);
  });

  it("a user CANNOT set is_elite on themselves", async () => {
    await cC.from("profile").update({ is_elite: true }).eq("id", C.id);
    expect(await isElite(C.id)).toBe(false); // column grant blocks it
  });
});
