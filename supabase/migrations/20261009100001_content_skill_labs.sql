-- Content & writing Skill Labs (days 91-120). Published; appended after the core path.
insert into public.day
  (track_id, tier_id, day_number, title, objective, lesson_md, skill_focus, assignment_md, rubric,
   est_minutes, is_published, credit_budget, submission_type, ai_evaluate, requires_review)
select t.id, ti.id, v.n, v.title, v.objective, v.lesson_md, v.skill_focus, v.assignment_md, v.rubric,
       v.est_minutes, true, null, v.submission_type, v.ai_evaluate, v.requires_review
from public.track t
join public.tier ti on ti.track_id = t.id and ti.slug = 'grandmaster'
cross join (values
  (91, $t91a$Skill Lab: Story structure: setup, tension, turn, payoff$t91a$, $t91b$Shape any piece as a story with a beginning that promises and an end that pays off.$t91b$, $t91c$Stories work because someone wants something, something stands in the way, and something changes. Use four beats: **setup** (who, where, what they want), **tension** (the obstacle grows), **turn** (a decision or discovery), **payoff** (what changed). This works for fiction, case studies, brand stories and even sales pages.

Write the payoff sentence first; it tells you what the story is for.

**Worked example:** Case study: a baker whose orders were lost on sticky notes (setup), two missed weddings (tension), she tries a simple tracking tool (turn), zero lost orders in three months (payoff).

**Common mistake:** Starting with background and never reaching a turn.$t91c$, $t91d$Skill Lab: Story structure: setup, tension, turn, payoff$t91d$, $t91e$Write the four beats (one sentence each) for a real or realistic story of your choice, then a 250-word version. Submit both.$t91e$, $t91f$[{"criterion": "All four beats present", "max_points": 40, "guidance": "Clear setup, tension, turn, payoff."}, {"criterion": "Payoff earns the setup", "max_points": 30, "guidance": "Ends on a real change."}, {"criterion": "Specific detail", "max_points": 30, "guidance": "Concrete, not generic."}]$t91f$::jsonb, 40, 'text', false, false),
  (92, $t92a$Skill Lab: Character, scene and sensory detail$t92a$, $t92b$Bring a moment to life with specific detail.$t92b$, $t92c$Readers believe details they can see, hear or touch. Replace labels ('a stressful day') with a scene (a phone buzzing under a pile of unpaid invoices). Choose two or three telling details per scene, not twenty. Keep every scene focused on one change.

**Worked example:** 'She was nervous' becomes 'She straightened the same pen three times before she knocked.'

**Common mistake:** Piling on adjectives instead of choosing one telling detail.$t92c$, $t92d$Skill Lab: Character, scene and sensory detail$t92d$, $t92e$Rewrite a flat 150-word paragraph as a scene with three sensory details. Submit both versions.$t92e$, $t92f$[{"criterion": "Show, do not label", "max_points": 40, "guidance": "Scene replaces labels."}, {"criterion": "Telling details", "max_points": 35, "guidance": "Chosen, not piled on."}, {"criterion": "Focused on one change", "max_points": 25, "guidance": "One clear moment."}]$t92f$::jsonb, 40, 'text', false, false),
  (93, $t93a$Skill Lab: Dialogue that sounds human$t93a$, $t93b$Write dialogue that reveals character and moves the story.$t93b$, $t93c$Real people interrupt, avoid the question and say less than they mean. Give each speaker a distinct rhythm and word choice. Cut greetings and filler, start late, and use small actions instead of tags. Read it aloud; if you would not say it, cut it.

**Worked example:** Instead of 'I am angry that you were late', she says 'Nice of you to join us.'

**Common mistake:** Making characters explain their feelings in full sentences.$t93c$, $t93d$Skill Lab: Dialogue that sounds human$t93d$, $t93e$Write a 200-word dialogue between two people who want different things. Submit it with one sentence on what each wants.$t93e$, $t93f$[{"criterion": "Distinct voices", "max_points": 40, "guidance": "Sound different."}, {"criterion": "Subtext", "max_points": 35, "guidance": "Says less than means."}, {"criterion": "Moves the story", "max_points": 25, "guidance": "Something changes."}]$t93f$::jsonb, 40, 'text', false, false),
  (94, $t94a$Skill Lab: Personal and brand storytelling$t94a$, $t94b$Tell true stories that build trust.$t94b$, $t94c$Brand and personal stories work when they are honest, specific and useful to the reader. Share the mistake, the lesson and the change, not just the win. Never invent events, testimonials or credentials. Change names and details when someone else's privacy is involved.

**Worked example:** A founder tells how her first order failed, what she changed and how customers get a better result now.

**Common mistake:** Inventing a dramatic origin story.$t94c$, $t94d$Skill Lab: Personal and brand storytelling$t94d$, $t94e$Write a 300-word honest story for yourself or a real brand that ends with a lesson useful to the reader. Note anything you changed for privacy.$t94e$, $t94f$[{"criterion": "True and specific", "max_points": 40, "guidance": "No invention."}, {"criterion": "Useful lesson", "max_points": 35, "guidance": "Helps the reader."}, {"criterion": "Privacy considered", "max_points": 25, "guidance": "Handled."}]$t94f$::jsonb, 40, 'text', false, false),
  (95, $t95a$Skill Lab: Lab 1 project: a 700-word story or narrative case study$t95a$, $t95b$Deliver a complete, human-sounding story.$t95b$, $t95c$Show Lab 1. Write a **700-word story or narrative case study** with all four beats, at least two scenes with sensory detail and one dialogue moment. Edit out AI habits and read it aloud.

Success looks like a reader who wants to know what happens next.

**Worked example:** A case study of a freelancer's first difficult client, told in three scenes with a real lesson at the end.

**Common mistake:** Leaving in AI habits such as tidy moral summaries.

Your work is scored on the rubric below. You can revise and resubmit.$t95c$, $t95d$Skill Lab: Lab 1 project: a 700-word story or narrative case study$t95d$, $t95e$Submit the story, the four-beat outline and a note listing three edits you made to remove AI habits.$t95e$, $t95f$[{"criterion": "Structure and payoff", "max_points": 30, "guidance": "Four beats."}, {"criterion": "Scene, detail and dialogue", "max_points": 30, "guidance": "Alive."}, {"criterion": "Voice and editing", "max_points": 25, "guidance": "Human."}, {"criterion": "Honesty", "max_points": 15, "guidance": "True or clearly fiction."}]$t95f$::jsonb, 90, 'text', true, false),
  (96, $t96a$Skill Lab: Keyword research and search intent$t96a$, $t96b$Find what people search and what they actually want.$t96b$, $t96c$Start from questions people ask. Group searches by intent: learn, compare, buy, fix. Note volume, competition and whether the results are guides, lists or product pages, because that tells you the format Google expects. Use free tools (search suggestions, 'People also ask') and never chase volume you cannot serve well.

**Worked example:** 'how to invoice as a freelancer' (learn), 'best invoicing app for freelancers' (compare); the results are lists, so write a comparison.

**Common mistake:** Picking keywords by volume without checking what the results look like.$t96c$, $t96d$Skill Lab: Keyword research and search intent$t96d$, $t96e$Research ten queries for one topic. Submit them grouped by intent with the format of the top results and the one you would target.$t96e$, $t96f$[{"criterion": "Intent grouped correctly", "max_points": 35, "guidance": "Sensible."}, {"criterion": "Result format noted", "max_points": 35, "guidance": "Observed."}, {"criterion": "Choice reasoned", "max_points": 30, "guidance": "Feasible."}]$t96f$::jsonb, 40, 'text', false, false),
  (97, $t97a$Skill Lab: On-page writing: headings, snippets and structure$t97a$, $t97b$Structure a page so people and search engines understand it.$t97b$, $t97c$Use one clear title, descriptive headings, short paragraphs, a direct answer near the top, and lists or tables where they help. Write a title and meta description that promise what the page delivers. Add internal links and descriptive link text. Never stuff keywords.

**Worked example:** A page that opens with a 40-word direct answer, then sections with question headings, a comparison table and a short FAQ.

**Common mistake:** Writing for keywords instead of for the reader.$t97c$, $t97d$Skill Lab: On-page writing: headings, snippets and structure$t97d$, $t97e$Take an existing 500-word draft and restructure it with headings, a direct answer, a title and a meta description. Submit before and after.$t97e$, $t97f$[{"criterion": "Structure improved", "max_points": 40, "guidance": "Clear headings."}, {"criterion": "Answer near top", "max_points": 30, "guidance": "Direct."}, {"criterion": "Title and description honest", "max_points": 30, "guidance": "Accurate."}]$t97f$::jsonb, 40, 'text', false, false),
  (98, $t98a$Skill Lab: Content briefs that writers can follow$t98a$, $t98b$Write a brief that produces a good article.$t98b$, $t98c$A brief includes the reader, the search intent, the angle, the questions to answer, headings, sources to use, internal links, length, tone and what to avoid. It saves revisions and keeps AI drafts on track.

**Worked example:** Brief: reader (new freelancer), intent (compare), angle (honest pros and cons), 6 headings, 3 sources, 1,200 words.

**Common mistake:** A one-line brief that leads to a generic article.$t98c$, $t98d$Skill Lab: Content briefs that writers can follow$t98d$, $t98e$Write a full content brief for a topic of your choice. Submit it.$t98e$, $t98f$[{"criterion": "Complete elements", "max_points": 40, "guidance": "All parts."}, {"criterion": "Angle distinct", "max_points": 30, "guidance": "Not generic."}, {"criterion": "Usable by a writer", "max_points": 30, "guidance": "Clear."}]$t98f$::jsonb, 40, 'text', false, false),
  (99, $t99a$Skill Lab: Refreshing and measuring content$t99a$, $t99b$Improve existing pages using evidence.$t99b$, $t99c$Older pages often gain more from an update than a new post. Check queries and clicks in a search dashboard, find pages that rank on page two, add missing answers and current facts, fix broken links and republish with an updated date only if changes are real. Track results for a month.

**Worked example:** A post ranking #11 gets a new section answering three related questions and a fresh comparison table; watch clicks over four weeks.

**Common mistake:** Changing the date without changing the content.$t99c$, $t99d$Skill Lab: Refreshing and measuring content$t99d$, $t99e$Choose an existing page (yours or a plan for one) and write an update plan with five specific changes and how you will measure the result.$t99e$, $t99f$[{"criterion": "Changes specific", "max_points": 40, "guidance": "Five real changes."}, {"criterion": "Evidence used", "max_points": 30, "guidance": "Data-based."}, {"criterion": "Measurement", "max_points": 30, "guidance": "Defined."}]$t99f$::jsonb, 40, 'text', false, false),
  (100, $t100a$Skill Lab: Lab 2 project: an SEO article with brief$t100a$, $t100b$Deliver a search-friendly article that still reads well.$t100b$, $t100c$Show Lab 2. Write a **1,000-word SEO article** with a content brief, keyword research, structured headings, a title and meta description, and sourced facts.

Success looks like an article that answers the question clearly and honestly.

**Worked example:** Topic: 'best free tools to invoice as a freelancer', with a comparison table and a verified feature list.

**Common mistake:** Publishing unverified claims about tools or pricing.

Your work is scored on the rubric below. You can revise and resubmit.$t100c$, $t100d$Skill Lab: Lab 2 project: an SEO article with brief$t100d$, $t100e$Submit the brief, the ten-query research, the article, the title and meta description, and a source list with links.$t100e$, $t100f$[{"criterion": "Intent and structure", "max_points": 30, "guidance": "Answers the query."}, {"criterion": "Accuracy and sources", "max_points": 30, "guidance": "Verified."}, {"criterion": "Readability and voice", "max_points": 25, "guidance": "Human."}, {"criterion": "Brief and research", "max_points": 15, "guidance": "Documented."}]$t100f$::jsonb, 120, 'text', true, false),
  (101, $t101a$Skill Lab: Writing for video: hooks and structure$t101a$, $t101b$Write a video script that keeps people watching.$t101b$, $t101c$Open with a hook in the first three seconds: a result, a question or a surprise. Then promise what the viewer will get, deliver in short beats, and end with one clear action. Write for the ear and add visual notes next to each line.

**Worked example:** Hook: 'This one setting saved me two hours a week.' Then three steps, each with an on-screen action, then 'Try it and tell me what changed.'

**Common mistake:** Starting with an introduction and your name.$t101c$, $t101d$Skill Lab: Writing for video: hooks and structure$t101d$, $t101e$Write a 60-second video script in two columns (spoken words and visuals). Submit it.$t101e$, $t101f$[{"criterion": "Hook and promise", "max_points": 35, "guidance": "Strong opening."}, {"criterion": "Two-column plan", "max_points": 30, "guidance": "Visuals matched."}, {"criterion": "Clear call to action", "max_points": 35, "guidance": "One action."}]$t101f$::jsonb, 40, 'text', false, false),
  (102, $t102a$Skill Lab: Podcast and audio scripts$t102a$, $t102b$Script spoken audio without sounding scripted.$t102b$, $t102c$Use an outline with a written intro and outro and bullet points for the middle. Write short sentences, contractions and signposts ('Here is the first thing'). Add pauses and pronunciation notes. Read it aloud and mark where you breathe.

**Worked example:** Intro: 'Today: one habit that fixed my inbox. Two minutes, no tools.'

**Common mistake:** Reading a written essay aloud.$t102c$, $t102d$Skill Lab: Podcast and audio scripts$t102d$, $t102e$Write the outline plus full intro and outro for a 5-minute episode. Submit it.$t102e$, $t102f$[{"criterion": "Sounds spoken", "max_points": 40, "guidance": "Natural."}, {"criterion": "Structure clear", "max_points": 30, "guidance": "Outline."}, {"criterion": "Signposts and pauses", "max_points": 30, "guidance": "Marked."}]$t102f$::jsonb, 40, 'text', false, false),
  (103, $t103a$Skill Lab: Talks and presentation scripts$t103a$, $t103b$Write a talk that lands one idea.$t103b$, $t103c$A talk has one idea, three points and one story. Open with a reason to care, give the idea early, support with one example per point and finish with what the audience should do. Speaker notes should be short cues, not paragraphs.

**Worked example:** Idea: 'Write the ending first.' Points: clarity, speed, honesty; one story of a rewritten proposal.

**Common mistake:** Trying to cover five ideas in ten minutes.$t103c$, $t103d$Skill Lab: Talks and presentation scripts$t103d$, $t103e$Write a 5-minute talk outline with the idea, three points, a story and cue-style notes. Submit it.$t103e$, $t103f$[{"criterion": "One clear idea", "max_points": 35, "guidance": "Focused."}, {"criterion": "Points supported", "max_points": 35, "guidance": "Examples."}, {"criterion": "Cue-style notes", "max_points": 30, "guidance": "Short."}]$t103f$::jsonb, 40, 'text', false, false),
  (104, $t104a$Skill Lab: Ad and promo scripts$t104a$, $t104b$Write persuasive short scripts honestly.$t104b$, $t104c$Short ads follow: hook, problem, solution, proof, action. Keep claims true and provable, follow advertising rules for your market, and disclose sponsorships. Test two hooks and keep the one that performs.

**Worked example:** 15-second ad: hook (question), problem (one line), product demo (one line), proof (real number), CTA.

**Common mistake:** Exaggerated claims you cannot back up.$t104c$, $t104d$Skill Lab: Ad and promo scripts$t104d$, $t104e$Write two 15-second ad scripts with different hooks and note the claim you can prove in each.$t104e$, $t104f$[{"criterion": "Two hooks distinct", "max_points": 35, "guidance": "Different."}, {"criterion": "Claims provable", "max_points": 40, "guidance": "Honest."}, {"criterion": "Clear action", "max_points": 25, "guidance": "One CTA."}]$t104f$::jsonb, 40, 'text', false, false),
  (105, $t105a$Skill Lab: Lab 3 project: a script pack$t105a$, $t105b$Deliver scripts for three formats from one idea.$t105b$, $t105c$Show Lab 3. From **one idea** write a video script (60s), a podcast outline (3 min) and a talk outline (5 min) that share a message but fit each format.

Success looks like three pieces that clearly belong together and sound natural spoken.

**Worked example:** Idea: 'One-page plans beat long plans', shaped as a punchy video, a conversational podcast and a story-led talk.

**Common mistake:** Using the same script three times.

Your work is scored on the rubric below. You can revise and resubmit.$t105c$, $t105d$Skill Lab: Lab 3 project: a script pack$t105d$, $t105e$Submit all three scripts and a note on what you changed for each format.$t105e$, $t105f$[{"criterion": "Fits each format", "max_points": 35, "guidance": "Adapted."}, {"criterion": "Sounds spoken", "max_points": 30, "guidance": "Natural."}, {"criterion": "One idea across all", "max_points": 20, "guidance": "Coherent."}, {"criterion": "Honest claims", "max_points": 15, "guidance": "True."}]$t105f$::jsonb, 90, 'text', true, false),
  (106, $t106a$Skill Lab: Newsletters people open and read$t106a$, $t106b$Write a newsletter with a clear promise.$t106b$, $t106c$A newsletter is a relationship. Promise one useful thing on a schedule, write a specific subject line, deliver value fast, and end with one link or reply prompt. Keep one voice and one topic per issue. Respect consent and include an easy unsubscribe.

**Worked example:** Weekly '3-minute Monday': one tip, one example, one question to reply to.

**Common mistake:** Sending irregular issues with no clear promise.$t106c$, $t106d$Skill Lab: Newsletters people open and read$t106d$, $t106e$Write a newsletter promise, five subject line options and one full issue (300 words).$t106e$, $t106f$[{"criterion": "Promise clear", "max_points": 30, "guidance": "Specific."}, {"criterion": "Subject lines varied", "max_points": 30, "guidance": "Five."}, {"criterion": "Issue delivers value", "max_points": 40, "guidance": "Useful."}]$t106f$::jsonb, 40, 'text', false, false),
  (107, $t107a$Skill Lab: Social writing by platform$t107a$, $t107b$Adapt writing for each platform without losing your voice.$t107b$, $t107c$Each platform has norms: LinkedIn rewards insight and stories, X rewards short and sharp, Instagram captions support a visual, community forums reward helpful answers. Lead with the point, use line breaks, and never fake engagement. Follow each platform's rules.

**Worked example:** One lesson written as a LinkedIn story, a five-post thread and an Instagram caption.

**Common mistake:** Posting the same text everywhere.$t107c$, $t107d$Skill Lab: Social writing by platform$t107d$, $t107e$Take one idea and write it for three platforms. Submit all three.$t107e$, $t107f$[{"criterion": "Fits each platform", "max_points": 40, "guidance": "Adapted."}, {"criterion": "Same message", "max_points": 30, "guidance": "Coherent."}, {"criterion": "Honest", "max_points": 30, "guidance": "No fake hooks."}]$t107f$::jsonb, 40, 'text', false, false),
  (108, $t108a$Skill Lab: Threads, carousels and educational posts$t108a$, $t108b$Teach in small pieces.$t108b$, $t108c$A good educational post has a promise, three to seven steps, one example each and a summary. Make the first line stand alone. Use plain words and give credit when you use someone else's idea.

**Worked example:** Carousel: 'How to write a brief in 5 steps', one step per slide with a tiny example.

**Common mistake:** A thread that is a list of vague tips.$t108c$, $t108d$Skill Lab: Threads, carousels and educational posts$t108d$, $t108e$Write a seven-part educational thread or carousel script with an example in each part. Submit it.$t108e$, $t108f$[{"criterion": "Clear promise", "max_points": 30, "guidance": "Specific."}, {"criterion": "Steps with examples", "max_points": 45, "guidance": "Concrete."}, {"criterion": "Standalone opener", "max_points": 25, "guidance": "Strong."}]$t108f$::jsonb, 40, 'text', false, false),
  (109, $t109a$Skill Lab: Community management and replies$t109a$, $t109b$Write helpful, human replies.$t109b$, $t109c$Answer questions fast and kindly, admit what you do not know, correct mistakes in public, and set clear community rules. Do not use AI to fake conversations. Draft replies with AI if you like, but read and edit each one.

**Worked example:** Reply: 'Good question. Short answer: yes. Here is the one thing to check first...'

**Common mistake:** Copy-pasting generic replies.$t109c$, $t109d$Skill Lab: Community management and replies$t109d$, $t109e$Write eight sample replies to realistic comments (three praise, three questions, two complaints).$t109e$, $t109f$[{"criterion": "Helpful", "max_points": 40, "guidance": "Answers."}, {"criterion": "Human tone", "max_points": 30, "guidance": "Warm."}, {"criterion": "Handles complaints well", "max_points": 30, "guidance": "Calm."}]$t109f$::jsonb, 40, 'text', false, false),
  (110, $t110a$Skill Lab: Lab 4 project: a four-week newsletter and social plan$t110a$, $t110b$Deliver a realistic content rhythm.$t110b$, $t110c$Show Lab 4. Deliver a **four-week plan**: newsletter promise and two full issues, social posts for two platforms each week, a repurposing map and a reply guide.

Success looks like a plan one person could actually keep.

**Worked example:** Weeks: theme per week, one newsletter issue, three posts, one carousel, ten minutes daily for replies.

**Common mistake:** Planning ten posts a day.

Your work is scored on the rubric below. You can revise and resubmit.$t110c$, $t110d$Skill Lab: Lab 4 project: a four-week newsletter and social plan$t110d$, $t110e$Submit the calendar, two newsletter issues, four sample posts and the reply guide.$t110e$, $t110f$[{"criterion": "Realistic plan", "max_points": 30, "guidance": "Doable."}, {"criterion": "Newsletter quality", "max_points": 30, "guidance": "Useful."}, {"criterion": "Platform fit", "max_points": 25, "guidance": "Adapted."}, {"criterion": "Reply guide", "max_points": 15, "guidance": "Human."}]$t110f$::jsonb, 120, 'text', true, false),
  (111, $t111a$Skill Lab: UX writing and microcopy$t111a$, $t111b$Write interface text that guides people.$t111b$, $t111c$Buttons say what happens ('Save changes', not 'Submit'). Error messages say what went wrong and how to fix it. Empty states invite the first action. Keep text short, consistent and in the user's words.

**Worked example:** Error: 'That email looks incomplete. Try name@example.com.'

**Common mistake:** Blaming the user or using jargon.$t111c$, $t111d$Skill Lab: UX writing and microcopy$t111d$, $t111e$Rewrite ten pieces of interface text (buttons, errors, empty states) for an app. Submit before and after.$t111e$, $t111f$[{"criterion": "Clear and specific", "max_points": 40, "guidance": "Says what to do."}, {"criterion": "Consistent voice", "max_points": 30, "guidance": "Uniform."}, {"criterion": "Helpful errors", "max_points": 30, "guidance": "Fixable."}]$t111f$::jsonb, 40, 'text', false, false),
  (112, $t112a$Skill Lab: Help articles and documentation$t112a$, $t112b$Write instructions people can follow.$t112b$, $t112c$Start with the goal, list prerequisites, number the steps with one action each, show the expected result and add troubleshooting. Use screenshots sparingly with descriptions. Test the steps yourself.

**Worked example:** 'Reset your password' in 5 numbered steps, each with one action and a note for 'no email arrived'.

**Common mistake:** Writing steps you have not tried.$t112c$, $t112d$Skill Lab: Help articles and documentation$t112d$, $t112e$Write a help article of at least six steps for a real task. Submit it.$t112e$, $t112f$[{"criterion": "Steps testable", "max_points": 40, "guidance": "One action each."}, {"criterion": "Troubleshooting", "max_points": 30, "guidance": "Included."}, {"criterion": "Clear goal", "max_points": 30, "guidance": "Stated."}]$t112f$::jsonb, 40, 'text', false, false),
  (113, $t113a$Skill Lab: Case studies and white papers$t113a$, $t113b$Write proof that persuades honestly.$t113b$, $t113c$A case study: situation, challenge, action, result with real numbers, quote with permission. A white paper explains a problem and a solution with evidence. Cite sources, separate fact from opinion and state limits.

**Worked example:** Case study with baseline (12 late invoices a month) and result (3 after eight weeks), quote approved by the client.

**Common mistake:** Rounding up results or inventing a quote.$t113c$, $t113d$Skill Lab: Case studies and white papers$t113d$, $t113e$Write a one-page case study from real or clearly labelled example facts. Submit it with a list of every number and its source.$t113e$, $t113f$[{"criterion": "Real numbers", "max_points": 40, "guidance": "Sourced."}, {"criterion": "Structure", "max_points": 30, "guidance": "Clear."}, {"criterion": "Honest limits", "max_points": 30, "guidance": "Stated."}]$t113f$::jsonb, 40, 'text', false, false),
  (114, $t114a$Skill Lab: Email sequences and product copy$t114a$, $t114b$Write sequences and descriptions that sell without hype.$t114b$, $t114c$A welcome sequence has 3 to 5 emails: welcome and promise, best value, story, proof, invitation. Product copy leads with what changes for the buyer, then details. Use true claims and follow email laws.

**Worked example:** Three-email welcome: what to expect, your best resource, a small offer.

**Common mistake:** Sending a hard sell in email one.$t114c$, $t114d$Skill Lab: Email sequences and product copy$t114d$, $t114e$Write a three-email sequence and one product description. Submit them.$t114e$, $t114f$[{"criterion": "Sequence flows", "max_points": 35, "guidance": "Logical."}, {"criterion": "Benefits and truth", "max_points": 40, "guidance": "Honest."}, {"criterion": "Clear CTAs", "max_points": 25, "guidance": "One each."}]$t114f$::jsonb, 40, 'text', false, false),
  (115, $t115a$Skill Lab: Lab 5 project: UX copy and a help article for an app$t115a$, $t115b$Deliver copy for a whole flow.$t115b$, $t115c$Show Lab 5. Write the **copy for a five-screen app flow**, an onboarding email and a help article, in one consistent voice with a voice guide.

Success looks like text a designer could paste straight into the product.

**Worked example:** Flow: sign up, verify email, first task, success, invite a friend, with a friendly, plain voice.

**Common mistake:** Different voices on different screens.

Your work is scored on the rubric below. You can revise and resubmit.$t115c$, $t115d$Skill Lab: Lab 5 project: UX copy and a help article for an app$t115d$, $t115e$Submit the screen copy, the email, the article and a half-page voice guide.$t115e$, $t115f$[{"criterion": "Clarity and helpfulness", "max_points": 30, "guidance": "Guides users."}, {"criterion": "Consistent voice", "max_points": 25, "guidance": "Uniform."}, {"criterion": "Article usability", "max_points": 25, "guidance": "Testable."}, {"criterion": "Accessibility and plain words", "max_points": 20, "guidance": "Simple."}]$t115f$::jsonb, 120, 'text', true, false),
  (116, $t116a$Skill Lab: Portfolio and proof for writers$t116a$, $t116b$Show your best work with context.$t116b$, $t116c$Show three to five pieces that fit the work you want. Add a sentence of context for each (goal, audience, result). Label AI-assisted work honestly and only include work you may show.

**Worked example:** Portfolio: an SEO article with traffic result, a newsletter issue, a UX copy sample.

**Common mistake:** Showing everything you have ever written.$t116c$, $t116d$Skill Lab: Portfolio and proof for writers$t116d$, $t116e$Draft a portfolio outline with three pieces and a context line for each.$t116e$, $t116f$[{"criterion": "Pieces fit target work", "max_points": 40, "guidance": "Relevant."}, {"criterion": "Context given", "max_points": 30, "guidance": "Goals and results."}, {"criterion": "Honest labelling", "max_points": 30, "guidance": "AI use stated."}]$t116f$::jsonb, 40, 'text', false, false),
  (117, $t117a$Skill Lab: Niches, pricing and finding clients$t117a$, $t117b$Pick a niche and price your work.$t117b$, $t117c$Choose a niche where you have knowledge, price by project with clear scope (word count, rounds, research, sources), and find clients through people you know, communities and personal outreach. Record enquiries and follow up.

**Worked example:** Offer: two case studies a month for B2B software, 600 each, two revision rounds.

**Common mistake:** Pricing by word count with no scope.$t117c$, $t117d$Skill Lab: Niches, pricing and finding clients$t117d$, $t117e$Write your offer, price sheet and an outreach list of ten with reasons.$t117e$, $t117f$[{"criterion": "Niche and scope clear", "max_points": 40, "guidance": "Defined."}, {"criterion": "Pricing logic", "max_points": 30, "guidance": "Reasoned."}, {"criterion": "Outreach realistic", "max_points": 30, "guidance": "Reasons."}]$t117f$::jsonb, 40, 'text', false, false),
  (118, $t118a$Skill Lab: Lead magnets, ebooks and products$t118a$, $t118b$Package knowledge into something people can use.$t118b$, $t118c$A lead magnet solves one small problem (a checklist, template or mini guide). An ebook or course needs a clear outcome, outline and honest promises. Validate demand with real people before you build.

**Worked example:** A one-page 'client onboarding checklist' offered in exchange for an email address.

**Common mistake:** Building a product before asking anyone.$t118c$, $t118d$Skill Lab: Lead magnets, ebooks and products$t118d$, $t118e$Design a lead magnet: audience, problem, outline and how you will test demand. Submit it.$t118e$, $t118f$[{"criterion": "Problem specific", "max_points": 35, "guidance": "Clear."}, {"criterion": "Outline useful", "max_points": 35, "guidance": "Practical."}, {"criterion": "Demand test", "max_points": 30, "guidance": "Real."}]$t118f$::jsonb, 40, 'text', false, false),
  (119, $t119a$Skill Lab: Ethics, AI disclosure and originality$t119a$, $t119b$State how you work.$t119b$, $t119c$Explain how you use AI, how you fact-check and how you avoid plagiarism. Run originality checks, credit sources, and disclose where clients or platforms require it. Never fabricate quotes or experience.

**Worked example:** 'I use AI for outlines and first drafts; every fact is checked against a source; every piece is edited by me.'

**Common mistake:** Claiming AI was not used when it was.$t119c$, $t119d$Skill Lab: Ethics, AI disclosure and originality$t119d$, $t119e$Write your public writing standards (about 200 words) and a client-facing AI-use note.$t119e$, $t119f$[{"criterion": "Specific", "max_points": 40, "guidance": "Concrete."}, {"criterion": "Fact-checking described", "max_points": 30, "guidance": "Real."}, {"criterion": "Honest disclosure", "max_points": 30, "guidance": "Clear."}]$t119f$::jsonb, 40, 'text', false, false),
  (120, $t120a$Skill Lab: Lab 6 project: your writing showcase$t120a$, $t120b$Present your best work and share it.$t120b$, $t120c$Show Lab 6. Assemble a **showcase**: three pieces from the Skill Labs, your offer and prices, your standards and a short bio. Share it in the NEXTGEN Discord and ask for one piece of feedback.

Success looks like something you would send to a real client.

**Worked example:** Showcase with a story, an SEO article, UX copy, offer, prices and standards.

**Common mistake:** Sharing without asking for feedback.

Your work is scored on the rubric below. You can revise and resubmit.$t120c$, $t120d$Skill Lab: Lab 6 project: your writing showcase$t120d$, $t120e$Submit the showcase text (or links) and a 150-word reflection on what you would improve next.$t120e$, $t120f$[{"criterion": "Quality of pieces", "max_points": 30, "guidance": "Strong."}, {"criterion": "Business readiness", "max_points": 25, "guidance": "Offer and terms."}, {"criterion": "Integrity", "max_points": 25, "guidance": "Honest."}, {"criterion": "Reflection", "max_points": 20, "guidance": "Specific."}]$t120f$::jsonb, 150, 'text', true, false)
) as v(n, title, objective, lesson_md, skill_focus, assignment_md, rubric, est_minutes, submission_type, ai_evaluate, requires_review)
where t.slug = 'content'
on conflict (track_id, day_number) do nothing;
