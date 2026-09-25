// Run with: node --test supabase/functions/evaluate-submission/
import test from "node:test";
import assert from "node:assert/strict";
import {
  computeScore, decideOutcome, parseEvaluation, extractImageUrls, nonUrlTextLength, hasUrl,
  buildUserText, feedbackText, PASS_MARK,
} from "./logic.ts";

const rubric = [
  { criterion: "Brief fit", max_points: 30, guidance: "g" },
  { criterion: "Composition", max_points: 25, guidance: "g" },
  { criterion: "Text legibility", max_points: 25, guidance: "g" },
  { criterion: "Consistency", max_points: 20, guidance: "g" },
];
const lv = (a: number[]) => rubric.map((r, i) => ({ name: r.criterion, level: a[i], evidence: "e" }));

test("score: all 2s is 100, all 0s is 0, all 1s is 50", () => {
  assert.equal(computeScore(rubric, lv([2, 2, 2, 2])), 100);
  assert.equal(computeScore(rubric, lv([0, 0, 0, 0])), 0);
  assert.equal(computeScore(rubric, lv([1, 1, 1, 1])), 50);
});

test("score is weighted by max_points", () => {
  // 2 on the 30-pt criterion only = 30
  assert.equal(computeScore(rubric, lv([2, 0, 0, 0])), 30);
  // 2,2,1,0 = 30 + 25 + 12.5 = 67.5 -> 68
  assert.equal(computeScore(rubric, lv([2, 2, 1, 0])), 68);
});

test("score normalises when weights do not sum to 100", () => {
  const r = [{ criterion: "A", max_points: 5 }, { criterion: "B", max_points: 5 }];
  assert.equal(computeScore(r, [{ name: "A", level: 2, evidence: "" }, { name: "B", level: 0, evidence: "" }]), 50);
});

test("outcome: pass mark, low confidence and flags", () => {
  assert.equal(decideOutcome(PASS_MARK, 0.9, []), "scored");
  assert.equal(decideOutcome(PASS_MARK - 1, 0.9, []), "needs_revision");
  assert.equal(decideOutcome(95, 0.4, []), "pending_review");
  assert.equal(decideOutcome(95, 0.9, ["injection_attempt"]), "pending_review");
  assert.equal(decideOutcome(95, 0.9, ["cannot_view_link"]), "pending_review");
  // advisory flags alone do not force a human
  assert.equal(decideOutcome(40, 0.9, ["too_short"]), "needs_revision");
});

test("parse: clamps levels, matches by name, ignores a model-supplied total", () => {
  const p = parseEvaluation({
    total: 100, // must be ignored
    criteria: [
      { name: "consistency", level: 2, evidence: "x" }, // out of order, different case
      { name: "Brief fit", level: 9, evidence: "y" },   // clamped to 2
      { name: "Composition", level: -3, evidence: "z" }, // clamped to 0
      { name: "Text legibility", level: 1, evidence: "w" },
    ],
    strengths: ["a", "b", "c"], fixes: ["1", "2", "3", "4"], next_step: "go", confidence: 1.7, flags: ["off_topic", "made_up"],
  }, rubric);
  assert.ok(p.ok);
  if (!p.ok) return;
  assert.deepEqual(p.value.criteria.map((c) => c.level), [2, 0, 1, 2]);
  assert.equal(p.value.strengths.length, 2);
  assert.equal(p.value.fixes.length, 3);
  assert.equal(p.value.confidence, 1);
  assert.deepEqual(p.value.flags, ["off_topic"]);
});

test("parse rejects garbage", () => {
  assert.equal(parseEvaluation(null, rubric).ok, false);
  assert.equal(parseEvaluation({ criteria: [] }, rubric).ok, false);
  assert.equal(parseEvaluation({ nope: 1 }, rubric).ok, false);
});

test("image and link detection", () => {
  const t = "Here it is https://cdn.example.com/a/b.PNG?x=1 and also https://example.com/doc";
  assert.deepEqual(extractImageUrls(t), ["https://cdn.example.com/a/b.PNG?x=1"]);
  assert.equal(hasUrl(t), true);
  assert.equal(nonUrlTextLength("https://notion.so/page"), 0);
  assert.ok(nonUrlTextLength("My poster uses a bold headline and a calm palette. https://notion.so/x") > 40);
  assert.deepEqual(extractImageUrls("http://insecure.example.com/a.png"), []); // https only
});

test("prompt keeps the submission inside tags and caps length", () => {
  const big = "x".repeat(50000);
  const out = buildUserText({ title: "T", objective: "O", assignment_md: "A", rubric }, big);
  assert.ok(out.includes("<submission>") && out.includes("</submission>"));
  assert.ok(out.length < 14000);
});

test("feedback text is readable", () => {
  const t = feedbackText({ criteria: [], strengths: ["Clear focal point"], fixes: ["Raise contrast"], next_step: "Redo the subhead", confidence: 1, flags: [] });
  assert.match(t, /What worked: Clear focal point/);
  assert.match(t, /Next step: Redo the subhead/);
});
