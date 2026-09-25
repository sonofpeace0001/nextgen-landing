-- Deepen Expert and Grandmaster lessons for research: worked example and common mistake (idempotent).
update public.day d
   set lesson_md = d.lesson_md || v.extra
  from (values
  (61, $x61$

**Worked example:** Question: 'Does a reminder email cause more people to finish?' Best design: randomised test; observational data cannot prove cause.

**Common mistake:** Claiming cause from correlation.$x61$),
  (62, $x62$

**Worked example:** Result: +6 points (95% CI 1 to 11), n=400; conclusion: probably helps, effect uncertain.

**Common mistake:** Reporting only a p-value.$x62$),
  (63, $x63$

**Worked example:** Notebook with fixed seed, package versions, data source; tests on a known answer.

**Common mistake:** Unrepeatable analysis.$x63$),
  (64, $x64$

**Worked example:** Mini review: 10 studies, criteria, PRISMA-style flow (120 found, 30 screened, 10 included), bias rated.

**Common mistake:** No inclusion criteria.$x64$),
  (65, $x65$

**Worked example:** Evidence synthesis: design reasoning, analysis, reproducibility pack, review method.

**Common mistake:** No reproducibility.$x65$),
  (66, $x66$

**Worked example:** Model: baseline (average) vs regression; train/test split; RMSE reported; leakage check.

**Common mistake:** Testing on training data.$x66$),
  (67, $x67$

**Worked example:** AI classifies 50 documents; hand-label 20: 18 agree (90%); errors clustered in sarcasm.

**Common mistake:** Trusting AI classification unchecked.$x67$),
  (68, $x68$

**Worked example:** Chart chosen for the question; takeaway annotated; a non-expert reads it correctly.

**Common mistake:** Chart junk.$x68$),
  (69, $x69$

**Worked example:** Audit: error rate 8% for group A, 15% for group B; investigate data representation; document mitigation.

**Common mistake:** Ignoring subgroup differences.$x69$),
  (70, $x70$

**Worked example:** Study: model, evaluation, fairness audit, visuals.

**Common mistake:** No audit.$x70$),
  (71, $x71$

**Worked example:** Needs assessment: five stakeholders; ask vs need: they ask for a dashboard, they need weekly follow-ups.

**Common mistake:** Building what was requested.$x71$),
  (72, $x72$

**Worked example:** Programme evaluation: outcomes, baseline, comparison, timeline, limits of attribution.

**Common mistake:** No comparison.$x72$),
  (73, $x73$

**Worked example:** Ethics application: consent, anonymisation, storage, withdrawal, risks.

**Common mistake:** No withdrawal option.$x73$),
  (74, $x74$

**Worked example:** Two-page brief: three options with trade-offs and confidence; no advocacy.

**Common mistake:** Advocacy disguised as evidence.$x74$),
  (75, $x75$

**Worked example:** Evaluation and brief: needs assessment, ethics plan, policy brief.

**Common mistake:** No ethics plan.$x75$),
  (76, $x76$

**Worked example:** Pre-registration: hypotheses, methods, analysis plan written before data.

**Common mistake:** Changing hypotheses after seeing results.$x76$),
  (77, $x77$

**Worked example:** Collect with a decision log and quality checks.

**Common mistake:** No log.$x77$),
  (78, $x78$

**Worked example:** Analyse as planned; robustness checks; list deviations with reasons.

**Common mistake:** Hiding deviations.$x78$),
  (79, $x79$

**Worked example:** Draft plus expert critique and written response.

**Common mistake:** Skipping independent review.$x79$),
  (80, $x80$

**Worked example:** Flagship: plan, data, analysis, robustness, response, reproducibility pack.

**Common mistake:** No expert review.$x80$),
  (81, $x81$

**Worked example:** Lesson: 'Absolute vs relative risk.' Example with numbers; practice on three headlines.

**Common mistake:** Teaching everything at once instead of one skill with one worked example.$x81$),
  (82, $x82$

**Worked example:** Review: 'Clear question; the biggest threat is selection bias in the sample. Name it and limit the claim.'

**Common mistake:** Listing every flaw instead of the one that matters most.$x82$),
  (83, $x83$

**Worked example:** Publish a cleaned dataset with documentation and privacy check.

**Common mistake:** Sharing something you would not want to be judged by.$x83$),
  (84, $x84$

**Worked example:** Case study: 'Survey of 200 changed the onboarding; effect +6 points; sample skewed young.'

**Common mistake:** Leaving out what failed.$x84$),
  (85, $x85$

**Worked example:** Plan: 'My point of view: careful, honest research that changes decisions. Three flagship pieces, one lesson, one open resource, six months, measured by real users and feedback.'

**Common mistake:** A plan with no numbers or dates.$x85$),
  (86, $x86$

**Worked example:** Scores for a peer: 'Clarity 2/2: purpose is clear in the first line. Evidence 1/2: one claim lacks a source.' Exercise: fix one claim.

**Common mistake:** Scoring without pointing to evidence.$x86$),
  (87, $x87$

**Worked example:** Module: three outcomes, five lessons, each with one task, a project and a rubric; test one lesson with a real learner and record what they misunderstood.

**Common mistake:** Writing lessons nobody has tried.$x87$),
  (88, $x88$

**Worked example:** Standards: 'I say when AI helped. I verify facts. I correct errors publicly within 48 hours.'

**Common mistake:** Principles too vague to break.$x88$),
  (89, $x89$

**Worked example:** Impact: 'Twelve learners used my template; eight finished; two hired.' State limits: small group, self-reported.

**Common mistake:** Claiming impact you cannot evidence.$x89$),
  (90, $x90$

**Worked example:** Portfolio: flagship piece, open resource, lesson with learner feedback, one peer review, standards, impact report and a one-page reflection.

**Common mistake:** Presenting a folder of files with no story of growth.$x90$)
  ) as v(n, extra), public.track t
 where t.id = d.track_id and t.slug = 'research' and d.day_number = v.n
   and d.lesson_md not like '%**Worked example:**%';
