import { describe, it, expect } from "vitest";
import { levelState } from "../src/lib/levels.js";

const full = { basic: true, pro: true, expert: true, grandmaster: true };
const basicOnly = { basic: true, pro: false, expert: false, grandmaster: false };

describe("levelState", () => {
  it("Novice is enrollable when Basic has days (no Elite needed)", () => {
    expect(levelState({ entryLevel: "novice", isElite: false, tierHasDays: basicOnly })).toBe("enrollable");
  });

  it("Novice is coming_soon when Basic is empty", () => {
    expect(levelState({ entryLevel: "novice", isElite: false, tierHasDays: { basic: false } })).toBe("coming_soon");
  });

  it("Intermediate/Advanced require Elite first, regardless of content", () => {
    expect(levelState({ entryLevel: "intermediate", isElite: false, tierHasDays: full })).toBe("requires_elite");
    expect(levelState({ entryLevel: "advanced", isElite: false, tierHasDays: full })).toBe("requires_elite");
  });

  it("Elite + content present → enrollable", () => {
    expect(levelState({ entryLevel: "intermediate", isElite: true, tierHasDays: full })).toBe("enrollable");
    expect(levelState({ entryLevel: "advanced", isElite: true, tierHasDays: full })).toBe("enrollable");
  });

  it("Elite but empty tier → coming_soon (never an empty path)", () => {
    expect(levelState({ entryLevel: "intermediate", isElite: true, tierHasDays: basicOnly })).toBe("coming_soon");
    expect(levelState({ entryLevel: "advanced", isElite: true, tierHasDays: basicOnly })).toBe("coming_soon");
  });

  it("throws on an unknown level", () => {
    expect(() => levelState({ entryLevel: "wizard", isElite: true, tierHasDays: full })).toThrow();
  });
});
