-- Motion graphics Skill Labs (days 91-120). Published; appended after the core path.
insert into public.day
  (track_id, tier_id, day_number, title, objective, lesson_md, skill_focus, assignment_md, rubric,
   est_minutes, is_published, credit_budget, submission_type, ai_evaluate, requires_review)
select t.id, ti.id, v.n, v.title, v.objective, v.lesson_md, v.skill_focus, v.assignment_md, v.rubric,
       v.est_minutes, true, null, v.submission_type, v.ai_evaluate, v.requires_review
from public.track t
join public.tier ti on ti.track_id = t.id and ti.slug = 'grandmaster'
cross join (values
  (91, $t91a$Skill Lab: Squash, stretch and weight$t91a$, $t91b$Give objects believable weight and flexibility.$t91b$, $t91c$Squash and stretch shows how heavy or soft something is: a ball stretches as it falls fast and squashes on impact, keeping its volume. Heavier objects accelerate slowly and settle slowly; light ones move quickly and bounce. Keep the effect subtle for professional graphics and stronger for playful ones.

**Worked example:** A bouncing ball at three weights: bowling ball (barely squashes), tennis ball, balloon.

**Common mistake:** Stretching so far that the shape changes volume and looks broken.$t91c$, $t91d$Skill Lab: Squash, stretch and weight$t91d$, $t91e$Animate one shape as three different materials. Submit the clip and a note on the timing and squash values for each.

**Sharing:** upload the animation and paste the link, plus key frames as direct image links. Animation is checked by a person.$t91e$, $t91f$[{"criterion": "Three materials distinct", "max_points": 40, "guidance": "Clear."}, {"criterion": "Volume preserved", "max_points": 30, "guidance": "Believable."}, {"criterion": "Notes accurate", "max_points": 30, "guidance": "Parameters."}]$t91f$::jsonb, 45, 'link', false, false),
  (92, $t92a$Skill Lab: Arcs, follow-through and overlap$t92a$, $t92b$Make motion feel organic.$t92b$, $t92c$Natural movement travels in arcs, not straight lines. Parts of an object do not stop at the same time: follow-through and overlapping action let hair, tails and text trail slightly behind the main move. Offset layers by a few frames.

**Worked example:** A title slides in and its subtitle arrives four frames later, settling with a tiny overshoot.

**Common mistake:** Moving everything in perfectly straight lines and stopping together.$t92c$, $t92d$Skill Lab: Arcs, follow-through and overlap$t92d$, $t92e$Animate a card sliding into place with an arc, overlap on two elements and a subtle settle. Submit the clip and describe each principle used.

**Sharing:** upload the animation and paste the link, plus key frames as direct image links. Animation is checked by a person.$t92e$, $t92f$[{"criterion": "Arc and overlap visible", "max_points": 45, "guidance": "Present."}, {"criterion": "Restraint", "max_points": 30, "guidance": "Subtle."}, {"criterion": "Principles named", "max_points": 25, "guidance": "Correct."}]$t92f$::jsonb, 45, 'link', false, false),
  (93, $t93a$Skill Lab: Anticipation, staging and appeal$t93a$, $t93b$Direct attention and prepare the viewer.$t93b$, $t93c$Anticipation is a small opposite move before the main action so viewers expect it. Staging means only one thing moves for the main point at a time, with clear silhouettes and space. Appeal is clarity and charm in shapes and timing.

**Worked example:** A button dips one pixel before it pops up; everything else on screen stays still.

**Common mistake:** Animating many elements at once so nothing reads.$t93c$, $t93d$Skill Lab: Anticipation, staging and appeal$t93d$, $t93e$Animate a three-element sequence where only one element leads at a time. Submit the clip and a staging diagram.

**Sharing:** upload the animation and paste the link, plus key frames as direct image links. Animation is checked by a person.$t93e$, $t93f$[{"criterion": "One focus at a time", "max_points": 45, "guidance": "Clear."}, {"criterion": "Anticipation used", "max_points": 30, "guidance": "Present."}, {"criterion": "Diagram matches", "max_points": 25, "guidance": "Consistent."}]$t93f$::jsonb, 45, 'link', false, false),
  (94, $t94a$Skill Lab: Timing, spacing and easing curves$t94a$, $t94b$Control feel with numbers.$t94b$, $t94c$Timing is how many frames a move takes; spacing is how the distance changes across those frames. Ease curves shape spacing: ease-out for arrivals, ease-in for exits, ease-in-out for repositioning. Build a small set of easing curves and reuse them.

**Worked example:** A brand set: entrances 400 ms ease-out, exits 250 ms ease-in, repositioning 350 ms ease-in-out.

**Common mistake:** Using default easing on every move.$t94c$, $t94d$Skill Lab: Timing, spacing and easing curves$t94d$, $t94e$Create and document a set of four easing curves and animate the same object with each. Submit the clip and the curve values.

**Sharing:** upload the animation and paste the link, plus key frames as direct image links. Animation is checked by a person.$t94e$, $t94f$[{"criterion": "Curves documented", "max_points": 40, "guidance": "Specific."}, {"criterion": "Difference visible", "max_points": 35, "guidance": "Clear."}, {"criterion": "Reasons given", "max_points": 25, "guidance": "Reasoned."}]$t94f$::jsonb, 45, 'link', false, false),
  (95, $t95a$Skill Lab: Lab 1 project: a principles showcase reel$t95a$, $t95b$Demonstrate the principles in one polished piece.$t95b$, $t95c$Show Lab 1. Produce a **20-second animation** that deliberately uses at least six of the twelve principles, with a labelled breakdown of where each appears.

Success looks like motion that feels alive without being busy.

**Worked example:** A character-free logo animation with squash, arcs, overlap, anticipation, staging and easing, each marked on a timeline.

**Common mistake:** Using principles by accident and being unable to point to them.

A person reviews your work and can ask for revisions.$t95c$, $t95d$Skill Lab: Lab 1 project: a principles showcase reel$t95d$, $t95e$Submit the animation, key frames and the labelled breakdown.

**Sharing:** upload the animation and paste the link, plus key frames as direct image links. Animation is checked by a person.$t95e$, $t95f$[{"criterion": "Principles applied", "max_points": 35, "guidance": "Six or more."}, {"criterion": "Polish and restraint", "max_points": 30, "guidance": "Clean."}, {"criterion": "Breakdown accurate", "max_points": 20, "guidance": "Clear."}, {"criterion": "Timing quality", "max_points": 15, "guidance": "Good."}]$t95f$::jsonb, 150, 'link', false, true),
  (96, $t96a$Skill Lab: The motion tool map$t96a$, $t96b$Choose the right tool for each job.$t96b$, $t96c$Different tools fit different jobs. After Effects is the deep, general-purpose standard. Jitter is a fast browser tool for interface and marketing motion. Cavalry is procedural and great for animating many items or data. Rive builds interactive animations that run inside apps. Lottie exports lightweight vector animation for the web. Learn one tool deeply before adding others, and check each tool's current pricing and licence. [CREAO](https://agent.creao.ai/@Sonofpeace) (referral link) is our recommended workspace for planning and generating assets.

**Worked example:** Job: 200 bars animating from a spreadsheet, choose a procedural tool; job: an animated onboarding tooltip in an app, choose Rive or Lottie.

**Common mistake:** Learning five tools shallowly instead of one well.$t96c$, $t96d$Skill Lab: The motion tool map$t96d$, $t96e$Build a table of five jobs, the best tool for each, why and the current cost. Submit it.$t96e$, $t96f$[{"criterion": "Jobs and tools matched", "max_points": 40, "guidance": "Sensible."}, {"criterion": "Facts current", "max_points": 30, "guidance": "Checked."}, {"criterion": "Learning path advised", "max_points": 30, "guidance": "Focused."}]$t96f$::jsonb, 45, 'text', false, false),
  (97, $t97a$Skill Lab: Interface motion and Lottie$t97a$, $t97b$Ship lightweight product animation.$t97b$, $t97c$Interface motion confirms actions, guides attention and explains changes. Keep it short (200 to 500 ms), use consistent easing and respect the reduced-motion setting. Export vector animation as Lottie for the web and check file size and fallbacks. Some places, such as email, do not support animation formats, so provide a static fallback.

**Worked example:** A success checkmark draws in 400 ms as a 6 KB Lottie with a static fallback for email.

**Common mistake:** Animating for email without a static fallback.$t97c$, $t97d$Skill Lab: Interface motion and Lottie$t97d$, $t97e$Create three micro-interactions with sizes and fallbacks documented. Submit clips and a table of sizes.

**Sharing:** upload the animation and paste the link, plus key frames as direct image links. Animation is checked by a person.$t97e$, $t97f$[{"criterion": "Short and consistent", "max_points": 35, "guidance": "Clear."}, {"criterion": "Fallbacks documented", "max_points": 35, "guidance": "Present."}, {"criterion": "Sizes small", "max_points": 30, "guidance": "Efficient."}]$t97f$::jsonb, 45, 'link', false, false),
  (98, $t98a$Skill Lab: Procedural and data-driven motion$t98a$, $t98b$Generate motion from rules and data.$t98b$, $t98c$Instead of keyframing each item, describe a rule and let the tool repeat it: stagger, noise, follow, and data-driven values from a sheet. Change the data and the animation updates. This is how one template makes hundreds of variants.

**Worked example:** A bar chart animation built from a spreadsheet; swapping the sheet makes a new version in a minute.

**Common mistake:** Hand-animating 50 items one by one.$t98c$, $t98d$Skill Lab: Procedural and data-driven motion$t98d$, $t98e$Build a data-driven animation with at least ten items and produce two variants by changing only the data.

**Sharing:** upload the animation and paste the link, plus key frames as direct image links. Animation is checked by a person.$t98e$, $t98f$[{"criterion": "Driven by data", "max_points": 40, "guidance": "Real."}, {"criterion": "Two variants", "max_points": 30, "guidance": "Produced."}, {"criterion": "Rule explained", "max_points": 30, "guidance": "Clear."}]$t98f$::jsonb, 45, 'link', false, false),
  (99, $t99a$Skill Lab: 3D basics for motion designers$t99a$, $t99b$Add depth with simple 3D.$t99b$, $t99c$Simple 3D adds depth: extruded shapes, lighting, a camera move and soft shadows. Keep scenes minimal, use a limited palette and match light direction. Tools such as Blender or Cinema 4D are common, and AI can generate assets, so check licences.

**Worked example:** An extruded logo turning slowly under one soft key light with a subtle ground shadow.

**Common mistake:** Adding many lights and reflective materials that slow rendering and muddy the look.$t99c$, $t99d$Skill Lab: 3D basics for motion designers$t99d$, $t99e$Create a 6-second 3D logo or object turntable. Submit the clip, render settings and a note on the lighting.

**Sharing:** upload the animation and paste the link, plus key frames as direct image links. Animation is checked by a person.$t99e$, $t99f$[{"criterion": "Reads as 3D", "max_points": 40, "guidance": "Depth."}, {"criterion": "Simple and clean", "max_points": 30, "guidance": "Controlled."}, {"criterion": "Settings noted", "max_points": 30, "guidance": "Documented."}]$t99f$::jsonb, 45, 'link', false, false),
  (100, $t100a$Skill Lab: Lab 2 project: one brief, three tools$t100a$, $t100b$Compare tools on the same animation.$t100b$, $t100c$Show Lab 2. Take **one 5-second animation brief** and build it in three tools or approaches, then compare quality, control, time, file size and cost.

A person reviews your work and can ask for revisions.

**Worked example:** Brief: a logo reveal; built in a browser tool, a keyframe tool and code or a procedural tool.

**Common mistake:** Comparing different briefs.

A person reviews your work and can ask for revisions.$t100c$, $t100d$Skill Lab: Lab 2 project: one brief, three tools$t100d$, $t100e$Submit the three results, a comparison table and your recommendation.

**Sharing:** upload the animation and paste the link, plus key frames as direct image links. Animation is checked by a person.$t100e$, $t100f$[{"criterion": "Fair comparison", "max_points": 35, "guidance": "Same brief."}, {"criterion": "Evidence", "max_points": 30, "guidance": "Measured."}, {"criterion": "Recommendation", "max_points": 20, "guidance": "Reasoned."}, {"criterion": "Craft", "max_points": 15, "guidance": "Good."}]$t100f$::jsonb, 150, 'link', false, true),
  (101, $t101a$Skill Lab: AI as a motion partner$t101a$, $t101b$Use AI to generate ideas and assets while you control the result.$t101b$, $t101c$A useful pairing is a generator that produces movement or assets cheaply and a control tool that makes them land exactly on brief. Use AI for storyboards, texture and background generation, rough timing and variations; do the final easing, timing and typography by hand. Check licences and never let generated motion contradict your motion language.

**Worked example:** Generate 8 background loops, choose one, then animate the title and easing yourself.

**Common mistake:** Shipping a generated clip with no control over timing.$t101c$, $t101d$Skill Lab: AI as a motion partner$t101d$, $t101e$Generate assets for a 10-second piece and document what was AI-made and what you controlled.

**Sharing:** upload the animation and paste the link, plus key frames as direct image links. Animation is checked by a person.$t101e$, $t101f$[{"criterion": "Roles clear", "max_points": 40, "guidance": "AI versus you."}, {"criterion": "Result on brief", "max_points": 30, "guidance": "Controlled."}, {"criterion": "Licences checked", "max_points": 30, "guidance": "Documented."}]$t101f$::jsonb, 45, 'link', false, false),
  (102, $t102a$Skill Lab: Generative video for motion design$t102a$, $t102b$Use video generation for textures and transitions.$t102b$, $t102c$Video generators can make abstract textures, light leaks and transitions. Ask for seamless loops, plain backgrounds and no text. Treat outputs as raw material to grade, mask and blend, not finished pieces.

**Worked example:** A generated ink-in-water loop used as a mask for a title reveal.

**Common mistake:** Using generated text or logos inside the clip.$t102c$, $t102d$Skill Lab: Generative video for motion design$t102d$, $t102e$Create two generated textures and use them in a title reveal. Submit the clip and prompts.

**Sharing:** upload the animation and paste the link, plus key frames as direct image links. Animation is checked by a person.$t102e$, $t102f$[{"criterion": "Textures useful", "max_points": 35, "guidance": "Fit."}, {"criterion": "Blended well", "max_points": 35, "guidance": "Integrated."}, {"criterion": "Prompts recorded", "max_points": 30, "guidance": "Given."}]$t102f$::jsonb, 45, 'link', false, false),
  (103, $t103a$Skill Lab: Voice and sound for motion$t103a$, $t103b$Add narration and sound.$t103b$, $t103c$Sound design makes motion land. Sync hits to key moments, keep music under voice, and record or generate voice with proper consent. Provide captions for spoken content.

**Worked example:** A whoosh at 0.4 s and a soft click when the icon lands; music at minus 20 dB under voice.

**Common mistake:** Sound effects a few frames off the movement.$t103c$, $t103d$Skill Lab: Voice and sound for motion$t103d$, $t103e$Add sound and captions to a 20-second animation and list the licences.

**Sharing:** upload the animation and paste the link, plus key frames as direct image links. Animation is checked by a person.$t103e$, $t103f$[{"criterion": "Sync tight", "max_points": 40, "guidance": "On beat."}, {"criterion": "Captions", "max_points": 30, "guidance": "Accurate."}, {"criterion": "Licences", "max_points": 30, "guidance": "Documented."}]$t103f$::jsonb, 45, 'link', false, false),
  (104, $t104a$Skill Lab: Templates and batch variants$t104a$, $t104b$Scale one design into many.$t104b$, $t104c$Build templates with placeholders for text, colour and images. Keep a naming scheme and export settings. Test with three very different inputs (short, long, different language).

**Worked example:** A social template producing 12 event announcements in 12 languages.

**Common mistake:** A template that breaks on a longer name.$t104c$, $t104d$Skill Lab: Templates and batch variants$t104d$, $t104e$Build a template and produce three variants including a stress test. Submit them and the stress notes.

**Sharing:** upload the animation and paste the link, plus key frames as direct image links. Animation is checked by a person.$t104e$, $t104f$[{"criterion": "Template robust", "max_points": 40, "guidance": "Stress tested."}, {"criterion": "Variants distinct", "max_points": 30, "guidance": "Different."}, {"criterion": "Naming and exports", "max_points": 30, "guidance": "Organised."}]$t104f$::jsonb, 45, 'link', false, false),
  (105, $t105a$Skill Lab: Lab 3 project: an AI-assisted animated brand kit$t105a$, $t105b$Deliver a scalable animation set.$t105b$, $t105c$Show Lab 3. Deliver a **brand animation kit**: logo sting, title template, lower third and three social variants, using AI-made assets with documented control and sound with captions.

A person reviews your work and can ask for revisions.

**Worked example:** A cafe brand kit where a single template produces weekly specials automatically.

**Common mistake:** No record of what was generated.

A person reviews your work and can ask for revisions.$t105c$, $t105d$Skill Lab: Lab 3 project: an AI-assisted animated brand kit$t105d$, $t105e$Submit the kit, asset log with licences, template stress tests and captions.

**Sharing:** upload the animation and paste the link, plus key frames as direct image links. Animation is checked by a person.$t105e$, $t105f$[{"criterion": "Consistency", "max_points": 30, "guidance": "One system."}, {"criterion": "Template quality", "max_points": 25, "guidance": "Robust."}, {"criterion": "Documentation and licences", "max_points": 25, "guidance": "Complete."}, {"criterion": "Craft", "max_points": 20, "guidance": "Polished."}]$t105f$::jsonb, 180, 'link', false, true),
  (106, $t106a$Skill Lab: Explainer structure and script$t106a$, $t106b$Explain complex ideas simply.$t106b$, $t106c$Use a structure: hook, problem, idea, three steps, result, call to action. Write voiceover first, then design visuals for each line. One idea per scene, plain language, and test comprehension with a non-expert.

**Worked example:** A 45-second explainer on how vaccines train the immune system, with one metaphor and three steps.

**Common mistake:** Cramming every detail into the script.$t106c$, $t106d$Skill Lab: Explainer structure and script$t106d$, $t106e$Write a 45-second explainer script with a scene table (line, visual, motion, seconds).$t106e$, $t106f$[{"criterion": "One idea per scene", "max_points": 40, "guidance": "Focused."}, {"criterion": "Plain language", "max_points": 30, "guidance": "Simple."}, {"criterion": "Scene table complete", "max_points": 30, "guidance": "Detailed."}]$t106f$::jsonb, 45, 'text', false, false),
  (107, $t107a$Skill Lab: Metaphor, icons and visual language$t107a$, $t107b$Choose visuals that carry meaning.$t107b$, $t107c$A good metaphor makes an abstract idea tangible: a pipe for data, a shield for security. Keep a consistent icon style (line weight, corner radius), limited palette and clear labels. Avoid clichés that mislead.

**Worked example:** Data as water: pipes, valves and a tank with consistent 3 px lines.

**Common mistake:** Mixing icon styles from different sets.$t107c$, $t107d$Skill Lab: Metaphor, icons and visual language$t107d$, $t107e$Design an icon and metaphor set of eight elements for one topic and animate three.

**Sharing:** upload the animation and paste the link, plus key frames as direct image links. Animation is checked by a person.$t107e$, $t107f$[{"criterion": "Consistent style", "max_points": 40, "guidance": "Uniform."}, {"criterion": "Metaphor clear", "max_points": 35, "guidance": "Understandable."}, {"criterion": "Animation clean", "max_points": 25, "guidance": "Smooth."}]$t107f$::jsonb, 45, 'link', false, false),
  (108, $t108a$Skill Lab: Data storytelling in motion$t108a$, $t108b$Animate charts honestly.$t108b$, $t108c$Reveal one series at a time, highlight the key point, keep axes honest, cite the source and end on the takeaway. Do not exaggerate change through scale.

**Worked example:** A growth line drawn over 3 seconds with the key month highlighted and the source on the last frame.

**Common mistake:** Cutting off the axis to inflate a change.$t108c$, $t108d$Skill Lab: Data storytelling in motion$t108d$, $t108e$Animate two charts from real public data with sources. Submit clips and sources.

**Sharing:** upload the animation and paste the link, plus key frames as direct image links. Animation is checked by a person.$t108e$, $t108f$[{"criterion": "Honest scales", "max_points": 40, "guidance": "Accurate."}, {"criterion": "Clear takeaway", "max_points": 30, "guidance": "Direct."}, {"criterion": "Sources shown", "max_points": 30, "guidance": "Cited."}]$t108f$::jsonb, 45, 'link', false, false),
  (109, $t109a$Skill Lab: Accessibility and reduced motion$t109a$, $t109b$Design for everyone.$t109b$, $t109c$Avoid flashing more than three times a second, offer static or reduced versions, add captions and description, and never rely on motion alone for meaning. Test with reduced-motion settings.

**Worked example:** Parallax replaced by fades and the flashing intro removed in the reduced-motion version.

**Common mistake:** One version only, with strobing effects.$t109c$, $t109d$Skill Lab: Accessibility and reduced motion$t109d$, $t109e$Produce a reduced-motion version of one piece and a short accessibility checklist.

**Sharing:** upload the animation and paste the link, plus key frames as direct image links. Animation is checked by a person.$t109e$, $t109f$[{"criterion": "Reduced version works", "max_points": 40, "guidance": "Tested."}, {"criterion": "Checklist real", "max_points": 30, "guidance": "Specific."}, {"criterion": "Meaning kept", "max_points": 30, "guidance": "Preserved."}]$t109f$::jsonb, 45, 'link', false, false),
  (110, $t110a$Skill Lab: Lab 4 project: a 60-second explainer$t110a$, $t110b$Deliver a complete explainer with accessibility.$t110b$, $t110c$Show Lab 4. Produce a **60-second explainer** with script, icon set, animated data, sound, captions and a reduced-motion version.

A person reviews your work and can ask for revisions.

**Worked example:** An explainer on how solar panels work, with a clear metaphor and one honest chart.

**Common mistake:** No comprehension test with a real viewer.

A person reviews your work and can ask for revisions.$t110c$, $t110d$Skill Lab: Lab 4 project: a 60-second explainer$t110d$, $t110e$Submit the explainer, script, icon set, reduced-motion version, sources and a comprehension test note.

**Sharing:** upload the animation and paste the link, plus key frames as direct image links. Animation is checked by a person.$t110e$, $t110f$[{"criterion": "Explains clearly", "max_points": 30, "guidance": "Understood."}, {"criterion": "Craft and sound", "max_points": 25, "guidance": "Polished."}, {"criterion": "Accessibility", "max_points": 25, "guidance": "Handled."}, {"criterion": "Honest data", "max_points": 20, "guidance": "Sourced."}]$t110f$::jsonb, 210, 'link', false, true),
  (111, $t111a$Skill Lab: Briefs, storyboards and approvals$t111a$, $t111b$Manage a project from brief to sign-off.$t111b$, $t111c$Agree the brief in writing, get storyboard and style-frame approval before animating, and lock the timing (animatic) before polish. Record approvals so changes after sign-off are paid work.

**Worked example:** Approvals: brief, storyboard, animatic, final, each dated and confirmed by email.

**Common mistake:** Animating before the storyboard is approved.$t111c$, $t111d$Skill Lab: Briefs, storyboards and approvals$t111d$, $t111e$Write a production plan for a 30-second animation with approval gates and revision limits.$t111e$, $t111f$[{"criterion": "Gates placed", "max_points": 40, "guidance": "Sensible."}, {"criterion": "Revision terms", "max_points": 30, "guidance": "Clear."}, {"criterion": "Timeline realistic", "max_points": 30, "guidance": "Feasible."}]$t111f$::jsonb, 45, 'text', false, false),
  (112, $t112a$Skill Lab: Delivery specs and formats$t112a$, $t112b$Export correctly for every use.$t112b$, $t112c$Match resolution, frame rate, codec and colour space to the destination. Provide alpha versions where needed, still frames, captioned versions and a project archive. Test playback on the target device.

**Worked example:** 1080x1920 H.264 for stories, ProRes 4444 with alpha for the editor, a static PNG for email.

**Common mistake:** Exporting once and hoping it works everywhere.$t112c$, $t112d$Skill Lab: Delivery specs and formats$t112d$, $t112e$Create a delivery spec sheet and export one animation in three formats with sizes.

**Sharing:** upload the animation and paste the link, plus key frames as direct image links. Animation is checked by a person.$t112e$, $t112f$[{"criterion": "Specs correct", "max_points": 40, "guidance": "Right for each use."}, {"criterion": "Sizes reported", "max_points": 30, "guidance": "Numbers."}, {"criterion": "Playback tested", "max_points": 30, "guidance": "Checked."}]$t112f$::jsonb, 45, 'link', false, false),
  (113, $t113a$Skill Lab: Pricing and contracts for motion work$t113a$, $t113b$Sell your work fairly.$t113b$, $t113c$Price per finished second and complexity, with rounds of revision, formats and rights defined. Charge for rush and extra rounds. Put ownership, AI-tool use and licence of assets in writing.

**Worked example:** 30-second explainer 1,500, two rounds, three formats, delivery in 10 days; extra round 150.

**Common mistake:** Unlimited revisions.$t113c$, $t113d$Skill Lab: Pricing and contracts for motion work$t113d$, $t113e$Write a quote and short agreement for a 30-second animation.$t113e$, $t113f$[{"criterion": "Scope clear", "max_points": 40, "guidance": "Precise."}, {"criterion": "Rights and AI-use stated", "max_points": 30, "guidance": "Included."}, {"criterion": "Price logic", "max_points": 30, "guidance": "Reasoned."}]$t113f$::jsonb, 45, 'text', false, false),
  (114, $t114a$Skill Lab: Portfolio and reel$t114a$, $t114b$Show your best motion work.$t114b$, $t114c$Lead with your best piece, keep the reel under 60 seconds, show breakdowns of how you made it and credit tools honestly. Include a short case study with the brief and result.

**Worked example:** A 45-second reel and three breakdown clips showing layers and easing.

**Common mistake:** A long reel with average pieces.$t114c$, $t114d$Skill Lab: Portfolio and reel$t114d$, $t114e$Plan your reel and write two breakdown captions.$t114e$, $t114f$[{"criterion": "Curated", "max_points": 40, "guidance": "Selective."}, {"criterion": "Breakdowns", "max_points": 30, "guidance": "Show process."}, {"criterion": "Honest credits", "max_points": 30, "guidance": "Tools named."}]$t114f$::jsonb, 45, 'text', false, false),
  (115, $t115a$Skill Lab: Lab 5 project: a client-ready animation package$t115a$, $t115b$Deliver as if to a client.$t115b$, $t115c$Show Lab 5. Deliver a **client package**: production plan, approved storyboard, final animation in three formats, delivery spec, quote and agreement.

A person reviews your work and can ask for revisions.

**Worked example:** A 30-second product promo with a full approval trail.

**Common mistake:** Missing approvals and final specs.

A person reviews your work and can ask for revisions.$t115c$, $t115d$Skill Lab: Lab 5 project: a client-ready animation package$t115d$, $t115e$Submit all documents and the three exports.

**Sharing:** upload the animation and paste the link, plus key frames as direct image links. Animation is checked by a person.$t115e$, $t115f$[{"criterion": "Meets brief", "max_points": 30, "guidance": "On target."}, {"criterion": "Professional process", "max_points": 30, "guidance": "Documented."}, {"criterion": "Technical delivery", "max_points": 25, "guidance": "Correct."}, {"criterion": "Business terms", "max_points": 15, "guidance": "Clear."}]$t115f$::jsonb, 210, 'link', false, true),
  (116, $t116a$Skill Lab: Finding motion work$t116a$, $t116b$Look for clients and studios.$t116b$, $t116c$Choose a niche (product explainers, social ads, title design), show relevant work, and reach out with a personal, useful note. Freelance boards, studios and agencies each need different pitches.

**Worked example:** Niche: product explainers for software startups; outreach with a tailored 15-second idea.

**Common mistake:** Sending the same reel to everyone.$t116c$, $t116d$Skill Lab: Finding motion work$t116d$, $t116e$Choose a niche and write outreach to five specific targets with a tailored idea each.$t116e$, $t116f$[{"criterion": "Niche clear", "max_points": 30, "guidance": "Defined."}, {"criterion": "Outreach personal", "max_points": 40, "guidance": "Tailored."}, {"criterion": "Ideas useful", "max_points": 30, "guidance": "Specific."}]$t116f$::jsonb, 45, 'text', false, false),
  (117, $t117a$Skill Lab: Staying current and growing$t117a$, $t117b$Keep learning without chasing every tool.$t117b$, $t117c$Tools change quickly. Keep principles at the centre, learn one new tool a quarter, follow a few good sources and rebuild an old project in a new tool to compare. Keep a learning log.

**Worked example:** Quarterly plan: learn a procedural tool by rebuilding your title template in it.

**Common mistake:** Switching tools every week.$t117c$, $t117d$Skill Lab: Staying current and growing$t117d$, $t117e$Write a six-month learning plan with three goals and how you will measure each.$t117e$, $t117f$[{"criterion": "Goals specific", "max_points": 40, "guidance": "Measurable."}, {"criterion": "Focus", "max_points": 30, "guidance": "Not scattered."}, {"criterion": "Log planned", "max_points": 30, "guidance": "Present."}]$t117f$::jsonb, 45, 'text', false, false),
  (118, $t118a$Skill Lab: Ethics: AI, credit and originality$t118a$, $t118b$Work honestly.$t118b$, $t118c$Credit tools and assets, avoid copying others' styles too closely, be clear about AI use in briefs, and never mislead with fabricated data or footage. Respect licences of fonts, music and generated content.

**Worked example:** A credits line and asset register delivered with every project.

**Common mistake:** Passing off generated work as hand-made.$t118c$, $t118d$Skill Lab: Ethics: AI, credit and originality$t118d$, $t118e$Write your motion ethics statement and an asset-register template.$t118e$, $t118f$[{"criterion": "Specific commitments", "max_points": 40, "guidance": "Concrete."}, {"criterion": "Register usable", "max_points": 30, "guidance": "Practical."}, {"criterion": "Honesty about AI", "max_points": 30, "guidance": "Clear."}]$t118f$::jsonb, 45, 'text', false, false),
  (119, $t119a$Skill Lab: Community and feedback$t119a$, $t119b$Learn from other creators.$t119b$, $t119c$Share work-in-progress, ask specific questions and give useful feedback. Post breakdowns, join challenges and credit inspirations. Handle criticism by asking what goal it serves.

**Worked example:** Post a breakdown with a question: 'Does the settle feel too slow?'

**Common mistake:** Asking for 'thoughts?' with no question.$t119c$, $t119d$Skill Lab: Community and feedback$t119d$, $t119e$Share one piece in the NEXTGEN Discord with a specific question and summarise the feedback you received.$t119e$, $t119f$[{"criterion": "Question specific", "max_points": 40, "guidance": "Clear."}, {"criterion": "Feedback summarised", "max_points": 30, "guidance": "Honest."}, {"criterion": "Action taken", "max_points": 30, "guidance": "Applied."}]$t119f$::jsonb, 45, 'text', false, false),
  (120, $t120a$Skill Lab: Lab 6 project: your motion showcase$t120a$, $t120b$Present your best work and services.$t120b$, $t120c$Show Lab 6. Publish a **showcase**: a 45-second reel, two breakdowns, your services and prices, your ethics statement and your learning plan. Share it in the NEXTGEN Discord.

A person reviews your work and can ask for revisions.

**Worked example:** A page with the reel, breakdowns, three packages and a contact button.

**Common mistake:** A reel with no breakdown.

A person reviews your work and can ask for revisions.$t120c$, $t120d$Skill Lab: Lab 6 project: your motion showcase$t120d$, $t120e$Submit the reel link, breakdowns, price sheet, ethics statement and a 150-word reflection.

**Sharing:** upload the animation and paste the link, plus key frames as direct image links. Animation is checked by a person.$t120e$, $t120f$[{"criterion": "Quality of work", "max_points": 35, "guidance": "Strong."}, {"criterion": "Business readiness", "max_points": 25, "guidance": "Clear."}, {"criterion": "Ethics", "max_points": 20, "guidance": "Handled."}, {"criterion": "Reflection", "max_points": 20, "guidance": "Specific."}]$t120f$::jsonb, 180, 'link', false, true)
) as v(n, title, objective, lesson_md, skill_focus, assignment_md, rubric, est_minutes, submission_type, ai_evaluate, requires_review)
where t.slug = 'motion'
on conflict (track_id, day_number) do nothing;
