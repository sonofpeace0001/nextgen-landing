-- Deepen Pro-tier lessons for audio: worked example and common mistake (idempotent).
update public.day d
   set lesson_md = d.lesson_md || v.extra
  from (values
  (31, $x31$

**Worked example:** Direction: 'warm, slightly amused, slow on the last three words.' Three takes, choose take 2.

**Common mistake:** Only one take.$x31$),
  (32, $x32$

**Worked example:** Voice A slow and deep, voice B quick; overlap by 0.3 seconds once; both licensed.

**Common mistake:** Same tone for both characters.$x32$),
  (33, $x33$

**Worked example:** UI click: short noise burst + low thump + tiny tail; note the layers.

**Common mistake:** Single layer sounds.$x33$),
  (34, $x34$

**Worked example:** Structure: intro 8 bars, build 8, main 16, breakdown 8, outro 8; edit best parts together.

**Common mistake:** Repeating one loop.$x34$),
  (35, $x35$

**Worked example:** Cut 250 Hz mud, gentle 3 dB compression, reference track at same loudness.

**Common mistake:** Mixing without a reference.$x35$),
  (36, $x36$

**Worked example:** Deliver a 30-second spot with script, direction notes, licences.

**Common mistake:** No direction notes.$x36$),
  (37, $x37$

**Worked example:** Checklist: outline, record, edit, master, publish, promote; 6 hours per episode.

**Common mistake:** No time budget.$x37$),
  (38, $x38$

**Worked example:** Guide: research guest, eight open questions, consent to record and publish, separate tracks.

**Common mistake:** No consent.$x38$),
  (39, $x39$

**Worked example:** Cut a 5-minute recording to 3; do not remove qualifiers that change meaning.

**Common mistake:** Editing meaning.$x39$),
  (40, $x40$

**Worked example:** Foley: footsteps and cloth for a 20-second clip; ambience under; dialogue clear.

**Common mistake:** Missing ambience.$x40$),
  (41, $x41$

**Worked example:** Master to -16 LUFS, true peak -1 dB, check on phone and car.

**Common mistake:** Only headphones.$x41$),
  (42, $x42$

**Worked example:** Episode with intro, interview, music, show notes, mastered.

**Common mistake:** No show notes.$x42$),
  (43, $x43$

**Worked example:** Narrate 2 minutes of public-domain text; sheet: 'Aoife = EE-fa'.

**Common mistake:** Inconsistent pronunciations.$x43$),
  (44, $x44$

**Worked example:** Sonic logo 2 seconds, two variants, brief documented.

**Common mistake:** Too long.$x44$),
  (45, $x45$

**Worked example:** 10-second loop with a seamless join, extra layer on state change.

**Common mistake:** A click at the loop point.$x45$),
  (46, $x46$

**Worked example:** Script translated; a native speaker corrects two phrases; synthetic dub labelled.

**Common mistake:** Unreviewed translation.$x46$),
  (47, $x47$

**Worked example:** Reduce hum with a notch filter, gentle noise reduction; before/after clips.

**Common mistake:** Over-processing.$x47$),
  (48, $x48$

**Worked example:** Package: sonic logo, bed, narration, localised line, licences.

**Common mistake:** No licences.$x48$),
  (49, $x49$

**Worked example:** Quote: 5-minute edit 150; 2 rounds; ownership and AI tools stated.

**Common mistake:** Not stating AI use.$x49$),
  (50, $x50$

**Worked example:** Consent form: purpose, duration, payment, revocation, labelling.

**Common mistake:** No revocation clause.$x50$),
  (51, $x51$

**Worked example:** Transcript proofread; audio description of visuals in plain language.

**Common mistake:** Skipping accessibility.$x51$),
  (52, $x52$

**Worked example:** Plan: weekly, retention at minute 4 drops; trim intros.

**Common mistake:** Clickbait titles.$x52$),
  (53, $x53$

**Worked example:** Release checklist: levels, clicks, pronunciations, licences, metadata.

**Common mistake:** Skipping a final listen.$x53$),
  (54, $x54$

**Worked example:** Deliver audio product with terms, consent, transcript, checklist.

**Common mistake:** Missing terms.$x54$),
  (55, $x55$

**Worked example:** Brief: audience, goal, deliverables, formats, schedule.

**Common mistake:** No audience.$x55$),
  (56, $x56$

**Worked example:** Scripts, sound brief, consent forms.

**Common mistake:** Recording before consent.$x56$),
  (57, $x57$

**Worked example:** Assets recorded or generated with licences.

**Common mistake:** Unlogged sources.$x57$),
  (58, $x58$

**Worked example:** Mix and master with loudness report.

**Common mistake:** No loudness check.$x58$),
  (59, $x59$

**Worked example:** Transcript, checklist, three listeners' feedback and fixes.

**Common mistake:** Ignoring feedback.$x59$),
  (60, $x60$

**Worked example:** Deliver package, guide, rights records, cover note.

**Common mistake:** No rights records.$x60$)
  ) as v(n, extra), public.track t
 where t.id = d.track_id and t.slug = 'audio' and d.day_number = v.n
   and d.lesson_md not like '%**Worked example:**%';
