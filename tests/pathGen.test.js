import { describe, it, expect } from "vitest";
import { generatePath } from "../src/lib/pathGen.js";

const tiers = [
  { id: "tb", slug: "basic", ordinal: 1 },
  { id: "tp", slug: "pro", ordinal: 2 },
  { id: "te", slug: "expert", ordinal: 3 },
  { id: "tg", slug: "grandmaster", ordinal: 4 },
];

// 90-day track: basic 1-30, pro 31-60, expert 61-80, grandmaster 81-90.
function fullDays() {
  const days = [];
  const push = (from, to, tierId) => {
    for (let n = from; n <= to; n++) days.push({ id: `d${n}`, day_number: n, tier_id: tierId });
  };
  push(1, 30, "tb");
  push(31, 60, "tp");
  push(61, 80, "te");
  push(81, 90, "tg");
  return days;
}

describe("generatePath", () => {
  it("novice → starts at basic day 1, full 90-day path", () => {
    const p = generatePath({ tiers, days: fullDays(), entryLevel: "novice" });
    expect(p.startTierId).toBe("tb");
    expect(p.startDayNumber).toBe(1);
    expect(p.totalDays).toBe(90);
    expect(p.dayNumbers[0]).toBe(1);
    expect(p.dayNumbers.at(-1)).toBe(90);
  });

  it("intermediate → starts at pro day 31, 60 days through grandmaster", () => {
    const p = generatePath({ tiers, days: fullDays(), entryLevel: "intermediate" });
    expect(p.startTierId).toBe("tp");
    expect(p.startDayNumber).toBe(31);
    expect(p.totalDays).toBe(60);
    expect(p.dayNumbers[0]).toBe(31);
    expect(p.dayNumbers.at(-1)).toBe(90);
  });

  it("advanced → starts at expert day 61, 30 days through grandmaster", () => {
    const p = generatePath({ tiers, days: fullDays(), entryLevel: "advanced" });
    expect(p.startTierId).toBe("te");
    expect(p.startDayNumber).toBe(61);
    expect(p.totalDays).toBe(30);
    expect(p.dayNumbers[0]).toBe(61);
    expect(p.dayNumbers.at(-1)).toBe(90);
  });

  it("higher levels skip earlier-tier days", () => {
    const inter = generatePath({ tiers, days: fullDays(), entryLevel: "intermediate" });
    expect(inter.dayNumbers).not.toContain(30); // last basic day excluded
    expect(Math.min(...inter.dayNumbers)).toBe(31);
  });

  it("sorts unordered day input", () => {
    const shuffled = fullDays().sort(() => Math.random() - 0.5);
    const p = generatePath({ tiers, days: shuffled, entryLevel: "novice" });
    const sorted = [...p.dayNumbers].sort((a, b) => a - b);
    expect(p.dayNumbers).toEqual(sorted);
  });

  it("clamps totalDays when content is shorter than the requested length", () => {
    // Only 10 published days exist; novice wants 90.
    const days = [];
    for (let n = 1; n <= 10; n++) days.push({ id: `d${n}`, day_number: n, tier_id: "tb" });
    const p = generatePath({ tiers, days, entryLevel: "novice" });
    expect(p.requestedDays).toBe(90);
    expect(p.totalDays).toBe(10);
    expect(p.dayNumbers).toHaveLength(10);
  });

  it("throws when the start tier is missing", () => {
    const noPro = tiers.filter((t) => t.slug !== "pro");
    expect(() => generatePath({ tiers: noPro, days: fullDays(), entryLevel: "intermediate" })).toThrow(/pro/);
  });

  it("throws when the start tier has no published days", () => {
    const onlyBasic = fullDays().filter((d) => d.tier_id === "tb");
    expect(() => generatePath({ tiers, days: onlyBasic, entryLevel: "intermediate" })).toThrow(/No published days/);
  });

  it("throws on empty tiers or days", () => {
    expect(() => generatePath({ tiers: [], days: fullDays(), entryLevel: "novice" })).toThrow();
    expect(() => generatePath({ tiers, days: [], entryLevel: "novice" })).toThrow();
  });

  it("throws on unknown entry level", () => {
    expect(() => generatePath({ tiers, days: fullDays(), entryLevel: "legend" })).toThrow();
  });
});
