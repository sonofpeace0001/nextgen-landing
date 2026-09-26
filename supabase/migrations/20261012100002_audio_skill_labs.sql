-- Audio, music & voice Skill Labs (days 91-120). Published; appended after the core path.
insert into public.day
  (track_id, tier_id, day_number, title, objective, lesson_md, skill_focus, assignment_md, rubric,
   est_minutes, is_published, credit_budget, submission_type, ai_evaluate, requires_review)
select t.id, ti.id, v.n, v.title, v.objective, v.lesson_md, v.skill_focus, v.assignment_md, v.rubric,
       v.est_minutes, true, null, v.submission_type, v.ai_evaluate, v.requires_review
from public.track t
join public.tier ti on ti.track_id = t.id and ti.slug = 'grandmaster'
cross join (values
  (91, $t91a$Skill Lab: Critical listening and reference tracks$t91a$, $t91b$Train your ears to hear problems.$t91b$, $t91c$Listen on headphones and speakers at a moderate level. Learn to hear balance (what is loud), frequency (bass, mids, highs), space (dry or roomy) and dynamics (steady or punchy). Compare your mix to a professional reference at the same loudness, because louder always sounds better.

**Worked example:** A reference song and your mix are matched in loudness, then compared for low-end and vocal clarity.

**Common mistake:** Judging a mix at a louder volume than the reference.$t91c$, $t91d$Skill Lab: Critical listening and reference tracks$t91d$, $t91e$Compare a track of yours with a reference and list five differences in balance, tone, space and dynamics.

**Sharing audio:** upload (unlisted) and paste the link. Audio is checked by a person.$t91e$, $t91f$[{"criterion": "Differences specific", "max_points": 40, "guidance": "Heard, not guessed."}, {"criterion": "Loudness matched", "max_points": 30, "guidance": "Fair."}, {"criterion": "Fixes suggested", "max_points": 30, "guidance": "Practical."}]$t91f$::jsonb, 45, 'link', false, false),
  (92, $t92a$Skill Lab: Frequency, EQ and making room$t92a$, $t92b$Give each sound its own space.$t92b$, $t92c$Sounds fight when they occupy the same frequencies. Cut what a part does not need (low rumble on voices), boost gently with wide curves, and cut clashing regions on the less important part. Small moves of 2 to 4 dB usually beat big ones.

**Worked example:** High-pass a voice at 80 Hz, cut 250 Hz mud slightly, and carve the same area in the guitar.

**Common mistake:** Boosting everything until it is harsh.$t92c$, $t92d$Skill Lab: Frequency, EQ and making room$t92d$, $t92e$Mix three layers (voice, music, effect) using EQ only and describe each move. Submit before and after.

**Sharing audio:** upload (unlisted) and paste the link. Audio is checked by a person.$t92e$, $t92f$[{"criterion": "Moves gentle", "max_points": 35, "guidance": "Reasonable."}, {"criterion": "Clarity improved", "max_points": 40, "guidance": "Better."}, {"criterion": "Moves explained", "max_points": 25, "guidance": "Noted."}]$t92f$::jsonb, 45, 'link', false, false),
  (93, $t93a$Skill Lab: Dynamics: compression, limiting and headroom$t93a$, $t93b$Control level without squashing life.$t93b$, $t93c$Compression reduces the gap between loud and quiet. Start with a low ratio (2 to 1), moderate threshold and fast-enough attack to keep punch. Use a limiter last to control peaks. Leave headroom (peaks around minus 6 dB before mastering).

**Worked example:** Voice compressed 3 dB at 2:1 so it sits evenly over music; a limiter at the end keeps peaks under minus 1 dB.

**Common mistake:** Over-compressing until everything sounds flat.$t93c$, $t93d$Skill Lab: Dynamics: compression, limiting and headroom$t93d$, $t93e$Apply light compression to a voice and a full mix limiter. Submit before and after with settings.

**Sharing audio:** upload (unlisted) and paste the link. Audio is checked by a person.$t93e$, $t93f$[{"criterion": "Gentle and effective", "max_points": 40, "guidance": "Natural."}, {"criterion": "Settings documented", "max_points": 30, "guidance": "Specific."}, {"criterion": "Headroom kept", "max_points": 30, "guidance": "Correct."}]$t93f$::jsonb, 45, 'link', false, false),
  (94, $t94a$Skill Lab: Space: reverb, delay and panning$t94a$, $t94b$Place sounds in a scene.$t94b$, $t94c$Reverb and delay create distance and mood; panning creates width. Use short reverbs for intimacy and long for scale, send sounds to a shared reverb, keep bass and lead voice near the centre, and check the mix in mono.

**Worked example:** Voice dry and centred, backing sounds panned left and right with a shared plate reverb.

**Common mistake:** Drowning everything in reverb.$t94c$, $t94d$Skill Lab: Space: reverb, delay and panning$t94d$, $t94e$Create a mix with space: two reverbs, one delay and panning. Submit the clip and a mono check note.

**Sharing audio:** upload (unlisted) and paste the link. Audio is checked by a person.$t94e$, $t94f$[{"criterion": "Depth and width", "max_points": 40, "guidance": "Clear."}, {"criterion": "Restraint", "max_points": 30, "guidance": "Controlled."}, {"criterion": "Mono compatible", "max_points": 30, "guidance": "Checked."}]$t94f$::jsonb, 45, 'link', false, false),
  (95, $t95a$Skill Lab: Lab 1 project: a clean two-minute mix$t95a$, $t95b$Deliver a balanced mix.$t95b$, $t95c$Show Lab 1. Mix a **two-minute piece** (voice plus music plus effects) with EQ, compression, space and a reference comparison, and a one-page mix report.

A person reviews your work and can ask for revisions.

**Worked example:** A narrated story with light music and two effects, mixed to minus 16 LUFS with a reference comparison.

**Common mistake:** No reference comparison.

A person reviews your work and can ask for revisions.$t95c$, $t95d$Skill Lab: Lab 1 project: a clean two-minute mix$t95d$, $t95e$Submit the mix, the reference used and the mix report.

**Sharing audio:** upload (unlisted) and paste the link. Audio is checked by a person.$t95e$, $t95f$[{"criterion": "Balance and clarity", "max_points": 35, "guidance": "Clear."}, {"criterion": "Technique appropriate", "max_points": 25, "guidance": "Gentle."}, {"criterion": "Loudness and headroom", "max_points": 20, "guidance": "Correct."}, {"criterion": "Report", "max_points": 20, "guidance": "Specific."}]$t95f$::jsonb, 150, 'link', false, true),
  (96, $t96a$Skill Lab: The AI music map and commercial risk$t96a$, $t96b$Choose music tools with licence in mind.$t96b$, $t96c$AI music generators differ in quality, control and, crucially, licence and training data. Some are best for quick ideas and personal use, others are positioned as safer for client work because they use licensed data. Terms change, so read the current commercial terms for every tool and plan, keep records, and never promise a client rights you do not have. Do not imitate a specific living artist's voice or style.

**Worked example:** Use a generator for ideas, record and edit your own parts, and use a tool with clear commercial terms for anything delivered to a client.

**Common mistake:** Assuming a paid plan automatically means safe commercial rights.$t96c$, $t96d$Skill Lab: The AI music map and commercial risk$t96d$, $t96e$Compare three tools on quality, control, price and current commercial terms. Submit a table with links to the terms.$t96e$, $t96f$[{"criterion": "Terms researched", "max_points": 45, "guidance": "Linked."}, {"criterion": "Comparison fair", "max_points": 30, "guidance": "Clear."}, {"criterion": "Risk advice sensible", "max_points": 25, "guidance": "Careful."}]$t96f$::jsonb, 45, 'text', false, false),
  (97, $t97a$Skill Lab: Prompting music: structure, style and stems$t97a$, $t97b$Get music you can actually use.$t97b$, $t97c$Describe genre, mood, tempo, instruments, structure (intro, verse, chorus, outro) and length. Generate several versions, keep the best sections, and export stems if the tool allows so you can mix them yourself. Edit for loops and endings.

**Worked example:** 'Warm lo-fi, 78 BPM, soft piano and vinyl crackle, no vocals, 2 minutes, gentle build' then keep verse two and re-edit the ending.

**Common mistake:** Accepting the first result.$t97c$, $t97d$Skill Lab: Prompting music: structure, style and stems$t97d$, $t97e$Generate five options for one brief, choose one with criteria and edit a clean ending. Submit the brief, criteria and the edit.

**Sharing audio:** upload (unlisted) and paste the link. Audio is checked by a person.$t97e$, $t97f$[{"criterion": "Brief specific", "max_points": 30, "guidance": "All parts."}, {"criterion": "Selection reasoned", "max_points": 40, "guidance": "Criteria."}, {"criterion": "Edit clean", "max_points": 30, "guidance": "Smooth."}]$t97f$::jsonb, 45, 'link', false, false),
  (98, $t98a$Skill Lab: From AI sketch to finished track$t98a$, $t98b$Add human craft.$t98b$, $t98c$Use generated audio as a sketch, then replace or add parts: record a melody, re-arrange, mix and master. Human input strengthens both quality and your claim to authorship. Note what is yours in a credit list.

**Worked example:** A generated chord bed becomes the base; you record a new melody and arrange the ending.

**Common mistake:** Releasing raw generated output as your own composition.$t98c$, $t98d$Skill Lab: From AI sketch to finished track$t98d$, $t98e$Turn an AI sketch into a track with at least two human contributions. Submit the audio and a credit list of who or what made each part.

**Sharing audio:** upload (unlisted) and paste the link. Audio is checked by a person.$t98e$, $t98f$[{"criterion": "Human contribution clear", "max_points": 40, "guidance": "Real."}, {"criterion": "Quality improved", "max_points": 30, "guidance": "Better."}, {"criterion": "Credits honest", "max_points": 30, "guidance": "Accurate."}]$t98f$::jsonb, 45, 'link', false, false),
  (99, $t99a$Skill Lab: Mastering and delivery$t99a$, $t99b$Finish for release.$t99b$, $t99c$Mastering is the final polish for consistent loudness and tone across a release. Use a reference, check on several devices, and export the formats platforms need. Automated mastering can be good for demos; check results by ear.

**Worked example:** A track mastered to minus 14 LUFS, true peak minus 1 dB, checked on phone, car and headphones.

**Common mistake:** Mastering louder than the platform target.$t99c$, $t99d$Skill Lab: Mastering and delivery$t99d$, $t99e$Master one track and provide a loudness report and a translation check on three devices.

**Sharing audio:** upload (unlisted) and paste the link. Audio is checked by a person.$t99e$, $t99f$[{"criterion": "Loudness right", "max_points": 35, "guidance": "Numbers."}, {"criterion": "Translation checked", "max_points": 35, "guidance": "Devices."}, {"criterion": "Sound quality", "max_points": 30, "guidance": "Clean."}]$t99f$::jsonb, 45, 'link', false, false),
  (100, $t100a$Skill Lab: Lab 2 project: an AI-assisted original track$t100a$, $t100b$Deliver a cleared, mastered track.$t100b$, $t100c$Show Lab 2. Deliver a **two-minute track** built from an AI sketch with your own contributions, a licence audit, a credit list, mastered and delivered as WAV and MP3.

A person reviews your work and can ask for revisions.

**Worked example:** A short brand theme with recorded melody, mixed and mastered with a documented licence.

**Common mistake:** No licence record for the generator.

A person reviews your work and can ask for revisions.$t100c$, $t100d$Skill Lab: Lab 2 project: an AI-assisted original track$t100d$, $t100e$Submit the track, sketch, credit list, licence audit and mastering report.

**Sharing audio:** upload (unlisted) and paste the link. Audio is checked by a person.$t100e$, $t100f$[{"criterion": "Musical quality", "max_points": 30, "guidance": "Strong."}, {"criterion": "Human contribution and credit", "max_points": 25, "guidance": "Clear."}, {"criterion": "Licence audit", "max_points": 25, "guidance": "Complete."}, {"criterion": "Mastering", "max_points": 20, "guidance": "Correct."}]$t100f$::jsonb, 180, 'link', false, true),
  (101, $t101a$Skill Lab: Voice acting and direction for AI voices$t101a$, $t101b$Get performances that sound alive.$t101b$, $t101c$Write direction: who is speaking, to whom, and the feeling. Break text at natural pauses, use punctuation and phonetic spellings, generate several takes and pick by emotion. Keep the voice consistent across a project and use only licensed voices.

**Worked example:** Direction: 'a tired teacher at the end of the day, warm but slow, smiles on the last line'.

**Common mistake:** Accepting a flat read for an emotional line.$t101c$, $t101d$Skill Lab: Voice acting and direction for AI voices$t101d$, $t101e$Generate three takes of one emotional line with different directions and choose one with reasons.

**Sharing audio:** upload (unlisted) and paste the link. Audio is checked by a person.$t101e$, $t101f$[{"criterion": "Directions specific", "max_points": 35, "guidance": "Clear."}, {"criterion": "Takes different", "max_points": 35, "guidance": "Distinct."}, {"criterion": "Choice reasoned", "max_points": 30, "guidance": "Justified."}]$t101f$::jsonb, 45, 'link', false, false),
  (102, $t102a$Skill Lab: Voice cloning, consent and law$t102a$, $t102b$Use voice technology responsibly.$t102b$, $t102c$Only clone or imitate a voice with the speaker's written consent, defined use, payment terms and a way to withdraw. Label synthetic voices where required, keep records and reject requests that deceive people. Laws about voice likeness differ and are changing.

**Worked example:** A consent form: purpose, duration, fee, examples of allowed use, right to revoke, labelling.

**Common mistake:** Using a friend's voice 'just for fun' without permission.$t102c$, $t102d$Skill Lab: Voice cloning, consent and law$t102d$, $t102e$Write a voice consent form and a use policy with three refusal cases.$t102e$, $t102f$[{"criterion": "Consent specific", "max_points": 40, "guidance": "Complete."}, {"criterion": "Refusals clear", "max_points": 30, "guidance": "Examples."}, {"criterion": "Labelling", "max_points": 30, "guidance": "Included."}]$t102f$::jsonb, 45, 'text', false, false),
  (103, $t103a$Skill Lab: Audiobooks, courses and long narration$t103a$, $t103b$Narrate consistently.$t103b$, $t103c$Long work needs a pronunciation sheet, consistent pace and tone, chapter-by-chapter checks and room-tone continuity. Record or generate in short sessions and proofread against the script.

**Worked example:** A style sheet lists names, numbers and a pace; each chapter is checked for level and consistency.

**Common mistake:** Changing voice settings midway through a book.$t103c$, $t103d$Skill Lab: Audiobooks, courses and long narration$t103d$, $t103e$Narrate five minutes with a style sheet and consistency check.

**Sharing audio:** upload (unlisted) and paste the link. Audio is checked by a person.$t103e$, $t103f$[{"criterion": "Consistency", "max_points": 40, "guidance": "Even."}, {"criterion": "Style sheet useful", "max_points": 30, "guidance": "Practical."}, {"criterion": "Accuracy", "max_points": 30, "guidance": "Proofread."}]$t103f$::jsonb, 45, 'link', false, false),
  (104, $t104a$Skill Lab: Dubbing and localisation$t104a$, $t104b$Reach other languages with care.$t104b$, $t104c$Translate for meaning, have a native reviewer check tone and terms, match timing, and label synthetic dubbing. Keep the original for reference and get consent for the voice in each language.

**Worked example:** A 60-word script translated, reviewed by a native speaker who fixes two idioms.

**Common mistake:** Publishing an unreviewed machine translation.$t104c$, $t104d$Skill Lab: Dubbing and localisation$t104d$, $t104e$Localise a 60-word script into one language with reviewer notes and a labelling decision.

**Sharing audio:** upload (unlisted) and paste the link. Audio is checked by a person.$t104e$, $t104f$[{"criterion": "Reviewed by a speaker", "max_points": 40, "guidance": "Real."}, {"criterion": "Timing and tone", "max_points": 30, "guidance": "Considered."}, {"criterion": "Consent and label", "max_points": 30, "guidance": "Handled."}]$t104f$::jsonb, 45, 'link', false, false),
  (105, $t105a$Skill Lab: Lab 3 project: a five-minute narrated production$t105a$, $t105b$Deliver a directed, consented narration.$t105b$, $t105c$Show Lab 3. Produce a **five-minute narrated piece** with directed voice, consistent style, licensed music, a localised excerpt, transcript and consent records.

A person reviews your work and can ask for revisions.

**Worked example:** A short audio guide to a local museum with narration, ambience and a translated introduction.

**Common mistake:** No transcript or consent record.

A person reviews your work and can ask for revisions.$t105c$, $t105d$Skill Lab: Lab 3 project: a five-minute narrated production$t105d$, $t105e$Submit the audio, script, style sheet, transcript, consent and licence records.

**Sharing audio:** upload (unlisted) and paste the link. Audio is checked by a person.$t105e$, $t105f$[{"criterion": "Performance and consistency", "max_points": 30, "guidance": "Strong."}, {"criterion": "Sound quality", "max_points": 25, "guidance": "Clean."}, {"criterion": "Consent and licences", "max_points": 25, "guidance": "Documented."}, {"criterion": "Localisation and transcript", "max_points": 20, "guidance": "Accurate."}]$t105f$::jsonb, 180, 'link', false, true),
  (106, $t106a$Skill Lab: Show design and audience$t106a$, $t106b$Plan a show people return to.$t106b$, $t106c$Define the audience, promise, format, length and cadence, then plan the first ten episodes. Make the show notes and titles honest and searchable. A repeatable structure makes weekly production sustainable.

**Worked example:** A 12-minute weekly show for new freelancers with a fixed structure: story, lesson, action.

**Common mistake:** Starting without a clear promise.$t106c$, $t106d$Skill Lab: Show design and audience$t106d$, $t106e$Write a show plan with promise, format, ten episode ideas and a weekly production checklist.$t106e$, $t106f$[{"criterion": "Promise clear", "max_points": 30, "guidance": "Specific."}, {"criterion": "Sustainable format", "max_points": 40, "guidance": "Realistic."}, {"criterion": "Episodes planned", "max_points": 30, "guidance": "Ten."}]$t106f$::jsonb, 45, 'text', false, false),
  (107, $t107a$Skill Lab: Interviews, remote recording and consent$t107a$, $t107b$Record great conversations.$t107b$, $t107c$Prepare questions, record separate tracks for each person, get recording and publishing consent, ask follow-ups and let silence work. Edit for clarity without changing meaning.

**Worked example:** A guest signs a release, records a local backup, and the host asks three follow-up questions.

**Common mistake:** Publishing an interview without permission.$t107c$, $t107d$Skill Lab: Interviews, remote recording and consent$t107d$, $t107e$Record a ten-minute conversation with consent and edit it to seven minutes. Submit both and the release text.

**Sharing audio:** upload (unlisted) and paste the link. Audio is checked by a person.$t107e$, $t107f$[{"criterion": "Consent and release", "max_points": 30, "guidance": "Present."}, {"criterion": "Edit clean", "max_points": 40, "guidance": "Natural."}, {"criterion": "Meaning intact", "max_points": 30, "guidance": "Faithful."}]$t107f$::jsonb, 45, 'link', false, false),
  (108, $t108a$Skill Lab: Editing for story and pace$t108a$, $t108b$Shape the listening experience.$t108b$, $t108c$Cut dead air and repetition, keep breaths, add music bridges and ambience for transitions, and open with the most interesting moment. Read the transcript to find cuts.

**Worked example:** A cold open with the best 20 seconds, then a sting and the intro.

**Common mistake:** Editing out every pause so speech sounds robotic.$t108c$, $t108d$Skill Lab: Editing for story and pace$t108d$, $t108e$Edit a twelve-minute recording to nine with a cold open. Submit both and an edit log.

**Sharing audio:** upload (unlisted) and paste the link. Audio is checked by a person.$t108e$, $t108f$[{"criterion": "Pace improved", "max_points": 40, "guidance": "Better."}, {"criterion": "Natural sound kept", "max_points": 30, "guidance": "Human."}, {"criterion": "Edit log", "max_points": 30, "guidance": "Clear."}]$t108f$::jsonb, 45, 'link', false, false),
  (109, $t109a$Skill Lab: Distribution, analytics and growth$t109a$, $t109b$Publish and learn.$t109b$, $t109c$Publish through a host that creates an RSS feed, submit to major directories, write clear titles and descriptions, and watch retention to find where listeners drop. Promote through communities and guests, not tricks.

**Worked example:** Retention drops at minute 4, so the intro is shortened and the opening story moves earlier.

**Common mistake:** Chasing download numbers over listener retention.$t109c$, $t109d$Skill Lab: Distribution, analytics and growth$t109d$, $t109e$Create a publishing checklist and a 90-day growth plan with three metrics.$t109e$, $t109f$[{"criterion": "Checklist practical", "max_points": 35, "guidance": "Complete."}, {"criterion": "Metrics useful", "max_points": 35, "guidance": "Retention."}, {"criterion": "Plan realistic", "max_points": 30, "guidance": "Feasible."}]$t109f$::jsonb, 45, 'text', false, false),
  (110, $t110a$Skill Lab: Lab 4 project: a podcast pilot$t110a$, $t110b$Deliver a complete pilot episode and plan.$t110b$, $t110c$Show Lab 4. Deliver a **pilot episode** (10 minutes), transcript, show notes, cover art plan, publishing checklist and a 90-day plan.

A person reviews your work and can ask for revisions.

**Worked example:** A pilot for a weekly show with a strong cold open and honest show notes.

**Common mistake:** No plan beyond the first episode.

A person reviews your work and can ask for revisions.$t110c$, $t110d$Skill Lab: Lab 4 project: a podcast pilot$t110d$, $t110e$Submit the episode, transcript, show notes, checklist and plan.

**Sharing audio:** upload (unlisted) and paste the link. Audio is checked by a person.$t110e$, $t110f$[{"criterion": "Episode quality", "max_points": 35, "guidance": "Engaging."}, {"criterion": "Sound and edit", "max_points": 25, "guidance": "Clean."}, {"criterion": "Notes and transcript", "max_points": 20, "guidance": "Accurate."}, {"criterion": "Plan", "max_points": 20, "guidance": "Realistic."}]$t110f$::jsonb, 210, 'link', false, true),
  (111, $t111a$Skill Lab: Sound design for video and games$t111a$, $t111b$Create sounds that support picture.$t111b$, $t111c$Layer sounds, sync to action and leave space for dialogue. Record real sounds (foley) for body and objects, use synthesis for impossible things, and keep a library with clear names and licences. Games need loops and variations to avoid repetition.

**Worked example:** Footsteps recorded on gravel with three variations, mixed under dialogue.

**Common mistake:** One repeated footstep sample.$t111c$, $t111d$Skill Lab: Sound design for video and games$t111d$, $t111e$Create a sound set (six sounds with variations) for a short scene. Submit the audio and a naming list with licences.

**Sharing audio:** upload (unlisted) and paste the link. Audio is checked by a person.$t111e$, $t111f$[{"criterion": "Sounds fit", "max_points": 35, "guidance": "Suitable."}, {"criterion": "Variations", "max_points": 35, "guidance": "Present."}, {"criterion": "Library organised", "max_points": 30, "guidance": "Clear."}]$t111f$::jsonb, 45, 'link', false, false),
  (112, $t112a$Skill Lab: Ambience, spatial audio and immersion$t112a$, $t112b$Create a sense of place.$t112b$, $t112c$Layer a bed (constant ambience), details (occasional sounds) and movement (things passing). Use panning and reverb for space, and check stereo fallbacks if you use spatial formats.

**Worked example:** A market: bed of crowd murmur, details of coins and a cart, and a bicycle bell passing left to right.

**Common mistake:** A single looped ambience with no detail.$t112c$, $t112d$Skill Lab: Ambience, spatial audio and immersion$t112d$, $t112e$Design a one-minute ambience for one place with three layers and a layer list.

**Sharing audio:** upload (unlisted) and paste the link. Audio is checked by a person.$t112e$, $t112f$[{"criterion": "Layers distinct", "max_points": 40, "guidance": "Three."}, {"criterion": "Sense of place", "max_points": 35, "guidance": "Convincing."}, {"criterion": "Fallback checked", "max_points": 25, "guidance": "Stereo."}]$t112f$::jsonb, 45, 'link', false, false),
  (113, $t113a$Skill Lab: Adaptive and interactive audio$t113a$, $t113b$Make sound respond to action.$t113b$, $t113c$Interactive audio changes with state: calm to tension music layers, randomised effects, and smooth transitions. Design states, triggers and crossfades, and test in context.

**Worked example:** Three music layers added as danger rises, crossfading over two bars.

**Common mistake:** Abrupt music switches that break immersion.$t113c$, $t113d$Skill Lab: Adaptive and interactive audio$t113d$, $t113e$Design an adaptive audio plan for three states with triggers and transition rules.$t113e$, $t113f$[{"criterion": "States and triggers", "max_points": 40, "guidance": "Clear."}, {"criterion": "Transitions smooth", "max_points": 30, "guidance": "Planned."}, {"criterion": "Tested in context", "max_points": 30, "guidance": "Evidence."}]$t113f$::jsonb, 45, 'text', false, false),
  (114, $t114a$Skill Lab: Loudness, delivery and platform specs$t114a$, $t114b$Deliver to standard.$t114b$, $t114c$Different platforms have loudness targets and formats. Check the current spec, measure integrated loudness and true peak, and deliver stems where requested. Keep a delivery checklist.

**Worked example:** Video delivered at minus 14 LUFS with stems and a cue sheet.

**Common mistake:** Using last year's loudness target without checking.$t114c$, $t114d$Skill Lab: Loudness, delivery and platform specs$t114d$, $t114e$Create a delivery checklist for three platforms with current specs and measure one file against it.

**Sharing audio:** upload (unlisted) and paste the link. Audio is checked by a person.$t114e$, $t114f$[{"criterion": "Specs current", "max_points": 40, "guidance": "Verified."}, {"criterion": "Measured", "max_points": 30, "guidance": "Numbers."}, {"criterion": "Stems and cue sheet", "max_points": 30, "guidance": "Included."}]$t114f$::jsonb, 45, 'link', false, false),
  (115, $t115a$Skill Lab: Lab 5 project: sound for a one-minute film$t115a$, $t115b$Deliver a full soundtrack.$t115b$, $t115c$Show Lab 5. Create the **complete soundtrack** for a one-minute film: dialogue clean-up, ambience, foley, music, mix, stems and a cue sheet with licences.

A person reviews your work and can ask for revisions.

**Worked example:** A one-minute scene with dialogue, rain ambience, foley steps and a short theme.

**Common mistake:** Dialogue buried under effects.

A person reviews your work and can ask for revisions.$t115c$, $t115d$Skill Lab: Lab 5 project: sound for a one-minute film$t115d$, $t115e$Submit the mixed film audio, stems, cue sheet and delivery checklist.

**Sharing audio:** upload (unlisted) and paste the link. Audio is checked by a person.$t115e$, $t115f$[{"criterion": "Sound supports picture", "max_points": 30, "guidance": "Purposeful."}, {"criterion": "Mix clarity", "max_points": 25, "guidance": "Dialogue clear."}, {"criterion": "Delivery", "max_points": 25, "guidance": "Stems and specs."}, {"criterion": "Rights", "max_points": 20, "guidance": "Cleared."}]$t115f$::jsonb, 210, 'link', false, true),
  (116, $t116a$Skill Lab: Copyright, splits and performing rights$t116a$, $t116b$Understand how music earns.$t116b$, $t116c$Songs have a composition side and a recording side, each with owners. Agree splits in writing, register works with a performing rights organisation where relevant, and register releases correctly. Most AI-assisted releases that succeed are credited to human artists using AI as a tool. Get legal advice for contracts. This course is not legal advice.

**Worked example:** Split sheet: composer 50 percent, producer 30, vocalist 20, signed by all.

**Common mistake:** Releasing collaborative work with no agreed splits.$t116c$, $t116d$Skill Lab: Copyright, splits and performing rights$t116d$, $t116e$Create a split sheet and a rights summary for one of your tracks.$t116e$, $t116f$[{"criterion": "Rights understood", "max_points": 45, "guidance": "Correct."}, {"criterion": "Split sheet complete", "max_points": 30, "guidance": "Signed."}, {"criterion": "Advice noted", "max_points": 25, "guidance": "Limits."}]$t116f$::jsonb, 45, 'text', false, false),
  (117, $t117a$Skill Lab: Distribution and release strategy$t117a$, $t117b$Get music heard.$t117b$, $t117c$Choose a distributor, prepare metadata and artwork, plan a release window, pitch playlists honestly and build a small audience before release. Do not buy fake streams.

**Worked example:** A four-week release plan: teaser clips, pre-save, release day, follow-up.

**Common mistake:** Buying streams to look popular.$t117c$, $t117d$Skill Lab: Distribution and release strategy$t117d$, $t117e$Write a release plan for one track with metadata, artwork and a four-week schedule.$t117e$, $t117f$[{"criterion": "Metadata and artwork", "max_points": 30, "guidance": "Complete."}, {"criterion": "Schedule realistic", "max_points": 40, "guidance": "Feasible."}, {"criterion": "Honest promotion", "max_points": 30, "guidance": "No fake plays."}]$t117f$::jsonb, 45, 'text', false, false),
  (118, $t118a$Skill Lab: Freelance audio services$t118a$, $t118b$Sell audio work.$t118b$, $t118c$Offer clear packages (podcast editing, voiceover production, sound design), price per finished minute or project, define revisions and rights, and use written agreements that state AI-tool use.

**Worked example:** Podcast edit 45 per episode, two rounds, delivered in 48 hours; ownership on payment.

**Common mistake:** Working without written terms.$t118c$, $t118d$Skill Lab: Freelance audio services$t118d$, $t118e$Write your service packages, prices and an agreement outline.$t118e$, $t118f$[{"criterion": "Packages clear", "max_points": 40, "guidance": "Defined."}, {"criterion": "Rights and AI use stated", "max_points": 30, "guidance": "Included."}, {"criterion": "Pricing logic", "max_points": 30, "guidance": "Reasoned."}]$t118f$::jsonb, 45, 'text', false, false),
  (119, $t119a$Skill Lab: Ethics and standards for synthetic audio$t119a$, $t119b$State your principles.$t119b$, $t119c$Publish how you use AI, obtain consent, label synthetic voices, credit sources and correct mistakes. Refuse deceptive uses, including fake endorsements and impersonation.

**Worked example:** A standards page with consent, labelling, refusal cases and a correction policy.

**Common mistake:** No refusal cases.$t119c$, $t119d$Skill Lab: Ethics and standards for synthetic audio$t119d$, $t119e$Write your audio standards (200 words) with three refusal cases.$t119e$, $t119f$[{"criterion": "Specific commitments", "max_points": 40, "guidance": "Concrete."}, {"criterion": "Refusal cases", "max_points": 30, "guidance": "Clear."}, {"criterion": "Correction policy", "max_points": 30, "guidance": "Present."}]$t119f$::jsonb, 45, 'text', false, false),
  (120, $t120a$Skill Lab: Lab 6 project: your audio showcase$t120a$, $t120b$Present your best work and services.$t120b$, $t120c$Show Lab 6. Publish a **showcase**: three audio pieces, credits and rights notes, your services and prices, and your standards. Share it in the NEXTGEN Discord and ask for one piece of feedback.

A person reviews your work and can ask for revisions.

**Worked example:** A page with a narration, a track, a podcast clip, three packages and a contact button.

**Common mistake:** No credit or rights notes.

A person reviews your work and can ask for revisions.$t120c$, $t120d$Skill Lab: Lab 6 project: your audio showcase$t120d$, $t120e$Submit links to the three pieces, rights notes, price sheet, standards and a 150-word reflection.

**Sharing audio:** upload (unlisted) and paste the link. Audio is checked by a person.$t120e$, $t120f$[{"criterion": "Quality of work", "max_points": 35, "guidance": "Strong."}, {"criterion": "Rights and credits", "max_points": 25, "guidance": "Documented."}, {"criterion": "Business readiness", "max_points": 20, "guidance": "Clear."}, {"criterion": "Reflection", "max_points": 20, "guidance": "Specific."}]$t120f$::jsonb, 180, 'link', false, true)
) as v(n, title, objective, lesson_md, skill_focus, assignment_md, rubric, est_minutes, submission_type, ai_evaluate, requires_review)
where t.slug = 'audio'
on conflict (track_id, day_number) do nothing;
