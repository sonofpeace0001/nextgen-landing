import { describe, it, expect } from "vitest";
import { dayStatus, highestAccessibleDay } from "../src/lib/unlock.js";

// Calendar-date helper (local midnight-ish; noon avoids DST edges).
const day = (n) => new Date(2026, 0, n, 12, 0, 0);
const noComp = new Map();

describe("dayStatus — date mode", () => {
  const base = { total: 90, startDate: day(1), unlockMode: "date", completions: noComp };

  it("day 1 is unlocked on the start date", () => {
    expect(dayStatus({ ...base, dayIndex: 1, today: day(1) })).toBe("unlocked");
  });
  it("future days are locked until their calendar date", () => {
    expect(dayStatus({ ...base, dayIndex: 2, today: day(1) })).toBe("locked");
    expect(dayStatus({ ...base, dayIndex: 2, today: day(2) })).toBe("unlocked");
    expect(dayStatus({ ...base, dayIndex: 5, today: day(5) })).toBe("unlocked");
    expect(dayStatus({ ...base, dayIndex: 6, today: day(5) })).toBe("locked");
  });
  it("everything is locked before the start date", () => {
    expect(dayStatus({ ...base, dayIndex: 1, today: day(0) })).toBe("locked");
  });
  it("highestAccessibleDay tracks the calendar", () => {
    expect(highestAccessibleDay({ ...base, today: day(5) })).toBe(5);
    expect(highestAccessibleDay({ ...base, today: day(1) })).toBe(1);
  });
});

describe("dayStatus — completion mode", () => {
  const base = { total: 90, startDate: day(1), unlockMode: "completion" };

  it("day 1 unlocked, day 2 locked until day 1 is submitted", () => {
    expect(dayStatus({ ...base, dayIndex: 1, completions: noComp, today: day(1) })).toBe("unlocked");
    expect(dayStatus({ ...base, dayIndex: 2, completions: noComp, today: day(1) })).toBe("locked");
  });
  it("day 2 unlocks the same day once day 1 is done (no cap)", () => {
    const c = new Map([[1, day(1)]]);
    expect(dayStatus({ ...base, dayIndex: 2, completions: c, today: day(1) })).toBe("unlocked");
    expect(dayStatus({ ...base, dayIndex: 3, completions: c, today: day(1) })).toBe("locked");
  });
});

describe("dayStatus — completion_capped mode (default)", () => {
  const base = { total: 90, startDate: day(1), unlockMode: "completion_capped" };

  it("completing day 1 does NOT unlock day 2 the same day", () => {
    const c = new Map([[1, day(1)]]);
    expect(dayStatus({ ...base, dayIndex: 2, completions: c, today: day(1) })).toBe("locked");
  });
  it("day 2 unlocks the next calendar day", () => {
    const c = new Map([[1, day(1)]]);
    expect(dayStatus({ ...base, dayIndex: 2, completions: c, today: day(2) })).toBe("unlocked");
  });
  it("caps progress at one new day per day", () => {
    const c = new Map([[1, day(1)]]);
    // day 1 done, day 2 still locked today => highest accessible is 1
    expect(highestAccessibleDay({ ...base, completions: c, today: day(1) })).toBe(1);
    // next day, day 2 opens
    expect(highestAccessibleDay({ ...base, completions: c, today: day(2) })).toBe(2);
  });
});

describe("dayStatus — shared rules", () => {
  const base = { total: 30, startDate: day(1), unlockMode: "completion", completions: noComp };
  it("a submitted day reports completed", () => {
    const c = new Map([[3, day(3)]]);
    expect(dayStatus({ ...base, dayIndex: 3, completions: c, today: day(5) })).toBe("completed");
  });
  it("out-of-range days are locked", () => {
    expect(dayStatus({ ...base, dayIndex: 0, today: day(1) })).toBe("locked");
    expect(dayStatus({ ...base, dayIndex: 31, today: day(1) })).toBe("locked");
  });
});
