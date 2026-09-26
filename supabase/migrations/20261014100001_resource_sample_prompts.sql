-- Free sample prompts inside the Resource Library (a new 'prompts' kind), covering every category.
alter table public.resource drop constraint if exists resource_kind_check;
alter table public.resource add constraint resource_kind_check
  check (kind in ('glossary','tools','templates','checklist','guide','prompts'));
insert into public.resource (category, kind, title, summary, body_md, sort_order) values
  ($c1$general$c1$, $k1$prompts$k1$, $t1$10 starter prompts anyone can use today$t1$, $s1$Copy, replace the brackets, run.$s1$, $b1$1. **Explain simply:** Explain [topic] to me as if I am [age or role]. Use one everyday example and end with three questions to test my understanding.
2. **Plan my week:** I have [hours] hours this week to learn [skill]. Make a day-by-day plan with one small task per day and how I will know it is done.
3. **Improve my draft:** Here is my draft: [paste]. List the five weakest sentences and why, then rewrite only those.
4. **Make it shorter:** Cut this to [number] words without losing the main point or any numbers: [paste].
5. **Brainstorm:** Give me 15 ideas for [goal] for [audience]. Group them into three themes and mark the two most realistic.
6. **Check my thinking:** Here is my plan: [paste]. What are the three biggest risks, what would a sceptic ask, and what would you test first?
7. **Turn notes into actions:** From these notes, list decisions, actions with owners and dates, and open questions: [paste].
8. **Compare options:** Compare [A], [B] and [C] for [goal] using these criteria: [list]. Use a table and say what evidence you would need to be sure.
9. **Roleplay practice:** Act as [person, e.g. a tough client]. I will practise [situation]. Respond realistically, then after five turns give me feedback.
10. **Verify a claim:** Here is a claim: [claim]. What evidence would support it, what would contradict it, and where can I check both?$b1$, 50),
  ($c2$graphics$c2$, $k2$prompts$k2$, $t2$Image prompts for graphic design$t2$, $s2$Ten prompts that get usable design assets.$s2$, $b2$1. **Poster background:** Abstract [colour] gradient with soft geometric shapes, lots of empty space on the left for a headline, clean modern, no text.
2. **Product on colour:** [product] centred on a seamless [colour] background, soft studio lighting from the left, gentle shadow, sharp focus, commercial photography.
3. **Flat illustration:** Flat vector illustration of [scene], limited palette of [3 colours], thick rounded shapes, no gradients, friendly.
4. **Icon set:** Set of six matching line icons for [topics], consistent 3 px stroke, rounded ends, single colour, white background.
5. **Social post image:** [subject] in [setting], bright natural light, 4:5 portrait, empty space at the top for text, warm colour grade.
6. **Pattern:** Seamless repeating pattern of [motifs] in [palette], hand-drawn feel, even spacing.
7. **Brand mood board:** Mood board look for [brand]: [three adjectives], [palette], textures of [materials], photographic style [natural / studio], no logos.
8. **Mockup scene:** Empty [product: tote bag, mug, poster frame] on [surface] in [setting], soft daylight, blank front for a logo, realistic shadows.
9. **Character in two poses:** [character description] standing and waving, same character, same outfit, plain background, consistent style.
10. **Fix an image:** Keep everything the same but change [element] to [new element]. Match the existing light direction and colour.$b2$, 151),
  ($c3$content$c3$, $k3$prompts$k3$, $t3$Writing prompts for every format$t3$, $s3$Ten prompts for briefs, drafts, editing and repurposing.$s3$, $b3$1. **Brief first:** Write a content brief for [topic] for [audience]: goal, angle, five questions to answer, outline, sources to check, and what to avoid.
2. **Voice copy:** Rewrite this in my voice. My voice: [three traits, words I use, words I avoid]. Match these examples: [paste]. Text: [paste].
3. **Outline:** Give me three different outlines for an article on [topic], each with a one-sentence promise. Then combine the best parts.
4. **Hooks:** Write ten opening lines for [topic]: five with a surprising fact, five with a specific scene. No clichés.
5. **Critique:** Act as a hard editor. List the five weakest sentences, what a sceptical reader would ask, and what is missing. Do not rewrite yet.
6. **Cut AI habits:** Rewrite removing filler, stacked adjectives, tidy morals and phrases like "in today's world". Keep facts unchanged: [paste].
7. **Repurpose:** Turn this article into an email (120 words), a LinkedIn post (150 words), five tweets and a 45-second script: [paste].
8. **Headlines:** Give me 20 headlines for this piece grouped by angle (benefit, curiosity, proof, urgency). Flag any that overpromise: [paste].
9. **Fact list:** From this draft, list every claim that needs a source, in a table with claim, type (number, quote, date, name) and suggested place to check: [paste].
10. **UX copy:** Rewrite these interface texts so they say what happens and what to do next, in friendly plain English: [paste].$b3$, 252),
  ($c4$apps$c4$, $k4$prompts$k4$, $t4$Prompts for planning and building tools$t4$, $s4$Ten prompts from idea to tested feature.$s4$, $b4$1. **One-page brief:** Write a product brief for a tool that helps [user] with [problem]: the one job, three user stories, screens, data stored, two things it will not do.
2. **Build in steps:** Break this brief into five small build prompts, each with a result I can check: [paste brief].
3. **Data table:** Design a table for [tool]: fields, types, why each is needed, and which are personal data.
4. **Acceptance tests:** For [feature], write five tests in the form "When I do X, I see Y", including one edge case and one mistake case.
5. **Explain a bug:** Expected: [x]. Actual: [y]. Steps: [z]. Relevant part: [paste]. List three likely causes, most likely first, and how to check each.
6. **Explain code:** Explain this code line by line for a beginner and list two things that could go wrong: [paste].
7. **Permissions table:** For [tool], list roles and a table of what each can view, add, edit and delete. Flag risky permissions.
8. **Friendly errors:** Rewrite these error messages to say what happened and what to do next: [paste].
9. **Security check:** Review [tool] for exposed keys, missing access checks, trusting user input and public links to private data. List tests and fixes.
10. **Launch plan:** Plan a two-week beta of [tool] with ten users: how to invite, what to ask, what to measure, how to decide what to fix.$b4$, 353),
  ($c5$agents$c5$, $k5$prompts$k5$, $t5$Prompts for building and testing agents$t5$, $s5$Ten prompts for briefs, guardrails and evaluation.$s5$, $b5$1. **Agent job description:** Write a job description for an agent that [task]: role, goal, inputs, tools with permissions, limits, output format and when to stop and ask a human.
2. **Map the workflow:** Turn this description into numbered steps with trigger, decisions, outputs and who is involved. Mark what to automate and what stays human: [paste].
3. **Tool spec:** Write a specification for a tool called [name]: purpose, inputs with examples, outputs, and three helpful error messages.
4. **Guardrails:** List ten things this agent must never do and the check that would stop each: [describe agent].
5. **Test set:** Create 20 realistic test tasks for this agent: 12 normal, 4 edge cases, 4 traps (including hidden instructions in a document). Give expected results.
6. **Injection test:** Write five documents that try to make an agent ignore its instructions or leak data, so I can test my own agent.
7. **Approval message:** Write the message a human sees before the agent sends [action]: what will happen, why, and approve, edit or reject options.
8. **Read a trace:** Here is a failed run trace: [paste]. Identify the root cause, not the symptom, and suggest one fix.
9. **Cost estimate:** My agent makes [n] model calls per run at about [cost]. Estimate the monthly cost at 100, 1,000 and 10,000 runs and three ways to cut it.
10. **Handover page:** Write a one-page handover for this agent: what it does, how to pause it, what can go wrong, who to contact and where logs are.$b5$, 454),
  ($c6$film$c6$, $k6$prompts$k6$, $t6$Camera angle and lens prompts for video$t6$, $s6$Every common angle and lens, ready to paste.$s6$, $b6$1. **Eye level:** Eye-level shot of [subject] [action] in [setting], neutral and natural, [lighting].
2. **Low angle:** Low-angle shot looking up at [subject], camera near the ground, powerful and tall, [sky or ceiling] behind.
3. **High angle:** High-angle shot looking down at [subject], small and vulnerable, [lighting].
4. **Bird's-eye:** Top-down bird's-eye view of [scene], patterns and layout clear, [lighting].
5. **Worm's-eye:** Worm's-eye view from ground level looking up at [subject], converging lines.
6. **Dutch angle:** Dutch angle, horizon tilted 20 degrees, [subject] in a tense [setting].
7. **Over-the-shoulder:** Over-the-shoulder shot from behind [A], [B] facing us in sharp focus, [setting].
8. **POV:** First-person point-of-view, we see [what the character sees], hands visible at the bottom of frame.
9. **Close-up / extreme close-up:** Close-up of [face or object], shallow depth of field. / Extreme close-up of [eye, hand, texture], macro detail.
10. **Wide / extreme wide:** Wide shot of [subject] small in [large setting]. / Extreme wide establishing shot of [city or landscape], sweeping scale.
11. **24mm wide lens:** [Subject] in [setting], shot on a 24mm wide-angle lens, expansive, slight edge stretch.
12. **85mm portrait:** Portrait of [person], 85mm lens, flattering compression, creamy blurred background.
13. **200mm telephoto:** [Subject] seen through a 200mm telephoto, background compressed close behind.
14. **Shallow depth of field:** [Subject] sharp, background heavily blurred with soft bokeh, f/1.8.
15. **Rack focus:** Rack focus from [foreground object] to [background subject], one blurs as the other sharpens.$b6$, 555),
  ($c7$film$c7$, $k7$prompts$k7$, $t7$Lighting and camera-move prompts for video$t7$, $s7$Lighting setups, movements and colour looks.$s7$, $b7$**Lighting**
1. **Three-point:** [Person] lit with three-point lighting: soft key from the front left, half-strength fill from the right, rim light behind.
2. **Rembrandt:** Portrait of [person] with Rembrandt lighting, key at 45 degrees above, a small triangle of light on the shadow cheek, dark moody background.
3. **Backlit rim:** [Subject] backlit, bright rim light outlining hair and shoulders, glowing edge, light haze.
4. **Silhouette:** Silhouette of [subject] against a bright [sunset or window], no facial detail, strong shape.
5. **Golden hour:** [Subject] at golden hour, warm low sun from the side, long soft shadows.
6. **Blue hour:** [Subject] at blue hour, cool blue ambient light with warm windows glowing.
7. **Neon night:** [Subject] on a rainy street lit by pink and cyan neon, colourful reflections on wet pavement.
8. **Candlelight:** [Subject] lit only by candlelight, warm flickering glow, deep dark surroundings.
9. **Volumetric:** [Setting] with visible beams of light through [windows or trees] and floating dust.
10. **Low-key / high-key:** Low-key: mostly shadow, one narrow light source. / High-key: bright, soft, minimal shadows.

**Camera moves**
11. **Dolly in:** Slow dolly in toward [subject], smooth and steady.
12. **Tracking:** Camera moves sideways alongside [subject] walking, keeping them centred.
13. **Crane:** Crane shot rising from [close on subject] to a high wide view of [setting].
14. **Orbit:** Camera circles 180 degrees around [subject], background rotating.
15. **Handheld:** Handheld camera following [subject], subtle natural shake.
16. **Drone reveal:** Drone rising over [ridge] to reveal [landscape], smooth, golden hour.
17. **Slow motion:** Slow-motion shot of [action], every droplet visible.

**Looks**
18. **Teal and orange:** [Scene] with cool teal shadows and warm skin tones.
19. **Warm film:** [Scene] with warm faded colours, soft contrast, gentle grain.
20. **35mm film:** [Scene] shot on 35mm film, visible grain, gentle halation.$b7$, 556),
  ($c8$motion$c8$, $k8$prompts$k8$, $t8$Prompts for motion graphics$t8$, $s8$Ten prompts for titles, logos, explainers and loops.$s8$, $b8$1. **Title reveal:** Animate the text "[title]": letters fade and slide up over 0.6 seconds with ease-out, hold 2 seconds, then fade out. Clean [font], [palette], centred.
2. **Logo sting:** A 3-second logo reveal: [logo] builds from simple shapes with ease-out, small settle, holds on a clean final frame.
3. **Lower third:** A [colour] bar slides in from the left in 0.4 seconds, name "[name]" and role "[role]" fade in, hold 4 seconds, exit in reverse.
4. **Kinetic type:** Kinetic typography for "[quote]": each word appears in time with speech, key words larger and bolder, ease-out.
5. **Background loop:** Seamless 6-second loop of [abstract shapes] in [palette], slow movement, no flashes, dark enough for white text.
6. **Explainer script:** Write a 30-second explainer for [product]: problem 5 s, idea 5 s, three steps 15 s, result 5 s, with visuals per scene.
7. **Storyboard:** Create a six-frame storyboard for this script with visual, motion and seconds per frame: [paste].
8. **Chart animation:** Animate this chart: reveal one series at a time, highlight the key point, label it, cite the source, start bars at zero: [data].
9. **Motion style guide:** Write a one-page motion style guide for [brand]: timing, easing, allowed and banned effects, colours, fonts, reduced-motion rule.
10. **Reduced-motion version:** Redesign this animation for viewers who prefer reduced motion, keeping the meaning: [describe].$b8$, 657),
  ($c9$audio$c9$, $k9$prompts$k9$, $t9$Prompts for voice, music and sound$t9$, $s9$Ten prompts for narration, music briefs and sound design.$s9$, $b9$1. **Script for speaking:** Rewrite this for the ear: short sentences, contractions, one idea per sentence, pauses marked with commas: [paste].
2. **Voice direction:** Direction for the read: [who is speaking, to whom, feeling]. Pace [slow/medium/fast], smile on the last line. Generate three takes.
3. **Music brief:** [Genre], [mood], [tempo] BPM, [instruments], no vocals, [length], gentle build, clean ending.
4. **Sting:** A 3-second sound logo for [brand]: [instrument or timbre], rising two notes, ends on a warm resolved note.
5. **Ambience:** A 60-second ambience of [place]: a bed of [constant sound], details of [occasional sounds], one passing [movement].
6. **UI sounds:** Six soft interface sounds for [app]: tap, success, error, notification, swipe, toggle. Short, non-annoying, same family.
7. **Podcast outline:** Outline a 10-minute episode on [topic]: cold open, intro, three segments, one story, call to action, and a written outro.
8. **Interview questions:** Write eight open, neutral questions for [guest] about [topic], plus a consent line to read before recording.
9. **Pronunciation sheet:** List every name, number and technical term in this script with a phonetic spelling: [paste].
10. **Transcript check:** Compare this transcript with the script and list every difference, especially names and numbers: [paste both].$b9$, 758),
  ($c10$research$c10$, $k10$prompts$k10$, $t10$Prompts for research and data$t10$, $s10$Ten prompts that produce checkable answers.$s10$, $b10$1. **Sharpen the question:** Turn the topic "[topic]" into one specific research question, four sub-questions and the evidence that would answer each.
2. **Search plan:** Suggest keywords and synonyms, source types, date range and exclusion rules for "[question]".
3. **Claims with sources:** What do studies from [years] say about [topic]? For each claim give the source, sample size and how sure the evidence is. Say what you could not find.
4. **Rate a source:** Ask me questions about the author, date, evidence, funding and bias of this source, then summarise how far to trust it: [paste].
5. **Extract to a table:** For each paper below extract question, method, sample, result, limits and link into one table. Quote the sentences you used: [paste].
6. **What contradicts it:** Here is a claim: [claim]. List three alternative explanations and how I could test each.
7. **Data description:** Here are 20 rows: [paste]. Describe columns, likely units, missing values and anything odd to check before analysis.
8. **Query help:** Write a SQL query that [question] on tables [describe]. Explain each clause and give a way to check the result by hand.
9. **Choose a chart:** I want to show [comparison, trend, share or relationship] with these columns: [list]. Recommend a chart, labels and how to avoid misleading readers.
10. **Plain-language findings:** Rewrite these findings for a non-expert: one main message, what is certain, what is uncertain, what to do next: [paste].$b10$, 859),
  ($c11$business$c11$, $k11$prompts$k11$, $t11$Prompts for freelancing and client work$t11$, $s11$Ten prompts from offer to invoice.$s11$, $b11$1. **Offer:** Turn this skill into an offer for [client type]: the problem, the result, what is included and excluded, price options and timeline: [skill].
2. **Customer profile:** Write a one-page profile of [client type]: role, goals, frustrations, where they look for help, and questions to ask in five interviews.
3. **Discovery call:** Write ten open questions for a discovery call about [service]: goals, past attempts, constraints, budget, timing, decision makers.
4. **Proposal:** Draft a two-page proposal for [client] using their words about the problem: [notes]. Three options, timeline, price, exclusions, one next step.
5. **Scope:** Write a scope for [service]: deliverables, exclusions, assumptions, acceptance criteria, revision rounds, change request process.
6. **Outreach:** Write a two-line personal note to [person] about [observation]. Useful, no pressure, easy to say no.
7. **Handle scope creep:** Write a polite reply to a client asking for extra work outside scope, offering a paid option: [describe request].
8. **AI-use note:** Write a short client-facing note on how I use AI, what I check by hand and how I protect confidential information.
9. **Case study:** Write a case study from these facts only: client [type], problem [ ], what I did [ ], results [numbers]. Mark anything I should confirm.
10. **Invoice chase:** Write three polite follow-ups for an overdue invoice, on day 3, 10 and 20, each firmer, referring to our agreed terms.$b11$, 960)
on conflict (category, title) do nothing;
