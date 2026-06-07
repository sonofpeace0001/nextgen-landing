import { describe, it, expect } from "vitest";
import {
  ENTRY_LEVELS,
  TIER_ORDER,
  resolveEntryLevel,
  tierOrdinal,
} from "../src/lib/academyConfig.js";

describe("entry-level config", () => {
  it("maps each level to the right start tier and duration", () => {
    expect(resolveEntryLevel("novice")).toEqual({ startTier: "basic", totalDays: 90 });
    expect(resolveEntryLevel("intermediate")).toEqual({ startTier: "pro", totalDays: 60 });
    expect(resolveEntryLevel("advanced")).toEqual({ startTier: "expert", totalDays: 30 });
  });

  it("durations decrease as the entry level rises", () => {
    expect(ENTRY_LEVELS.novice.totalDays).toBeGreaterThan(ENTRY_LEVELS.intermediate.totalDays);
    expect(ENTRY_LEVELS.intermediate.totalDays).toBeGreaterThan(ENTRY_LEVELS.advanced.totalDays);
  });

  it("every start tier is a real tier", () => {
    for (const { startTier } of Object.values(ENTRY_LEVELS)) {
      expect(TIER_ORDER).toContain(startTier);
    }
  });

  it("tierOrdinal is 1-based and matches order", () => {
    expect(tierOrdinal("basic")).toBe(1);
    expect(tierOrdinal("grandmaster")).toBe(4);
  });

  it("throws on unknown level or tier", () => {
    expect(() => resolveEntryLevel("wizard")).toThrow();
    expect(() => tierOrdinal("legend")).toThrow();
  });
});
