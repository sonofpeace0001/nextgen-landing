-- Deepen Basic-tier lessons for research: add a worked example and a common mistake (idempotent).
update public.day d
   set lesson_md = d.lesson_md || v.extra
  from (values
  (1, $x1$

**Worked example:** Ask about a topic you know: the AI gives a wrong date. Lesson: verify every fact, especially numbers, names and dates.

**Common mistake:** Believing fluent answers.$x1$),
  (2, $x2$

**Worked example:** Vague: 'Is social media bad?' Better: 'Does daily use over 3 hours relate to lower sleep in UK teenagers?' Sub-questions on measures and studies.

**Common mistake:** Asking a question too big to answer.$x2$),
  (3, $x3$

**Worked example:** Rank: government statistics (strong), peer-reviewed study (strong), company blog (check bias), anonymous forum (weak).

**Common mistake:** Treating all sources equally.$x3$),
  (4, $x4$

**Worked example:** AI cites 'Smith 2019'. Search: no such paper. Log: claim, source, quote, verified: no.

**Common mistake:** Copying citations without opening them.$x4$),
  (5, $x5$

**Worked example:** Read abstract, conclusion, figures, then methods: 400 adults, 8 weeks, no control group. Limit: cannot prove cause.

**Common mistake:** Reading only the abstract.$x5$),
  (6, $x6$

**Worked example:** Briefing: answer first, three findings with sources, limits, recommendation, all on one page.

**Common mistake:** Burying the answer at the end.$x6$),
  (7, $x7$

**Worked example:** Dataset: 1 row per country per year; columns: population (people), GDP (US dollars, 2015 prices). Note missing years.

**Common mistake:** Not reading the units.$x7$),
  (8, $x8$

**Worked example:** Found 12 duplicate rows and 'UK', 'U.K.' and 'United Kingdom'; fix, then log: 412 rows before, 400 after.

**Common mistake:** Cleaning without a log.$x8$),
  (9, $x9$

**Worked example:** Median income 32k, mean 41k: the mean is pulled up by a few high earners. Use a bar chart starting at zero.

**Common mistake:** Reporting only the average.$x9$),
  (10, $x10$

**Worked example:** Ice cream sales and drownings both rise in summer; the shared cause is hot weather.

**Common mistake:** Assuming one thing caused the other.$x10$),
  (11, $x11$

**Worked example:** Ask AI for the average, then check three numbers by hand in a spreadsheet; use public data only.

**Common mistake:** Uploading private data to a tool you have not checked.$x11$),
  (12, $x12$

**Worked example:** Data story: question, cleaned public dataset, three charts, limits, all sources cited.

**Common mistake:** Charts without a stated takeaway.$x12$),
  (13, $x13$

**Worked example:** Compare three phones on price, battery and support, with weights and a source for each score.

**Common mistake:** Hiding your weights.$x13$),
  (14, $x14$

**Worked example:** Table: competitor, offer, price, source link, date checked. Public sources only.

**Common mistake:** Using undated or private information.$x14$),
  (15, $x15$

**Worked example:** Ask: 'Tell me about the last time you did X.' Not: 'Would you like a feature that does X?'

**Common mistake:** Leading questions.$x15$),
  (16, $x16$

**Worked example:** Six notes group into themes; insight: 'Users abandon at payment because costs appear late.' Confidence: medium.

**Common mistake:** Listing notes without an insight.$x16$),
  (17, $x17$

**Worked example:** Rewrite: 'Recommendation: show total costs earlier. Evidence: 3 of 5 users left at checkout. Limit: small sample.'

**Common mistake:** Sending long documents to busy people.$x17$),
  (18, $x18$

**Worked example:** Brief: options, criteria, evidence with links, recommendation, confidence, what would change your mind.

**Common mistake:** No statement of limits.$x18$),
  (19, $x19$

**Worked example:** Ethics checklist: consent, anonymise names, secure storage, delete after project, honest reporting, permission for quotes.

**Common mistake:** Publishing identifiable quotes without permission.$x19$),
  (20, $x20$

**Worked example:** Ask 'Are electric cars greener?' three ways (neutral, pro, anti) and compare; note where framing changes the answer.

**Common mistake:** Not testing different framings.$x20$),
  (21, $x21$

**Worked example:** Viral quote: trace it to the original speech, find the date; the meaning changed. Verdict: misleading.

**Common mistake:** Fact-checking only the headline.$x21$),
  (22, $x22$

**Worked example:** Notes template: source, date, key point, tags, confidence, follow-up. Weekly 30-minute review.

**Common mistake:** Keeping notes with no sources.$x22$),
  (23, $x23$

**Worked example:** Three slides: one message each, clear labels, source line at the bottom.

**Common mistake:** Cluttered charts.$x23$),
  (24, $x24$

**Worked example:** Pack: question, methods, verified sources, findings, ethics note, one-page summary.

**Common mistake:** No methods section.$x24$),
  (25, $x25$

**Worked example:** Question: 'Which local shops need better online booking?' Decision it supports: which to contact first.

**Common mistake:** A question nobody needs answered.$x25$),
  (26, $x26$

**Worked example:** Plan: sub-questions, sources, data, verification steps, ethics check, timeline.

**Common mistake:** Starting collection with no plan.$x26$),
  (27, $x27$

**Worked example:** Evidence table with 12 rows: claim, source, quote, verified, notes; gaps listed.

**Common mistake:** Not recording gaps.$x27$),
  (28, $x28$

**Worked example:** Compare five shops; three insights with confidence: high, medium, low.

**Common mistake:** Overstating confidence.$x28$),
  (29, $x29$

**Worked example:** Briefing draft reviewed by a peer, who spots that the answer is on page 2; move it first.

**Common mistake:** Skipping peer review.$x29$),
  (30, $x30$

**Worked example:** Q&A: 'Why this source?' 'Why exclude the survey?' 'What would change your view?'

**Common mistake:** Defending choices without evidence.$x30$)
  ) as v(n, extra), public.track t
 where t.id = d.track_id and t.slug = 'research' and d.day_number = v.n
   and d.lesson_md not like '%**Worked example:**%';
