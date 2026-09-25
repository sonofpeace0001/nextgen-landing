-- Deepen Expert and Grandmaster lessons for graphics: worked example and common mistake (idempotent).
update public.day d
   set lesson_md = d.lesson_md || v.extra
  from (values
  (61, $x61$

**Worked example:** Positioning: 'For independent cafes, a warm, hand-made look that says local, not chain.' Principles: hand-drawn accents, warm palette, no stock people.

**Common mistake:** Principles that fit any brand.$x61$),
  (62, $x62$

**Worked example:** Tokens: colour/brand/primary, spacing/16, type/heading-2. Components: post, story, button, each with do and do not.

**Common mistake:** Naming tokens by colour ('blue-500') instead of purpose.$x62$),
  (63, $x63$

**Worked example:** Audit: body text #777 on white is 4.48:1, fails; change to #595959 (7:1). Add alt text.

**Common mistake:** Relying on colour alone to show meaning.$x63$),
  (64, $x64$

**Worked example:** Pipeline: brief template, style block, reference, 10 generations, checklist, edit, export; approval 6 of 10, cost 40 credits.

**Common mistake:** Not tracking approval rate or cost.$x64$),
  (65, $x65$

**Worked example:** System sheet with tokens, components, accessibility audit, pipeline notes and five sample assets.

**Common mistake:** A system with no examples of use.$x65$),
  (66, $x66$

**Worked example:** Line length 60 characters, leading 1.5, hierarchy 48/32/20/16; annotate why the heading pairs with the body font.

**Common mistake:** Choosing fonts by mood only.$x66$),
  (67, $x67$

**Worked example:** Shot list: subject, framing, light, palette; reject shots whose hands melt or whose light disagrees with the set.

**Common mistake:** Keeping a beautiful image that does not fit.$x67$),
  (68, $x68$

**Worked example:** Style sheet: round shapes, 3 px outline, flat colour, paper texture; four illustrations follow it.

**Common mistake:** Each illustration in a new style.$x68$),
  (69, $x69$

**Worked example:** Four-page layout on a 12-column grid, full-bleed image page, pull quote, consistent captions.

**Common mistake:** Ignoring pacing across pages.$x69$),
  (70, $x70$

**Worked example:** Identity: vector logo, palette, fonts, illustration style, five applications (sign, menu, post, cup, card).

**Common mistake:** Delivering only the logo.$x70$),
  (71, $x71$

**Worked example:** Proposal: strategy 600, identity 1,400, revisions 2 rounds, usage rights, AI use disclosed.

**Common mistake:** Selling logo files with no usage terms.$x71$),
  (72, $x72$

**Worked example:** Checklist: tool licence checked, no resemblance to known marks, prompts and edits saved, likeness consent.

**Common mistake:** Assuming ownership is automatic.$x72$),
  (73, $x73$

**Worked example:** Critique: 'The headline competes with the image; reduce the image contrast under the text.'

**Common mistake:** Saying 'I do not like it'.$x73$),
  (74, $x74$

**Worked example:** Review: goals first, criteria, decisions logged with owners, next review date.

**Common mistake:** Meetings with no decisions.$x74$),
  (75, $x75$

**Worked example:** Set of eight assets with direction brief, critique notes and before/after for three.

**Common mistake:** No brief for the team.$x75$),
  (76, $x76$

**Worked example:** Insight: 'Cafe owners do not lack posts; they lack posts that match their shop.' Idea: 'Made like your shop'. Test on five people.

**Common mistake:** A big idea with no insight.$x76$),
  (77, $x77$

**Worked example:** Key visual plus rules: layout, type, colour, imagery, voice; tested at social, print and screen sizes.

**Common mistake:** A hero that does not scale.$x77$),
  (78, $x78$

**Worked example:** Extend to social, ad, email header, print and a landing hero; check specs per format.

**Common mistake:** Wrong sizes.$x78$),
  (79, $x79$

**Worked example:** Launch a small run, record metrics (saves, clicks), note what to change.

**Common mistake:** No measure of results.$x79$),
  (80, $x80$

**Worked example:** Campaign: research, idea, key visual, set, accessibility and rights checks, results.

**Common mistake:** Skipping checks.$x80$),
  (81, $x81$

**Worked example:** Lesson: 'Make one thing the biggest.' Two example images, a practice task to fix a poster with three equal headlines.

**Common mistake:** Teaching everything at once instead of one skill with one worked example.$x81$),
  (82, $x82$

**Worked example:** Critique: 'Great palette; biggest problem is small body text. Increase to 18px and add space.' with an annotated image.

**Common mistake:** Listing every flaw instead of the one that matters most.$x82$),
  (83, $x83$

**Worked example:** Publish a campaign case study with the key visuals and process.

**Common mistake:** Sharing something you would not want to be judged by.$x83$),
  (84, $x84$

**Worked example:** Case study: 'Set of eight, saves up 22%; the first key visual failed because text was tiny.'

**Common mistake:** Leaving out what failed.$x84$),
  (85, $x85$

**Worked example:** Plan: 'My point of view: design that feels made for the people it serves. Three flagship pieces, one lesson, one open resource, six months, measured by real users and feedback.'

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
 where t.id = d.track_id and t.slug = 'graphics' and d.day_number = v.n
   and d.lesson_md not like '%**Worked example:**%';
