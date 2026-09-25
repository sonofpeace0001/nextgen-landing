-- Deepen Expert and Grandmaster lessons for apps: worked example and common mistake (idempotent).
update public.day d
   set lesson_md = d.lesson_md || v.extra
  from (values
  (61, $x61$

**Worked example:** Build vs buy: sign-in (buy), payments (buy), booking rules (build), email sending (buy). Exit plan: export data monthly.

**Common mistake:** Building things that are not your edge.$x61$),
  (62, $x62$

**Worked example:** Bookings have audit fields (created_at, updated_by) and status history; adding a 'deposit' field later is a simple migration.

**Common mistake:** Overwriting rows and losing history.$x62$),
  (63, $x63$

**Worked example:** Threats: guess ids (fix: access rules), upload abuse (limit types), leaked key (rotate, store as secret); ranked by likelihood x impact.

**Common mistake:** Assuming nobody will attack a small app.$x63$),
  (64, $x64$

**Worked example:** Ten tests: sign-up, book, cancel, double-book, permission, upload, email, payment test mode, reset, delete; 9 pass, 1 fixed.

**Common mistake:** No tests for sign-up and payments.$x64$),
  (65, $x65$

**Worked example:** Hardened product: decisions record, data model, threat model with fixes, tested critical flow.

**Common mistake:** No proof fixes worked.$x65$),
  (66, $x66$

**Worked example:** Unit economics: hosting 5, AI 12, support 8 per 100 users; price 9/month; margin 72%.

**Common mistake:** Forgetting AI and support costs.$x66$),
  (67, $x67$

**Worked example:** Activation: first booking within 10 minutes; retention: week-4 return 35% target; tactic: reminder email.

**Common mistake:** Measuring sign-ups only.$x67$),
  (68, $x68$

**Worked example:** Scorecard: reminder emails (impact 8, effort 2, confidence 7) beat multi-language (impact 5, effort 8).

**Common mistake:** Building what is loudest.$x68$),
  (69, $x69$

**Worked example:** Postmortem: 09:10 outage, cause full disk, impact 40 min, prevention: alert at 80%.

**Common mistake:** Blaming a person.$x69$),
  (70, $x70$

**Worked example:** Business case: economics, activation plan, analytics, scorecard, incident plan.

**Common mistake:** No plan for when it breaks.$x70$),
  (71, $x71$

**Worked example:** Evaluation: 30 test inputs, target 90% correct, fallback message, thumbs-down report button.

**Common mistake:** No way for users to report bad AI output.$x71$),
  (72, $x72$

**Worked example:** Deletion flow: user requests, account and files removed within 30 days, confirmation email; data inventory lists every store.

**Common mistake:** Data you forgot you stored.$x72$),
  (73, $x73$

**Worked example:** Audit: focus order skips the Save button; add tab order and visible focus ring.

**Common mistake:** Testing only with a mouse.$x73$),
  (74, $x74$

**Worked example:** Slowest query 1.8s; add an index; now 0.2s; load-test 100 concurrent users.

**Common mistake:** Optimising without measuring.$x74$),
  (75, $x75$

**Worked example:** Readiness review: AI eval, privacy flows, accessibility fixes, performance numbers.

**Common mistake:** Declaring ready with no numbers.$x75$),
  (76, $x76$

**Worked example:** Validation: ten interviews, three commit to a paid pilot at 20 a month.

**Common mistake:** Counting compliments as commitments.$x76$),
  (77, $x77$

**Worked example:** Build the core with tests and accessibility from day one; screenshots of passing tests.

**Common mistake:** Adding features before the core.$x77$),
  (78, $x78$

**Worked example:** Pilot with five users for two weeks; weekly changes: better search, larger buttons.

**Common mistake:** Pilot with no changes.$x78$),
  (79, $x79$

**Worked example:** Launch, monitor errors, handle one incident, record numbers.

**Common mistake:** No monitoring.$x79$),
  (80, $x80$

**Worked example:** Flagship: validation, build, pilot data, launch and operations evidence, honest lessons.

**Common mistake:** Case study with no numbers.$x80$),
  (81, $x81$

**Worked example:** Lesson: 'Write acceptance tests.' Example: 'Empty name shows an error.' Practice: write five for a form.

**Common mistake:** Teaching everything at once instead of one skill with one worked example.$x81$),
  (82, $x82$

**Worked example:** Review: 'Clear job; the biggest risk is anyone can open other users' pages. Fix access rules, then retest.'

**Common mistake:** Listing every flaw instead of the one that matters most.$x82$),
  (83, $x83$

**Worked example:** Publish a reusable template with docs and a licence.

**Common mistake:** Sharing something you would not want to be judged by.$x83$),
  (84, $x84$

**Worked example:** Case study: 'Booking tool, 30 users, 90% fewer double bookings; first version lost data on refresh.'

**Common mistake:** Leaving out what failed.$x84$),
  (85, $x85$

**Worked example:** Plan: 'My point of view: small, reliable tools for people who do real work. Three flagship pieces, one lesson, one open resource, six months, measured by real users and feedback.'

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
 where t.id = d.track_id and t.slug = 'apps' and d.day_number = v.n
   and d.lesson_md not like '%**Worked example:**%';
