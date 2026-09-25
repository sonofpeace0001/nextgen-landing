-- Deepen Expert and Grandmaster lessons for audio: worked example and common mistake (idempotent).
update public.day d
   set lesson_md = d.lesson_md || v.extra
  from (values
  (61, $x61$

**Worked example:** Strategy: values (warm, trustworthy), sound principles (soft attack, wooden timbre), three test options rated by 10 listeners.

**Common mistake:** Choosing sounds by taste alone.$x61$),
  (62, $x62$

**Worked example:** Six sounds with patch notes so anyone can reproduce them; a clean, non-clipping export.

**Common mistake:** Undocumented sounds.$x62$),
  (63, $x63$

**Worked example:** Spatial scene of a market with stereo fallback; check it stays clear on a phone.

**Common mistake:** A spatial mix that collapses on speakers.$x63$),
  (64, $x64$

**Worked example:** Master: reference track compared, -14 LUFS, true peak -1 dB, translation checked on five devices.

**Common mistake:** Mastering only on headphones.$x64$),
  (65, $x65$

**Worked example:** Identity system: strategy, sound logo, six UI sounds, mastered anthem.

**Common mistake:** No usage rules.$x65$),
  (66, $x66$

**Worked example:** AI sketches a melody; you rearrange, replace a line, record your part; note what is yours and the tool's terms.

**Common mistake:** Releasing raw AI output as your composition.$x66$),
  (67, $x67$

**Worked example:** 20 lines in one voice, consistent settings, QC log; consent documented.

**Common mistake:** Inconsistent takes.$x67$),
  (68, $x68$

**Worked example:** Adaptive audio: calm, tension, danger layers; randomised footsteps; tested in context.

**Common mistake:** Repeating the same sound.$x68$),
  (69, $x69$

**Worked example:** 10-minute episode: -16 LUFS, credits, licensed music, accurate transcript.

**Common mistake:** No transcript.$x69$),
  (70, $x70$

**Worked example:** Pilot: composed music, voice lines, adaptive element, cue sheet, QC log.

**Common mistake:** Missing QC.$x70$),
  (71, $x71$

**Worked example:** Split sheet: composer 50, lyricist 25, producer 25; rights summary.

**Common mistake:** No agreed splits.$x71$),
  (72, $x72$

**Worked example:** Policy: written consent, defined use, right to withdraw, synthetic label.

**Common mistake:** No labelling.$x72$),
  (73, $x73$

**Worked example:** Quote, contract outline, revision policy stating who owns the audio and AI tool use.

**Common mistake:** Ambiguous ownership.$x73$),
  (74, $x74$

**Worked example:** 90-day plan: weekly release, retention analysis, promote to two communities.

**Common mistake:** No metrics.$x74$),
  (75, $x75$

**Worked example:** Practice pack: split sheet, voice policy, contract, growth plan.

**Common mistake:** No policy.$x75$),
  (76, $x76$

**Worked example:** Brief, plan and rights map for a series.

**Common mistake:** Rights ignored.$x76$),
  (77, $x77$

**Worked example:** Core audio recorded or composed; source log kept.

**Common mistake:** Unlogged sources.$x77$),
  (78, $x78$

**Worked example:** Mix, master, QC across devices; loudness report.

**Common mistake:** No device checks.$x78$),
  (79, $x79$

**Worked example:** Release; two weeks of feedback and metrics.

**Common mistake:** No listener feedback.$x79$),
  (80, $x80$

**Worked example:** Flagship work: audio, documentation, rights, accessibility files, results.

**Common mistake:** No accessibility files.$x80$),
  (81, $x81$

**Worked example:** Lesson: 'Duck music under speech.' Example mix and a practice task.

**Common mistake:** Teaching everything at once instead of one skill with one worked example.$x81$),
  (82, $x82$

**Worked example:** Critique: 'Lovely tone; speech is masked at 0:45. Lower the music 6 dB there.'

**Common mistake:** Listing every flaw instead of the one that matters most.$x82$),
  (83, $x83$

**Worked example:** Publish a licensed sound pack with documentation.

**Common mistake:** Sharing something you would not want to be judged by.$x83$),
  (84, $x84$

**Worked example:** Case study: 'Audio brand for a cafe; listener recall 60%; first sting was too long.'

**Common mistake:** Leaving out what failed.$x84$),
  (85, $x85$

**Worked example:** Plan: 'My point of view: sound that is clear, licensed and human. Three flagship pieces, one lesson, one open resource, six months, measured by real users and feedback.'

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
 where t.id = d.track_id and t.slug = 'audio' and d.day_number = v.n
   and d.lesson_md not like '%**Worked example:**%';
