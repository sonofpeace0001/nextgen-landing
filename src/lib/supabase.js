import { createClient } from "@supabase/supabase-js";

// Browser client. Uses the PUBLIC anon key only — never the service_role key.
const url = import.meta.env.VITE_SUPABASE_URL;
const anonKey = import.meta.env.VITE_SUPABASE_ANON_KEY;

if (!url || !anonKey) {
  // eslint-disable-next-line no-console
  console.warn(
    "Supabase env missing: set VITE_SUPABASE_URL and VITE_SUPABASE_ANON_KEY in .env.local"
  );
}

export const supabase = createClient(url ?? "", anonKey ?? "");
