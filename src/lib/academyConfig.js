// Data-driven academy configuration. Change durations, add levels, or tune
// unlock/scoring defaults HERE — not in feature logic. Path generation (Phase 2)
// and drip/unlock (Phase 3) read from this module.

export const TIER_ORDER = ["basic", "pro", "expert", "grandmaster"];

// Entry level (self-selected at signup) -> start tier + total path length in days.
// Novice runs the full path; Intermediate/Advanced start further in and run shorter.
export const ENTRY_LEVELS = {
  novice: { startTier: "basic", totalDays: 90 },
  intermediate: { startTier: "pro", totalDays: 60 },
  advanced: { startTier: "expert", totalDays: 30 },
};

// Drip default: completion-gated — the next day unlocks as soon as the previous
// one is completed (no calendar-day cooldown), so members can move at their pace.
export const DEFAULT_UNLOCK_MODE = "completion";

// Auto-graded checks must hit this percent to count as passed.
export const DEFAULT_PASS_PCT = 70;

export function resolveEntryLevel(level) {
  const cfg = ENTRY_LEVELS[level];
  if (!cfg) throw new Error(`Unknown entry level: ${level}`);
  return cfg;
}

export function tierOrdinal(slug) {
  const i = TIER_ORDER.indexOf(slug);
  if (i === -1) throw new Error(`Unknown tier: ${slug}`);
  return i + 1; // 1-based, matches tier.ordinal in the DB
}
