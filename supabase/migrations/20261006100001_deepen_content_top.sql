-- Deepen Expert and Grandmaster lessons for content: worked example and common mistake (idempotent).
update public.day d
   set lesson_md = d.lesson_md || v.extra
  from (values
  (61, $x61$

**Worked example:** A SaaS firm's goal is trials. Content roles: attract (guides), convince (comparisons), retain (tips); metrics: guide-to-trial rate, comparison-to-demo rate.

**Common mistake:** Choosing topics first and goals never.$x61$),
  (62, $x62$

**Worked example:** Interview: 'Tell me about the last time you searched for this.' Job: 'When I inherit a spreadsheet mess, I want a fast clean-up so I can send it today.'

**Common mistake:** Asking what features people want instead of what they were trying to do.$x62$),
  (63, $x63$

**Worked example:** Standard: voice rules, sourcing rule ('two sources for any number'), AI rule ('AI drafts, humans verify'), definition of done checklist.

**Common mistake:** A 30-page guide nobody reads.$x63$),
  (64, $x64$

**Worked example:** Gates: brief approved, sources logged, fact-check, brand check, legal check; error log shows 6 fixes at the fact-check gate.

**Common mistake:** Only checking at the end.$x64$),
  (65, $x65$

**Worked example:** Pack: strategy on one page, three interview summaries, the standard and the workflow diagram.

**Common mistake:** Strategy with no research behind it.$x65$),
  (66, $x66$

**Worked example:** Queries by intent: 'best crm for freelancers' (compare), 'how to import contacts' (fix); gap: no honest small-business comparison.

**Common mistake:** Chasing keywords with no expertise to add.$x66$),
  (67, $x67$

**Worked example:** 30-day plan: Day 1 publish, day 2 email 200 subscribers, day 3 two communities, day 7 partner mention, day 14 update with reader questions.

**Common mistake:** Publishing and hoping.$x67$),
  (68, $x68$

**Worked example:** Metrics: sign-ups from the guide (outcome), time on page (engagement), impressions (reach); limit: last-click attribution.

**Common mistake:** Reporting page views as success.$x68$),
  (69, $x69$

**Worked example:** Hypothesis: 'A benefit headline will lift email clicks 20%.' Two versions, 500 sends each, run two days; result 4.1% vs 4.9%, not conclusive.

**Common mistake:** Stopping the test when your favourite wins.$x69$),
  (70, $x70$

**Worked example:** Deliver hypothesis, setup, actions, data and 'what I would test next'.

**Common mistake:** Reporting only successful tests.$x70$),
  (71, $x71$

**Worked example:** Policy: 'Named author reviews and owns every word. AI assistance disclosed on request. No invented quotes.'

**Common mistake:** Inventing an expert quote.$x71$),
  (72, $x72$

**Worked example:** Audit: 'Company X is scamming customers' flagged as defamation risk; rewrite as sourced fact or remove.

**Common mistake:** Publishing accusations without proof.$x72$),
  (73, $x73$

**Worked example:** Edit note: 'Moved the main point to paragraph 1, cut two repeated examples, kept your joke in paragraph 4.'

**Common mistake:** Rewriting the writer's voice away.$x73$),
  (74, $x74$

**Worked example:** Brief: goal, reader, angle, three sources to start, 1,200 words, due date, two revision rounds, rights, AI rule.

**Common mistake:** Briefing in one sentence.$x74$),
  (75, $x75$

**Worked example:** System: risk checklist, edit process, freelancer brief and terms, scorecard with example scores.

**Common mistake:** Systems with no example.$x75$),
  (76, $x76$

**Worked example:** Question: 'How long does a typical freelance invoice take to be paid?' Plan: survey 60 freelancers plus public data.

**Common mistake:** Writing a flagship with no original angle.$x76$),
  (77, $x77$

**Worked example:** Outline: promise, three findings each with evidence, objections, what to do; 1,000-word first draft.

**Common mistake:** Drafting before the argument is clear.$x77$),
  (78, $x78$

**Worked example:** Revision log: cut 120 words, fixed one wrong statistic, added two sources, outside reader flagged a confusing example.

**Common mistake:** Publishing the first draft.$x78$),
  (79, $x79$

**Worked example:** Publish with a benefit headline and summary; distribute to email, two communities and a partner; record 2-week results.

**Common mistake:** No distribution plan.$x79$),
  (80, $x80$

**Worked example:** Flagship: article, source log, distribution summary, results with honest analysis (visits, sign-ups, replies).

**Common mistake:** Hiding poor results.$x80$),
  (81, $x81$

**Worked example:** Lesson: 'Write a one-sentence brief.' Example: audience, goal, tone. Practice: rewrite three vague requests.

**Common mistake:** Teaching everything at once instead of one skill with one worked example.$x81$),
  (82, $x82$

**Worked example:** Critique: 'Strong opening; the biggest problem is the third paragraph repeats the first. Cut it and merge the example.'

**Common mistake:** Listing every flaw instead of the one that matters most.$x82$),
  (83, $x83$

**Worked example:** Publish your best case study with sources and a short note on how AI helped.

**Common mistake:** Sharing something you would not want to be judged by.$x83$),
  (84, $x84$

**Worked example:** Case study: 'Guide grew trials 12%; the comparison table did most of the work; my first headline failed.'

**Common mistake:** Leaving out what failed.$x84$),
  (85, $x85$

**Worked example:** Plan: 'My point of view: clear, honest writing that helps small businesses. Three flagship pieces, one lesson, one open resource, six months, measured by real users and feedback.'

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
 where t.id = d.track_id and t.slug = 'content' and d.day_number = v.n
   and d.lesson_md not like '%**Worked example:**%';
