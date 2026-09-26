import { supabase } from "./supabase.js";

// Full access = Elite, VIP, admin, someone who unlocked with the library code, or a member whose free
// trial is still running. Enforced in the database (RLS); this is only how the UI finds out.
export async function getMyAccess() {
  const { data: userData } = await supabase.auth.getUser();
  if (!userData?.user) return { signedIn: false, full: false, source: "none", trialEndsAt: null, trialUsed: false };
  const { data, error } = await supabase.rpc("my_access_status");
  if (error || !data) return { signedIn: true, full: false, source: "none", trialEndsAt: null, trialUsed: false };
  return {
    signedIn: true,
    full: data.full === true,
    source: data.source ?? "none",
    trialEndsAt: data.trial_ends_at ?? null,
    trialUsed: data.trial_used === true,
  };
}

// Returns true when the code was accepted (library code, redeem code or a free-trial code). Throws on
// network errors, too many wrong tries, or a trial that was already used.
export async function unlockAccess(code) {
  const { data, error } = await supabase.rpc("unlock_access", { p_code: code });
  if (error) throw new Error(error.message || "Could not check that code.");
  if (data === true && typeof window !== "undefined") window.dispatchEvent(new Event("ng-access-changed"));
  return data === true;
}
