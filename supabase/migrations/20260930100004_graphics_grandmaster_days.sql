-- Graphics & design, Grandmaster tier (days 81-90). Authored content, UNPUBLISHED until a person reviews it in Admin.
insert into public.day
  (track_id, tier_id, day_number, title, objective, lesson_md, skill_focus, assignment_md, rubric,
   est_minutes, is_published, credit_budget, submission_type, ai_evaluate, requires_review)
select t.id, ti.id, v.n, v.title, v.objective, v.lesson_md, v.skill_focus, v.assignment_md, v.rubric,
       v.est_minutes, false, null, v.submission_type, v.ai_evaluate, v.requires_review
from public.track t
join public.tier ti on ti.track_id = t.id and ti.slug = 'grandmaster'
cross join (values
  (81, $t81a$Teach a design skill$t81a$, $t81b$Explain a visual skill so a beginner can apply it.$t81b$, $t81c$Pick one skill (hierarchy, contrast, prompt control). Write a lesson: goal, explanation with visual examples, a practice task and a check for success.

**Sharing images:** paste *direct* links ending .png/.jpg/.webp, one per line.$t81c$, $t81d$Teach a design skill$t81d$, $t81e$Submit a one-page lesson with two example images (direct links) and a practice task.$t81e$, $t81f$[{"criterion": "Clear explanation", "max_points": 35, "guidance": "Beginner-friendly."}, {"criterion": "Examples effective", "max_points": 35, "guidance": "Visual."}, {"criterion": "Practice task", "max_points": 30, "guidance": "Usable."}]$t81f$::jsonb, 60, 'link', false, false),
  (82, $t82a$Critique clinic: three expert critiques$t82a$, $t82b$Diagnose others' work precisely.$t82b$, $t82c$Critique three pieces with permission: what works, the top problem, the fix and an exercise. Show the fix with an annotated image or a redraw.

**Sharing images:** paste *direct* links ending .png/.jpg/.webp, one per line.$t82c$, $t82d$Critique clinic: three expert critiques$t82d$, $t82e$Submit three critiques with one annotated example (direct link).$t82e$, $t82f$[{"criterion": "Diagnosis precise", "max_points": 40, "guidance": "Insightful."}, {"criterion": "Prioritised", "max_points": 30, "guidance": "Focused."}, {"criterion": "Fix demonstrated", "max_points": 30, "guidance": "Shown."}]$t82f$::jsonb, 60, 'link', false, false),
  (83, $t83a$Original visual research$t83a$, $t83b$Learn something new about visual communication.$t83b$, $t83c$Run a small test: for example which of two layouts people understand faster. State the method, sample and limits and share results honestly.

**Sharing images:** paste *direct* links ending .png/.jpg/.webp, one per line.$t83c$, $t83d$Original visual research$t83d$, $t83e$Submit the method, materials (direct links), results and limits.$t83e$, $t83f$[{"criterion": "Method sound", "max_points": 35, "guidance": "Clear."}, {"criterion": "Results honest", "max_points": 40, "guidance": "Limits."}, {"criterion": "Insight", "max_points": 25, "guidance": "Useful."}]$t83f$::jsonb, 120, 'link', false, false),
  (84, $t84a$Case study: process and results$t84a$, $t84b$Show your thinking and outcome.$t84b$, $t84c$A case study: brief, insight, options explored, decisions, final work and results. Include what did not work.

**Sharing images:** paste *direct* links ending .png/.jpg/.webp, one per line.$t84c$, $t84d$Case study: process and results$t84d$, $t84e$Submit a case study with at least four images (direct links).$t84e$, $t84f$[{"criterion": "Process visible", "max_points": 35, "guidance": "Options."}, {"criterion": "Results honest", "max_points": 35, "guidance": "Evidence."}, {"criterion": "Presentation", "max_points": 30, "guidance": "Clear."}]$t84f$::jsonb, 90, 'link', false, false),
  (85, $t85a$Grandmaster project 1: a body-of-work plan$t85a$, $t85b$Plan a visible portfolio with a distinct voice.$t85b$, $t85c$Deliver a **body-of-work plan**: your design point of view, three flagship pieces, one teaching resource, one research piece and a six-month schedule with measures.

Your work is scored on the rubric below. You can revise and resubmit.$t85c$, $t85d$Grandmaster project 1: a body-of-work plan$t85d$, $t85e$Submit the plan (text) with any supporting image links.$t85e$, $t85f$[{"criterion": "Point of view", "max_points": 30, "guidance": "Distinct."}, {"criterion": "Pieces valuable", "max_points": 30, "guidance": "Strong."}, {"criterion": "Schedule realistic", "max_points": 20, "guidance": "Feasible."}, {"criterion": "Measures and honesty", "max_points": 20, "guidance": "Clear."}]$t85f$::jsonb, 90, 'link', true, false),
  (86, $t86a$Mentoring: review a peer's work$t86a$, $t86b$Help another designer improve.$t86b$, $t86c$With permission, score a peer's project against the rubric, explain each score with evidence and give one exercise.

**Sharing images:** paste *direct* links ending .png/.jpg/.webp, one per line.$t86c$, $t86d$Mentoring: review a peer's work$t86d$, $t86e$Submit your scored review with evidence per criterion.$t86e$, $t86f$[{"criterion": "Scores justified", "max_points": 40, "guidance": "Evidence."}, {"criterion": "Fair and kind", "max_points": 30, "guidance": "Balanced."}, {"criterion": "Exercise helpful", "max_points": 30, "guidance": "Practical."}]$t86f$::jsonb, 60, 'text', false, false),
  (87, $t87a$Build a course module$t87a$, $t87b$Package what you know into a teachable unit.$t87b$, $t87c$Design a module: outcomes, five lessons, practice tasks, a project and rubric. Test with one learner.

**Sharing images:** paste *direct* links ending .png/.jpg/.webp, one per line.$t87c$, $t87d$Build a course module$t87d$, $t87e$Submit the outline, one full lesson (with images) and learner feedback.$t87e$, $t87f$[{"criterion": "Outcomes clear", "max_points": 30, "guidance": "Measurable."}, {"criterion": "Lesson quality", "max_points": 40, "guidance": "Strong."}, {"criterion": "Tested", "max_points": 30, "guidance": "Real learner."}]$t87f$::jsonb, 120, 'link', false, false),
  (88, $t88a$Ethics and standards for AI-assisted design$t88a$, $t88b$State your principles publicly.$t88b$, $t88c$Write how you use AI, credit sources, avoid misleading imagery, protect people's likeness and handle mistakes. Publish it.$t88c$, $t88d$Ethics and standards for AI-assisted design$t88d$, $t88e$Submit your public standards statement.$t88e$, $t88f$[{"criterion": "Principles specific", "max_points": 40, "guidance": "Concrete."}, {"criterion": "Accountability", "max_points": 35, "guidance": "Corrections."}, {"criterion": "Honest about AI", "max_points": 25, "guidance": "Transparent."}]$t88f$::jsonb, 45, 'text', false, false),
  (89, $t89a$Impact audit$t89a$, $t89b$Show what your work has done.$t89b$, $t89c$Collect evidence: client results, learner outcomes, feedback. Be honest about what cannot be shown.

**Sharing images:** paste *direct* links ending .png/.jpg/.webp, one per line.$t89c$, $t89d$Impact audit$t89d$, $t89e$Submit an impact report with evidence and limits.$t89e$, $t89f$[{"criterion": "Evidence real", "max_points": 45, "guidance": "Collected."}, {"criterion": "Analysis honest", "max_points": 35, "guidance": "Limits."}, {"criterion": "Next steps", "max_points": 20, "guidance": "Clear."}]$t89f$::jsonb, 60, 'link', false, false),
  (90, $t90a$Grandmaster capstone: portfolio, teaching and impact$t90a$, $t90b$Present a body of work that proves mastery.$t90b$, $t90c$The final assessment. Deliver a **Grandmaster portfolio**: a flagship campaign, a research piece, a teaching resource with learner feedback, a peer review, your standards statement and an impact report.

Your work is scored on the rubric below. You can revise and resubmit.

**Sharing images:** paste *direct* links ending .png/.jpg/.webp, one per line.$t90c$, $t90d$Grandmaster capstone: portfolio, teaching and impact$t90d$, $t90e$Submit direct links to the key images (one per line), a link or text for each part, and a one-page reflection on your growth.$t90e$, $t90f$[{"criterion": "Craft and originality", "max_points": 30, "guidance": "Excellent."}, {"criterion": "Rigour and honesty", "max_points": 25, "guidance": "Verified."}, {"criterion": "Teaching and mentoring", "max_points": 25, "guidance": "Effective."}, {"criterion": "Impact and reflection", "max_points": 20, "guidance": "Evidenced."}]$t90f$::jsonb, 180, 'link', true, false)
) as v(n, title, objective, lesson_md, skill_focus, assignment_md, rubric, est_minutes, submission_type, ai_evaluate, requires_review)
where t.slug = 'graphics'
on conflict (track_id, day_number) do nothing;
