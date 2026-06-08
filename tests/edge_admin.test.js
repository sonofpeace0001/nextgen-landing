// Integration for the deployed `admin` Edge Function. Runs only when the function
// is deployed: set RUN_EDGE_TESTS=1. Verifies the server-side admin gate and a
// code round-trip + elite toggle.

import { describe, it, expect, beforeAll, afterAll } from "vitest";
import { createClient } from "@supabase/supabase-js";

const url = process.env.SUPABASE_URL;
const anonKey = process.env.SUPABASE_ANON_KEY;
const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
const run = Boolean(url && anonKey && serviceKey) && process.env.RUN_EDGE_TESTS === "1";
const suite = run ? describe : describe.skip;
const admin = run ? createClient(url, serviceKey, { auth: { persistSession: false, autoRefreshToken: false } }) : null;

const PW = "Test-Passw0rd!";
const stamp = Date.now();
const mk = (p) => `${p}_${stamp}@example.com`;
let adminUser, plainUser, cAdmin, cPlain;

async function signIn(email) {
  const c = createClient(url, anonKey, { auth: { persistSession: false, autoRefreshToken: false } });
  const { error } = await c.auth.signInWithPassword({ email, password: PW });
  if (error) throw error;
  return c;
}
const invoke = (c, action, payload = {}) => c.functions.invoke("admin", { body: { action, payload } });

suite("admin Edge Function", () => {
  beforeAll(async () => {
    adminUser = (await admin.auth.admin.createUser({ email: mk("ef_admin"), password: PW, email_confirm: true })).data.user;
    plainUser = (await admin.auth.admin.createUser({ email: mk("ef_plain"), password: PW, email_confirm: true })).data.user;
    await admin.from("profile").update({ is_admin: true }).eq("id", adminUser.id);
    cAdmin = await signIn(mk("ef_admin"));
    cPlain = await signIn(mk("ef_plain"));
  });

  afterAll(async () => {
    if (!run) return;
    await admin.from("access_code").delete().eq("created_by", adminUser?.id);
    for (const u of [adminUser, plainUser]) if (u) await admin.auth.admin.deleteUser(u.id);
  });

  it("rejects a non-admin caller", async () => {
    const { error } = await invoke(cPlain, "code.list");
    expect(error).toBeTruthy(); // 403 from the function
  });

  it("admin can generate, list, and revoke codes", async () => {
    const gen = await invoke(cAdmin, "code.generate", { count: 2 });
    expect(gen.error).toBeFalsy();
    expect(gen.data.codes).toHaveLength(2);
    const codeId = gen.data.codes[0].id;

    const list = await invoke(cAdmin, "code.list");
    expect(list.data.codes.some((c) => c.id === codeId)).toBe(true);

    const rev = await invoke(cAdmin, "code.revoke", { id: codeId });
    expect(rev.error).toBeFalsy();
    const after = await admin.from("access_code").select("revoked").eq("id", codeId).single();
    expect(after.data.revoked).toBe(true);
  });

  it("admin can toggle a member's Elite status", async () => {
    const { error } = await invoke(cAdmin, "member.setElite", { user_id: plainUser.id, is_elite: true });
    expect(error).toBeFalsy();
    const p = await admin.from("profile").select("is_elite").eq("id", plainUser.id).single();
    expect(p.data.is_elite).toBe(true);
  });
});
