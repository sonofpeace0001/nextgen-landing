// Calibrate the AI scorer against hand-graded cases.
//   ANTHROPIC_API_KEY=... node scripts/calibration/calibrate.mjs scripts/calibration/gold-business-offer.json
// Prints, per case, the human levels vs the model's levels, then agreement statistics.
// Uses the same prompt, tool and scoring maths as the evaluate-submission edge function.
import fs from "node:fs";
import {
  EVAL_TOOL, buildSystemPrompt, buildUserText, computeScore, decideOutcome, parseEvaluation,
} from "../../supabase/functions/evaluate-submission/logic.ts";

const file = process.argv[2];
if (!file) { console.error("usage: node calibrate.mjs <gold.json>"); process.exit(1); }
const apiKey = process.env.ANTHROPIC_API_KEY;
if (!apiKey) { console.error("Set ANTHROPIC_API_KEY (the script never prints it)."); process.exit(1); }
const model = process.env.EVAL_MODEL || "claude-sonnet-5";
const gold = JSON.parse(fs.readFileSync(file, "utf8"));
const { day, cases } = gold;
const rubric = day.rubric;

const humanCriteria = (lv) => rubric.map((r, i) => ({ name: r.criterion, level: lv[i], evidence: "" }));

async function run(c) {
  const res = await fetch("https://api.anthropic.com/v1/messages", {
    method: "POST",
    headers: { "x-api-key": apiKey, "anthropic-version": "2023-06-01", "content-type": "application/json" },
    body: JSON.stringify({
      model, max_tokens: 1500, system: buildSystemPrompt(), tools: [EVAL_TOOL],
      tool_choice: { type: "tool", name: EVAL_TOOL.name },
      messages: [{ role: "user", content: [{ type: "text", text: buildUserText(day, c.text) }] }],
    }),
  });
  if (!res.ok) throw new Error(`API ${res.status}`);
  const data = await res.json();
  const tu = (data.content ?? []).find((b) => b.type === "tool_use");
  const p = parseEvaluation(tu?.input, rubric);
  if (!p.ok) throw new Error("unparseable: " + p.reason);
  return p.value;
}

const rows = [];
for (const c of cases) {
  try {
    const ev = await run(c);
    const humanScore = computeScore(rubric, humanCriteria(c.levels));
    const aiScore = computeScore(rubric, ev.criteria);
    rows.push({
      id: c.id, human: c.levels.join(""), ai: ev.criteria.map((x) => x.level).join(""), humanScore, aiScore,
      conf: ev.confidence, aiOutcome: decideOutcome(aiScore, ev.confidence, ev.flags), flags: ev.flags.join(","),
    });
  } catch (e) {
    rows.push({ id: c.id, error: String(e.message) });
  }
}
console.table(rows);

const ok = rows.filter((r) => !r.error);
const mae = ok.reduce((a, r) => a + Math.abs(r.humanScore - r.aiScore), 0) / (ok.length || 1);
let exact = 0, adjacent = 0, total = 0;
const big = [];
for (const r of ok) {
  for (let i = 0; i < r.human.length; i++) {
    total++;
    const d = Math.abs(+r.human[i] - +r.ai[i]);
    if (d === 0) exact++;
    if (d <= 1) adjacent++;
    if (d === 2) big.push(`case ${r.id} criterion ${i + 1}`);
  }
}
const passAgree = ok.filter((r) => r.humanScore >= 70 === r.aiScore >= 70).length;
console.log(`\ncases scored: ${ok.length}/${rows.length}   model: ${model}`);
console.log(`mean absolute score error: ${mae.toFixed(1)} points (target: under 8)`);
console.log(`criterion agreement: exact ${((100 * exact) / total).toFixed(0)}%, within one level ${((100 * adjacent) / total).toFixed(0)}% (targets: 70% / 95%)`);
console.log(`pass/fail agreement at 70: ${((100 * passAgree) / (ok.length || 1)).toFixed(0)}% (target: 90%)`);
if (big.length) console.log(`two-level disagreements (review these): ${big.join("; ")}`);
