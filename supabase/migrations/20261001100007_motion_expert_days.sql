-- Motion graphics, Expert tier (days 61-80). Authored content, UNPUBLISHED until a person reviews it in Admin.
insert into public.day
  (track_id, tier_id, day_number, title, objective, lesson_md, skill_focus, assignment_md, rubric,
   est_minutes, is_published, credit_budget, submission_type, ai_evaluate, requires_review)
select t.id, ti.id, v.n, v.title, v.objective, v.lesson_md, v.skill_focus, v.assignment_md, v.rubric,
       v.est_minutes, false, null, v.submission_type, v.ai_evaluate, v.requires_review
from public.track t
join public.tier ti on ti.track_id = t.id and ti.slug = 'expert'
cross join (values
  (61, $t61a$Motion design language for a brand$t61a$, $t61b$Define how a brand moves.$t61b$, $t61c$Movement carries personality: precise and quick, or soft and slow. Define principles, timing tokens, easing families and do/don't examples.$t61c$, $t61d$Motion design language for a brand$t61d$, $t61e$Write a motion language (six principles, timing tokens, easings) and show three examples.

**Sharing:** upload and paste the link. Animation is checked by a person.$t61e$, $t61f$[{"criterion": "Principles clear", "max_points": 35, "guidance": "Specific."}, {"criterion": "Tokens usable", "max_points": 35, "guidance": "Numbers."}, {"criterion": "Examples follow", "max_points": 30, "guidance": "Consistent."}]$t61f$::jsonb, 60, 'link', false, false),
  (62, $t62a$Design-to-motion pipelines$t62a$, $t62b$Move from static to animated smoothly.$t62b$, $t62c$Prepare layered, named source files, export assets consistently and keep design and motion in sync through versioned handoffs.$t62c$, $t62d$Design-to-motion pipelines$t62d$, $t62e$Document a handoff pipeline and demonstrate with one animated screen.

**Sharing:** upload and paste the link. Animation is checked by a person.$t62e$, $t62f$[{"criterion": "Handoff clear", "max_points": 40, "guidance": "Organised."}, {"criterion": "Sync maintained", "max_points": 30, "guidance": "Versioned."}, {"criterion": "Result good", "max_points": 30, "guidance": "Works."}]$t62f$::jsonb, 60, 'link', false, false),
  (63, $t63a$Expressions, rigs and procedural animation$t63a$, $t63b$Automate repetitive motion.$t63b$, $t63c$Use controllers, expressions or code-driven animation to make systems that update when data or text changes.$t63c$, $t63d$Expressions, rigs and procedural animation$t63d$, $t63e$Build a procedural animation that responds to changing text or data; show three variants.

**Sharing:** upload and paste the link. Animation is checked by a person.$t63e$, $t63f$[{"criterion": "Procedural works", "max_points": 40, "guidance": "Flexible."}, {"criterion": "Variants", "max_points": 30, "guidance": "Three."}, {"criterion": "Documented", "max_points": 30, "guidance": "Clear."}]$t63f$::jsonb, 90, 'link', false, false),
  (64, $t64a$Real-time and interactive motion$t64a$, $t64b$Animate for apps and web.$t64b$, $t64c$Consider frame budgets, state changes, interruptibility and accessibility. Prototype and test on real devices.$t64c$, $t64d$Real-time and interactive motion$t64d$, $t64e$Prototype an interactive animation and test on two devices.

**Sharing:** upload and paste the link. Animation is checked by a person.$t64e$, $t64f$[{"criterion": "Interactive", "max_points": 35, "guidance": "Responsive."}, {"criterion": "Tested on devices", "max_points": 40, "guidance": "Real."}, {"criterion": "Accessible", "max_points": 25, "guidance": "Considered."}]$t64f$::jsonb, 90, 'link', false, false),
  (65, $t65a$Expert project 1: a motion language and system$t65a$, $t65b$Deliver a system a team can use.$t65b$, $t65c$Show Module 1. Deliver a **motion system**: language, tokens, handoff pipeline, procedural template and interactive prototype.

A person reviews your work and can ask for revisions.$t65c$, $t65d$Expert project 1: a motion language and system$t65d$, $t65e$Submit all parts with examples.

**Sharing:** upload and paste the link. Animation is checked by a person.$t65e$, $t65f$[{"criterion": "Language and tokens", "max_points": 30, "guidance": "Clear."}, {"criterion": "Pipeline and template", "max_points": 30, "guidance": "Usable."}, {"criterion": "Prototype", "max_points": 20, "guidance": "Works."}, {"criterion": "Documentation", "max_points": 20, "guidance": "Complete."}]$t65f$::jsonb, 240, 'link', false, true),
  (66, $t66a$Advanced 3D and compositing$t66a$, $t66b$Build convincing hybrid scenes.$t66b$, $t66c$Match camera, light and grain between 3D, footage and generated layers. Use depth passes and masks for control.$t66c$, $t66d$Advanced 3D and compositing$t66d$, $t66e$Create a 10-second composite with matched camera and light; document steps.

**Sharing:** upload and paste the link. Animation is checked by a person.$t66e$, $t66f$[{"criterion": "Believable", "max_points": 40, "guidance": "Matched."}, {"criterion": "Control", "max_points": 30, "guidance": "Passes."}, {"criterion": "Documented", "max_points": 30, "guidance": "Steps."}]$t66f$::jsonb, 120, 'link', false, false),
  (67, $t67a$Broadcast and title design$t67a$, $t67b$Design titles and lower thirds.$t67b$, $t67c$Templates for repeat use, safe areas, legibility at speed and localisation-ready text.$t67c$, $t67d$Broadcast and title design$t67d$, $t67e$Design a title package (opening, lower third, end card) with localisation notes.

**Sharing:** upload and paste the link. Animation is checked by a person.$t67e$, $t67f$[{"criterion": "Package cohesive", "max_points": 40, "guidance": "Consistent."}, {"criterion": "Legible", "max_points": 30, "guidance": "Clear."}, {"criterion": "Localisable", "max_points": 30, "guidance": "Ready."}]$t67f$::jsonb, 60, 'link', false, false),
  (68, $t68a$Data journalism and explainers$t68a$, $t68b$Explain complex ideas honestly.$t68b$, $t68c$Show sources, uncertainty and scale honestly. Test comprehension with a non-expert and revise.$t68c$, $t68d$Data journalism and explainers$t68d$, $t68e$Produce a 40-second data explainer with sources and a comprehension test result.

**Sharing:** upload and paste the link. Animation is checked by a person.$t68e$, $t68f$[{"criterion": "Honest data", "max_points": 40, "guidance": "Accurate."}, {"criterion": "Comprehension tested", "max_points": 35, "guidance": "Real."}, {"criterion": "Clear design", "max_points": 25, "guidance": "Readable."}]$t68f$::jsonb, 90, 'link', false, false),
  (69, $t69a$Audio-visual systems and music visuals$t69a$, $t69b$Create synchronised visuals.$t69b$, $t69c$Drive visuals from audio analysis and design intensity arcs across a track.$t69c$, $t69d$Audio-visual systems and music visuals$t69d$, $t69e$Create a 45-second audio-driven piece with a licensed track.

**Sharing:** upload and paste the link. Animation is checked by a person.$t69e$, $t69f$[{"criterion": "Sync", "max_points": 40, "guidance": "Tight."}, {"criterion": "Arc", "max_points": 30, "guidance": "Dynamic."}, {"criterion": "Licence", "max_points": 30, "guidance": "Documented."}]$t69f$::jsonb, 90, 'link', false, false),
  (70, $t70a$Expert project 2: a broadcast-grade package$t70a$, $t70b$Deliver titles, explainer and audio-visual piece.$t70b$, $t70c$Show Module 2. Deliver a **broadcast-grade package** with title system, data explainer and audio-visual piece.

A person reviews your work and can ask for revisions.$t70c$, $t70d$Expert project 2: a broadcast-grade package$t70d$, $t70e$Submit all pieces with notes.

**Sharing:** upload and paste the link. Animation is checked by a person.$t70e$, $t70f$[{"criterion": "Craft", "max_points": 30, "guidance": "Polished."}, {"criterion": "Honesty and clarity", "max_points": 25, "guidance": "Accurate."}, {"criterion": "Consistency", "max_points": 25, "guidance": "One system."}, {"criterion": "Rights", "max_points": 20, "guidance": "Documented."}]$t70f$::jsonb, 240, 'link', false, true),
  (71, $t71a$Accessibility standards and reduced-motion design$t71a$, $t71b$Design safely for everyone.$t71b$, $t71c$Follow guidance on flashing, parallax and vestibular triggers. Provide static and reduced versions and captions.$t71c$, $t71d$Accessibility standards and reduced-motion design$t71d$, $t71e$Create reduced-motion variants for two animations and test them.

**Sharing:** upload and paste the link. Animation is checked by a person.$t71e$, $t71f$[{"criterion": "Variants work", "max_points": 40, "guidance": "Tested."}, {"criterion": "Guidance followed", "max_points": 35, "guidance": "Cited."}, {"criterion": "Meaning kept", "max_points": 25, "guidance": "Preserved."}]$t71f$::jsonb, 75, 'link', false, false),
  (72, $t72a$Licensing, IP and AI asset provenance$t72a$, $t72b$Keep a clean rights record.$t72b$, $t72c$Track every asset, tool licence and permission. Document provenance for generated content and know client contract needs.$t72c$, $t72d$Licensing, IP and AI asset provenance$t72d$, $t72e$Create a provenance and licence register for a project.$t72e$, $t72f$[{"criterion": "Complete", "max_points": 45, "guidance": "Every asset."}, {"criterion": "Terms understood", "max_points": 30, "guidance": "Correct."}, {"criterion": "Proof kept", "max_points": 25, "guidance": "Linked."}]$t72f$::jsonb, 60, 'text', false, false),
  (73, $t73a$Studio pricing and production management$t73a$, $t73b$Run motion work profitably.$t73b$, $t73c$Estimate by second, complexity and revisions, schedule with buffers and track hours against quotes.$t73c$, $t73d$Studio pricing and production management$t73d$, $t73e$Create a quote, schedule and time tracker for a 30-second piece.$t73e$, $t73f$[{"criterion": "Estimate logic", "max_points": 40, "guidance": "Sound."}, {"criterion": "Buffers", "max_points": 30, "guidance": "Included."}, {"criterion": "Tracking", "max_points": 30, "guidance": "Real."}]$t73f$::jsonb, 60, 'text', false, false),
  (74, $t74a$Client presentation and feedback management$t74a$, $t74b$Present work persuasively.$t74b$, $t74c$Frame rationale, show options, control feedback and record approvals.$t74c$, $t74d$Client presentation and feedback management$t74d$, $t74e$Write a presentation script and feedback protocol for one project.$t74e$, $t74f$[{"criterion": "Rationale clear", "max_points": 40, "guidance": "Reasoned."}, {"criterion": "Feedback control", "max_points": 35, "guidance": "Defined."}, {"criterion": "Approvals recorded", "max_points": 25, "guidance": "Logged."}]$t74f$::jsonb, 60, 'text', false, false),
  (75, $t75a$Expert project 3: a studio-ready kit$t75a$, $t75b$Deliver accessibility, provenance and business documents.$t75b$, $t75c$Show Module 3. Deliver a **studio kit**: reduced-motion set, provenance register, quote package and presentation.

A person reviews your work and can ask for revisions.$t75c$, $t75d$Expert project 3: a studio-ready kit$t75d$, $t75e$Submit all parts.

**Sharing:** upload and paste the link. Animation is checked by a person.$t75e$, $t75f$[{"criterion": "Accessibility", "max_points": 25, "guidance": "Handled."}, {"criterion": "Provenance", "max_points": 25, "guidance": "Complete."}, {"criterion": "Business documents", "max_points": 30, "guidance": "Professional."}, {"criterion": "Quality", "max_points": 20, "guidance": "Clear."}]$t75f$::jsonb, 150, 'link', false, true),
  (76, $t76a$Flagship: brief and concept$t76a$, $t76b$Start a flagship campaign.$t76b$, $t76c$Write brief, insight, concept and motion language for a three-piece campaign.$t76c$, $t76d$Flagship: brief and concept$t76d$, $t76e$Submit the documents and boards.

**Sharing:** upload and paste the link. Animation is checked by a person.$t76e$, $t76f$[{"criterion": "Insight", "max_points": 35, "guidance": "Real."}, {"criterion": "Concept", "max_points": 35, "guidance": "Strong."}, {"criterion": "Language", "max_points": 30, "guidance": "Defined."}]$t76f$::jsonb, 90, 'link', false, false),
  (77, $t77a$Flagship: production$t77a$, $t77b$Animate the key piece.$t77b$, $t77c$Animate the hero piece to a professional standard.$t77c$, $t77d$Flagship: production$t77d$, $t77e$Submit the hero piece.

**Sharing:** upload and paste the link. Animation is checked by a person.$t77e$, $t77f$[{"criterion": "Craft", "max_points": 50, "guidance": "Excellent."}, {"criterion": "On concept", "max_points": 30, "guidance": "Faithful."}, {"criterion": "Technical", "max_points": 20, "guidance": "Correct."}]$t77f$::jsonb, 240, 'link', false, false),
  (78, $t78a$Flagship: extend and adapt$t78a$, $t78b$Produce variants and formats.$t78b$, $t78c$Adapt the hero to social, web and broadcast with reduced-motion versions.$t78c$, $t78d$Flagship: extend and adapt$t78d$, $t78e$Submit all variants.

**Sharing:** upload and paste the link. Animation is checked by a person.$t78e$, $t78f$[{"criterion": "Variants consistent", "max_points": 40, "guidance": "One system."}, {"criterion": "Formats right", "max_points": 30, "guidance": "Correct."}, {"criterion": "Accessibility", "max_points": 30, "guidance": "Provided."}]$t78f$::jsonb, 180, 'link', false, false),
  (79, $t79a$Flagship: review and delivery$t79a$, $t79b$Finalise with feedback.$t79b$, $t79c$Collect feedback, revise, complete the register and deliver.$t79c$, $t79d$Flagship: review and delivery$t79d$, $t79e$Submit feedback, changes and register.

**Sharing:** upload and paste the link. Animation is checked by a person.$t79e$, $t79f$[{"criterion": "Feedback used", "max_points": 40, "guidance": "Applied."}, {"criterion": "Register", "max_points": 35, "guidance": "Complete."}, {"criterion": "Delivery", "max_points": 25, "guidance": "Organised."}]$t79f$::jsonb, 90, 'link', false, false),
  (80, $t80a$Expert project 4: the flagship campaign$t80a$, $t80b$Deliver a full motion campaign.$t80b$, $t80c$Show Module 4. Deliver the **flagship motion campaign** with all pieces, accessibility variants and provenance register.

A person reviews your work and can ask for revisions.$t80c$, $t80d$Expert project 4: the flagship campaign$t80d$, $t80e$Submit the package and a 200-word rationale.

**Sharing:** upload and paste the link. Animation is checked by a person.$t80e$, $t80f$[{"criterion": "Concept and craft", "max_points": 35, "guidance": "Excellent."}, {"criterion": "Consistency", "max_points": 25, "guidance": "One system."}, {"criterion": "Accessibility and rights", "max_points": 25, "guidance": "Clean."}, {"criterion": "Rationale", "max_points": 15, "guidance": "Clear."}]$t80f$::jsonb, 300, 'link', false, true)
) as v(n, title, objective, lesson_md, skill_focus, assignment_md, rubric, est_minutes, submission_type, ai_evaluate, requires_review)
where t.slug = 'motion'
on conflict (track_id, day_number) do nothing;
