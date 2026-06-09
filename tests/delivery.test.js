import { describe, it, expect } from "vitest";
import { buildPathView } from "../src/lib/delivery.js";

const day = (n) => new Date(2026, 0, n, 12, 0, 0);

// Intermediate-style plan: path begins at day_number 5.
const plan = { dayNumbers: [5, 6, 7] };
const days = [
  { id: "a", day_number: 5 },
  { id: "b", day_number: 6 },
  { id: "c", day_number: 7 },
];

describe("buildPathView", () => {
  it("maps path indexes to day_numbers in order", () => {
    const view = buildPathView({
      plan,
      days,
      submissions: [],
      enrollment: { start_date: day(1), unlock_mode: "completion" },
      today: day(1),
    });
    expect(view.map((v) => v.dayIndex)).toEqual([1, 2, 3]);
    expect(view.map((v) => v.dayNumber)).toEqual([5, 6, 7]);
  });

  it("reflects completion + unlock from submissions", () => {
    const view = buildPathView({
      plan,
      days,
      submissions: [{ day_id: "a", submitted_at: day(1).toISOString(), status: "scored" }],
      enrollment: { start_date: day(1), unlock_mode: "completion" },
      today: day(1),
    });
    expect(view[0].status).toBe("completed"); // day_number 5 submitted
    expect(view[1].status).toBe("unlocked"); // next unlocks (completion mode)
    expect(view[2].status).toBe("locked");
  });

  it("honors the capped mode (next day not open same day)", () => {
    const view = buildPathView({
      plan,
      days,
      submissions: [{ day_id: "a", submitted_at: day(1).toISOString(), status: "scored" }],
      enrollment: { start_date: day(1), unlock_mode: "completion_capped" },
      today: day(1),
    });
    expect(view[0].status).toBe("completed");
    expect(view[1].status).toBe("locked"); // capped: must wait a calendar day
  });

  it("ignores submissions for days outside the path", () => {
    const view = buildPathView({
      plan,
      days,
      submissions: [{ day_id: "zzz", submitted_at: day(1).toISOString(), status: "scored" }],
      enrollment: { start_date: day(1), unlock_mode: "completion" },
      today: day(1),
    });
    expect(view[0].status).toBe("unlocked"); // day 1 still just unlocked, not completed
  });

  it("does not complete a day for a needs_revision submission", () => {
    const view = buildPathView({
      plan,
      days,
      submissions: [{ day_id: "a", submitted_at: day(1).toISOString(), status: "needs_revision" }],
      enrollment: { start_date: day(1), unlock_mode: "completion" },
      today: day(1),
    });
    expect(view[0].status).toBe("unlocked"); // retry, not completed
    expect(view[1].status).toBe("locked"); // next stays locked
  });

  it("treats a pending_review submission as completed (non-blocking)", () => {
    const view = buildPathView({
      plan,
      days,
      submissions: [{ day_id: "a", submitted_at: day(1).toISOString(), status: "pending_review" }],
      enrollment: { start_date: day(1), unlock_mode: "completion" },
      today: day(1),
    });
    expect(view[0].status).toBe("completed"); // counts as submitted
    expect(view[1].status).toBe("unlocked"); // next opens while review is pending
  });
});
