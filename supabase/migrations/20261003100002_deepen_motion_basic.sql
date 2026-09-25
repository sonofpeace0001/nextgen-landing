-- Deepen Basic-tier lessons for motion: add a worked example and a common mistake (idempotent).
update public.day d
   set lesson_md = d.lesson_md || v.extra
  from (values
  (1, $x1$

**Worked example:** A button that scales slightly on hover directs attention; a bouncing logo that never stops just distracts.

**Common mistake:** Adding motion to everything because you can.$x1$),
  (2, $x2$

**Worked example:** Move a square 300 px in 400 ms three ways: linear feels robotic; ease-out feels natural; a bounce feels playful.

**Common mistake:** Using linear timing for things that should feel natural.$x2$),
  (3, $x3$

**Worked example:** A ball squashes before jumping (anticipation) and settles after landing (follow-through). Two principles, clearer motion.

**Common mistake:** Animating everything at the same time.$x3$),
  (4, $x4$

**Worked example:** Frame 1: title off-screen. Frame 2 (0.4s): title in, ease-out. Frame 3 (2s): hold. Frame 4 (2.4s): fade out.

**Common mistake:** Skipping the storyboard and rebuilding the animation three times.$x4$),
  (5, $x5$

**Worked example:** 'Now open' enters over 0.4s, holds 2s (enough to read 3 words), exits over 0.3s.

**Common mistake:** Making text disappear before it can be read.$x5$),
  (6, $x6$

**Worked example:** Deliver storyboard frames, a 10-second sequence and a note: 'ease-out for entrances, 300 ms, one thing moves at a time.'

**Common mistake:** Submitting a moving piece with no reasoning about timing.$x6$),
  (7, $x7$

**Worked example:** The word 'FAST' snaps in; the word 'gently' fades in slowly. Motion matches meaning.

**Common mistake:** Applying the same reveal to every word.$x7$),
  (8, $x8$

**Worked example:** Three icons draw on in 500 ms with the same easing; the export is a 12 KB Lottie file.

**Common mistake:** Exporting a 6 MB GIF for a small icon.$x8$),
  (9, $x9$

**Worked example:** Bar chart: reveal one bar at a time; highlight the biggest bar; label with source and date.

**Common mistake:** Starting the axis above zero to exaggerate the change.$x9$),
  (10, $x10$

**Worked example:** A wipe moves from problem to solution; a match cut links a circle icon to a sun. Each transition supports the story.

**Common mistake:** Using a different flashy transition between every scene.$x10$),
  (11, $x11$

**Worked example:** Guide: 300 ms base, ease-out, brand blue and yellow, 0.5s stagger. Every new animation follows it.

**Common mistake:** Building each piece with new rules.$x11$),
  (12, $x12$

**Worked example:** Deliver storyboard, style guide and a 20-second animation with three scenes, two transitions and one chart.

**Common mistake:** Making a piece that looks good but has no system.$x12$),
  (13, $x13$

**Worked example:** Logo builds in 1.2s, holds 1s on a clean final frame, exports as MP4 and as a still.

**Common mistake:** Ending on a half-finished frame.$x13$),
  (14, $x14$

**Worked example:** Script: problem (5s), idea (5s), 3 steps (15s), result (5s). One idea per scene, voiceover first.

**Common mistake:** Writing on-screen text longer than a viewer can read.$x14$),
  (15, $x15$

**Worked example:** Separate sky, mountain, subject and foreground; move them at different speeds for depth. Note the image tool licence.

**Common mistake:** Using a flat image and trying to fake depth.$x15$),
  (16, $x16$

**Worked example:** A soft 'pop' lands exactly when the icon appears; music sits 15 dB under.

**Common mistake:** Sound effects a few frames off the movement.$x16$),
  (17, $x17$

**Worked example:** Make frame 96 match frame 1 so the 4-second loop has no jump.

**Common mistake:** A loop with a visible jump.$x17$),
  (18, $x18$

**Worked example:** Deliver the 30-second explainer, script, storyboard, asset licences and a note on two timing changes.

**Common mistake:** Not documenting asset sources.$x18$),
  (19, $x19$

**Worked example:** MP4 720p 1.1 MB; GIF 6 MB; Lottie 9 KB. Choose Lottie for the web, MP4 for social.

**Common mistake:** Picking a format by habit rather than by use.$x19$),
  (20, $x20$

**Worked example:** Avoid more than three flashes a second; provide a static or reduced-motion version for the web.

**Common mistake:** Ignoring viewers who get motion sickness or seizures.$x20$),
  (21, $x21$

**Worked example:** Template: title, subtitle, logo slots. Two different clients reuse it in 10 minutes each.

**Common mistake:** Building every piece from scratch.$x21$),
  (22, $x22$

**Worked example:** Feedback: '0:04 text leaves too early.' Change to 2.5s hold. Version 2 shown.

**Common mistake:** Feedback without time codes.$x22$),
  (23, $x23$

**Worked example:** Scope: 15 seconds, 2 revision rounds, 3 formats, delivered in 5 days for 450. Extra rounds 60 each.

**Common mistake:** Unlimited revisions.$x23$),
  (24, $x24$

**Worked example:** Deliver three animations (1:1, 9:16, 16:9), one style guide and an accessibility note.

**Common mistake:** Resizing without redesigning for each ratio.$x24$),
  (25, $x25$

**Worked example:** Brief: 'Launch pack for a coffee brand: logo sting, 30-second explainer, social loop.'

**Common mistake:** A pack with no shared style.$x25$),
  (26, $x26$

**Worked example:** Style guide: 300 ms, ease-out, cream and brown palette, one font; storyboards for each piece.

**Common mistake:** Designing pieces separately.$x26$),
  (27, $x27$

**Worked example:** Logo sting 3 seconds; loop 4 seconds; both follow the guide.

**Common mistake:** Making the sting longer than 4 seconds.$x27$),
  (28, $x28$

**Worked example:** Explainer with voiceover, three scenes and music at -18 dB under voice.

**Common mistake:** Music louder than speech.$x28$),
  (29, $x29$

**Worked example:** Feedback: 'loop feels choppy' -> raise frame rate to 30 fps; export all formats.

**Common mistake:** Not re-exporting after changes.$x29$),
  (30, $x30$

**Worked example:** Usage guide: where each file goes, colours, fonts, do and do not examples.

**Common mistake:** Delivering files without instructions.$x30$)
  ) as v(n, extra), public.track t
 where t.id = d.track_id and t.slug = 'motion' and d.day_number = v.n
   and d.lesson_md not like '%**Worked example:**%';
