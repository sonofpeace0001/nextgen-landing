-- Deepen Basic-tier lessons for film: add a worked example and a common mistake (idempotent).
update public.day d
   set lesson_md = d.lesson_md || v.extra
  from (values
  (1, $x1$

**Worked example:** Logline: 'A shy delivery rider must return a lost dog before the shop closes, but the owner's building has no buzzer.' Who, want, obstacle, in one sentence.

**Common mistake:** Starting with tool settings before knowing what happens in the story.$x1$),
  (2, $x2$

**Worked example:** Shot 3: medium, rider knocks on a door, 3 seconds, sound of a distant dog barking. Six such shots make a 20-second scene.

**Common mistake:** Writing dialogue-heavy scenes that need lip-sync the tools cannot yet do well.$x2$),
  (3, $x3$

**Worked example:** Generate six stills, notice the rider's jacket changes colour in shot 4, and fix the description before spending video credits.

**Common mistake:** Skipping stills and finding problems only after expensive video generations.$x3$),
  (4, $x4$

**Worked example:** Prompt: 'Low angle, slow push-in, a rider in a yellow jacket knocks on a green door at dusk, warm streetlight, cinematic, 5 seconds.'

**Common mistake:** Asking for three actions and two camera moves in one five-second shot.$x4$),
  (5, $x5$

**Worked example:** Watch the clip three times: first for story, then hands and faces, then flicker on edges. Note the usable two seconds.

**Common mistake:** Judging on one viewing and accepting flaws you would spot on a big screen.$x5$),
  (6, $x6$

**Worked example:** Deliver script, six-shot list, six stills, a 15-second clip and a note: 'Shot 4 changed from wide to medium because the door was not readable.'

**Common mistake:** Submitting only the final clip with no evidence of planning.$x6$),
  (7, $x7$

**Worked example:** Sequence: wide (place), medium (action), close-up (reaction), over-the-shoulder (meeting). Each 2 to 4 seconds.

**Common mistake:** Using six wide shots in a row so nothing feels important.$x7$),
  (8, $x8$

**Worked example:** Character sheet: 'Mara, 30s, short black hair, yellow rain jacket, round glasses, blue backpack.' Paste it into every prompt.

**Common mistake:** Describing the character differently in each prompt.$x8$),
  (9, $x9$

**Worked example:** Animate the door still with 'slow push-in, door opens slightly'. Compare with a pan; choose the push-in.

**Common mistake:** Asking for large body motion that models often distort.$x9$),
  (10, $x10$

**Worked example:** Palette: warm yellow, deep green, dusk blue. Every shot pulls from these three; a red shot stands out as wrong.

**Common mistake:** Letting each generation choose its own colours.$x10$),
  (11, $x11$

**Worked example:** A clip melts the hand: reroll with a simpler prompt, then cut away to the door handle before the hand appears.

**Common mistake:** Rerolling the same complex prompt ten times.$x11$),
  (12, $x12$

**Worked example:** Deliver character sheet, colour plan, six-shot list and a 30-second sequence with a note on two fixes.

**Common mistake:** Delivering a clip that looks good but has no consistent character.$x12$),
  (13, $x13$

**Worked example:** Cut on the knock sound; trim two frames off the start of each clip; keep each shot 2 to 4 seconds.

**Common mistake:** Leaving dead time at the start and end of every clip.$x13$),
  (14, $x14$

**Worked example:** Layers: footsteps, distant dog, city hum, soft piano. Music 12 dB under any voice. Licence link for the piano track.

**Common mistake:** Using a famous song without a licence.$x14$),
  (15, $x15$

**Worked example:** Voiceover: 'She had eleven minutes.' Short, spoken sentences, recorded with your own voice or a licensed voice.

**Common mistake:** Cloning a real person's voice without written consent.$x15$),
  (16, $x16$

**Worked example:** Captions in large white text with dark outline, two lines maximum, checked against the spoken words.

**Common mistake:** Trusting auto-captions without proofreading names.$x16$),
  (17, $x17$

**Worked example:** Warm grade on all shots, same contrast. Export 1080p, 24 fps, H.264, under 100 MB for social.

**Common mistake:** Exporting at the tool's default settings without checking the platform.$x17$),
  (18, $x18$

**Worked example:** Deliver 45-second film, script, voiceover source, music licence and export settings.

**Common mistake:** Forgetting to list where sounds and music came from.$x18$),
  (19, $x19$

**Worked example:** Recut the 16:9 film to 9:16: reframe faces, add captions, hook in the first 3 seconds.

**Common mistake:** Simply cropping the sides and cutting off the subject.$x19$),
  (20, $x20$

**Worked example:** Rule: never make a realistic video of a real person doing something they did not do. Label AI scenes when a platform asks.

**Common mistake:** Treating disclosure as optional.$x20$),
  (21, $x21$

**Worked example:** Audit table: asset, source, licence, proof link. One row for the music, one for each voice, one for the tool licence.

**Common mistake:** Assuming 'AI-generated' means 'free of rights questions'.$x21$),
  (22, $x22$

**Worked example:** Budget: 12 shots x 4 attempts x 5 credits = 240 credits. Add 20 percent buffer. Two working days for editing.

**Common mistake:** Budgeting one attempt per shot.$x22$),
  (23, $x23$

**Worked example:** Three viewers: two did not realise the rider was delivering; add a shot of the parcel in the first 5 seconds.

**Common mistake:** Explaining your film to viewers instead of watching their reactions.$x23$),
  (24, $x24$

**Worked example:** Deliver captions, disclosure line, rights audit and a note on the feedback change.

**Common mistake:** Publishing before the rights check.$x24$),
  (25, $x25$

**Worked example:** Brief: 'A 60-second promo for a small bakery. Audience: local students. Goal: 100 new visitors. Tone: warm, funny. Platform: vertical video.'

**Common mistake:** A brief with no goal, so you cannot tell if it worked.$x25$),
  (26, $x26$

**Worked example:** Script in two columns: picture and sound. Ten shots, each with a reference still.

**Common mistake:** A shot list that does not match the script.$x26$),
  (27, $x27$

**Worked example:** Keep the best of three takes per shot; log 'shot 5, take 2, 6 credits'.

**Common mistake:** Not logging credits until the budget runs out.$x27$),
  (28, $x28$

**Worked example:** Assemble, add the music, grade and add captions. Watch on a phone with the sound off.

**Common mistake:** Only checking on a large monitor.$x28$),
  (29, $x29$

**Worked example:** Three viewers say the ending is rushed; hold the last shot 2 seconds longer and re-export.

**Common mistake:** Ignoring feedback because you are tired of the project.$x29$),
  (30, $x30$

**Worked example:** Making-of note: what worked, what failed, credits used (312), and what you would change.

**Common mistake:** Hiding the failures; they are the learning.$x30$)
  ) as v(n, extra), public.track t
 where t.id = d.track_id and t.slug = 'film' and d.day_number = v.n
   and d.lesson_md not like '%**Worked example:**%';
