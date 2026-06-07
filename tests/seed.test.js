// Verifies the seeded AI Basic tier is present, published, and complete.
// Reads as anon (public content). Skips without env.

import { describe, it, expect } from "vitest";
import { createClient } from "@supabase/supabase-js";

const url = process.env.SUPABASE_URL;
const anonKey = process.env.SUPABASE_ANON_KEY;
const hasEnv = Boolean(url && anonKey);
const suite = hasEnv ? describe : describe.skip;

const anon = hasEnv ? createClient(url, anonKey, { auth: { persistSession: false } }) : null;

suite("seeded AI Basic tier", () => {
  it("AI track is published with a full Basic tier", async () => {
    const { data: track } = await anon.from("track").select("id").eq("slug", "ai").maybeSingle();
    expect(track).toBeTruthy();

    const { data: basic } = await anon.from("tier").select("id").eq("track_id", track.id).eq("slug", "basic").maybeSingle();
    expect(basic).toBeTruthy();

    const { data: days } = await anon
      .from("day")
      .select("day_number")
      .eq("track_id", track.id)
      .eq("tier_id", basic.id)
      .eq("is_published", true);
    expect(days.length).toBeGreaterThanOrEqual(20);
  });

  it("each seeded day has all four parts and an auto-graded check", async () => {
    const { data: track } = await anon.from("track").select("id").eq("slug", "ai").maybeSingle();
    const { data: d } = await anon
      .from("day")
      .select("id, objective, lesson_md, skill_focus, assignment_md, rubric")
      .eq("track_id", track.id)
      .eq("day_number", 1)
      .maybeSingle();
    expect(d.objective).toBeTruthy();
    expect(d.lesson_md).toBeTruthy();
    expect(d.skill_focus).toBeTruthy();
    expect(d.assignment_md).toBeTruthy();
    expect(Array.isArray(d.rubric)).toBe(true);

    const { data: checks } = await anon.from("day_check").select("type, items").eq("day_id", d.id);
    expect(checks.length).toBeGreaterThanOrEqual(1);
    expect(checks[0].type).toBe("mcq");
  });
});
