import { resolveEntryLevel, LAB_START_DAY } from "./academyConfig.js";

// Pure path generation — no DB, no IO, fully unit-testable.
// Given a track's tiers + published days and a chosen entry level, work out where
// the student starts (tier + first day) and the ordered day_numbers they'll walk.
//
// Rule: the path begins at the FIRST day of the level's start tier, then takes the
// next `totalDays` published days (config-driven). Higher entry levels skip earlier
// tiers by virtue of starting at a later tier.
//
// @param {{ id:string, slug:string, ordinal:number }[]} tiers
// @param {{ id:string, day_number:number, tier_id:string }[]} days  (published only)
// @param {string} entryLevel  novice | intermediate | advanced
export function generatePath({ tiers, days, entryLevel }) {
  const { startTier, totalDays: requestedDays } = resolveEntryLevel(entryLevel);

  if (!Array.isArray(tiers) || tiers.length === 0) {
    throw new Error("Track has no tiers");
  }
  const startTierObj = tiers.find((t) => t.slug === startTier);
  if (!startTierObj) {
    throw new Error(`Track is missing the '${startTier}' tier`);
  }
  if (!Array.isArray(days) || days.length === 0) {
    throw new Error("Track has no published days");
  }

  const startTierDayNumbers = days
    .filter((d) => d.tier_id === startTierObj.id)
    .map((d) => d.day_number);
  if (startTierDayNumbers.length === 0) {
    throw new Error(`No published days in the '${startTier}' tier yet`);
  }
  const startDayNumber = Math.min(...startTierDayNumbers);

  const allNumbers = days.map((d) => d.day_number).sort((a, b) => a - b);
  // Core path: the next `requestedDays` published days from the start (labs excluded).
  const core = allNumbers.filter((n) => n >= startDayNumber && n < LAB_START_DAY).slice(0, requestedDays);
  // Skill Labs (day 91+) follow the core path for every entry level.
  const labs = allNumbers.filter((n) => n >= LAB_START_DAY);
  const dayNumbers = [...core, ...labs];

  return {
    startTierId: startTierObj.id,
    startTierSlug: startTier,
    startDayNumber,
    labDays: labs.length, // Skill Labs appended after the core path
    requestedDays, // the planned length from config (90/60/30)
    totalDays: dayNumbers.length, // actual available given current content
    dayNumbers,
  };
}
