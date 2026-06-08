import { resolveEntryLevel } from "./academyConfig.js";

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

  const dayNumbers = days
    .map((d) => d.day_number)
    .filter((n) => n >= startDayNumber)
    .sort((a, b) => a - b)
    .slice(0, requestedDays);

  return {
    startTierId: startTierObj.id,
    startTierSlug: startTier,
    startDayNumber,
    requestedDays, // the planned length from config (90/60/30)
    totalDays: dayNumbers.length, // actual available given current content
    dayNumbers,
  };
}
