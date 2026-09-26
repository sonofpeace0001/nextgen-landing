import { supabase } from "./supabase.js";

export const KIND_LABEL = {
  glossary: "Glossary",
  tools: "Tool guide",
  templates: "Templates",
  checklist: "Checklist",
  guide: "Guide",
  prompts: "Sample prompts",
};

// One query: the whole library is small (a few dozen documents), so filtering happens in the browser.
export async function fetchResources() {
  const { data, error } = await supabase
    .from("resource")
    .select("id, category, kind, title, summary, body_md, sort_order")
    .order("sort_order")
    .order("id");
  if (error) throw error;
  return data ?? [];
}

export function filterResources(items, { category, kind, query }) {
  const q = (query || "").trim().toLowerCase();
  return items.filter((r) => {
    if (category && category !== "all" && r.category !== category) return false;
    if (kind && kind !== "all" && r.kind !== kind) return false;
    if (q && !`${r.title} ${r.summary ?? ""} ${r.body_md}`.toLowerCase().includes(q)) return false;
    return true;
  });
}
