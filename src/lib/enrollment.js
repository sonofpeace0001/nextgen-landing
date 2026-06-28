import { generatePath } from "./pathGen.js";
import { DEFAULT_UNLOCK_MODE } from "./academyConfig.js";

// Enrollment service. All reads/writes go through a Supabase client whose RLS
// enforces owner-only access; we never trust a user_id from the caller — it's
// taken from the authenticated session.

export async function listPublishedTracks(supabase) {
  const { data, error } = await supabase
    .from("track")
    .select("id, slug, title, description")
    .eq("is_published", true)
    .order("sort_order");
  if (error) throw error;
  return data ?? [];
}

export async function fetchTrackContent(supabase, trackId) {
  const [tiersRes, daysRes] = await Promise.all([
    supabase.from("tier").select("id, slug, ordinal").eq("track_id", trackId).order("ordinal"),
    supabase
      .from("day")
      .select("id, day_number, tier_id")
      .eq("track_id", trackId)
      .eq("is_published", true)
      .order("day_number"),
  ]);
  if (tiersRes.error) throw tiersRes.error;
  if (daysRes.error) throw daysRes.error;
  return { tiers: tiersRes.data ?? [], days: daysRes.data ?? [] };
}

// Create a dated enrollment for the signed-in user. Returns { enrollment, plan }.
export async function createEnrollment(supabase, { trackId, entryLevel }) {
  const { data: userData, error: userErr } = await supabase.auth.getUser();
  if (userErr) throw userErr;
  const user = userData?.user;
  if (!user) throw new Error("You must be signed in to enroll");

  const { tiers, days } = await fetchTrackContent(supabase, trackId);
  const plan = generatePath({ tiers, days, entryLevel });

  const { data, error } = await supabase
    .from("enrollment")
    .insert({
      user_id: user.id, // RLS with_check requires this to equal auth.uid()
      track_id: trackId,
      entry_level: entryLevel,
      start_tier_id: plan.startTierId,
      total_days: plan.requestedDays,
      current_day: 1,
      unlock_mode: DEFAULT_UNLOCK_MODE,
    })
    .select()
    .single();

  if (error) {
    if (error.code === "23505") throw new Error("You're already enrolled in this track");
    throw error;
  }
  return { enrollment: data, plan };
}

export async function getMyEnrollments(supabase) {
  const { data, error } = await supabase
    .from("enrollment")
    .select("id, track_id, entry_level, start_tier_id, start_date, total_days, current_day, status, unlock_mode")
    .order("created_at", { ascending: false });
  if (error) throw error;
  return data ?? [];
}
