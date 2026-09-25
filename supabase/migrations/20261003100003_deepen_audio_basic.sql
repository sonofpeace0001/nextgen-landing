-- Deepen Basic-tier lessons for audio: add a worked example and a common mistake (idempotent).
update public.day d
   set lesson_md = d.lesson_md || v.extra
  from (values
  (1, $x1$

**Worked example:** Tasks: 60-second narration (text to speech), podcast intro (music + voice), noisy interview cleanup. Rule: consent before cloning any voice.

**Common mistake:** Believing AI voices are free of legal limits.$x1$),
  (2, $x2$

**Worked example:** Written: 'The utilisation of our services provides savings.' Spoken: 'Using our service saves you money.'

**Common mistake:** Reading written sentences aloud without editing.$x2$),
  (3, $x3$

**Worked example:** Add commas for pauses, spell 'Aoife' as 'EE-fa', generate in 30-second chunks and listen to all of it.

**Common mistake:** Generating the whole script once and not listening.$x3$),
  (4, $x4$

**Worked example:** Checklist: written consent, exact use, duration, payment, right to withdraw, label as synthetic.

**Common mistake:** Using a friend's voice 'for fun' without permission.$x4$),
  (5, $x5$

**Worked example:** Record in a wardrobe, 20 cm from the mic; trim silence, reduce noise gently, normalise to -16 LUFS.

**Common mistake:** Over-processing until the voice sounds underwater.$x5$),
  (6, $x6$

**Worked example:** Deliver script, 60-second audio, tool and licence notes, and pronunciation fixes.

**Common mistake:** Submitting audio with no rights information.$x6$),
  (7, $x7$

**Worked example:** Brief: 'Calm lo-fi, 80 BPM, soft piano, no vocals, 30 seconds, gentle build.'

**Common mistake:** 'Make it sound good' as a brief.$x7$),
  (8, $x8$

**Worked example:** Generate five, score on mood fit, energy, loop point and distracting parts; pick one and check its licence.

**Common mistake:** Choosing the first result.$x8$),
  (9, $x9$

**Worked example:** Music at -18 dB under speech, ducking during words. Check on headphones and a phone speaker.

**Common mistake:** Mixing only on good headphones.$x9$),
  (10, $x10$

**Worked example:** Ambience of a cafe at -30 dB, plus a cup clink and a door chime placed on the action.

**Common mistake:** Filling every second with effects.$x10$),
  (11, $x11$

**Worked example:** Export WAV for editing and MP3 128 kbps for delivery; target -16 LUFS, peaks under -1 dB.

**Common mistake:** Delivering very loud or very quiet audio.$x11$),
  (12, $x12$

**Worked example:** Deliver a 20-second intro: sting, voice line 'Fresh ideas daily', effects, mixed and exported.

**Common mistake:** A sting longer than the message.$x12$),
  (13, $x13$

**Worked example:** Show: 'Small Shop Stories', weekly, 15 minutes, one owner per episode. Five topics planned.

**Common mistake:** A show idea with no clear audience.$x13$),
  (14, $x14$

**Worked example:** Outline: hook (30s), story (5m), lesson (3m), call to action (30s). Intro and outro fully scripted.

**Common mistake:** Scripting every word so it sounds stiff.$x14$),
  (15, $x15$

**Worked example:** Remove 'um' and 4-second gaps but keep natural breaths. Cut 30 minutes to 24.

**Common mistake:** Editing until the speaker sounds robotic.$x15$),
  (16, $x16$

**Worked example:** Translate a 60-word script; a fluent speaker corrects two phrases. Disclose synthetic dubbing.

**Common mistake:** Publishing an unreviewed machine translation.$x16$),
  (17, $x17$

**Worked example:** Proofread transcript names and numbers against the audio; correct three errors.

**Common mistake:** Publishing the raw auto-transcript.$x17$),
  (18, $x18$

**Worked example:** Deliver a 3-minute episode, outline, transcript and licence notes.

**Common mistake:** Skipping the transcript.$x18$),
  (19, $x19$

**Worked example:** Publishing pack: title, 150-word description, 3000x3000 cover, category, explicit flag.

**Common mistake:** A tiny or blurry cover image.$x19$),
  (20, $x20$

**Worked example:** Audit: music (licence link), voice (consent form), effects (pack terms), tool terms (commercial use).

**Common mistake:** Assuming a platform will not scan for copyrighted audio.$x20$),
  (21, $x21$

**Worked example:** Export stems: voice.wav, music.wav, fx.wav at 48 kHz, named clearly.

**Common mistake:** Delivering a single mixed file when the editor needs stems.$x21$),
  (22, $x22$

**Worked example:** Listener 2 lost interest at minute 4; shorten the story section and re-check.

**Common mistake:** Ignoring where listeners lose interest.$x22$),
  (23, $x23$

**Worked example:** Quote: 2-minute narrated ad, 2 revisions, WAV and MP3, 90; extra revision 20; who owns the file stated.

**Common mistake:** Not stating who owns the audio or what AI tools were used.$x23$),
  (24, $x24$

**Worked example:** Deliver a sonic logo, 30-second narration and bumper with a rights audit.

**Common mistake:** Inconsistent sound between pieces.$x24$),
  (25, $x25$

**Worked example:** Brief: 'A 60-second radio ad for a bakery: warm voice, light music, call to action.'

**Common mistake:** No target listener.$x25$),
  (26, $x26$

**Worked example:** Script 120 words at 150 words a minute, plus a sound brief with three moments marked.

**Common mistake:** A script too long for the time.$x26$),
  (27, $x27$

**Worked example:** Generate voice, generate three music options, log licences.

**Common mistake:** Losing track of where files came from.$x27$),
  (28, $x28$

**Worked example:** Mix with -18 dB music under voice, master to -16 LUFS, export.

**Common mistake:** Not checking on a phone speaker.$x28$),
  (29, $x29$

**Worked example:** Transcript proofread; feedback: 'the offer is unclear' -> move it earlier.

**Common mistake:** Skipping the listener test.$x29$),
  (30, $x30$

**Worked example:** Deliver the audio, transcript, publishing pack and rights audit with a cover note.

**Common mistake:** Forgetting the rights audit.$x30$)
  ) as v(n, extra), public.track t
 where t.id = d.track_id and t.slug = 'audio' and d.day_number = v.n
   and d.lesson_md not like '%**Worked example:**%';
