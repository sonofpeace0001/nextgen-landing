-- Give the 50 terse capstone/flagship step days concrete steps and a definition of done (idempotent).
update public.day d
   set lesson_md = d.lesson_md || v.extra
  from (values
  ($sl1$agents$sl1$, 57, $x1$

**Steps:** 1. Write 20 realistic tasks (12 normal, 4 edge cases, 4 traps) with the result you expect for each. 2. Run every task and record what the agent did. 3. Mark each pass or fail and note the cause of each failure. 4. Fix the biggest cause first, then re-run the failed tasks.

**You are done when:** Your test log shows all 20 results, at least one fix and a re-test.$x1$),
  ($sl2$agents$sl2$, 58, $x2$

**Steps:** 1. Decide which actions need a human approval and write the threshold. 2. Test with three hostile inputs (hidden instructions, odd formats, a request to leak data). 3. Map the personal data the agent sees, where it goes and how long it is kept. 4. Review each tool permission and remove any you do not need.

**You are done when:** Approvals, injection results, the data map and the permission review are all documented.$x2$),
  ($sl3$agents$sl3$, 77, $x3$

**Steps:** 1. Run your evaluation harness on real cases, not made-up ones. 2. Record success rate, harmful errors, cost per task and interventions. 3. Pick the two worst failures and read their traces. 4. Fix, re-run and compare before and after.

**You are done when:** You can show a before-and-after number for at least one improvement.$x3$),
  ($sl4$agents$sl4$, 78, $x4$

**Steps:** 1. Run the agent for two weeks with a real user watching. 2. Log every incident: what happened, impact, cause, fix. 3. Track oversight numbers such as how often a person corrected or blocked it. 4. Ask the user what to change.

**You are done when:** The pilot report has metrics, an incident log and at least one change you made.$x4$),
  ($sl5$apps$sl5$, 56, $x5$

**Steps:** 1. Sketch every screen and the main flow on paper. 2. List the tables, their fields and the links between them. 3. Write a permissions table (roles by actions). 4. Check the three against each other: every screen field must exist in the data, every action in the permissions.

**You are done when:** Screens, data model and permissions agree with each other.$x5$),
  ($sl6$apps$sl6$, 79, $x6$

**Steps:** 1. Publish the tool and test it signed out. 2. Turn on error alerts and a daily backup. 3. Answer at least one real user question or fix one real problem. 4. Record signups, active users and errors for a week.

**You are done when:** The tool is live, monitored, and you have a week of real numbers.$x6$),
  ($sl7$audio$sl7$, 28, $x7$

**Steps:** 1. Set music about 15 to 20 dB under speech and use gentle EQ so voice is clear. 2. Compress lightly and limit peaks. 3. Master to your loudness target and check the true peak. 4. Listen on headphones, a phone speaker and a car or laptop speaker.

**You are done when:** You have a loudness reading and notes from three listening devices.$x7$),
  ($sl8$audio$sl8$, 55, $x8$

**Steps:** 1. Name the audience and what they should do after listening. 2. List each deliverable, its length and format. 3. Set the schedule and how many revisions you offer. 4. State the measure of success.

**You are done when:** A one-page brief a stranger could produce from.$x8$),
  ($sl9$audio$sl9$, 56, $x9$

**Steps:** 1. Write the script for the ear (short sentences, pauses marked). 2. Write a sound brief: music mood, tempo, effects and where each goes. 3. Write a consent form for every voice you will use. 4. Get signatures or written agreement before recording.

**You are done when:** Scripts, sound brief and signed consent are ready before any recording.$x9$),
  ($sl10$audio$sl10$, 57, $x10$

**Steps:** 1. Record or generate the voice and keep every take. 2. Generate music options and choose with criteria. 3. Design or record the effects. 4. Log every source, tool and licence in one sheet.

**You are done when:** Every asset is saved with its source and licence.$x10$),
  ($sl11$audio$sl11$, 58, $x11$

**Steps:** 1. Mix speech, music and effects for clarity. 2. Master to the platform loudness target. 3. Export the deliverables in the required formats. 4. Write a short loudness report with the numbers.

**You are done when:** Final files exist with a loudness report.$x11$),
  ($sl12$audio$sl12$, 76, $x12$

**Steps:** 1. Choose the project (series, album or brand sound). 2. Write who it is for, the promise and a schedule. 3. Draw a rights map: who owns what and what needs consent. 4. Plan the budget and tools.

**You are done when:** A brief, a plan and a rights map that another person could follow.$x12$),
  ($sl13$audio$sl13$, 77, $x13$

**Steps:** 1. Record or compose the core pieces first. 2. Keep a source log as you go. 3. Save takes with clear names. 4. Check each piece against the brief.

**You are done when:** Core audio is finished and every source is logged.$x13$),
  ($sl14$audio$sl14$, 78, $x14$

**Steps:** 1. Mix and master each piece. 2. Compare with a reference track at the same loudness. 3. Test on at least three devices. 4. Write the QC report with loudness and fixes.

**You are done when:** Mixes are final and the QC report is complete.$x14$),
  ($sl15$audio$sl15$, 79, $x15$

**Steps:** 1. Publish the work on a real platform. 2. Ask at least five listeners for specific feedback. 3. Track plays and retention for two weeks. 4. Write what you would change.

**You are done when:** You have real listener feedback and numbers, not guesses.$x15$),
  ($sl16$business$sl16$, 28, $x16$

**Steps:** 1. Choose ten real prospects and write a personal opener for each. 2. Send them over a few days. 3. Log who replied, what they said and what worked. 4. Follow up once, politely.

**You are done when:** Ten sent messages, a results log and one thing you learned.$x16$),
  ($sl17$business$sl17$, 57, $x17$

**Steps:** 1. Agree a small paid or free pilot with a real client. 2. Deliver it using your process. 3. Ask for a short quote and permission to share results. 4. Write the case study with real numbers.

**You are done when:** A case study the client has approved.$x17$),
  ($sl18$business$sl18$, 58, $x18$

**Steps:** 1. Contact 20 prospects with personal, honest messages. 2. Hold discovery calls with those who reply. 3. Send proposals with three options. 4. Track every step in a sheet.

**You are done when:** Numbers for messages, replies, calls and proposals, and what you learned.$x18$),
  ($sl19$business$sl19$, 59, $x19$

**Steps:** 1. Draft a one-page contract with scope, payment, ownership and AI use. 2. Make an invoice template. 3. Set up records and a tax set-aside. 4. Write a risk register and a short privacy practice.

**You are done when:** Each item exists in a usable form.$x19$),
  ($sl20$business$sl20$, 76, $x20$

**Steps:** 1. Define your offer in one sentence. 2. Name the client type. 3. Set a revenue goal with a date. 4. Break it into weekly actions.

**You are done when:** A goal with a number, a date and weekly actions.$x20$),
  ($sl21$business$sl21$, 77, $x21$

**Steps:** 1. Set weekly targets for messages, calls and proposals. 2. Do the work for 30 days. 3. Track every result. 4. Adjust messages or offer after two weeks.

**You are done when:** A 30-day log with honest numbers.$x21$),
  ($sl22$business$sl22$, 79, $x22$

**Steps:** 1. List targets and actuals for revenue, margin, hours and satisfaction. 2. Find the biggest gap. 3. Write why it happened and what you will change. 4. Set next month's targets.

**You are done when:** A review with real numbers and three next actions.$x22$),
  ($sl23$content$sl23$, 47, $x23$

**Steps:** 1. List the five biggest doubts a reader has. 2. Answer each in two or three honest sentences. 3. Add who the offer is not for. 4. Read it as a sceptical customer.

**You are done when:** Five honest answers and one clear 'not for you' line.$x23$),
  ($sl24$content$sl24$, 55, $x24$

**Steps:** 1. Choose a client or cause and get permission. 2. Write audience, goal and one measurable result. 3. List channels and constraints. 4. Decide how you will know it worked.

**You are done when:** A one-page brief with a measurable result.$x24$),
  ($sl25$content$sl25$, 56, $x25$

**Steps:** 1. Gather five to eight facts and open every source. 2. Write your voice guide: traits, words, kill list, examples. 3. Test the guide on a short paragraph. 4. Fix what the test shows.

**You are done when:** A sourced fact sheet and a voice guide that passed a test.$x25$),
  ($sl26$content$sl26$, 57, $x26$

**Steps:** 1. Write the spine and outline. 2. Draft with a strong opening and checked evidence. 3. Cut ten percent. 4. Add sources and a clear ending.

**You are done when:** An 800 to 1,000 word article with a source list.$x26$),
  ($sl27$content$sl27$, 58, $x27$

**Steps:** 1. Choose the message that matters most. 2. Reshape it for each channel, not copy it. 3. Keep the voice guide beside you. 4. Give each piece one call to action.

**You are done when:** Five pieces that clearly come from one idea.$x27$),
  ($sl28$content$sl28$, 59, $x28$

**Steps:** 1. Read every piece aloud. 2. Remove AI habits from your kill list. 3. Verify every fact again. 4. Add alt text and plain-language fixes and keep a changelog.

**You are done when:** A changelog and final versions you would put your name to.$x28$),
  ($sl29$film$sl29$, 57, $x29$

**Steps:** 1. Generate each shot from your storyboard. 2. Log attempts and credits per shot. 3. Keep the best take and note why. 4. Record where each asset came from.

**You are done when:** Selected clips for every shot plus a tracker and credit ledger.$x29$),
  ($sl30$film$sl30$, 58, $x30$

**Steps:** 1. Assemble the cut and trim for pace. 2. Mix dialogue, music and effects. 3. Grade all shots to one look. 4. Add captions and credits and check on a phone.

**You are done when:** A finished cut with captions and credits.$x30$),
  ($sl31$film$sl31$, 59, $x31$

**Steps:** 1. Screen for five viewers and ask what they understood and felt. 2. Fix the top two problems. 3. Complete the clearance sheet for every asset. 4. Record the changes.

**You are done when:** Viewer notes, changes made and a complete clearance sheet.$x31$),
  ($sl32$film$sl32$, 77, $x32$

**Steps:** 1. Generate and film the shots in the planned order. 2. Keep a shot tracker with attempts and credits. 3. Log where each asset came from. 4. Choose the best takes.

**You are done when:** All shots selected, tracker and provenance log complete.$x32$),
  ($sl33$film$sl33$, 78, $x33$

**Steps:** 1. Edit for story and pace. 2. Mix and grade. 3. Add captions and credits. 4. Export to the delivery spec and check on a phone and a TV.

**You are done when:** A locked cut that meets the delivery spec.$x33$),
  ($sl34$graphics$sl34$, 55, $x34$

**Steps:** 1. Name the business and its audience. 2. Write the goals and the deliverables with sizes. 3. Set tone, constraints and deadline. 4. Add what must and must not appear.

**You are done when:** A one-page brief a designer could work from.$x34$),
  ($sl35$graphics$sl35$, 56, $x35$

**Steps:** 1. Collect references and write three direction words. 2. Choose a palette with roles and check contrast. 3. Pick fonts and a type scale. 4. Write imagery rules and put it all on one page.

**You are done when:** A brand kit page and a moodboard that match the brief.$x35$),
  ($sl36$graphics$sl36$, 57, $x36$

**Steps:** 1. Generate options for the hero image. 2. Choose with a checklist (fit, composition, flaws). 3. Place your logo and check contrast and legibility. 4. Confirm the image is honest about the product or message.

**You are done when:** One strong hero asset with prompts recorded.$x36$),
  ($sl37$graphics$sl37$, 58, $x37$

**Steps:** 1. Duplicate your master layout for each deliverable. 2. Change only the content. 3. Check sizes and safe margins. 4. Review the set side by side.

**You are done when:** Every deliverable exists and clearly belongs to one campaign.$x37$),
  ($sl38$graphics$sl38$, 59, $x38$

**Steps:** 1. Show the set to three people with two specific questions. 2. Decide which feedback to apply. 3. Zoom-check flaws, proofread text and check sizes. 4. Confirm the rights for every asset.

**You are done when:** Feedback, the changes you made and final files.$x38$),
  ($sl39$motion$sl39$, 27, $x39$

**Steps:** 1. Animate the logo reveal in about three seconds, ending on a clean frame. 2. Build a four-second loop that joins seamlessly. 3. Use your style guide's easing and timing. 4. Export and test on a phone.

**You are done when:** Two short animations that follow the guide.$x39$),
  ($sl40$motion$sl40$, 28, $x40$

**Steps:** 1. Record or generate the voiceover from your script. 2. Animate each scene to the timing. 3. Add music under the voice and effects on the action. 4. Add captions and check licences.

**You are done when:** A 30-second explainer with sound, captions and licences.$x40$),
  ($sl41$motion$sl41$, 55, $x41$

**Steps:** 1. Name the brand and goals. 2. List each animation, its length and format. 3. Describe the style and constraints. 4. Set the schedule and revision rounds.

**You are done when:** A brief with deliverables and formats.$x41$),
  ($sl42$motion$sl42$, 56, $x42$

**Steps:** 1. Write the motion system: timing, easing, hierarchy, banned effects. 2. Storyboard every piece. 3. Check the boards follow the system. 4. Get the plan approved before animating.

**You are done when:** A motion system and storyboards for every deliverable.$x42$),
  ($sl43$motion$sl43$, 57, $x43$

**Steps:** 1. Animate the hero piece to the storyboard. 2. Reuse the same system for one variant. 3. Check timing against the tokens. 4. Export and review.

**You are done when:** A hero animation and one variant.$x43$),
  ($sl44$motion$sl44$, 58, $x44$

**Steps:** 1. Produce the remaining ratios and formats. 2. Add sound and captions. 3. Make reduced-motion versions. 4. Check the flashing rule.

**You are done when:** All formats delivered with accessibility versions.$x44$),
  ($sl45$motion$sl45$, 59, $x45$

**Steps:** 1. Collect time-coded feedback from two people. 2. Revise and keep a version log. 3. Finish the asset licence log. 4. Re-check the delivery specs.

**You are done when:** Critique, version log and a complete licence log.$x45$),
  ($sl46$motion$sl46$, 77, $x46$

**Steps:** 1. Animate the hero piece to a professional standard. 2. Follow your timing tokens and easing. 3. Review frame by frame for glitches. 4. Export and test on target devices.

**You are done when:** A polished hero animation that follows your system.$x46$),
  ($sl47$motion$sl47$, 79, $x47$

**Steps:** 1. Gather feedback and decide what to change. 2. Revise and re-export. 3. Complete the asset and licence register. 4. Organise the files and write a usage guide.

**You are done when:** Final files, a register and a short guide.$x47$),
  ($sl48$research$sl48$, 57, $x48$

**Steps:** 1. Collect your data or evidence following the plan. 2. Log decisions and problems as they happen. 3. Clean and check quality with counts before and after. 4. Save an analysis log another person could follow.

**You are done when:** Data summary plus an analysis log.$x48$),
  ($sl49$research$sl49$, 77, $x49$

**Steps:** 1. Collect according to your plan and ethics rules. 2. Keep a decision log. 3. Check quality: duplicates, gaps, odd values. 4. Record counts before and after cleaning.

**You are done when:** A quality log and a clean dataset.$x49$),
  ($sl50$research$sl50$, 79, $x50$

**Steps:** 1. Draft the report with the answer first. 2. Give it to one expert for critique. 3. Respond in writing to each point. 4. Revise and note what you changed and why.

**You are done when:** A revised report and your written response to the critique.$x50$)
  ) as v(slug, n, extra), public.track t
 where t.id = d.track_id and t.slug = v.slug and d.day_number = v.n
   and d.lesson_md not like '%**You are done when:**%';
