import { supabase } from "./supabase.js";

// Calls the `admin` Edge Function. The user's JWT rides along automatically;
// the function verifies is_admin server-side. The service_role key is never here.
async function call(action, payload = {}) {
  const { data, error } = await supabase.functions.invoke("admin", { body: { action, payload } });
  if (error) throw error;
  if (data?.error) throw new Error(data.error);
  return data;
}

export const adminApi = {
  // codes
  generateCodes: (opts) => call("code.generate", opts),
  listCodes: () => call("code.list"),
  revokeCode: (id) => call("code.revoke", { id }),
  // members
  listMembers: () => call("member.list"),
  setElite: (user_id, is_elite) => call("member.setElite", { user_id, is_elite }),
  // content
  upsertDay: (day) => call("content.upsertDay", { day }),
  publishDay: (id, is_published) => call("content.publishDay", { id, is_published }),
  // review queue
  listReviewQueue: () => call("review.list"),
  scoreSubmission: (submission_id, score, feedback) => call("review.score", { submission_id, score, feedback }),
  // settings
  getSettings: () => call("settings.get"),
  updateSetting: (key, value) => call("settings.update", { key, value }),
};
