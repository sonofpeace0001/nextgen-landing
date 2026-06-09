import { fetchTrackContent } from "./enrollment.js";

// The signed-in user's own profile (is_elite / is_admin).
export async function getMyProfile(supabase) {
  const { data: userData } = await supabase.auth.getUser();
  const user = userData?.user;
  if (!user) return null;
  const { data, error } = await supabase
    .from("profile")
    .select("is_elite, is_admin, email, display_name")
    .eq("id", user.id)
    .maybeSingle();
  if (error) throw error;
  return data;
}

// Redeem an Elite code (server-side validated; flips own is_elite).
export async function redeemCode(supabase, code) {
  const { data, error } = await supabase.rpc("redeem_code", { p_code: code });
  if (error) throw error;
  return data;
}

// Which tier slugs in a track currently have >=1 published day → { slug: bool }.
export async function trackTierAvailability(supabase, trackId) {
  const { tiers, days } = await fetchTrackContent(supabase, trackId);
  const counts = {};
  for (const t of tiers) counts[t.slug] = false;
  for (const d of days) {
    const tier = tiers.find((t) => t.id === d.tier_id);
    if (tier) counts[tier.slug] = true;
  }
  return counts;
}
