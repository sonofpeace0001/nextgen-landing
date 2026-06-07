// Pure drip / unlock logic. No IO — fully unit-testable. Three modes, configurable
// per enrollment (enrollment.unlock_mode):
//   'date'              day i unlocks on start_date + (i-1) calendar days
//   'completion'        day i unlocks once day i-1 has a submission
//   'completion_capped' like completion, but at most ONE new day per calendar day
//                       (default) — keeps students moving without bingeing the path
//
// Day indexes are 1-based positions within the student's path (not raw day_numbers).
// `completions` is a Map<dayIndex, Date> of when each day was submitted.

function startOfDay(d) {
  const x = new Date(d);
  x.setHours(0, 0, 0, 0);
  return x;
}
function addDays(d, n) {
  const x = startOfDay(d);
  x.setDate(x.getDate() + n);
  return x;
}
function calDiffDays(a, b) {
  return Math.round((startOfDay(a).getTime() - startOfDay(b).getTime()) / 86400000);
}

export function dayStatus({ dayIndex, total, startDate, unlockMode, completions, today = new Date() }) {
  if (dayIndex < 1 || dayIndex > total) return "locked";
  if (completions.has(dayIndex)) return "completed";

  const start = startDate instanceof Date ? startDate : new Date(startDate);

  // Day 1 is available from the start date onward.
  if (dayIndex === 1) {
    return calDiffDays(today, start) >= 0 ? "unlocked" : "locked";
  }

  if (unlockMode === "date") {
    return calDiffDays(today, addDays(start, dayIndex - 1)) >= 0 ? "unlocked" : "locked";
  }

  // completion-based modes need the previous day submitted first
  const prev = dayIndex - 1;
  if (!completions.has(prev)) return "locked";
  if (unlockMode === "completion") return "unlocked";
  if (unlockMode === "completion_capped") {
    // a full calendar day must pass after completing the previous day
    return calDiffDays(today, completions.get(prev)) >= 1 ? "unlocked" : "locked";
  }
  return "locked";
}

// Highest contiguous day the student can currently reach (0 = nothing yet).
export function highestAccessibleDay({ total, startDate, unlockMode, completions, today = new Date() }) {
  let last = 0;
  for (let i = 1; i <= total; i++) {
    const s = dayStatus({ dayIndex: i, total, startDate, unlockMode, completions, today });
    if (s === "locked") break;
    last = i;
  }
  return last;
}
