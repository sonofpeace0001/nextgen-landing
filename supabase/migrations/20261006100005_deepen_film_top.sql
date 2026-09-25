-- Deepen Expert and Grandmaster lessons for film: worked example and common mistake (idempotent).
update public.day d
   set lesson_md = d.lesson_md || v.extra
  from (values
  (61, $x61$

**Worked example:** Statement: 'I make quiet films about ordinary courage; slow pace, warm light, sound over score.' Look book of six frames.

**Common mistake:** Copying a director without choosing anything yourself.$x61$),
  (62, $x62$

**Worked example:** Bible: characters with reference images, wardrobe, locations, palette, prompt blocks; eight shots checked against it.

**Common mistake:** No bible, so the character drifts.$x62$),
  (63, $x63$

**Worked example:** Cue sheet with sources and licences; two minutes mixed with dialogue at -16 LUFS.

**Common mistake:** No licence for music.$x63$),
  (64, $x64$

**Worked example:** Deliver to YouTube (1080p, -14 LUFS) and a festival spec (ProRes, 24 fps); checklist ticked.

**Common mistake:** Exporting once for everything.$x64$),
  (65, $x65$

**Worked example:** Directed short: statement, bible, cue sheet, platform checklist.

**Common mistake:** No documentation.$x65$),
  (66, $x66$

**Worked example:** Budget: 30 shots x 4 attempts x 5 credits = 600, 20% buffer, 10 days; risk: tool outage, so keep a backup tool.

**Common mistake:** Budget with no buffer.$x66$),
  (67, $x67$

**Worked example:** Talent agreement: written consent, use limited to this film, pay, credit, revocation.

**Common mistake:** Using a voice without consent.$x67$),
  (68, $x68$

**Worked example:** Hybrid sequence: filmed hallway + generated window view, matched grain; provenance log lists each source.

**Common mistake:** No log of what is generated.$x68$),
  (69, $x69$

**Worked example:** Folders: 01_script, 02_boards, 03_shots, 04_edit; versions v01 to v05; time-coded notes.

**Common mistake:** Files named 'final_final2'.$x69$),
  (70, $x70$

**Worked example:** Client-style production: budget, schedule, agreement, provenance log, locked-cut review.

**Common mistake:** Skipping the locked cut.$x70$),
  (71, $x71$

**Worked example:** Factual film: sources for each claim; reconstructions labelled 'illustration'.

**Common mistake:** Presenting generated images as real footage.$x71$),
  (72, $x72$

**Worked example:** Audit: 'clinically proven' claim needs evidence or removal; sponsored content needs disclosure.

**Common mistake:** Unsubstantiated claims.$x72$),
  (73, $x73$

**Worked example:** Plan: platform, release date, goals (500 views, 10 emails), 90-day calendar.

**Common mistake:** Publishing with no plan.$x73$),
  (74, $x74$

**Worked example:** Pack for two festivals with their AI policies noted; honest tool statement.

**Common mistake:** Ignoring festival rules.$x74$),
  (75, $x75$

**Worked example:** Release package: factual/label plan, advertising audit, distribution plan, submission pack.

**Common mistake:** No submission pack.$x75$),
  (76, $x76$

**Worked example:** Development: treatment, script, look book, bible, budget, schedule, consent forms.

**Common mistake:** Skipping development.$x76$),
  (77, $x77$

**Worked example:** Production: tracker with attempts and credits; provenance log kept.

**Common mistake:** Losing track of credits.$x77$),
  (78, $x78$

**Worked example:** Post: edit, mix, grade, captions; check on a phone and a TV.

**Common mistake:** Only checking on one screen.$x78$),
  (79, $x79$

**Worked example:** Screen for ten viewers; two did not understand the ending; add a shot; release with credits.

**Common mistake:** Skipping the screening.$x79$),
  (80, $x80$

**Worked example:** Flagship: film, development docs, provenance log, clearance, screening results, release plan.

**Common mistake:** No clearance.$x80$),
  (81, $x81$

**Worked example:** Lesson: 'Cover lip-sync with a cutaway.' Example clip and practice task.

**Common mistake:** Teaching everything at once instead of one skill with one worked example.$x81$),
  (82, $x82$

**Worked example:** Critique: 'Strong mood; the continuity error is the jacket colour change in shot 6.'

**Common mistake:** Listing every flaw instead of the one that matters most.$x82$),
  (83, $x83$

**Worked example:** Publish a behind-the-scenes breakdown showing failed takes and credits used.

**Common mistake:** Sharing something you would not want to be judged by.$x83$),
  (84, $x84$

**Worked example:** Case study: 'Six-minute film, 312 credits, 1,800 views; the first ending failed in screening.'

**Common mistake:** Leaving out what failed.$x84$),
  (85, $x85$

**Worked example:** Plan: 'My point of view: quiet, human stories made with honest tools. Three flagship pieces, one lesson, one open resource, six months, measured by real users and feedback.'

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
 where t.id = d.track_id and t.slug = 'film' and d.day_number = v.n
   and d.lesson_md not like '%**Worked example:**%';
