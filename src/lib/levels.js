import { ENTRY_LEVELS } from "./academyConfig.js";

// Pure: the state of a level for a given user + track.
//   'enrollable'      — go ahead
//   'requires_elite'  — Intermediate/Advanced and the user is not Elite
//   'coming_soon'     — Elite (or Novice) but the start tier has no published days
// tierHasDays: { [tierSlug]: boolean } — does that tier have >=1 published day?
export function levelState({ entryLevel, isElite, tierHasDays }) {
  const cfg = ENTRY_LEVELS[entryLevel];
  if (!cfg) throw new Error(`Unknown entry level: ${entryLevel}`);

  const needsElite = entryLevel !== "novice";
  if (needsElite && !isElite) return "requires_elite";
  if (!tierHasDays || !tierHasDays[cfg.startTier]) return "coming_soon";
  return "enrollable";
}
