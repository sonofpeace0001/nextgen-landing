-- Deepen Pro-tier lessons for research: worked example and common mistake (idempotent).
update public.day d
   set lesson_md = d.lesson_md || v.extra
  from (values
  (31, $x31$

**Worked example:** Terms: 'AI' OR 'artificial intelligence' AND 'tutoring' AND 'secondary school'; sources: journals, government sites; date 2019+; log each search.

**Common mistake:** Searching once and calling it thorough.$x31$),
  (32, $x32$

**Worked example:** Rank: randomised trial (strong), survey of 200 (moderate), blog opinion (weak). Note funder and conflicts.

**Common mistake:** Not checking funding.$x32$),
  (33, $x33$

**Worked example:** Study A says 12% gain (lab), study B says none (classrooms). Difference: setting, age, test type.

**Common mistake:** Averaging conflicting results.$x33$),
  (34, $x34$

**Worked example:** 'Risk doubled' means 1 in 1000 to 2 in 1000: absolute change 0.1 percentage points.

**Common mistake:** Confusing relative and absolute change.$x34$),
  (35, $x35$

**Worked example:** Pivot: average price by region; formula for percent change; charts checked against raw rows.

**Common mistake:** Editing the raw data sheet.$x35$),
  (36, $x36$

**Worked example:** Deliver search log, graded source table, conflict notes and conclusion with confidence.

**Common mistake:** A conclusion with no confidence level.$x36$),
  (37, $x37$

**Worked example:** Question: 'How many hours of sleep do you get on school nights?' (not 'Do you sleep too little?'). Pilot with five; two misread 'night'.

**Common mistake:** Skipping the pilot.$x37$),
  (38, $x38$

**Worked example:** Sample: 60 students from one school; claims limited to that school; missing: those absent.

**Common mistake:** Generalising from a convenience sample.$x38$),
  (39, $x39$

**Worked example:** Codes: 'cost', 'time', 'trust'; theme 'trust' backed by four quotes; AI suggested a theme not in the text, rejected.

**Common mistake:** Accepting AI themes unchecked.$x39$),
  (40, $x40$

**Worked example:** Merge on id; found 15 duplicates created; log 1,200 -> 1,215 -> 1,200 after fix.

**Common mistake:** Not counting rows after merges.$x40$),
  (41, $x41$

**Worked example:** Chart with a shaded range and caption: 'Estimates range 18-26%; small sample.'

**Common mistake:** One precise-looking number.$x41$),
  (42, $x42$

**Worked example:** Deliver questions, sample, results, limits, at least 15 responses.

**Common mistake:** Fewer than promised responses with no comment.$x42$),
  (43, $x43$

**Worked example:** Base rate: 60% of similar projects finish late; adjust for your team; scenarios low/medium/high with assumptions.

**Common mistake:** Ignoring base rates.$x43$),
  (44, $x44$

**Worked example:** Bottom-up: 4,000 shops x 12% adoption x 300 = 144,000; top-down check; range 100k-200k.

**Common mistake:** One number with no assumptions.$x44$),
  (45, $x45$

**Worked example:** Option A costs 500 and saves 20 hours; B costs 800 and saves 35; sensitivity if hours are worth 15 vs 30.

**Common mistake:** Ignoring non-quantified costs.$x45$),
  (46, $x46$

**Worked example:** Stages: search, screen, extract, verify, synthesise; AI drafts search terms; humans verify quotes; log AI use.

**Common mistake:** Using AI at the verification step.$x46$),
  (47, $x47$

**Worked example:** Critique: 'Conclusion claims cause; design cannot support it; suggest wording.'

**Common mistake:** Nit-picking style and missing the flaw.$x47$),
  (48, $x48$

**Worked example:** Deliver memo with options, ranges, scenarios, recommendation and what would change it.

**Common mistake:** A recommendation with no conditions.$x48$),
  (49, $x49$

**Worked example:** Package: raw data, cleaned data, script, versions, method notes; a peer reproduces your table.

**Common mistake:** Only sharing the chart.$x49$),
  (50, $x50$

**Worked example:** Ethics plan: consent text, anonymised IDs, encrypted storage, deletion after 12 months.

**Common mistake:** Names stored in the analysis file.$x50$),
  (51, $x51$

**Worked example:** Rewrite: 'Likely (about 70%) that ...' with what is known, likely, unknown.

**Common mistake:** Jargon like 'statistically significant' unexplained.$x51$),
  (52, $x52$

**Worked example:** Story: context, question, finding (chart), meaning, action, with source line.

**Common mistake:** Charts with no message.$x52$),
  (53, $x53$

**Worked example:** Prepare answers to 'Why should we trust this?', 'What if you are wrong?', 'What now?'

**Common mistake:** Not preparing for hard questions.$x53$),
  (54, $x54$

**Worked example:** Report with summary, method, findings with uncertainty, ethics note and file list.

**Common mistake:** No methods.$x54$),
  (55, $x55$

**Worked example:** Question: 'Why do first-week users leave?' Decision: which fix first.

**Common mistake:** Choosing a question first and a decision never.$x55$),
  (56, $x56$

**Worked example:** Method: 12 interviews + usage data; verification via two coders; timeline four weeks.

**Common mistake:** Method chosen for convenience.$x56$),
  (57, $x57$

**Worked example:** Collected 12 interviews, 1,400 usage rows, cleaned; quality log kept.

**Common mistake:** No quality log.$x57$),
  (58, $x58$

**Worked example:** Alternative: users left because of a price change, not onboarding; test by cohort.

**Common mistake:** Not testing alternatives.$x58$),
  (59, $x59$

**Worked example:** Peer says the summary mixes causes and correlations; reword; changelog shows edits.

**Common mistake:** No independent review.$x59$),
  (60, $x60$

**Worked example:** Final: report, reproducibility pack, Q and A defending three decisions.

**Common mistake:** Not defending choices.$x60$)
  ) as v(n, extra), public.track t
 where t.id = d.track_id and t.slug = 'research' and d.day_number = v.n
   and d.lesson_md not like '%**Worked example:**%';
