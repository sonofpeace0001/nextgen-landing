-- Free Resource Library: glossaries, tool guides, templates, checklists and guides for each category.
create table if not exists public.resource (
  id         serial primary key,
  category   text not null,
  kind       text not null check (kind in ('glossary','tools','templates','checklist','guide')),
  title      text not null,
  summary    text,
  body_md    text not null,
  sort_order int  not null default 0,
  is_published boolean not null default true,
  created_at timestamptz not null default now(),
  unique (category, title)
);
alter table public.resource enable row level security;
drop policy if exists "resource readable by all" on public.resource;
create policy "resource readable by all" on public.resource for select to anon, authenticated using (is_published);
insert into public.resource (category, kind, title, summary, body_md, sort_order) values
  ($c1$general$c1$, $k1$guide$k1$, $t1$The prompt formula: context, task, format, example$t1$, $s1$A four-part way to write prompts that get useful first drafts.$s1$, $b1$A prompt is a brief for a fast, literal assistant. Give it what a good freelancer would need.

- **Context:** who it is for and why it matters.
- **Task:** the exact thing to produce.
- **Format:** length, structure and tone.
- **Example:** a sample of what good looks like (optional, very powerful).

**Weak:** "Write a post about my bakery."

**Stronger:** "You are writing for students near my bakery (context). Write an Instagram caption announcing our new vegan brownie (task). Friendly, under 40 words, one emoji, ending with a question (format). Match this style: 'Warm cookies, cold weather, zero regrets.' (example)"

Then iterate: name what is wrong and ask for that change. Three short rounds beat one giant prompt.$b1$, 0),
  ($c2$general$c2$, $k2$checklist$k2$, $t2$Safe use of AI: a checklist before you hit publish$t2$, $s2$Privacy, rights, accuracy and honesty in one page.$s2$, $b2$Run this before you share or sell anything made with AI.

- I did not paste passwords, ID numbers, bank details or private client files into a tool I have not checked.
- I checked every fact, number, name and quote against a source I opened myself.
- I have the right to use every image, sound, font and text in this work (licence checked).
- I did not use a real person's face or voice without clear written permission.
- I said where AI helped if the client, school or platform expects it.
- Nothing here is misleading about what is real, what is generated and what a product does.
- I know where to report or correct a mistake.$b2$, 1),
  ($c3$general$c3$, $k3$guide$k3$, $t3$How to verify what an AI tells you$t3$, $s3$A fast routine for catching confident mistakes.$s3$, $b3$AI is fluent even when it is wrong. Use this routine for anything that matters.

1. **Separate claims.** List each fact, number, date, name and quote.
2. **Ask for sources**, then open them. Fake citations look real.
3. **Find the passage.** Does the source really say it?
4. **Check numbers** by hand on a small example.
5. **Look for the opposite.** Search for evidence that disagrees.
6. **Record it.** Keep a log: claim, source, verified yes or no.

If you cannot verify a claim, soften it, label it as unverified or remove it.$b3$, 2),
  ($c4$general$c4$, $k4$templates$k4$, $t4$A one-page brief you can reuse for any project$t4$, $s4$Fill this in before you open any tool.$s4$, $b4$Copy this and fill it in.

- **Goal:** what should exist at the end, and why?
- **Audience:** who is it for and what do they already know?
- **Deliverables:** exactly what will you hand over (sizes, formats, length)?
- **Tone and style:** three words, plus one example you like.
- **Must include:** facts, names, logos, calls to action.
- **Must avoid:** things that would be wrong, off-brand or unsafe.
- **Deadline and budget:** time, credits and money you will spend.
- **How I will judge success:** two or three checks a stranger could apply.$b4$, 3),
  ($c5$general$c5$, $k5$glossary$k5$, $t5$AI glossary for beginners$t5$, $s5$The words you will meet in every course.$s5$, $b5$- **Model:** software trained on lots of data that predicts useful output from your input.
- **Prompt:** the instructions and context you give a model.
- **Token:** a small chunk of text a model reads or writes; limits and prices are often counted in tokens.
- **Context window:** how much text a model can consider at once.
- **Hallucination:** confident output that is false or invented.
- **Temperature:** a setting that makes output more predictable (low) or more varied (high).
- **Fine-tuning:** further training a model on your own examples.
- **Retrieval (RAG):** looking up relevant documents first, then answering from them.
- **Agent:** a model plus tools, memory and a goal that can take steps for you.
- **Tool use:** a model calling an outside function such as search or a calendar.
- **MCP:** a common standard for describing tools so agents can connect to them.
- **Guardrail:** a rule or check that limits what a model or agent can do.
- **Multimodal:** handling more than one kind of input, such as text and images.
- **Open-weight:** a model whose files you can download and run yourself, under its licence.
- **Provenance:** the record of where an asset came from and who made it.$b5$, 4),
  ($c6$general$c6$, $k6$guide$k6$, $t6$Choosing tools: how to compare and what to record$t6$, $s6$A method that survives tools changing every month.$s6$, $b6$Tools and prices change quickly. Compare them the same way each time.

- **Job:** what exactly do you need it to do?
- **Quality:** run the same test brief in each tool.
- **Control:** can you steer it (references, settings, editing)?
- **Cost:** credits or price per finished, approved result, not per try.
- **Licence:** may you use the output commercially? Read the current terms.
- **Data:** what does it store and who can see your inputs?
- **Exit:** can you export your work if you leave?

Write the date next to what you learned. Start with one main workspace such as [CREAO](https://agent.creao.ai/@Sonofpeace) (referral link), then add specialist tools only when a job needs them.$b6$, 5),
  ($c7$graphics$c7$, $k7$glossary$k7$, $t7$Graphic design glossary$t7$, $s7$Terms for layout, colour, type and production.$s7$, $b7$- **Hierarchy:** the order in which the eye reads a design.
- **Contrast:** clear difference between elements (size, colour, weight).
- **Alignment:** lining elements up on shared edges.
- **Proximity:** grouping related items close together.
- **Negative space:** empty area that gives elements room.
- **Grid:** invisible columns and margins that keep a layout consistent.
- **Kerning / leading / tracking:** spacing between letter pairs, lines and across a word.
- **Serif / sans-serif:** fonts with or without small strokes on letters.
- **Vector / raster:** shapes that scale without blur versus pixels.
- **Bleed:** extra image beyond the trim line so printing has no white edge.
- **CMYK / RGB:** colour systems for print and screens.
- **Dieline:** the flat template of a package.
- **Mockup:** a design shown in context, such as on a bag or phone.
- **Inpainting:** changing part of an image while keeping the rest.
- **Seed / reference image:** a starting value or picture that steers a generation.$b7$, 106),
  ($c8$graphics$c8$, $k8$tools$k8$, $t8$Graphics tool guide: what to use for which job$t8$, $s8$Pick tools by the job, then check current licences.$s8$, $b8$Check each tool's current price and commercial terms before you rely on it.

- **Concepts and images:** image generators (for example Firefly, Midjourney, Ideogram, or the image tools in [CREAO](https://agent.creao.ai/@Sonofpeace) (referral link)). Use them for ideas and assets, not for long text.
- **Text-heavy layouts:** a layout tool such as Canva or Figma. Add all words there so spelling is perfect.
- **Photo fixes and cut-outs:** an editor such as Photopea or a phone editor, plus the AI erase and fill features.
- **Logos and icons:** a vector tool (Figma, Illustrator, Inkscape) so the result scales.
- **Mockups:** template mockups inside your design tool.
- **Batch work:** a workspace that can run repeatable workflows with your style rules.

Rule of thumb: generate the picture in one tool, add the words in another, export in the right format for the destination.$b8$, 107),
  ($c9$graphics$c9$, $k9$templates$k9$, $t9$Image prompt block for a consistent brand look$t9$, $s9$Paste this at the end of every prompt.$s9$, $b9$Copy and edit the brackets.

**Style block:** [brand name] look: [three adjectives]. Colour palette: [hex codes with roles]. Lighting: [soft daylight / studio / golden hour]. Framing: [close-up / centred / rule of thirds with space at top for text]. Texture: [paper grain / clean / glossy]. Avoid: [text, watermarks, extra fingers, cluttered backgrounds].

**Full prompt:** [subject and action], [setting]. Then paste the style block. Keep the block identical between images and change only the subject.$b9$, 108),
  ($c10$graphics$c10$, $k10$checklist$k10$, $t10$Before you export or publish a graphic$t10$, $s10$Ten quick checks.$s10$, $b10$- Is the message clear in two seconds?
- Is there one obvious focal point and a clear order after it?
- Is all text spelled correctly, at least 16 px on a phone, with strong contrast?
- Do margins and alignment feel consistent?
- Are colours from the palette, and does the design work in one colour?
- Have I zoomed to 200 percent and checked hands, faces, edges and text for AI flaws?
- Is the size and ratio right for the platform?
- Is the format right (PNG, JPG, PDF, SVG) and the file size reasonable?
- Do I have the right to use every image and font?
- Have I saved the source file and my prompts?$b10$, 109),
  ($c11$graphics$c11$, $k11$guide$k11$, $t11$Common graphic mistakes and quick fixes$t11$, $s11$Spot the problem, apply the fix.$s11$, $b11$- **Everything is the same size.** Make the most important thing much bigger.
- **Text is hard to read.** Raise contrast, increase size, or put a solid shape behind it.
- **Looks crowded.** Remove one element, add margin, group related items.
- **Colours clash.** Use one dominant colour, one supporting colour and one accent (about 60, 30 and 10 percent).
- **Fonts fight.** Use two fonts at most, paired by contrast.
- **AI image has odd details.** Regenerate or inpaint that area, or crop it out.
- **Set does not match.** Reuse a style block, palette and layout template.
- **Blurry when printed.** Export at higher resolution and check 300 dpi at final size.$b11$, 100),
  ($c12$content$c12$, $k12$glossary$k12$, $t12$Content and writing glossary$t12$, $s12$Terms writers and marketers use.$s12$, $b12$- **Audience:** the specific reader you are writing for.
- **Angle:** the distinctive point of view of a piece.
- **Hook:** the opening that earns the next line.
- **Spine:** the one sentence a whole piece proves.
- **Voice:** the recognisable way you write; **tone** is how it changes by situation.
- **Call to action (CTA):** the one thing you want the reader to do next.
- **Search intent:** what a searcher is trying to do: learn, compare, buy or fix.
- **Meta description:** the short summary shown under a search result.
- **Long-form:** in-depth writing, often over a thousand words.
- **Microcopy:** small interface text such as buttons and error messages.
- **Lead magnet:** a free resource offered in exchange for an email address.
- **Repurposing:** reshaping one idea into several formats.
- **Style guide:** rules for voice, spelling, formatting and sourcing.
- **Fact-check:** verifying each claim against a source you opened.$b12$, 201),
  ($c13$content$c13$, $k13$tools$k13$, $t13$Writing tool guide$t13$, $s13$What to use for drafting, editing, research and publishing.$s13$, $b13$Tools change often; check current terms and pricing.

- **Drafting and ideas:** a general assistant, or [CREAO](https://agent.creao.ai/@Sonofpeace) (referral link) for saved voice, audience and repeatable workflows.
- **Research with sources:** search assistants that cite sources, and document tools that answer only from files you provide. Always open the sources.
- **Editing:** a grammar and style checker for typos, plus reading your work aloud.
- **SEO basics:** search suggestions, "people also ask", and a search dashboard for your own pages.
- **Plagiarism and originality:** an originality checker for anything you deliver to a client.
- **Publishing and email:** a blog or newsletter platform with consent and unsubscribe built in.

Rule of thumb: AI drafts, you decide, and a person verifies facts.$b13$, 202),
  ($c14$content$c14$, $k14$templates$k14$, $t14$Content brief template$t14$, $s14$Give this to a writer or an AI before drafting.$s14$, $b14$- **Working title:**
- **Reader:** who, what they know, what they need to do afterwards.
- **Search intent or purpose:** learn, compare, buy, fix.
- **Angle:** what will make this different from what already exists.
- **Questions to answer:** five to eight.
- **Outline:** headings in order.
- **Sources to use:** links you have opened.
- **Length and tone:** words, voice traits and examples.
- **Internal links and CTA:**
- **Avoid:** claims you cannot prove, clichés, competitors' names.$b14$, 203),
  ($c15$content$c15$, $k15$checklist$k15$, $t15$Editing and fact-check checklist$t15$, $s15$Before you publish or send to a client.$s15$, $b15$- The spine (one-sentence promise) is clear and the piece proves it.
- The opening earns the next paragraph.
- Every number, date, name and quote is checked against a source I opened.
- Claims I cannot prove are softened or removed.
- AI habits are edited out (stacked adjectives, tidy morals, "in today's world").
- Sentences vary in length and the piece reads well aloud.
- Headings tell the story when read alone.
- Links use descriptive text and all work.
- Images have alt text.
- The call to action is one clear step.
- Spelling of names and terms is consistent.
- Disclosure of AI help is included if required.$b15$, 204),
  ($c16$content$c16$, $k16$guide$k16$, $t16$Twelve headline and hook formulas$t16$, $s16$Ready patterns to adapt honestly.$s16$, $b16$1. **The result:** "How I [result] in [time] without [pain]." Only if it is true.
2. **The question:** "Are you making this [mistake] with [thing]?"
3. **The number:** "[Number] ways to [outcome] (and one to avoid)."
4. **The contrast:** "[Common belief] is wrong. Here is what works."
5. **The story:** "The day I lost [thing] taught me [lesson]."
6. **The how-to:** "How to [task] in [steps]."
7. **The warning:** "Before you [action], read this."
8. **The comparison:** "[A] vs [B]: which should you pick?"
9. **The secret you can prove:** "The [small habit] top [people] use."
10. **The specific promise:** "A one-page plan for [audience] to [goal]."
11. **The list of mistakes:** "[Number] mistakes that cost [audience] [thing]."
12. **The plain statement:** "[Clear claim]. Here is the proof."

Test at least five versions and keep the one that says the most in the fewest honest words.$b16$, 205),
  ($c17$apps$c17$, $k17$glossary$k17$, $t17$Apps and tools glossary$t17$, $s17$The vocabulary of building tools without code.$s17$, $b17$- **Input, logic, output:** what goes in, the rules applied, what comes out.
- **User story:** "As a [person] I want [action] so that [benefit]."
- **MVP:** the smallest version that does one job end to end.
- **Wireframe:** a rough sketch of a screen's layout.
- **Database / table / field:** where an app stores information, in rows and columns.
- **Authentication:** proving who a user is (sign-in). **Authorisation:** what they may do.
- **Permission / role:** what a type of user can view or change.
- **API:** a way for one tool to ask another for data or actions.
- **Webhook:** a message another service sends when something happens.
- **JSON:** a common format for labelled data.
- **State:** the current condition of something (new, paid, shipped).
- **Environment:** a separate copy of an app, such as test or live.
- **Deployment:** publishing a version so users can reach it.
- **Rate limit:** a cap on how often something may be used.
- **Acceptance test:** a plain check that a feature works ("When I do X, I see Y").$b17$, 306),
  ($c18$apps$c18$, $k18$tools$k18$, $t18$App-building tool guide$t18$, $s18$Choose by how much control and how much risk you need.$s18$, $b18$Check current features, pricing, data location and export options.

- **Chat-to-app builders:** describe the tool and get a working version. Good for first versions and prototypes. [CREAO](https://agent.creao.ai/@Sonofpeace) (referral link) is our recommended starting workspace; others include Lovable, Bolt and Replit.
- **Spreadsheet-based tools:** fast for small, low-risk data with one or two editors.
- **Form and workflow tools:** best when the job is collect, route and notify.
- **Databases with sign-in:** use a real database when several people write data, rules matter or data is sensitive.
- **Automation platforms:** connect services (Zapier, Make, n8n) for simple links.
- **Analytics:** a privacy-friendly tool for a few events tied to real questions.

Rule of thumb: prototype fast, then harden anything that holds other people's data.$b18$, 307),
  ($c19$apps$c19$, $k19$templates$k19$, $t19$Product brief and acceptance tests$t19$, $s19$Fill in before you prompt a builder.$s19$, $b19$**Product brief**
- For: [user]
- One job it does: [sentence]
- Screens: [list]
- Data it stores: [fields and types; mark personal data]
- Will not do (v1): [two things]
- Success looks like: [a number]

**Acceptance tests** (five per feature)
1. When I [normal action], I see [result].
2. When I leave [field] empty, I see [error] and my other data stays.
3. When I enter a very long [input], [expected behaviour].
4. When I am [role], I cannot [action].
5. When I go back or double-click, [nothing breaks].$b19$, 308),
  ($c20$apps$c20$, $k20$checklist$k20$, $t20$Pre-launch checklist for a small tool$t20$, $s20$Twelve checks before real users arrive.$s20$, $b20$- The one job works end to end.
- Ten tests pass: normal, empty, long, wrong type, double-click, back button.
- Users cannot see each other's data (tested with two accounts).
- Secrets and keys are stored in secret settings, not in the page.
- Uploads are limited by type and size.
- Error messages say what happened and what to do.
- It works on a phone and with the keyboard only.
- A privacy note says what is collected, why and how to delete it.
- Backups run and a restore was tested once.
- Monitoring alerts someone when it breaks.
- Costs and per-user limits are set for any paid feature.
- There is an easy way to ask for help.$b20$, 309),
  ($c21$apps$c21$, $k21$guide$k21$, $t21$Debugging in plain steps$t21$, $s21$A calm routine for when something breaks.$s21$, $b21$1. **Reproduce it.** Write the exact steps that trigger the problem.
2. **Read the message.** Copy the error text exactly.
3. **Check what changed.** Undo the last change if you can.
4. **Narrow it down.** Test one thing at a time.
5. **Ask for help well.** Give your AI assistant: what you expected, what happened, the steps and the relevant part.
6. **Fix and retest.** Run the original steps and your test list.
7. **Write it down.** One line: cause and fix.

Avoid changing five things at once, and avoid accepting code you cannot explain.$b21$, 300),
  ($c22$agents$c22$, $k22$glossary$k22$, $t22$AI agents glossary$t22$, $s22$Words for agents, tools and automation.$s22$, $b22$- **Chatbot / automation / agent:** answers when asked / runs fixed steps / pursues a goal and chooses steps.
- **Tool:** an action an agent may call, such as search or create a draft.
- **MCP (Model Context Protocol):** a common standard for describing and connecting tools.
- **Permission (least privilege):** giving only the access the task needs.
- **Trigger:** what starts a run (schedule, email, form).
- **Workflow:** a chain of steps with data passed between them.
- **Human in the loop:** a person approves risky steps.
- **Idempotency:** running the same event twice has the same effect as once.
- **Retrieval (RAG):** finding relevant passages before answering.
- **Grounding:** tying answers to sources.
- **Prompt injection:** hidden instructions in content the agent reads.
- **Trace:** a record of every step an agent took.
- **Evaluation set:** realistic tasks with expected results used to test changes.
- **Guardrail:** a rule or check that limits behaviour.
- **Rollback:** returning to the previous working version.$b22$, 401),
  ($c23$agents$c23$, $k23$tools$k23$, $t23$Agent and automation tool guide$t23$, $s23$Match the tool to the job and the risk.$s23$, $b23$Check current pricing, limits, data handling and security features.

- **General agent workspace:** build, connect and schedule agents in one place: [CREAO](https://agent.creao.ai/@Sonofpeace) (referral link).
- **Workflow platforms:** Zapier, Make and n8n for trigger-and-action flows.
- **Knowledge tools:** document assistants that answer only from your files, with citations.
- **Approval channels:** email or chat approvals so a person confirms risky steps.
- **Logging and monitoring:** any dashboard that records runs, errors, cost and interventions.
- **Secrets storage:** the platform's secret settings or a password vault.

Rule of thumb: start with read-only access and drafts, add actions only with approvals.$b23$, 402),
  ($c24$agents$c24$, $k24$templates$k24$, $t24$Agent job description$t24$, $s24$Fill this in before you build.$s24$, $b24$- **Role:** [one line]
- **Goal:** [the result it should produce]
- **Inputs:** [what it receives]
- **Tools and permissions:** [tool: read / draft / act]
- **Rules and limits:** [what it must never do]
- **Output format:** [fields, length, tone]
- **When to stop and ask a human:** [uncertainty, anger, legal words, money]
- **Approval steps:** [which actions need a person]
- **Logging:** [what is recorded]
- **Budget:** [max cost and steps per run]$b24$, 403),
  ($c25$agents$c25$, $k25$checklist$k25$, $t25$Agent safety checklist$t25$, $s25$Before an agent touches real work.$s25$, $b25$- Every tool has the minimum permission it needs.
- Sending, paying, deleting and publishing need human approval.
- Secrets are stored securely and never appear in prompts or logs.
- Content the agent reads is treated as data, not instructions.
- There is a step limit, a cost limit and a kill switch.
- Failures alert a person and are logged.
- It says "not found" instead of guessing when sources lack the answer.
- It was tested on at least 20 realistic tasks, including traps.
- Personal data is minimised and retention is defined.
- Users are told when they are dealing with automation, with a route to a human.
- There is a rollback plan.$b25$, 404),
  ($c26$agents$c26$, $k26$guide$k26$, $t26$Automation ideas by team$t26$, $s26$Good first jobs, with the guard for each.$s26$, $b26$- **Support:** draft replies from approved answers (guard: never promise refunds; human sends).
- **Sales:** research a lead from public sources and draft a personal note (guard: approval and opt-out).
- **Finance:** extract invoice fields and flag mismatches (guard: no payments without approval).
- **Operations:** summarise meetings into actions with owners (guard: humans confirm owners).
- **Marketing:** turn one article into channel drafts (guard: brand and fact check).
- **People:** schedule interviews and draft feedback summaries (guard: humans decide, avoid biased screening).
- **Research:** weekly digest of new sources (guard: verify before acting).$b26$, 405),
  ($c27$film$c27$, $k27$glossary$k27$, $t27$Film and video glossary$t27$, $s27$Shots, lenses, lighting and editing terms.$s27$, $b27$- **Establishing shot:** wide shot that shows where we are.
- **Close-up / extreme close-up:** a face or detail filling the frame.
- **Over-the-shoulder:** shot from behind one person toward another.
- **POV:** what a character sees.
- **Low / high angle:** camera below or above eye level.
- **Dutch angle:** tilted camera for unease.
- **Dolly / truck / pan / tilt / crane:** moving forward-back, sideways, rotating left-right, rotating up-down, rising.
- **Handheld / steadicam:** shaky or smooth operator-carried camera.
- **Depth of field:** how much of the scene is in focus. **Bokeh:** the look of blurred lights.
- **Focal length:** wide (16-24mm), normal (35-50mm), telephoto (85mm+).
- **Key / fill / rim light:** main light, softer light on shadows, light outlining a subject from behind.
- **High-key / low-key:** bright and even versus dark and contrasty.
- **Golden hour / blue hour:** warm low sun versus cool twilight.
- **J cut / L cut / match cut:** audio leads the picture / audio trails / two shots linked by shape or motion.
- **180-degree rule:** keep the camera on one side of the action line.
- **LUFS:** a loudness measurement for audio delivery.$b27$, 506),
  ($c28$film$c28$, $k28$tools$k28$, $t28$AI video tool guide$t28$, $s28$Pick the model for the job; never depend on one.$s28$, $b28$Video tools change fast and some are retired, so re-check before you build a workflow. Compare current options for the job:

- **Text-to-video for quick ideas:** fast but least controllable.
- **Image-to-video:** approve a still first, then animate it for consistent looks.
- **Camera and reference control:** tools that let you steer moves and keep characters consistent.
- **Talking characters with sound:** tools that generate synchronised audio; always listen to the result.
- **Editing and grading:** a proper editor with scopes for colour, and a mixer for sound.
- **Planning and pipelines:** a workspace such as [CREAO](https://agent.creao.ai/@Sonofpeace) (referral link) for storyboards, prompts and repeatable steps.

For each tool check: clip length, resolution, price per approved second, commercial licence, and consent rules for voices and faces.$b28$, 507),
  ($c29$film$c29$, $k29$templates$k29$, $t29$Shot list and shot prompt templates$t29$, $s29$Plan before you spend credits.$s29$, $b29$**Shot list row:** number | shot type and angle | subject and action | setting | light | lens | movement | duration | sound

**Shot prompt:** [shot type and angle] of [subject] [action] in [setting], [lighting], shot on [lens], [camera movement], [colour grade], [mood]. Avoid: [three to five terms].

**Character sheet:** [name], [age], [face and hair], [clothing], [distinct prop], reference image. Paste into every prompt.

**Continuity list:** costume, props, time of day, weather, screen direction, eyelines.$b29$, 508),
  ($c30$film$c30$, $k30$checklist$k30$, $t30$Before you release a video$t30$, $s30$Craft, rights and ethics.$s30$, $b30$- The first three seconds give a reason to keep watching.
- The story is clear on a phone with the sound off (captions on).
- Character, costume and light stay consistent across shots.
- Faces, hands and edges checked at full size; flawed shots fixed or cut.
- Dialogue is clear; music sits under speech; loudness meets the platform spec.
- Every music, voice, image and effect has a licence recorded.
- Written consent exists for any real person's face or voice.
- Synthetic content is labelled where required.
- Claims in ads are true and substantiated.
- Exported at the right size, ratio and format.
- Credits, disclosure line and source files saved.$b30$, 509),
  ($c31$film$c31$, $k31$guide$k31$, $t31$Camera angle quick reference$t31$, $s31$What each angle usually makes viewers feel.$s31$, $b31$- **Eye level:** neutral, honest.
- **Low angle:** power, threat, heroism.
- **High angle:** vulnerability, smallness.
- **Bird's-eye:** pattern, overview, distance.
- **Worm's-eye:** scale and drama.
- **Dutch angle:** unease or chaos.
- **Over-the-shoulder:** relationship and conversation.
- **POV:** immersion.
- **Close-up:** emotion. **Extreme close-up:** tension or key detail.
- **Wide / extreme wide:** place and scale.
- **Two-shot:** relationship and distance between people.
- **Insert:** important information.

Pair angle with lens and light: a low angle on a wide lens in hard light feels very different from an eye-level portrait in soft light.$b31$, 500),
  ($c32$motion$c32$, $k32$glossary$k32$, $t32$Motion graphics glossary$t32$, $s32$Words for timing, easing and animation systems.$s32$, $b32$- **Keyframe:** a saved value at a point in time.
- **Easing:** how speed changes between keyframes (ease-in, ease-out, ease-in-out).
- **Spring / overshoot:** motion that passes its target slightly, then settles.
- **Anticipation / follow-through / overlap:** small preparation, settling and offset timing.
- **Staging:** directing attention to one thing at a time.
- **Squash and stretch:** flexing shape to suggest weight and speed.
- **Stagger:** delaying items in a group to make a wave.
- **Mask / matte:** hiding or revealing parts of a layer.
- **Parallax:** layers moving at different speeds for depth.
- **Loop:** an animation whose end matches its start.
- **Lottie:** lightweight vector animation format for web and apps.
- **Alpha channel:** transparency in a video or image.
- **Expression / procedural animation:** motion driven by rules or data.
- **Frame rate:** frames per second (24, 30 or 60 are common).
- **Reduced motion:** a user setting asking for less movement.$b32$, 601),
  ($c33$motion$c33$, $k33$tools$k33$, $t33$Motion tool guide$t33$, $s33$Learn one deeply, then add others only when needed.$s33$, $b33$Check current pricing and licences.

- **Deep general-purpose motion:** After Effects.
- **Fast browser-based motion for interface and marketing:** Jitter and similar tools.
- **Procedural and data-driven 2D:** Cavalry.
- **Interactive animation inside apps:** Rive.
- **Lightweight vector animation for web:** Lottie exports.
- **3D:** Blender or Cinema 4D.
- **AI for assets, textures and rough ideas:** image and video generators, or the workspace in [CREAO](https://agent.creao.ai/@Sonofpeace) (referral link).
- **Editing and sound:** a video editor and a mixer.

Note that email clients generally do not run animation formats, so always supply a static fallback.$b33$, 602),
  ($c34$motion$c34$, $k34$templates$k34$, $t34$Motion style guide template$t34$, $s34$One page that keeps a whole set consistent.$s34$, $b34$- **Personality:** three words (for example precise, calm, friendly).
- **Timing tokens:** base 100 ms; entrances 400 ms; exits 250 ms; repositioning 350 ms.
- **Easing:** entrances ease-out, exits ease-in, repositioning ease-in-out.
- **Hierarchy:** primary elements move most; secondary less; only one leads at a time.
- **Allowed effects:** [fades, slides, scale up to 105 percent].
- **Not allowed:** [bounce, flashing, spinning text].
- **Palette and fonts:** [hex codes, font names].
- **Accessibility:** reduced-motion version, no flashing over three times per second, captions.
- **Delivery:** [formats, sizes, frame rate].$b34$, 603),
  ($c35$motion$c35$, $k35$checklist$k35$, $t35$Animation delivery checklist$t35$, $s35$Before you send it to a client.$s35$, $b35$- Message is clear without sound.
- Text stays on screen long enough to read (about one second per three words).
- Motion follows the style guide.
- No flashing over three times per second; reduced-motion version provided.
- Loops join cleanly.
- File formats and sizes match each destination; static fallback included.
- Colours match the brand and text contrast is strong.
- Fonts, music, stock and generated assets are licensed and logged.
- Captions included for spoken content.
- Source project and asset register saved.$b35$, 604),
  ($c36$motion$c36$, $k36$guide$k36$, $t36$Timing cheat sheet$t36$, $s36$Starting values to adjust by eye.$s36$, $b36$- **Small interface change:** 150 to 250 ms.
- **Panel or card moving:** 250 to 400 ms.
- **Full-screen transition:** 400 to 600 ms.
- **Title reveal:** 400 to 800 ms in, 1 to 3 seconds hold, 300 to 500 ms out.
- **Logo sting:** 2 to 4 seconds total, ending on a clean still.
- **Stagger between items:** 40 to 100 ms.
- **Loop for social:** 3 to 6 seconds.

Use ease-out for things arriving, ease-in for things leaving, and keep the same easing family across a project.$b36$, 605),
  ($c37$audio$c37$, $k37$glossary$k37$, $t37$Audio, music and voice glossary$t37$, $s37$Words for sound, mixing and rights.$s37$, $b37$- **Frequency:** how high or low a sound is (bass to treble).
- **EQ:** boosting or cutting frequency ranges.
- **Compression:** reducing the gap between loud and quiet.
- **Limiter:** a hard ceiling that stops peaks.
- **Reverb / delay:** simulated space / repeating echoes.
- **Panning:** placing a sound left to right.
- **LUFS / true peak:** integrated loudness / the highest signal level.
- **Stem:** a grouped track such as voice, music or effects.
- **Foley:** recorded everyday sounds for picture.
- **Ambience / room tone:** background sound of a place.
- **BPM:** tempo in beats per minute.
- **Split sheet:** an agreement on who owns what share of a song.
- **PRO:** a performing rights organisation that collects royalties.
- **Synthetic voice / voice clone:** a generated voice / a copy of a specific person's voice (needs written consent).
- **Transcript:** a written record of speech.$b37$, 706),
  ($c38$audio$c38$, $k38$tools$k38$, $t38$Audio tool guide$t38$, $s38$Match tools to recording, generating, editing and delivery.$s38$, $b38$Check current pricing and, above all, current commercial licence terms.

- **Voice and narration:** text-to-speech platforms with licensed voices; your own voice for authenticity.
- **Music generation:** several AI music generators exist; some suit ideas and demos, others are positioned for client work with licensed training data. Read the current terms and keep records.
- **Recording and editing:** a free editor such as Audacity or a full DAW.
- **Cleanup and enhancement:** noise reduction and speech enhancement tools; use lightly.
- **Mastering and loudness:** meters plus reference tracks; automated mastering suits demos.
- **Podcast hosting:** a host that gives you an RSS feed and analytics.
- **Planning and scripts:** a workspace such as [CREAO](https://agent.creao.ai/@Sonofpeace) (referral link) for scripts, voice notes and repeatable jobs.$b38$, 707),
  ($c39$audio$c39$, $k39$templates$k39$, $t39$Voice consent form and split sheet$t39$, $s39$Two documents to keep on file (not legal advice).$s39$, $b39$**Voice consent form**
- Speaker name and date
- Project and exact permitted uses
- Duration and territories
- Fee and payment date
- Whether the voice may be synthesised, and how it will be labelled
- Right to withdraw and what happens to existing work
- Signature

**Split sheet**
- Song title and date
- Each contributor's name, role and percentage of the composition
- Each contributor's percentage of the recording
- PRO membership numbers if any
- Signatures from everyone

Have a lawyer review contracts for anything commercial.$b39$, 708),
  ($c40$audio$c40$, $k40$checklist$k40$, $t40$Audio release checklist$t40$, $s40$Before you publish or deliver.$s40$, $b40$- Speech is clear; music is under speech.
- Loudness and true peak meet the platform target.
- Checked on headphones, a phone speaker and a car or laptop speaker.
- No clicks, pops, hum or clipping.
- Pronunciations checked; a transcript proofread.
- Every sound, music and voice source has a licence recorded.
- Written consent exists for every real voice.
- Synthetic voices are labelled where required.
- Metadata, cover art and credits complete.
- Files exported in the right formats, with stems if requested.$b40$, 709),
  ($c41$audio$c41$, $k41$guide$k41$, $t41$Mix problems and fixes$t41$, $s41$Hear it, name it, fix it.$s41$, $b41$- **Muddy:** cut a little around 200 to 300 Hz on crowded parts.
- **Harsh:** reduce 2 to 5 kHz slightly on the offending part.
- **Voice hard to hear:** lower the music 10 to 15 dB under speech and compress the voice gently.
- **Thin:** check that low end is not cut too far; reduce competing bass.
- **Too roomy:** shorten or lower the reverb.
- **Lifeless:** ease off compression; leave dynamics.
- **Loud one moment, quiet the next:** automate levels or apply light compression.
- **Sounds different on other speakers:** compare to a reference at the same loudness and check in mono.$b41$, 700),
  ($c42$research$c42$, $k42$glossary$k42$, $t42$Research and data glossary$t42$, $s42$Terms for evidence, statistics and analysis.$s42$, $b42$- **Primary / secondary source:** original evidence versus commentary about it.
- **Peer review:** checking by independent experts before publication.
- **Sample / population:** the group studied / the group you want to describe.
- **Bias:** a systematic distortion, such as who was included.
- **Confounder:** a hidden factor that explains an apparent link.
- **Correlation / causation:** moving together / one causing the other.
- **Mean / median / mode:** average, middle value, most common value.
- **Standard deviation:** typical spread around the mean.
- **Confidence interval:** a range likely to contain the true value.
- **Effect size:** how big a difference is.
- **p-value:** how surprising the data would be if there were no effect (not the chance the result is true).
- **Baseline / control:** where you started / the comparison group.
- **SQL:** a language for querying databases.
- **Reproducibility:** others can repeat your steps and get the same result.
- **Hallucinated citation:** a source an AI invented.$b42$, 801),
  ($c43$research$c43$, $k43$tools$k43$, $t43$Research tool guide$t43$, $s43$Different tools do different research jobs.$s43$, $b43$Check current features and pricing.

- **Discovery:** search assistants that cite web sources, plus academic search for papers.
- **Synthesis of your own sources:** document assistants that answer only from files you upload.
- **Reference management:** a tool to store sources, notes and quotes.
- **Spreadsheets:** pivots, formulas and charts for most analysis.
- **SQL and notebooks:** for larger data and repeatable analysis.
- **Dashboards:** for recurring questions.
- **Scheduled digests and workflows:** agents that watch sources and summarise leads, for example in [CREAO](https://agent.creao.ai/@Sonofpeace) (referral link).

Workflow: discover, gather, synthesise, verify, then think and write. Never skip opening the original sources.$b43$, 802),
  ($c44$research$c44$, $k44$templates$k44$, $t44$Research question and evidence log$t44$, $s44$Two tables to keep every project honest.$s44$, $b44$**Research question sheet**
- Main question (specific, bounded by time, place and group)
- Four sub-questions
- Evidence that would answer each
- Where I will look
- What would make me exclude a source

**Evidence log** (one row per claim)
Claim | Source and link | Exact quote | Date | Strength (strong, moderate, weak) | Verified (yes, no) | Notes$b44$, 803),
  ($c45$research$c45$, $k45$checklist$k45$, $t45$Analysis and claims checklist$t45$, $s45$Before you share conclusions.$s45$, $b45$- The question is specific and the data can answer it.
- Every source was opened and rated for author, date, evidence and bias.
- Data cleaning is logged with row counts before and after.
- Numbers were checked by hand on a small example.
- Charts start bars at zero and are labelled with a source.
- Correlation is not described as causation.
- Uncertainty is shown as ranges or plain words.
- Limits and alternative explanations are stated.
- Private data is protected and permission exists for quotes.
- Someone could reproduce the analysis from my notes.$b45$, 804),
  ($c46$research$c46$, $k46$guide$k46$, $t46$Statistics traps to avoid$t46$, $s46$Common ways numbers mislead.$s46$, $b46$- **Average of a skewed set:** use the median as well.
- **Relative versus absolute change:** "doubled" may be 1 in 1,000 to 2 in 1,000.
- **Tiny samples:** wide uncertainty; avoid big claims.
- **Cherry-picked dates:** show the full period.
- **Truncated axes:** start bars at zero.
- **Comparing unlike groups:** check they were comparable.
- **Many tests, one win:** more tests mean more false alarms.
- **Survivorship:** you only see what remained.
- **Confusing correlation with cause:** look for confounders and better designs.$b46$, 805),
  ($c47$business$c47$, $k47$glossary$k47$, $t47$Freelancing and business glossary$t47$, $s47$Terms for offers, pricing and delivery.$s47$, $b47$- **Niche:** a specific type of client or problem you focus on.
- **Offer:** a clear result, scope, price and timeline.
- **Productised service:** a fixed-scope, fixed-price service.
- **Scope / scope creep:** what is included / extra work creeping in.
- **Deliverable:** a specific thing you hand over.
- **Acceptance criteria:** how a client confirms work is done.
- **Retainer / care plan:** a monthly arrangement for ongoing support.
- **Value-based pricing:** pricing from the result's value, not hours.
- **Deposit / milestone payment:** part payment up front or at stages.
- **Discovery call:** a conversation to find the real need.
- **Proposal:** a written offer for a specific client.
- **Case study:** an honest story of a client result.
- **Conversion rate:** the share of leads who become clients.
- **Margin / runway:** profit share of revenue / months of cash left.
- **Ownership / IP:** who owns the work and when.$b47$, 906),
  ($c48$business$c48$, $k48$tools$k48$, $t48$Business tool guide$t48$, $s48$Simple systems for a one-person business.$s48$, $b48$Check current pricing and data handling.

- **Offer page and portfolio:** a simple site or document you control.
- **Proposals and contracts:** templates plus e-signature.
- **Client tracking:** a spreadsheet or light CRM.
- **Invoicing and accounting:** invoicing software and a separate business account.
- **Scheduling:** a booking page for discovery calls.
- **Automation for admin:** agents that draft reminders, research and reports, with your approval: for example in [CREAO](https://agent.creao.ai/@Sonofpeace) (referral link).
- **Communities:** places where your clients gather and you can help honestly.

Keep client data in tools you have vetted, and tell clients how you use AI.$b48$, 907),
  ($c49$business$c49$, $k49$templates$k49$, $t49$Offer page and proposal skeleton$t49$, $s49$Two short structures to copy.$s49$, $b49$**Offer page**
1. Who it is for
2. The problem in their words
3. The result you deliver
4. What is included and what is not
5. Price and timeline
6. Proof (real case study or clearly labelled example)
7. How it works (three steps)
8. FAQ
9. One clear next step

**Proposal (two pages)**
1. Their problem, in their words
2. Recommended approach and outcome
3. Three options with scope, exclusions and price
4. Timeline with milestones
5. Terms: revisions, payment, ownership, AI use
6. Validity date and one next step$b49$, 908),
  ($c50$business$c50$, $k50$checklist$k50$, $t50$Client project checklist$t50$, $s50$From first call to handover.$s50$, $b50$- Discovery notes and a summary sent to the client.
- Written scope with exclusions and acceptance criteria.
- Signed agreement covering payment, ownership, confidentiality and AI use.
- Deposit received.
- Data map of tools that will see client data, with consent.
- Milestones and approvals recorded in writing.
- Change requests handled with price and time impact.
- QA checklist passed before delivery.
- Handover pack, access transfer and care plan offered.
- Final invoice sent and follow-up reminders scheduled.
- Testimonial requested with permission; case study drafted.$b50$, 909),
  ($c51$business$c51$, $k51$guide$k51$, $t51$Honest claims for AI service sellers$t51$, $s51$Say what is true and provable.$s51$, $b51$- Do not promise guaranteed income, rankings or results you cannot control.
- Show measured examples with baselines and say they are examples.
- Never invent testimonials, reviews, logos or case studies.
- Label practice work as practice work.
- Say when AI helped, and what you checked by hand.
- Protect client confidentiality in every case study.
- State limits: what your service cannot do.
- Follow advertising and email rules where you and your clients are based.
- Correct mistakes publicly and promptly.$b51$, 900)
on conflict (category, title) do nothing;
