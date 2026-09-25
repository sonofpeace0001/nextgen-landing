-- Deepen Expert and Grandmaster lessons for business: worked example and common mistake (idempotent).
update public.day d
   set lesson_md = d.lesson_md || v.extra
  from (values
  (61, $x61$

**Worked example:** Score niches: cafes (pain 8, budget 6, access 9) vs law firms (pain 6, budget 9, access 3); choose cafes; five buyer conversations.

**Common mistake:** Choosing a niche by hunch.$x61$),
  (62, $x62$

**Worked example:** Playbook: steps, templates, QA, timings; a subcontractor could deliver from it.

**Common mistake:** Playbook only in your head.$x62$),
  (63, $x63$

**Worked example:** Forecast: income 3,000, costs 500, tax 25%; slow month at 50% still covers rent.

**Common mistake:** No slow-month scenario.$x63$),
  (64, $x64$

**Worked example:** Pipeline: lead, call, proposal, won; conversion 30%; follow-up on day 2, 5, 10.

**Common mistake:** Not tracking stages.$x64$),
  (65, $x65$

**Worked example:** Operating system: niche evidence, playbook, forecast, pipeline.

**Common mistake:** No numbers.$x65$),
  (66, $x66$

**Worked example:** Competitor map: five, with offer and price; gap: none offer a monthly report.

**Common mistake:** Undated information.$x66$),
  (67, $x67$

**Worked example:** 90-day authority plan: two case studies, one talk, one guide; expected 12 leads.

**Common mistake:** Fake authority.$x67$),
  (68, $x68$

**Worked example:** Partner programme: printers and photographers; free audit; written referral terms.

**Common mistake:** Undisclosed commission.$x68$),
  (69, $x69$

**Worked example:** Pricing test: raise Standard from 280 to 320 for new leads; win rate 40% to 35%; margin up.

**Common mistake:** Testing several things at once.$x69$),
  (70, $x70$

**Worked example:** Growth engine: positioning, authority, partners, pricing test.

**Common mistake:** No test results.$x70$),
  (71, $x71$

**Worked example:** Role brief, trial task (paid), contract outline, quality check.

**Common mistake:** Unpaid trials.$x71$),
  (72, $x72$

**Worked example:** Structure comparison: sole trader vs company; questions for an accountant.

**Common mistake:** Skipping professional advice.$x72$),
  (73, $x73$

**Worked example:** Client success: onboarding, check-ins, results review, renewal at month 3.

**Common mistake:** No retention plan.$x73$),
  (74, $x74$

**Worked example:** Risk register and crisis message: honest, specific, with fix and time.

**Common mistake:** Vague apologies.$x74$),
  (75, $x75$

**Worked example:** Scale plan: subcontracting kit, structure, client success, risks.

**Common mistake:** Scaling without quality checks.$x75$),
  (76, $x76$

**Worked example:** Goal: 4 clients and 1,200 a month in 90 days; timeline.

**Common mistake:** Goal with no date.$x76$),
  (77, $x77$

**Worked example:** 30 days outreach: 60 messages, 15 replies, 6 calls, 2 clients.

**Common mistake:** No tracking.$x77$),
  (78, $x78$

**Worked example:** Deliver a project with the playbook, QA record and client feedback.

**Common mistake:** No client feedback.$x78$),
  (79, $x79$

**Worked example:** Compare targets to actuals: revenue 900 vs 1,200; find why.

**Common mistake:** Ignoring the gap.$x79$),
  (80, $x80$

**Worked example:** Business case study: goal, actions, results, lessons, next 90 days.

**Common mistake:** No lessons.$x80$),
  (81, $x81$

**Worked example:** Lesson: 'Write a scope with exclusions.' Example and a practice task.

**Common mistake:** Teaching everything at once instead of one skill with one worked example.$x81$),
  (82, $x82$

**Worked example:** Critique: 'Clear offer; the price has no scope, so it invites endless edits. Add exclusions.'

**Common mistake:** Listing every flaw instead of the one that matters most.$x82$),
  (83, $x83$

**Worked example:** Publish a template kit with disclaimers.

**Common mistake:** Sharing something you would not want to be judged by.$x83$),
  (84, $x84$

**Worked example:** Case study: 'Cafe client, 5 enquiries a month; first proposal lost for lack of options.'

**Common mistake:** Leaving out what failed.$x84$),
  (85, $x85$

**Worked example:** Plan: 'My point of view: honest, well-run one-person businesses. Three flagship pieces, one lesson, one open resource, six months, measured by real users and feedback.'

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
 where t.id = d.track_id and t.slug = 'business' and d.day_number = v.n
   and d.lesson_md not like '%**Worked example:**%';
