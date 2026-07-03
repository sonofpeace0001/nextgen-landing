import { supabase } from "./supabase.js";

// Fetch ALL site settings in one query and return them as a { key: value }
// object. Rows live in the site_settings table and are edited in Supabase
// Studio (see README); the anon key has read-only access via RLS.
export async function fetchSiteSettings() {
  const { data, error } = await supabase.from("site_settings").select("key, value");
  if (error) throw error;
  return Object.fromEntries((data ?? []).map((r) => [r.key, r.value]));
}
