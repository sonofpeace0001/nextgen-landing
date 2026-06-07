import { generatePath } from "./pathGen.js";
import { dayStatus } from "./unlock.js";
import { fetchTrackContent } from "./enrollment.js";

// Reconstruct the student's path (ordered day_numbers) from their enrollment.
export async function resolvePlan(supabase, enrollment) {
  const { tiers, days } = await fetchTrackContent(supabase, enrollment.track_id);
  const plan = generatePath({ tiers, days, entryLevel: enrollment.entry_level });
  return { plan, days };
}

export async function getMySubmissions(supabase, enrollmentId) {
  const { data, error } = await supabase
    .from("submission")
    .select("day_id, status, submitted_at")
    .eq("enrollment_id", enrollmentId);
  if (error) throw error;
  return data ?? [];
}

// Full content for one day (published only), plus any auto-graded check.
// NOTE: published day content is readable by any enrolled user via RLS — drip is a
// presentation/business gate here, not a secrecy boundary. Hard-gating future days
// would need a security-definer RPC (revisit if required).
export async function getDayByNumber(supabase, trackId, dayNumber) {
  const { data: day, error } = await supabase
    .from("day")
    .select("*")
    .eq("track_id", trackId)
    .eq("day_number", dayNumber)
    .eq("is_published", true)
    .maybeSingle();
  if (error) throw error;
  if (!day) return null;
  const { data: checks, error: ce } = await supabase.from("day_check").select("*").eq("day_id", day.id);
  if (ce) throw ce;
  return { ...day, checks: checks ?? [] };
}

// Pure: assemble per-day status for the whole path.
//  plan        — from generatePath (has dayNumbers[])
//  days        — track day rows [{ id, day_number }] for id->number mapping
//  submissions — [{ day_id, submitted_at }]
export function buildPathView({ plan, days, submissions, enrollment, today = new Date() }) {
  const numberById = new Map(days.map((d) => [d.id, d.day_number]));
  const indexByNumber = new Map(plan.dayNumbers.map((n, i) => [n, i + 1]));

  const completions = new Map();
  for (const s of submissions) {
    const num = numberById.get(s.day_id);
    const idx = num != null ? indexByNumber.get(num) : undefined;
    if (idx) completions.set(idx, new Date(s.submitted_at));
  }

  const total = plan.dayNumbers.length;
  const view = [];
  for (let i = 1; i <= total; i++) {
    view.push({
      dayIndex: i,
      dayNumber: plan.dayNumbers[i - 1],
      status: dayStatus({
        dayIndex: i,
        total,
        startDate: enrollment.start_date,
        unlockMode: enrollment.unlock_mode,
        completions,
        today,
      }),
    });
  }
  return view;
}
