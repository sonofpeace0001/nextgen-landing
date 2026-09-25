-- Deepen Pro-tier lessons for motion: worked example and common mistake (idempotent).
update public.day d
   set lesson_md = d.lesson_md || v.extra
  from (values
  (31, $x31$

**Worked example:** Timing token 100 ms; hierarchy: primary moves 400 ms, secondary 250 ms; ease-out entrances only.

**Common mistake:** Every element moves the same.$x31$),
  (32, $x32$

**Worked example:** Light object: fast, little overshoot; heavy object: slow start, settles; compare parameters.

**Common mistake:** Too much overshoot.$x32$),
  (33, $x33$

**Worked example:** Reveal a headline through a circle mask that grows; edges crisp.

**Common mistake:** Feathered masks that look muddy.$x33$),
  (34, $x34$

**Worked example:** Headline staggers by word 60 ms; subhead fades after; read time 2.2 seconds.

**Common mistake:** Animating paragraphs.$x34$),
  (35, $x35$

**Worked example:** Lottie 14 KB with a still fallback and a reduced-motion version.

**Common mistake:** No fallback.$x35$),
  (36, $x36$

**Worked example:** Deliver five micro-interactions, system definition, reduced-motion notes.

**Common mistake:** No accessibility notes.$x36$),
  (37, $x37$

**Worked example:** A box lit from top-left, camera orbit 20 degrees, subtle shadow.

**Common mistake:** Over-complicated scenes.$x37$),
  (38, $x38$

**Worked example:** Glow at 20% and grain 4% unify layers; checked on dark and bright screens.

**Common mistake:** Heavy glow everywhere.$x38$),
  (39, $x39$

**Worked example:** Chart animates from zero; annotated peak; source on last frame.

**Common mistake:** Distorting the scale.$x39$),
  (40, $x40$

**Worked example:** Character: idle breathing loop 3 seconds, one wave; design rights documented.

**Common mistake:** Using someone else's character.$x40$),
  (41, $x41$

**Worked example:** Hits at 0:01, 0:03, 0:05 on the kick; intensity rises in the chorus.

**Common mistake:** Sync drift.$x41$),
  (42, $x42$

**Worked example:** Deliver 30-second brand animation, storyboard, system notes, licences.

**Common mistake:** No licence list.$x42$),
  (43, $x43$

**Worked example:** Animatic: stills with voiceover timed to 45 seconds before any animation.

**Common mistake:** Animating before timing is agreed.$x43$),
  (44, $x44$

**Worked example:** Two ad hooks: question vs stat; caption on screen; policy checked.

**Common mistake:** No captions.$x44$),
  (45, $x45$

**Worked example:** Highlight the feature with a soft glow; keep each scene under 5 seconds.

**Common mistake:** Feature tour with no story.$x45$),
  (46, $x46$

**Worked example:** Template with text and colour controls; two variants in 10 minutes.

**Common mistake:** Hard-coded text.$x46$),
  (47, $x47$

**Worked example:** Quote: 30 seconds, 2 rounds, 3 formats, 5 days; rush +25%.

**Common mistake:** Free revisions.$x47$),
  (48, $x48$

**Worked example:** Deliver explainer, two cut-downs, and template.

**Common mistake:** No template.$x48$),
  (49, $x49$

**Worked example:** Reduce layers 40 to 18; file 8 MB to 2 MB; playback smooth on old phone.

**Common mistake:** Optimising blindly.$x49$),
  (50, $x50$

**Worked example:** Checklist: no flashing, pause control, captions, reduced-motion version, meaningful alt.

**Common mistake:** Skipping checks.$x50$),
  (51, $x51$

**Worked example:** Log: asset, source, licence, proof link; AI-generated images noted with tool terms.

**Common mistake:** Untracked assets.$x51$),
  (52, $x52$

**Worked example:** Reel: three best pieces, best first, under 60 seconds, credits honest.

**Common mistake:** A reel of ten average pieces.$x52$),
  (53, $x53$

**Worked example:** Feedback with time codes; version log v1 to v3.

**Common mistake:** No version log.$x53$),
  (54, $x54$

**Worked example:** Deliver reel, process notes, accessibility check and licence log.

**Common mistake:** Hiding process.$x54$),
  (55, $x55$

**Worked example:** Brief: brand, goals, deliverables, formats, schedule.

**Common mistake:** No formats.$x55$),
  (56, $x56$

**Worked example:** Motion system and storyboards for every piece.

**Common mistake:** Pieces with no shared system.$x56$),
  (57, $x57$

**Worked example:** Hero animation plus a variant.

**Common mistake:** Skipping the variant.$x57$),
  (58, $x58$

**Worked example:** Formats with captions and reduced-motion versions.

**Common mistake:** No reduced-motion version.$x58$),
  (59, $x59$

**Worked example:** Critique, revise, licence log complete.

**Common mistake:** Incomplete log.$x59$),
  (60, $x60$

**Worked example:** All files, usage guide, licence log, client summary.

**Common mistake:** No usage guide.$x60$)
  ) as v(n, extra), public.track t
 where t.id = d.track_id and t.slug = 'motion' and d.day_number = v.n
   and d.lesson_md not like '%**Worked example:**%';
