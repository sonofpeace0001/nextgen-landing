import { TIER_ORDER } from "./academyConfig.js";

// Pure streak calculation. Current streak = consecutive calendar days (ending today,
// or yesterday if nothing yet today) on which at least one day was completed.
function startOfDay(d) {
  const x = new Date(d);
  x.setHours(0, 0, 0, 0);
  return x;
}
function addDays(d, n) {
  const x = startOfDay(d);
  x.setDate(x.getDate() + n);
  return x;
}
function key(d) {
  const x = startOfDay(d);
  return `${x.getFullYear()}-${x.getMonth()}-${x.getDate()}`;
}

export function currentStreak(dates, today = new Date()) {
  if (!dates || dates.length === 0) return 0;
  const seen = new Set(dates.map((d) => key(d)));
  let cursor = startOfDay(today);
  if (!seen.has(key(cursor))) {
    // allow the streak to "hold" if you were active yesterday but not yet today
    cursor = addDays(cursor, -1);
    if (!seen.has(key(cursor))) return 0;
  }
  let streak = 0;
  while (seen.has(key(cursor))) {
    streak += 1;
    cursor = addDays(cursor, -1);
  }
  return streak;
}

export function tierName(ordinal) {
  const slug = TIER_ORDER[Math.max((ordinal ?? 1) - 1, 0)] ?? TIER_ORDER[0];
  return slug.charAt(0).toUpperCase() + slug.slice(1);
}

// Read the owner-only progress view row (RLS via security_invoker).
export async function getProgress(supabase, enrollmentId) {
  const { data, error } = await supabase
    .from("progress")
    .select("*")
    .eq("enrollment_id", enrollmentId)
    .maybeSingle();
  if (error) throw error;
  return data;
}
