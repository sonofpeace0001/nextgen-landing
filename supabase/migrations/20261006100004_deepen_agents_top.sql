-- Deepen Expert and Grandmaster lessons for agents: worked example and common mistake (idempotent).
update public.day d
   set lesson_md = d.lesson_md || v.extra
  from (values
  (61, $x61$

**Worked example:** Three tasks: invoice chase (single agent), monthly report (pipeline), supplier research (supervisor with a checker).

**Common mistake:** Choosing the fanciest architecture.$x61$),
  (62, $x62$

**Worked example:** Harness runs 20 tasks daily; model grader agrees with a human on 18 of 20; regressions flagged.

**Common mistake:** Trusting a model grader without checking it.$x62$),
  (63, $x63$

**Worked example:** Ten attacks: hidden instructions in a PDF, 'ignore previous', data exfiltration via link, tool abuse; four succeeded, all fixed.

**Common mistake:** Testing only friendly inputs.$x63$),
  (64, $x64$

**Worked example:** Per-task credentials that expire in 1 hour; sandboxed code; allow-list of two domains; spending cap 5 a day.

**Common mistake:** One master key for everything.$x64$),
  (65, $x65$

**Worked example:** Secured agent: architecture rationale, eval results, red-team log, containment design.

**Common mistake:** No evidence it is safe.$x65$),
  (66, $x66$

**Worked example:** Two agents: researcher writes notes in a shared schema; writer drafts; ownership: writer decides final wording; stop after 3 rounds.

**Common mistake:** No stop rule.$x66$),
  (67, $x67$

**Worked example:** Long task: state saved after each step, resume after failure, cancel button, progress messages.

**Common mistake:** Restarting from zero after a failure.$x67$),
  (68, $x68$

**Worked example:** Oversight: review 100% under 90% confidence, 10% above; reviewer agreement 92%; override rate tracked.

**Common mistake:** Reviewing nothing until problems appear.$x68$),
  (69, $x69$

**Worked example:** Route easy tickets to a small model, cache repeats: cost per resolved ticket 4.1p to 2.6p, quality unchanged.

**Common mistake:** Cutting cost and quality together.$x69$),
  (70, $x70$

**Worked example:** Scalable workflow: coordination design, resume logic, oversight plan, cost results.

**Common mistake:** No numbers.$x70$),
  (71, $x71$

**Worked example:** Service agent metrics: resolution time, satisfaction, plus harm metrics: wrong refund promises, missed escalations.

**Common mistake:** Only measuring speed.$x71$),
  (72, $x72$

**Worked example:** Reporting agent saves query and data version; a human signs off conclusions.

**Common mistake:** No sign-off.$x72$),
  (73, $x73$

**Worked example:** Model doc: purpose, data, testing, oversight, known limits, incident log; note where legal advice is needed.

**Common mistake:** No record of testing.$x73$),
  (74, $x74$

**Worked example:** Adoption: involve two users early, train 30 minutes, start with one team, weekly feedback.

**Common mistake:** Announcing it without training.$x74$),
  (75, $x75$

**Worked example:** Deployment plan: domain design, metrics, documentation, regulatory notes, adoption plan.

**Common mistake:** Ignoring the rules of the sector.$x75$),
  (76, $x76$

**Worked example:** Baseline: two weeks measured; risk register with wrong-amount, leak, loop.

**Common mistake:** Building before measuring.$x76$),
  (77, $x77$

**Worked example:** Harness results on real cases; fixes tracked.

**Common mistake:** Testing only synthetic cases.$x77$),
  (78, $x78$

**Worked example:** Pilot with oversight metrics and an incident log for two weeks.

**Common mistake:** No incident log.$x78$),
  (79, $x79$

**Worked example:** Compare to baseline: time -55%, error rate same, cost +8 pounds; one harm case reviewed.

**Common mistake:** Ignoring harms.$x79$),
  (80, $x80$

**Worked example:** Flagship: baseline, evaluation, pilot, results, documentation, handover.

**Common mistake:** No handover.$x80$),
  (81, $x81$

**Worked example:** Lesson: 'Add an approval step.' Example approval card. Practice: add approval to an email drafter.

**Common mistake:** Teaching everything at once instead of one skill with one worked example.$x81$),
  (82, $x82$

**Worked example:** Review: 'Good permissions; missing a stop rule so a loop could spend money. Add a step cap.'

**Common mistake:** Listing every flaw instead of the one that matters most.$x82$),
  (83, $x83$

**Worked example:** Publish an approval-flow pattern with safe defaults.

**Common mistake:** Sharing something you would not want to be judged by.$x83$),
  (84, $x84$

**Worked example:** Case study: 'Invoice agent saved 3 hours weekly; two wrong dates were caught by approval.'

**Common mistake:** Leaving out what failed.$x84$),
  (85, $x85$

**Worked example:** Plan: 'My point of view: automation people can trust and switch off. Three flagship pieces, one lesson, one open resource, six months, measured by real users and feedback.'

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
 where t.id = d.track_id and t.slug = 'agents' and d.day_number = v.n
   and d.lesson_md not like '%**Worked example:**%';
