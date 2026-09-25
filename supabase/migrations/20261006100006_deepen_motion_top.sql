-- Deepen Expert and Grandmaster lessons for motion: worked example and common mistake (idempotent).
update public.day d
   set lesson_md = d.lesson_md || v.extra
  from (values
  (61, $x61$

**Worked example:** Language: 'precise and calm': 300 ms ease-out, small scale changes, no bounce; three examples.

**Common mistake:** A language nobody can apply.$x61$),
  (62, $x62$

**Worked example:** Handoff: named layers, exported tokens, version notes; the animator can rebuild a screen in 20 minutes.

**Common mistake:** Sending a flattened file.$x62$),
  (63, $x63$

**Worked example:** Procedural: a title card whose text and colour come from a data file; three variants produced instantly.

**Common mistake:** Rebuilding the same animation for every text change.$x63$),
  (64, $x64$

**Worked example:** Prototype tested on two phones: 60 fps on one, 35 on the low-end; simplify the blur.

**Common mistake:** Testing only on your laptop.$x64$),
  (65, $x65$

**Worked example:** Motion system: language, tokens, handoff, procedural template, interactive prototype.

**Common mistake:** No template.$x65$),
  (66, $x66$

**Worked example:** Composite: 3D object, footage and generated sky matched with the same camera, light and grain.

**Common mistake:** Mismatched light.$x66$),
  (67, $x67$

**Worked example:** Title package: opening, lower third, end card; safe areas; localisation-ready text boxes.

**Common mistake:** Text that breaks in another language.$x67$),
  (68, $x68$

**Worked example:** Data explainer: 40 seconds, sources on screen, uncertainty shown; a non-expert explains it back correctly.

**Common mistake:** No comprehension test.$x68$),
  (69, $x69$

**Worked example:** Audio-driven visuals: kick drives scale; chorus raises intensity; licensed track.

**Common mistake:** Unlicensed music.$x69$),
  (70, $x70$

**Worked example:** Package: titles, explainer, audio-visual piece with notes.

**Common mistake:** No consistency across pieces.$x70$),
  (71, $x71$

**Worked example:** Reduced-motion variants: parallax becomes fade; flashing removed; captions on.

**Common mistake:** Only one version.$x71$),
  (72, $x72$

**Worked example:** Register: asset, source, licence, proof; generated images noted with tool terms.

**Common mistake:** Untracked assets.$x72$),
  (73, $x73$

**Worked example:** Quote: seconds, complexity, rounds, formats; hours tracked against the quote.

**Common mistake:** Never tracking hours.$x73$),
  (74, $x74$

**Worked example:** Presentation: rationale first, two options, feedback protocol, approvals recorded.

**Common mistake:** Showing work without rationale.$x74$),
  (75, $x75$

**Worked example:** Studio kit: reduced-motion set, provenance register, quote package, presentation.

**Common mistake:** Business documents missing.$x75$),
  (76, $x76$

**Worked example:** Brief, insight, concept and language for three pieces; boards.

**Common mistake:** Skipping the concept.$x76$),
  (77, $x77$

**Worked example:** Hero piece 30 seconds following the language; check timing tokens.

**Common mistake:** Ignoring your own system.$x77$),
  (78, $x78$

**Worked example:** Variants for social, web and broadcast with reduced-motion versions.

**Common mistake:** No accessibility variants.$x78$),
  (79, $x79$

**Worked example:** Feedback with time codes, register finished, delivery organised.

**Common mistake:** Loose files.$x79$),
  (80, $x80$

**Worked example:** Flagship campaign: all pieces, accessibility variants, provenance register, rationale.

**Common mistake:** No rationale.$x80$),
  (81, $x81$

**Worked example:** Lesson: 'Ease-out for entrances.' Example animation link and practice.

**Common mistake:** Teaching everything at once instead of one skill with one worked example.$x81$),
  (82, $x82$

**Worked example:** Critique: 'The hold is too short to read; extend to 2 seconds.'

**Common mistake:** Listing every flaw instead of the one that matters most.$x82$),
  (83, $x83$

**Worked example:** Publish a template with docs and licence.

**Common mistake:** Sharing something you would not want to be judged by.$x83$),
  (84, $x84$

**Worked example:** Case study: 'Launch pack; completion up 14% after slowing the explainer; first version too fast.'

**Common mistake:** Leaving out what failed.$x84$),
  (85, $x85$

**Worked example:** Plan: 'My point of view: clear, considerate motion. Three flagship pieces, one lesson, one open resource, six months, measured by real users and feedback.'

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
 where t.id = d.track_id and t.slug = 'motion' and d.day_number = v.n
   and d.lesson_md not like '%**Worked example:**%';
