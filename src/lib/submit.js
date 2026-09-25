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

// Ask the evaluator to score a 'pending_ai' submission. Never leaves a member
// stuck: if the evaluator cannot be reached, the submission is handed to a person.
export async function evaluateSubmission(supabase, submissionId) {
  try {
    const { data, error } = await supabase.functions.invoke("evaluate-submission", {
      body: { submission_id: submissionId },
    });
    if (error) throw error;
    return data;
  } catch {
    try {
      await supabase.rpc("park_for_review", { p_submission_id: submissionId });
    } catch {
      /* the next page load shows the real state */
    }
    return { ok: false, status: "pending_review", fallback: true };
  }
}

// Member appeal: ask a person to re-check an AI score (the AI result is kept).
export async function requestRecheck(supabase, submissionId) {
  const { data, error } = await supabase.rpc("request_recheck", { p_submission_id: submissionId });
  if (error) throw error;
  return data;
}
