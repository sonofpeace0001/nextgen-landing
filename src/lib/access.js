import { supabase } from "./supabase.js";

// Full access = Elite member, admin, or someone who unlocked with the library code or a redeem code.
// Enforced in the database (RLS); this is only how the UI finds out.
export async function getMyAccess() {
  const { data: userData } = await supabase.auth.getUser();
  if (!userData?.user) return { signedIn: false, full: false };
  const { data, error } = await supabase.rpc("has_full_access");
  if (error) return { signedIn: true, full: false };
  return { signedIn: true, full: data === true };
}

// Returns true when the code was accepted. Throws on network errors or when too many wrong tries.
export async function unlockAccess(code) {
  const { data, error } = await supabase.rpc("unlock_access", { p_code: code });
  if (error) throw new Error(error.message || "Could not check that code.");
  return data === true;
}
