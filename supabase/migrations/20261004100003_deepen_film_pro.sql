-- Deepen Pro-tier lessons for film: worked example and common mistake (idempotent).
update public.day d
   set lesson_md = d.lesson_md || v.extra
  from (values
  (31, $x31$

**Worked example:** Scene: a courier reaches the door and hears her own voice inside. One want, one obstacle, one turn: she goes in.

**Common mistake:** Long dialogue instead of action.$x31$),
  (32, $x32$

**Worked example:** Character A looks left-to-right; keep B right-to-left in reverse shots; check props (the parcel stays in her left hand).

**Common mistake:** Flipping screen direction between shots.$x32$),
  (33, $x33$

**Worked example:** Beat 1 calm, beat 2 doubt (eyes down, still), beat 3 resolve (small nod). Use profile shots when faces drift.

**Common mistake:** Asking for huge emotions.$x33$),
  (34, $x34$

**Worked example:** Push-in for tension, slow pan to reveal the hallway, static wide for calm; state intent for each.

**Common mistake:** Camera drifting for no reason.$x34$),
  (35, $x35$

**Worked example:** A filmed hallway shot plus a generated window view, matched with the same grain and colour; both labelled in the log.

**Common mistake:** Unlabelled mixed footage.$x35$),
  (36, $x36$

**Worked example:** Deliver script, shot list, continuity notes, a 2-minute scene and notes on fixes.

**Common mistake:** Ignoring continuity.$x36$),
  (37, $x37$

**Worked example:** Cue sheet: 0:12 door creak (fx), 0:40 low drone (music), 1:10 silence for the reveal.

**Common mistake:** Constant music.$x37$),
  (38, $x38$

**Worked example:** Two edits of one sequence: fast (1.5s shots) feels anxious; slow (4s) feels lonely.

**Common mistake:** Never comparing paces.$x38$),
  (39, $x39$

**Worked example:** Look: 'cold teal shadows, warm skin', same across all shots, subtle grain.

**Common mistake:** Over-grading to hide flaws.$x39$),
  (40, $x40$

**Worked example:** Cover lip-sync with a cutaway to her hands while the voice speaks; voice used with written consent.

**Common mistake:** Forcing perfect lip-sync.$x40$),
  (41, $x41$

**Worked example:** Credits list tools and music sources; captions proofread; safe margins checked.

**Common mistake:** Forgetting to credit sources.$x41$),
  (42, $x42$

**Worked example:** Deliver 3-minute short, sound mix notes, grade notes, captions and credits.

**Common mistake:** No finishing pass.$x42$),
  (43, $x43$

**Worked example:** Factual explainer: every claim has a source; reconstructed images labelled 'illustration'.

**Common mistake:** Presenting synthetic images as evidence.$x43$),
  (44, $x44$

**Worked example:** Ad: hook in 3 seconds, one message, proof, CTA; every claim substantiated.

**Common mistake:** Claims you cannot prove.$x44$),
  (45, $x45$

**Worked example:** Cut to the beat every 4 bars; repeat a visual motif at each chorus; licensed track.

**Common mistake:** Unlicensed music.$x45$),
  (46, $x46$

**Worked example:** Client brief: goal, audience, storyboard approval before generation, 2 revision rounds, rights statement.

**Common mistake:** Generating before approval.$x46$),
  (47, $x47$

**Worked example:** Log where each shot's audience view is; retention drops at 0:20, so trim the intro.

**Common mistake:** Ignoring analytics.$x47$),
  (48, $x48$

**Worked example:** Deliver brief, approved storyboard, final promo, rights and claims check.

**Common mistake:** No approvals recorded.$x48$),
  (49, $x49$

**Worked example:** Character bible with reference image; check every new shot; keep successful seeds.

**Common mistake:** Regenerating the character each shot.$x49$),
  (50, $x50$

**Worked example:** Shot tracker: shot, status, attempts, credits, notes; 10 shots, 41 attempts.

**Common mistake:** No credit tracking.$x50$),
  (51, $x51$

**Worked example:** Clearance sheet: music, voice, faces, brands, generated assets, tool terms, releases.

**Common mistake:** Assuming releases are unnecessary.$x51$),
  (52, $x52$

**Worked example:** Festival pack: logline, statement, stills, target list, AI policy of each noted.

**Common mistake:** Ignoring a festival's AI rules.$x52$),
  (53, $x53$

**Worked example:** Screen for five viewers: two did not follow the timeline; add an on-screen date.

**Common mistake:** Explaining instead of listening.$x53$),
  (54, $x54$

**Worked example:** Deliver film, clearance, submission pack, screening notes.

**Common mistake:** Skipping clearance.$x54$),
  (55, $x55$

**Worked example:** Pitch: logline, synopsis, audience, look, feasibility with budget.

**Common mistake:** A pitch with no feasibility.$x55$),
  (56, $x56$

**Worked example:** Script, shot list, storyboard and character sheets aligned.

**Common mistake:** Boards that contradict the script.$x56$),
  (57, $x57$

**Worked example:** Produce shots with tracker and provenance log.

**Common mistake:** Losing provenance.$x57$),
  (58, $x58$

**Worked example:** Edit, mix, grade, caption; check on phone.

**Common mistake:** Skipping the phone check.$x58$),
  (59, $x59$

**Worked example:** Screen, fix, clear, finalise.

**Common mistake:** Ignoring viewer notes.$x59$),
  (60, $x60$

**Worked example:** Release package: film, statement, clearance, distribution plan.

**Common mistake:** No distribution plan.$x60$)
  ) as v(n, extra), public.track t
 where t.id = d.track_id and t.slug = 'film' and d.day_number = v.n
   and d.lesson_md not like '%**Worked example:**%';
