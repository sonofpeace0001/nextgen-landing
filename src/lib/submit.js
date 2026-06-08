// Submit a day's work. Goes through the submit_day RPC, which auto-grades and sets
// the score server-side — the client cannot influence check_score or the final score.
export async function submitDay(supabase, { enrollmentId, dayId, content, selfScore, answers }) {
  const { data, error } = await supabase.rpc("submit_day", {
    p_enrollment_id: enrollmentId,
    p_day_id: dayId,
    p_content: content ?? null,
    p_self_score: selfScore ?? null,
    p_answers: answers ?? [],
  });
  if (error) throw error;
  return data;
}
