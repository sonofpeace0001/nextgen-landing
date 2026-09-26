-- AI film & video Skill Labs (days 91-120). Published; appended after the core path.
insert into public.day
  (track_id, tier_id, day_number, title, objective, lesson_md, skill_focus, assignment_md, rubric,
   est_minutes, is_published, credit_budget, submission_type, ai_evaluate, requires_review)
select t.id, ti.id, v.n, v.title, v.objective, v.lesson_md, v.skill_focus, v.assignment_md, v.rubric,
       v.est_minutes, true, null, v.submission_type, v.ai_evaluate, v.requires_review
from public.track t
join public.tier ti on ti.track_id = t.id and ti.slug = 'grandmaster'
cross join (values
  (91, $t91a$Skill Lab: Composition: thirds, lines and headroom$t91a$, $t91b$Frame shots that guide the eye.$t91b$, $t91c$Place the subject on a third, not dead centre, unless symmetry is the point. Use leading lines (roads, walls, shadows) to point at the subject, leave headroom above heads and lead room in front of a moving subject, and keep the horizon level unless you tilt on purpose. Name these choices in your prompt: 'subject on the left third, road leading to the horizon, lead room on the right'.

**Worked example:** Prompt: 'Wide shot, a cyclist on the right third riding toward the left, empty road as a leading line, mist, lead room on the left.'

**Common mistake:** Centring every subject and cutting off the top of heads.$t91c$, $t91d$Skill Lab: Composition: thirds, lines and headroom$t91d$, $t91e$Generate or sketch four frames that use four different composition rules. Submit direct image links and name the rule in each.

**Sharing video:** upload (unlisted) and paste the link, plus any still frames as direct image links. Video is checked by a person.$t91e$, $t91f$[{"criterion": "Rules applied correctly", "max_points": 45, "guidance": "Visible in the frames."}, {"criterion": "Prompts describe composition", "max_points": 30, "guidance": "Specific."}, {"criterion": "Variety", "max_points": 25, "guidance": "Four different rules."}]$t91f$::jsonb, 45, 'link', false, false),
  (92, $t92a$Skill Lab: Exposure, contrast and mood$t92a$, $t92b$Control how bright, dark and contrasty a shot feels.$t92b$, $t92c$Exposure is how much light reaches the sensor; contrast is the gap between light and dark. Low-key (mostly dark) feels tense or intimate, high-key (mostly bright) feels light or clean. Describe exposure in words: 'underexposed by one stop', 'bright, high-key', 'crushed blacks'. Keep faces readable unless you hide them on purpose.

**Worked example:** Same alley scene twice: high-key morning versus low-key night with one streetlight; the mood flips.

**Common mistake:** Making everything dark and calling it cinematic while faces disappear.$t92c$, $t92d$Skill Lab: Exposure, contrast and mood$t92d$, $t92e$Create the same scene in high-key and low-key. Submit direct image links and describe how each feels.

**Sharing video:** upload (unlisted) and paste the link, plus any still frames as direct image links. Video is checked by a person.$t92e$, $t92f$[{"criterion": "Two clear looks", "max_points": 40, "guidance": "Distinct."}, {"criterion": "Faces and story readable", "max_points": 30, "guidance": "Visible."}, {"criterion": "Mood described", "max_points": 30, "guidance": "Reasoned."}]$t92f$::jsonb, 45, 'link', false, false),
  (93, $t93a$Skill Lab: Blocking and staging$t93a$, $t93b$Place people and camera to tell the story.$t93b$, $t93c$Blocking is where actors and camera are and how they move. Position characters to show power, distance and relationship. Keep the foreground, middle ground and background purposeful. In AI video, simple blocking (one or two characters, one clear move) works best.

**Worked example:** A tense conversation: the boss stands, the employee sits, the camera behind the employee's shoulder, the window behind the boss.

**Common mistake:** Filling the frame with many people doing different things.$t93c$, $t93d$Skill Lab: Blocking and staging$t93d$, $t93e$Write a blocking plan (text plus a simple diagram or stills) for a two-person scene with a clear power shift.$t93e$, $t93f$[{"criterion": "Positions tell the story", "max_points": 45, "guidance": "Meaningful."}, {"criterion": "Simple and achievable", "max_points": 30, "guidance": "Realistic."}, {"criterion": "Camera plan", "max_points": 25, "guidance": "Specific."}]$t93f$::jsonb, 45, 'text', false, false),
  (94, $t94a$Skill Lab: Continuity and the 180-degree rule$t94a$, $t94b$Keep space and direction consistent across cuts.$t94b$, $t94c$Draw an imaginary line between two characters and keep the camera on one side, so left and right stay consistent. Match eyelines, costume, props and lighting across shots. Add a neutral cutaway when you must cross the line.

**Worked example:** Character A always looks left-to-right; after a cutaway to a clock, the camera crosses the line smoothly.

**Common mistake:** Flipping screen direction between shots so viewers feel lost.$t94c$, $t94d$Skill Lab: Continuity and the 180-degree rule$t94d$, $t94e$Plan a six-shot dialogue sequence with a diagram of the line and camera positions, and list five continuity items to check.$t94e$, $t94f$[{"criterion": "Line respected", "max_points": 40, "guidance": "Diagram clear."}, {"criterion": "Continuity checklist", "max_points": 35, "guidance": "Five items."}, {"criterion": "Shot plan complete", "max_points": 25, "guidance": "Six shots."}]$t94f$::jsonb, 45, 'text', false, false),
  (95, $t95a$Skill Lab: Lab 1 project: a six-shot sequence with stills$t95a$, $t95b$Plan and generate a coherent sequence.$t95b$, $t95c$Show Lab 1. Produce a **six-shot sequence** (stills or short clips) that uses composition, exposure choices, blocking and continuity on purpose, with a written shot plan.

Success looks like six shots that clearly belong to one scene.

**Worked example:** Scene: a courier delivers a letter to a nervous customer, shot as wide, medium, over-shoulder, close-up, insert of the letter, wide exit.

**Common mistake:** Six beautiful shots that do not cut together.

A person reviews your work and can ask for revisions.$t95c$, $t95d$Skill Lab: Lab 1 project: a six-shot sequence with stills$t95d$, $t95e$Submit the shot plan, six frames or clips, and a note on the composition and continuity choices.

**Sharing video:** upload (unlisted) and paste the link, plus any still frames as direct image links. Video is checked by a person.$t95e$, $t95f$[{"criterion": "Coherent sequence", "max_points": 30, "guidance": "Belongs together."}, {"criterion": "Composition and light", "max_points": 25, "guidance": "Deliberate."}, {"criterion": "Blocking and continuity", "max_points": 25, "guidance": "Consistent."}, {"criterion": "Plan and notes", "max_points": 20, "guidance": "Clear."}]$t95f$::jsonb, 120, 'link', false, true),
  (96, $t96a$Skill Lab: The model map: choosing the right video tool$t96a$, $t96b$Match the tool to the job.$t96b$, $t96c$Video tools differ. Some lead on cinematic lighting and prompt following, some on complex motion like hair and water, some on fine camera and reference control, some on talking characters with synchronised sound. Tools also change quickly and some are retired, so never build a workflow on a single one. Compare current options (for example Veo, Kling, Runway, Seedance, Pika) and check pricing, length limits, resolution and commercial licence. [CREAO](https://agent.creao.ai/@Sonofpeace) (referral link) is our recommended workspace for planning and running the whole workflow.

**Worked example:** Job: a 6-second product ad. Choose the tool with the best prompt adherence for products; for a vertical hook choose a fast, cheap one; for a lip-synced scene choose one with native audio.

**Common mistake:** Choosing a tool because it is famous rather than because it fits the job.$t96c$, $t96d$Skill Lab: The model map: choosing the right video tool$t96d$, $t96e$Build a comparison table of three tools for three jobs (length, control, audio, price, licence). Submit it.$t96e$, $t96f$[{"criterion": "Jobs and tools matched", "max_points": 40, "guidance": "Sensible."}, {"criterion": "Facts current and sourced", "max_points": 35, "guidance": "Links."}, {"criterion": "Licence checked", "max_points": 25, "guidance": "Documented."}]$t96f$::jsonb, 45, 'text', false, false),
  (97, $t97a$Skill Lab: Text-to-video, image-to-video and video-to-video$t97a$, $t97b$Pick the right input for control.$t97b$, $t97c$Text-to-video is fastest but least controllable. Image-to-video keeps the look of a frame you approved. Video-to-video restyles or extends existing footage. Start with stills to lock the look, then animate. Use reference images for characters and locations.

**Worked example:** Lock the character in a still, animate the still with a slow push-in, then extend the clip in the last frame.

**Common mistake:** Using text-to-video for every shot and losing consistency.$t97c$, $t97d$Skill Lab: Text-to-video, image-to-video and video-to-video$t97d$, $t97e$Make one shot three ways (text, image, video input). Submit clips and a note on the control each gave.

**Sharing video:** upload (unlisted) and paste the link, plus any still frames as direct image links. Video is checked by a person.$t97e$, $t97f$[{"criterion": "Three methods tried", "max_points": 40, "guidance": "Distinct."}, {"criterion": "Control compared", "max_points": 35, "guidance": "Honest."}, {"criterion": "Prompts recorded", "max_points": 25, "guidance": "Given."}]$t97f$::jsonb, 45, 'link', false, false),
  (98, $t98a$Skill Lab: Prompt structure and negative prompts$t98a$, $t98b$Write prompts models follow reliably.$t98b$, $t98c$A reliable order: shot type and angle, subject and action, setting, lighting, lens or look, camera movement, style, then a short list of things to avoid (three to five terms, such as 'extra fingers, text, watermark'). Keep one action per shot and avoid contradictory instructions.

**Worked example:** 'Low-angle wide shot, a chef flips a pancake, sunny kitchen, soft morning light, 35mm look, slow push-in, warm film style. Avoid: text, watermark, extra fingers.'

**Common mistake:** Long negative lists and prompts that ask for opposite things.$t98c$, $t98d$Skill Lab: Prompt structure and negative prompts$t98d$, $t98e$Write six prompts using the structure and negative terms, and record which words changed the results.

**Sharing video:** upload (unlisted) and paste the link, plus any still frames as direct image links. Video is checked by a person.$t98e$, $t98f$[{"criterion": "Structure followed", "max_points": 40, "guidance": "Ordered."}, {"criterion": "Negative list short", "max_points": 25, "guidance": "3 to 5 terms."}, {"criterion": "Results analysed", "max_points": 35, "guidance": "Observed."}]$t98f$::jsonb, 45, 'link', false, false),
  (99, $t99a$Skill Lab: Multi-shot scenes and native audio$t99a$, $t99b$Keep a scene coherent across shots and sound.$t99b$, $t99c$Some tools plan several shots at once and generate matching sound. Give each shot its own line, keep character and location descriptions identical, and say what audio you want (dialogue, footsteps, ambience). Always check the sound: synthetic audio can be wrong or unsafe to publish without review.

**Worked example:** Three-shot storyboard: wide street, medium at the door, close-up of the hand on the handle; ambience of rain and a distant siren.

**Common mistake:** Trusting generated audio without listening to it.$t99c$, $t99d$Skill Lab: Multi-shot scenes and native audio$t99d$, $t99e$Create a three-shot scene with a written shot list and a sound note. Submit the clip and the shot list.

**Sharing video:** upload (unlisted) and paste the link, plus any still frames as direct image links. Video is checked by a person.$t99e$, $t99f$[{"criterion": "Consistent across shots", "max_points": 40, "guidance": "Coherent."}, {"criterion": "Sound intentional", "max_points": 30, "guidance": "Planned."}, {"criterion": "Shot list clear", "max_points": 30, "guidance": "Precise."}]$t99f$::jsonb, 45, 'link', false, false),
  (100, $t100a$Skill Lab: Lab 2 project: one brief, three models$t100a$, $t100b$Compare tools on the same shot honestly.$t100b$, $t100c$Show Lab 2. Take **one shot brief** and generate it in three tools or modes, then compare prompt adherence, motion quality, consistency, sound, cost and licence.

Success looks like a fair test and a clear recommendation.

**Worked example:** Brief: a 5-second slow push-in on a rain-soaked neon street with a lone walker; compare all three on the same prompt.

**Common mistake:** Changing the prompt between tools.

A person reviews your work and can ask for revisions.$t100c$, $t100d$Skill Lab: Lab 2 project: one brief, three models$t100d$, $t100e$Submit the three clips, the identical prompt, a comparison table and your recommendation with costs.

**Sharing video:** upload (unlisted) and paste the link, plus any still frames as direct image links. Video is checked by a person.$t100e$, $t100f$[{"criterion": "Fair test", "max_points": 30, "guidance": "Same prompt."}, {"criterion": "Comparison evidence", "max_points": 30, "guidance": "Table."}, {"criterion": "Recommendation reasoned", "max_points": 25, "guidance": "Clear."}, {"criterion": "Licence and cost", "max_points": 15, "guidance": "Noted."}]$t100f$::jsonb, 120, 'link', false, true),
  (101, $t101a$Skill Lab: Writing dialogue for AI video$t101a$, $t101b$Write lines that work on screen.$t101b$, $t101c$Keep lines short (under twelve words), one speaker at a time, and place emotion in the action or tone note. Avoid tongue-twisters, names that are hard to pronounce and long monologues. Add a pronunciation note and a delivery note for each line.

**Worked example:** MARA (quietly, not looking up): 'You came back.' Delivery: half-smile, low voice.

**Common mistake:** Long speeches that make the mouth movement drift.$t101c$, $t101d$Skill Lab: Writing dialogue for AI video$t101d$, $t101e$Write a one-page dialogue scene (eight lines) with delivery notes.$t101e$, $t101f$[{"criterion": "Short natural lines", "max_points": 40, "guidance": "Speakable."}, {"criterion": "Delivery notes", "max_points": 30, "guidance": "Clear."}, {"criterion": "Subtext", "max_points": 30, "guidance": "Present."}]$t101f$::jsonb, 45, 'text', false, false),
  (102, $t102a$Skill Lab: Voice, casting and consent$t102a$, $t102b$Choose voices responsibly.$t102b$, $t102c$Choose or design a voice that fits the character, and use only voices you are licensed to use. Never clone a real person's voice without written consent. Label synthetic voices where required and keep records.

**Worked example:** A licensed synthetic voice chosen from a library, plus a written note of its licence terms.

**Common mistake:** Using a celebrity-sounding voice.$t102c$, $t102d$Skill Lab: Voice, casting and consent$t102d$, $t102e$Create a voice casting sheet for two characters with licence notes and a consent policy.$t102e$, $t102f$[{"criterion": "Fits characters", "max_points": 30, "guidance": "Suitable."}, {"criterion": "Licences documented", "max_points": 40, "guidance": "Real."}, {"criterion": "Consent policy", "max_points": 30, "guidance": "Clear."}]$t102f$::jsonb, 45, 'text', false, false),
  (103, $t103a$Skill Lab: Lip-sync and performance$t103a$, $t103b$Get believable speaking shots.$t103b$, $t103c$Talking shots need a stable face, clear mouth visibility and audio that matches the clip length. Use a close or medium shot, keep the head fairly still, and add cutaways to hide small errors. Check teeth, lips and eyes at full size.

**Worked example:** A medium close-up of a speaker with a still camera; a cutaway to their hands covers a two-word slip.

**Common mistake:** Wide shots with tiny mouths and constant head movement.$t103c$, $t103d$Skill Lab: Lip-sync and performance$t103d$, $t103e$Produce a 20-second talking shot with a cutaway to cover one flaw. Submit the clip and note the flaw you covered.

**Sharing video:** upload (unlisted) and paste the link, plus any still frames as direct image links. Video is checked by a person.$t103e$, $t103f$[{"criterion": "Believable speech", "max_points": 40, "guidance": "Looks right."}, {"criterion": "Flaw handled", "max_points": 30, "guidance": "Cutaway."}, {"criterion": "Sound in sync", "max_points": 30, "guidance": "Matches."}]$t103f$::jsonb, 45, 'link', false, false),
  (104, $t104a$Skill Lab: Subtitles, captions and accessibility$t104a$, $t104b$Make dialogue accessible.$t104b$, $t104c$Add accurate captions with speaker labels for important non-speech sounds. Keep two lines at most, high contrast, and safe margins. Proofread names and numbers. Offer a transcript.

**Worked example:** Captions in white with a dark outline, [rain] and [door slams] noted, checked against audio.

**Common mistake:** Trusting auto-captions without proofreading.$t104c$, $t104d$Skill Lab: Subtitles, captions and accessibility$t104d$, $t104e$Caption your 20-second scene and proofread it. Submit the caption text and the changes you made.$t104e$, $t104f$[{"criterion": "Accurate", "max_points": 40, "guidance": "Proofread."}, {"criterion": "Readable design", "max_points": 30, "guidance": "Contrast, margins."}, {"criterion": "Sounds noted", "max_points": 30, "guidance": "Included."}]$t104f$::jsonb, 45, 'text', false, false),
  (105, $t105a$Skill Lab: Lab 3 project: a 45-second dialogue scene$t105a$, $t105b$Deliver a short scene with two speaking characters.$t105b$, $t105c$Show Lab 3. Produce a **45-second dialogue scene** with two characters, casting and licence notes, cutaways, captions and a mixed soundtrack.

A person reviews your work and can ask for revisions.

**Worked example:** Scene: two colleagues discover a mistake before a launch, tense but funny.

**Common mistake:** No consent or licence record for the voices.

A person reviews your work and can ask for revisions.$t105c$, $t105d$Skill Lab: Lab 3 project: a 45-second dialogue scene$t105d$, $t105e$Submit the script, the film, voice licence notes, caption file and a note on three flaws you fixed.

**Sharing video:** upload (unlisted) and paste the link, plus any still frames as direct image links. Video is checked by a person.$t105e$, $t105f$[{"criterion": "Performance and story", "max_points": 30, "guidance": "Believable."}, {"criterion": "Sound and captions", "max_points": 25, "guidance": "Clear."}, {"criterion": "Consent and licences", "max_points": 25, "guidance": "Documented."}, {"criterion": "Craft notes", "max_points": 20, "guidance": "Honest."}]$t105f$::jsonb, 150, 'link', false, true),
  (106, $t106a$Skill Lab: Editing craft: rhythm, cutaways and pace$t106a$, $t106b$Edit for story and emotion.$t106b$, $t106c$Cut to reveal information, not just to change the picture. Vary shot length, hold on emotion, use cutaways to hide flaws and J and L cuts (audio leading or trailing the picture) to smooth changes. Watch on a phone and a big screen.

**Worked example:** The reply audio begins before the cut to the listener's face (a J cut), which feels natural.

**Common mistake:** Cutting every two seconds regardless of story.$t106c$, $t106d$Skill Lab: Editing craft: rhythm, cutaways and pace$t106d$, $t106e$Re-edit a sequence using at least two J or L cuts and two cutaways. Submit before and after clips and notes.

**Sharing video:** upload (unlisted) and paste the link, plus any still frames as direct image links. Video is checked by a person.$t106e$, $t106f$[{"criterion": "Rhythm improved", "max_points": 40, "guidance": "Better."}, {"criterion": "J and L cuts used", "max_points": 30, "guidance": "Present."}, {"criterion": "Notes explain choices", "max_points": 30, "guidance": "Reasoned."}]$t106f$::jsonb, 45, 'link', false, false),
  (107, $t107a$Skill Lab: Colour correction and grading with scopes$t107a$, $t107b$Correct first, then grade with evidence.$t107b$, $t107c$Correct exposure, white balance and contrast using scopes (waveform for brightness, vectorscope for colour) before you choose a look. Match shots from different generations. Apply a consistent grade, add subtle grain and check skin tones.

**Worked example:** Waveform shows faces at 60 to 70 percent; shots are matched, then a single warm grade is applied to all.

**Common mistake:** Applying a heavy look before fixing exposure.$t107c$, $t107d$Skill Lab: Colour correction and grading with scopes$t107d$, $t107e$Match and grade a three-shot sequence. Submit before and after and note what the scopes showed.

**Sharing video:** upload (unlisted) and paste the link, plus any still frames as direct image links. Video is checked by a person.$t107e$, $t107f$[{"criterion": "Shots matched", "max_points": 40, "guidance": "Consistent."}, {"criterion": "Scopes used", "max_points": 30, "guidance": "Evidence."}, {"criterion": "Restraint", "max_points": 30, "guidance": "Natural."}]$t107f$::jsonb, 45, 'link', false, false),
  (108, $t108a$Skill Lab: Sound mixing and music$t108a$, $t108b$Mix a cinematic soundtrack.$t108b$, $t108c$Layer dialogue, ambience, effects and music. Mix dialogue clearly around minus 16 LUFS for online delivery (check the platform), duck music under speech, and use silence. Clear all music and effects licences.

**Worked example:** Music at minus 20 dB under speech, rain ambience at minus 30 dB, one impact effect on the cut.

**Common mistake:** Music louder than dialogue.$t108c$, $t108d$Skill Lab: Sound mixing and music$t108d$, $t108e$Mix a two-minute piece and provide a cue sheet with licences. Submit the link and the sheet.

**Sharing video:** upload (unlisted) and paste the link, plus any still frames as direct image links. Video is checked by a person.$t108e$, $t108f$[{"criterion": "Dialogue clear", "max_points": 40, "guidance": "Intelligible."}, {"criterion": "Balanced layers", "max_points": 30, "guidance": "Even."}, {"criterion": "Licences listed", "max_points": 30, "guidance": "Complete."}]$t108f$::jsonb, 45, 'link', false, false),
  (109, $t109a$Skill Lab: VFX cleanup and fixes$t109a$, $t109b$Repair generated shots.$t109b$, $t109c$Fix flicker, warping and small objects with masks, stabilisation, frame blending, cropping or replacing a bad section. Sometimes reshooting is faster than repair. Keep a log of fixes.

**Worked example:** A warped hand in frames 40 to 55 is hidden by a cutaway; a flicker is smoothed with frame blending.

**Common mistake:** Spending an hour repairing a shot you could regenerate in two minutes.$t109c$, $t109d$Skill Lab: VFX cleanup and fixes$t109d$, $t109e$Repair two flawed clips and log each fix and the time it took. Submit before and after.

**Sharing video:** upload (unlisted) and paste the link, plus any still frames as direct image links. Video is checked by a person.$t109e$, $t109f$[{"criterion": "Fixes effective", "max_points": 40, "guidance": "Better."}, {"criterion": "Time judgement", "max_points": 30, "guidance": "Sensible."}, {"criterion": "Log kept", "max_points": 30, "guidance": "Complete."}]$t109f$::jsonb, 45, 'link', false, false),
  (110, $t110a$Skill Lab: Lab 4 project: a finished 90-second piece$t110a$, $t110b$Deliver a polished edited film.$t110b$, $t110c$Show Lab 4. Deliver a **90-second finished piece** with edited rhythm, matched grade, mixed sound, VFX fixes, captions and a delivery checklist.

A person reviews your work and can ask for revisions.

**Worked example:** A 90-second brand story: three scenes, one voiceover, licensed music, exported for YouTube.

**Common mistake:** Skipping the delivery checklist.

A person reviews your work and can ask for revisions.$t110c$, $t110d$Skill Lab: Lab 4 project: a finished 90-second piece$t110d$, $t110e$Submit the film, cue sheet, fix log, caption file and a checklist of export settings.

**Sharing video:** upload (unlisted) and paste the link, plus any still frames as direct image links. Video is checked by a person.$t110e$, $t110f$[{"criterion": "Edit and story", "max_points": 30, "guidance": "Engaging."}, {"criterion": "Colour and sound", "max_points": 30, "guidance": "Polished."}, {"criterion": "Fixes and captions", "max_points": 20, "guidance": "Clean."}, {"criterion": "Delivery checklist", "max_points": 20, "guidance": "Complete."}]$t110f$::jsonb, 180, 'link', false, true),
  (111, $t111a$Skill Lab: Documentary and explainer films$t111a$, $t111b$Tell true stories with synthetic help.$t111b$, $t111c$Non-fiction demands accuracy. Verify every claim, label reconstructions and illustrations, never fabricate evidence or quotes, and get permission from real subjects. Structure: question, evidence, meaning.

**Worked example:** A three-minute explainer where every fact has a source on screen and generated visuals are labelled 'illustration'.

**Common mistake:** Presenting generated footage as real events.$t111c$, $t111d$Skill Lab: Documentary and explainer films$t111d$, $t111e$Outline a 3-minute explainer with a source list and a labelling plan.$t111e$, $t111f$[{"criterion": "Claims sourced", "max_points": 40, "guidance": "Verified."}, {"criterion": "Labelling honest", "max_points": 35, "guidance": "Clear."}, {"criterion": "Structure clear", "max_points": 25, "guidance": "Question to meaning."}]$t111f$::jsonb, 45, 'text', false, false),
  (112, $t112a$Skill Lab: Ads and promos that respect the audience$t112a$, $t112b$Make effective, honest promos.$t112b$, $t112c$Hook fast, show the product truthfully, prove one claim and give one action. Follow advertising rules and disclosure requirements in your market and never show AI product footage that misrepresents the item.

**Worked example:** 15-second promo: hook, real product footage, one true claim, CTA.

**Common mistake:** Showing a product that does not exist as sold.$t112c$, $t112d$Skill Lab: Ads and promos that respect the audience$t112d$, $t112e$Produce two 15-second promo versions with different hooks. Submit clips and the claim evidence for each.

**Sharing video:** upload (unlisted) and paste the link, plus any still frames as direct image links. Video is checked by a person.$t112e$, $t112f$[{"criterion": "Hooks distinct", "max_points": 30, "guidance": "Different."}, {"criterion": "Claims evidenced", "max_points": 40, "guidance": "True."}, {"criterion": "Clear CTA", "max_points": 30, "guidance": "One."}]$t112f$::jsonb, 45, 'link', false, false),
  (113, $t113a$Skill Lab: Music videos and visual rhythm$t113a$, $t113b$Cut visuals to music.$t113b$, $t113c$Map the song's sections, match energy, repeat visual motifs and cut on beats without overdoing it. Use licensed music or your own; never use someone else's track without permission.

**Worked example:** Verse: slow shots; chorus: faster cuts and a repeated red door motif.

**Common mistake:** Using an unlicensed popular song.$t113c$, $t113d$Skill Lab: Music videos and visual rhythm$t113d$, $t113e$Cut a 45-second music piece with a motif and licence note.

**Sharing video:** upload (unlisted) and paste the link, plus any still frames as direct image links. Video is checked by a person.$t113e$, $t113f$[{"criterion": "Beats and sections matched", "max_points": 40, "guidance": "Tight."}, {"criterion": "Motif used", "max_points": 30, "guidance": "Repeated."}, {"criterion": "Licence documented", "max_points": 30, "guidance": "Clear."}]$t113f$::jsonb, 45, 'link', false, false),
  (114, $t114a$Skill Lab: Short-form vertical video$t114a$, $t114b$Make videos for phones.$t114b$, $t114c$Vertical 9:16 with a hook in the first second, captions, tight framing and a clear loop or call to action. Keep text inside safe areas and re-frame rather than crop. Test different hooks.

**Worked example:** A 20-second tip video: bold caption hook, three quick steps, a satisfying loop back to the first frame.

**Common mistake:** Cropping a horizontal video and cutting off the subject.$t114c$, $t114d$Skill Lab: Short-form vertical video$t114d$, $t114e$Make two vertical versions of one idea with different hooks. Submit both and your results notes.

**Sharing video:** upload (unlisted) and paste the link, plus any still frames as direct image links. Video is checked by a person.$t114e$, $t114f$[{"criterion": "Hook and framing", "max_points": 40, "guidance": "Strong."}, {"criterion": "Captions safe", "max_points": 30, "guidance": "Readable."}, {"criterion": "Two versions compared", "max_points": 30, "guidance": "Reasoned."}]$t114f$::jsonb, 45, 'link', false, false),
  (115, $t115a$Skill Lab: Lab 5 project: a trailer and a vertical cut$t115a$, $t115b$Deliver two formats from one story.$t115b$, $t115c$Show Lab 5. Create a **60-second trailer** for a story and a **20-second vertical cut** of the same material, with captions and a rights note.

A person reviews your work and can ask for revisions.

**Worked example:** Trailer builds mystery in three beats; the vertical cut leads with the strongest image and a caption hook.

**Common mistake:** Making the vertical cut a straight crop.

A person reviews your work and can ask for revisions.$t115c$, $t115d$Skill Lab: Lab 5 project: a trailer and a vertical cut$t115d$, $t115e$Submit both videos, the captions and a rights note listing sources.

**Sharing video:** upload (unlisted) and paste the link, plus any still frames as direct image links. Video is checked by a person.$t115e$, $t115f$[{"criterion": "Story and hook", "max_points": 30, "guidance": "Compelling."}, {"criterion": "Format fit", "max_points": 30, "guidance": "Adapted."}, {"criterion": "Craft", "max_points": 25, "guidance": "Polished."}, {"criterion": "Rights", "max_points": 15, "guidance": "Documented."}]$t115f$::jsonb, 180, 'link', false, true),
  (116, $t116a$Skill Lab: Channel strategy and audience$t116a$, $t116b$Plan a channel that can grow.$t116b$, $t116c$Pick a clear promise, a format you can repeat weekly and a posting rhythm you can sustain. Study what your audience watches to the end, write titles and thumbnails that are honest, and review analytics for drop-off points.

**Worked example:** Channel promise: 'One-minute AI film tricks, every Thursday.' Track retention at 15 seconds.

**Common mistake:** Changing topic every video.$t116c$, $t116d$Skill Lab: Channel strategy and audience$t116d$, $t116e$Write a channel plan: promise, format, 8-week calendar and three metrics.$t116e$, $t116f$[{"criterion": "Promise clear", "max_points": 30, "guidance": "Specific."}, {"criterion": "Sustainable rhythm", "max_points": 35, "guidance": "Realistic."}, {"criterion": "Metrics", "max_points": 35, "guidance": "Defined."}]$t116f$::jsonb, 45, 'text', false, false),
  (117, $t117a$Skill Lab: How video makes money (honestly)$t117a$, $t117b$Understand real income routes.$t117b$, $t117c$Ad revenue from short video is often small (check current terms and eligibility), so most creators earn from client work, sponsorships, products and courses. Check each platform's current monetisation rules and never buy fake views or subscribers.

**Worked example:** A creator earns most from paid promo videos for local businesses, not from ad revenue.

**Common mistake:** Expecting ad money to replace a job quickly.$t117c$, $t117d$Skill Lab: How video makes money (honestly)$t117d$, $t117e$Research current monetisation rules for two platforms and write a realistic income plan with three routes.$t117e$, $t117f$[{"criterion": "Rules researched", "max_points": 40, "guidance": "Current."}, {"criterion": "Realistic expectations", "max_points": 35, "guidance": "Honest."}, {"criterion": "Three routes", "max_points": 25, "guidance": "Planned."}]$t117f$::jsonb, 45, 'text', false, false),
  (118, $t118a$Skill Lab: Freelance video: scope, price and deliver$t118a$, $t118b$Sell video services.$t118b$, $t118c$Define deliverables (length, formats, revisions), price per finished minute or project, agree on rights and AI-use disclosure, deliver with a checklist and keep source files. Put everything in writing.

**Worked example:** Offer: 30-second promo, two revisions, three formats, 600, delivered in 7 days.

**Common mistake:** Unlimited revisions.$t118c$, $t118d$Skill Lab: Freelance video: scope, price and deliver$t118d$, $t118e$Write an offer, price sheet and short agreement for a promo video service.$t118e$, $t118f$[{"criterion": "Scope clear", "max_points": 40, "guidance": "Precise."}, {"criterion": "Rights and AI-use stated", "max_points": 30, "guidance": "Included."}, {"criterion": "Price logic", "max_points": 30, "guidance": "Reasoned."}]$t118f$::jsonb, 45, 'text', false, false),
  (119, $t119a$Skill Lab: Rights, likeness and ethics$t119a$, $t119b$Work responsibly with synthetic media.$t119b$, $t119c$Get releases for real people, clear all assets, label synthetic content per platform rules, never create misleading videos of real events or people, and handle complaints and takedowns promptly.

**Worked example:** A release form, an asset register and a labelling note included in every delivery.

**Common mistake:** Publishing a realistic video of a real person without consent.$t119c$, $t119d$Skill Lab: Rights, likeness and ethics$t119d$, $t119e$Write your production ethics statement and a delivery-rights checklist.$t119e$, $t119f$[{"criterion": "Specific commitments", "max_points": 40, "guidance": "Concrete."}, {"criterion": "Checklist practical", "max_points": 30, "guidance": "Usable."}, {"criterion": "Complaint process", "max_points": 30, "guidance": "Defined."}]$t119f$::jsonb, 45, 'text', false, false),
  (120, $t120a$Skill Lab: Lab 6 project: your showreel and offer$t120a$, $t120b$Present your best work and your services.$t120b$, $t120c$Show Lab 6. Publish a **60-second showreel** of your best work, an offer page with prices, your ethics statement and a rights checklist. Share it in the NEXTGEN Discord and ask for one piece of feedback.

A person reviews your work and can ask for revisions.

**Worked example:** Reel: four clips in under 60 seconds with credits and tool notes; an offer page with three packages.

**Common mistake:** A reel of everything you have ever made.

A person reviews your work and can ask for revisions.$t120c$, $t120d$Skill Lab: Lab 6 project: your showreel and offer$t120d$, $t120e$Submit the reel link, offer page, ethics statement and a 150-word reflection on what to improve next.

**Sharing video:** upload (unlisted) and paste the link, plus any still frames as direct image links. Video is checked by a person.$t120e$, $t120f$[{"criterion": "Quality of work", "max_points": 35, "guidance": "Strong."}, {"criterion": "Offer and business readiness", "max_points": 25, "guidance": "Clear."}, {"criterion": "Ethics and rights", "max_points": 25, "guidance": "Handled."}, {"criterion": "Reflection", "max_points": 15, "guidance": "Specific."}]$t120f$::jsonb, 180, 'link', false, true)
) as v(n, title, objective, lesson_md, skill_focus, assignment_md, rubric, est_minutes, submission_type, ai_evaluate, requires_review)
where t.slug = 'film'
on conflict (track_id, day_number) do nothing;
