import { supabase } from "./supabase.js";
import { fetchSiteSettings } from "./settings.js";

// Categories + their subcategories in ONE query (embedded resource), so opening
// the library never costs more than a single round trip before a subcategory
// is picked.
export async function fetchCategoriesWithSubcategories() {
  const { data, error } = await supabase
    .from("prompt_categories")
    .select("id, slug, name, description, sort_order, prompt_subcategories(id, slug, name, sort_order)")
    .order("sort_order")
    .order("sort_order", { foreignTable: "prompt_subcategories" });
  if (error) throw error;
  return data ?? [];
}

// Prompts for one subcategory, fetched only once it is selected.
export async function fetchPromptsForSubcategory(subcategoryId) {
  const { data, error } = await supabase
    .from("prompts")
    .select("id, title, body, swap_note, difficulty, sort_order")
    .eq("subcategory_id", subcategoryId)
    .order("sort_order");
  if (error) throw error;
  return data ?? [];
}

// Light gating, not security: this only decides whether to show the library UI
// in this browser tab. The prompt tables are already readable by anon via RLS
// (see the migration), so the code is a members-only courtesy gate, not an
// access-control boundary. Never log the code itself, in success or failure.
export async function checkElitePromptCode(inputCode) {
  const settings = await fetchSiteSettings();
  const real = (settings.elite_prompt_code ?? "").trim().toLowerCase();
  const attempt = (inputCode ?? "").trim().toLowerCase();
  return real.length > 0 && attempt === real;
}
