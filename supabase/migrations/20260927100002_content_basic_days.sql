-- Content & writing, Basic tier (days 1-30). Authored content, UNPUBLISHED until a person reviews it in Admin.
insert into public.day
  (track_id, tier_id, day_number, title, objective, lesson_md, skill_focus, assignment_md, rubric,
   est_minutes, is_published, credit_budget, submission_type, ai_evaluate)
select t.id, ti.id, v.n, v.title, v.objective, v.lesson_md, v.skill_focus, v.assignment_md, v.rubric,
       v.est_minutes, false, null, v.submission_type, v.ai_evaluate
from public.track t
join public.tier ti on ti.track_id = t.id and ti.slug = 'basic'
cross join (values
  (1, $t1a$The writing brief: audience, goal, tone$t1a$, $t1b$Turn a vague request into a three-part brief and see how it changes the result.$t1b$, $t1c$Good writing starts before the first sentence. AI can only write for the person you describe, so describe them.

A writing brief has three parts:

- **Audience:** who will read this, and what do they already know?
- **Goal:** what should they think, feel or do afterwards?
- **Tone:** how should it sound (friendly, direct, formal)?

Compare:

- Weak: *Write a post about healthy eating.*
- Strong: *Write a 150-word Instagram caption for busy parents who are tired of complicated recipes. Goal: get them to save the post. Tone: warm and encouraging, no jargon.*

The strong version tells the AI who it is talking to and what success looks like. You will use this brief in every lesson from now on.

## Today

Pick something you might really write and turn it into a three-part brief.$t1c$, $t1d$Writing a clear brief$t1d$, $t1e$Submit:

1. The weak one-line request.
2. Your three-part brief (audience, goal, tone).
3. The AI's first output, pasted (about 100 to 150 words).
4. One sentence: did it fit your audience? Why or why not?$t1e$, $t1f$[{"criterion": "Audience is specific", "max_points": 40, "guidance": "Names a real reader and what they already know, not just everyone."}, {"criterion": "Goal is clear", "max_points": 30, "guidance": "Says what the reader should do, think or feel."}, {"criterion": "Honest reflection", "max_points": 30, "guidance": "Judges the output against the brief."}]$t1f$::jsonb, 15, 'text', false),
  (2, $t2a$Context and constraints: give the model what it lacks$t2a$, $t2b$Add real context and testable constraints to a prompt and see what changes.$t2b$, $t2c$AI does not know your business, your story or your facts. If you do not supply them, it will invent them, and invented details make writing generic or wrong.

Give it **context** (the facts it needs) and **constraints** (the limits):

- **Facts:** names, numbers, offers, what already happened.
- **Must include:** a point you need covered.
- **Must avoid:** words, claims or cliches you do not want.
- **Length and format.**

Try: *Context: I run a small bakery that sells 12 cake flavours; our best seller is red velvet; orders close at 4pm. Write a 3-sentence WhatsApp broadcast announcing a Saturday offer: 10% off red velvet. Must include the 4pm deadline. Avoid exclamation marks.*

Notice how little the AI has to guess.

## Today

Rewrite one weak prompt three ways, adding context each time.$t2c$, $t2d$Supplying context and limits$t2d$, $t2e$Take one weak request. Submit:

1. The original request.
2. A version with real context added.
3. A version with constraints added (must include, must avoid, length).
4. The best output, pasted.
5. One sentence: which addition changed the output most?$t2e$, $t2f$[{"criterion": "Real context added", "max_points": 40, "guidance": "Facts the AI could not have guessed."}, {"criterion": "Constraints are testable", "max_points": 30, "guidance": "You could check whether the output obeyed them."}, {"criterion": "Insight", "max_points": 30, "guidance": "Explains what changed and why."}]$t2f$::jsonb, 15, 'text', false),
  (3, $t3a$Format and length: shape the output$t3a$, $t3b$Ask for the shape of an answer, not just its content.$t3b$, $t3c$You can ask for the shape of the answer, not only the content. Say the **format** (list, email, table, script), the **length** (words or sentences) and the **structure** (headline, three bullets, one call to action).

Useful phrases:

- "in three short paragraphs"
- "as a numbered list"
- "as a table with columns X and Y"
- "headline under 10 words"

Also ask for **options**: *Give me three headline options in different tones.* Choosing beats guessing.

## Today

Ask for the same idea in three formats and choose the best one for your audience.$t3c$, $t3d$Controlling format and length$t3d$, $t3e$Pick one idea (an event, an offer, a tip). Submit:

1. The three prompts (for example a caption, an email and a short script).
2. The three outputs, pasted.
3. Which format fits your audience best, and why.$t3e$, $t3f$[{"criterion": "Format instructions are specific", "max_points": 35, "guidance": "Each prompt names format, length or structure."}, {"criterion": "Outputs match the requested shape", "max_points": 35, "guidance": "Length and structure were followed."}, {"criterion": "Choice is justified", "max_points": 30, "guidance": "Ties the choice to the audience."}]$t3f$::jsonb, 15, 'text', false),
  (4, $t4a$Examples: show the voice you want$t4a$, $t4b$Use a short example of your own writing to steer the AI's voice.$t4b$, $t4c$Showing beats telling. If you paste a short example of writing you like, the AI can match its rhythm and word choice.

Try: *Here are two paragraphs in the voice I want. Write the next paragraph about X in the same voice.*

Rules:

- Use **your own writing**, or text you have the right to use.
- Never ask it to imitate a living author to pass work off as theirs.
- Check that the output does not copy phrases from your sample.

## Today

Use 100 to 200 words of your own writing as the example.$t4c$, $t4d$Steering voice with examples$t4d$, $t4e$Submit:

1. Your sample (100 to 200 words of your own writing).
2. Your prompt.
3. The AI's output.
4. Three specific ways the output matches or differs from your voice.$t4e$, $t4f$[{"criterion": "Sample and prompt are clear", "max_points": 30, "guidance": "The example is your own and the request is specific."}, {"criterion": "Voice match judged specifically", "max_points": 40, "guidance": "Points to actual words, rhythm or tone."}, {"criterion": "Originality check", "max_points": 30, "guidance": "Confirms nothing was copied from the sample."}]$t4f$::jsonb, 15, 'text', false),
  (5, $t5a$Iterate: three short rounds beat one long prompt$t5a$, $t5b$Improve a piece with specific follow-ups instead of restarting.$t5b$, $t5c$Your first prompt is a starting point. Improve the result with short follow-ups:

1. **Generate.**
2. **Name what is wrong:** "too formal, cut the second paragraph, add a real example."
3. **Polish:** "make the opening more direct."

Be specific about the change and the reason. Avoid "make it better."

Save your prompt versions. The best prompts become templates you reuse.

## Today

Run three rounds on one short piece and keep all three versions.$t5c$, $t5d$Giving specific feedback to the AI$t5d$, $t5e$Submit:

1. An excerpt of the round 1, 2 and 3 outputs.
2. The follow-up prompt you used for each round.
3. One sentence per round on what it fixed.$t5e$, $t5f$[{"criterion": "Follow-ups are specific", "max_points": 40, "guidance": "Each names what to change and why."}, {"criterion": "Each round improved something", "max_points": 40, "guidance": "The versions show real progress."}, {"criterion": "Reflection", "max_points": 20, "guidance": "Explains what each round fixed."}]$t5f$::jsonb, 15, 'text', false),
  (6, $t6a$Module project: one message, three audiences$t6a$, $t6b$Show you can write one message for three different readers using a brief for each.$t6b$, $t6c$Time to show Module 1. Take a single message (an announcement, an offer or a request) and write it for **three different audiences**, with a brief for each.

Example: a study-group meeting change told to (a) classmates on WhatsApp, (b) a lecturer by email, (c) parents in a newsletter.

Success means each version sounds written for that reader while the facts stay the same.

Your work is scored on the rubric below. You can revise and resubmit.$t6c$, $t6d$Writing for different audiences$t6d$, $t6e$Submit:

1. The core message in one sentence.
2. Three briefs (audience, goal, tone).
3. Three final versions (50 to 120 words each).
4. A two-sentence note on what you changed between them and why.$t6e$, $t6f$[{"criterion": "Fit to each audience", "max_points": 30, "guidance": "Each version clearly suits its reader."}, {"criterion": "Tone differences are visible", "max_points": 30, "guidance": "The three do not sound alike."}, {"criterion": "Facts stay consistent", "max_points": 20, "guidance": "Names, dates and offers match across versions."}, {"criterion": "Reflection", "max_points": 20, "guidance": "Explains the changes and the reasons."}]$t6f$::jsonb, 40, 'text', true),
  (7, $t7a$Find one idea worth writing$t7a$, $t7b$Choose one specific claim you can support from your own experience.$t7b$, $t7c$Most weak writing has no clear idea. One piece, one idea.

Test an idea with three questions: **Who is it for? What do they get? What do you know or believe about it that is worth saying?**

Use AI to *generate and test* ideas, not to choose: *Give me 10 angles on X for [audience]. Then tell me which two are the most specific and why.* You pick the one you can support with your own experience or evidence.

Avoid topics ("productivity"). Prefer claims ("A 10-minute daily habit beats a weekend binge").$t7c$, $t7d$Turning a topic into a claim$t7d$, $t7e$Submit:

1. Your topic and audience.
2. The ten AI-generated angles, pasted.
3. Your chosen idea as one sentence.
4. Why you chose it, and what personal experience or evidence supports it.$t7e$, $t7f$[{"criterion": "Claim is specific", "max_points": 40, "guidance": "A statement someone could agree or disagree with."}, {"criterion": "Chosen with reasoning", "max_points": 30, "guidance": "Compared against other angles."}, {"criterion": "Personal support named", "max_points": 30, "guidance": "Says what experience or evidence backs it."}]$t7f$::jsonb, 15, 'text', false),
  (8, $t8a$Angles and hooks$t8a$, $t8b$Write an opening line that makes the right reader keep going.$t8b$, $t8c$A hook is the first line that makes the right reader keep going. Good hooks include a surprising fact you can prove, a clear problem, a short story, a bold but defensible claim, or a direct question.

Ask AI for many, then edit: *Write 8 opening lines for my post in 4 styles: problem, story, claim, question.* Pick one and rewrite it in your voice.

Never invent statistics for a hook. If you use a number, it needs a source you have checked (you will practise this in Module 4).$t8c$, $t8d$Writing strong openings$t8d$, $t8e$Submit:

1. Eight AI hooks, pasted.
2. The one you chose.
3. Your rewritten version in your own voice.
4. Why it fits your audience.$t8e$, $t8f$[{"criterion": "Variety explored", "max_points": 30, "guidance": "Considered different styles of hook."}, {"criterion": "Rewritten in your voice", "max_points": 40, "guidance": "The final line sounds like you, not the AI."}, {"criterion": "No unsourced statistics", "max_points": 30, "guidance": "Any number used has a checked source."}]$t8f$::jsonb, 15, 'text', false),
  (9, $t9a$The outline: claim, proof, close$t9a$, $t9b$Turn your claim into a simple outline you can defend.$t9b$, $t9c$An outline saves you from rambling. A simple structure for short posts:

1. **Claim:** your one idea, stated plainly.
2. **Proof:** two or three points, each with an example or evidence.
3. **Close:** what the reader should do or remember.

Ask AI: *Turn this claim into an outline with three proof points and a closing call to action. Keep each point to one line.* Then change it: cut points you cannot support and add your own examples.$t9c$, $t9d$Structuring an argument$t9d$, $t9e$Submit:

1. Your claim.
2. The AI's outline.
3. Your edited outline.
4. At least two changes you made and why.$t9e$, $t9f$[{"criterion": "Claim is clear", "max_points": 30, "guidance": "One plain sentence."}, {"criterion": "Proof points are supported", "max_points": 40, "guidance": "Each has an example or evidence you can back up."}, {"criterion": "Edited meaningfully", "max_points": 30, "guidance": "The final outline is clearly yours."}]$t9f$::jsonb, 15, 'text', false),
  (10, $t10a$Turn the outline into a draft$t10a$, $t10b$Write a first draft section by section with your own examples.$t10b$, $t10c$Now write the first draft, and keep control. Two good ways:

- **Section by section:** give the AI one outline point at a time with your example, then combine.
- **You write, AI extends:** write the opening and one point yourself, then ask it to continue in your voice.

Give each section its own short brief (length, tone, must include your example). Do not let AI make up examples: supply yours.

First drafts are meant to be rough. You will improve this one in Module 3.$t10c$, $t10d$Drafting with control$t10d$, $t10e$Submit:

1. Your outline.
2. The full draft (200 to 300 words).
3. A list of the real examples you supplied.$t10e$, $t10f$[{"criterion": "Follows the outline", "max_points": 30, "guidance": "Each point appears in order."}, {"criterion": "Real examples used", "max_points": 40, "guidance": "Examples come from you, not invented by the AI."}, {"criterion": "Complete and readable", "max_points": 30, "guidance": "A whole draft, roughly the right length."}]$t10f$::jsonb, 25, 'text', false),
  (11, $t11a$Structure for the reader$t11a$, $t11b$Make a draft easy to skim without changing its meaning.$t11b$, $t11c$Readers skim. Help them.

- Short paragraphs (2 to 4 lines).
- One idea per paragraph, with the first sentence carrying it.
- Headings or bold key phrases for longer pieces.
- A clear next step at the end.

Ask AI to *restructure*, not rewrite: *Reformat this draft with short paragraphs and two subheadings. Do not change my wording.* Then check that the meaning did not change.$t11c$, $t11d$Formatting for skimmers$t11d$, $t11e$Submit:

1. A before excerpt (120+ words).
2. The after excerpt.
3. The prompt you used.
4. Two things you checked to be sure the meaning stayed the same.$t11e$, $t11f$[{"criterion": "Skimmable structure", "max_points": 40, "guidance": "Short paragraphs and clear signposts."}, {"criterion": "Wording preserved", "max_points": 30, "guidance": "Only the layout changed."}, {"criterion": "Meaning check", "max_points": 30, "guidance": "Says how you confirmed nothing changed."}]$t11f$::jsonb, 15, 'text', false),
  (12, $t12a$Module project: outline and draft of a 300-word post$t12a$, $t12b$Show you can go from idea to a clear first draft with real proof.$t12b$, $t12c$Show Module 2: idea, hook, outline and draft. Choose a topic you can genuinely write about. You will polish it in Module 3 and can build your capstone from it.

Success looks like: one clear claim, a strong first line, proof from your own experience, and a draft that reads like a person wrote it.

Your work is scored on the rubric below. You can revise and resubmit.$t12c$, $t12d$From idea to draft$t12d$, $t12e$Submit:

1. Your claim.
2. The hook you chose.
3. Your outline.
4. A draft of 250 to 350 words.
5. A note on which parts you wrote yourself and which the AI helped with.$t12e$, $t12f$[{"criterion": "Idea and claim", "max_points": 25, "guidance": "A specific claim you can support."}, {"criterion": "Hook", "max_points": 20, "guidance": "The opening earns the reader's attention."}, {"criterion": "Structure", "max_points": 25, "guidance": "Clear claim, proof and close."}, {"criterion": "Real proof", "max_points": 30, "guidance": "Examples and evidence from your own experience."}]$t12f$::jsonb, 45, 'text', true),
  (13, $t13a$Read like an editor: what to cut$t13a$, $t13b$Find and cut what does not earn its place.$t13b$, $t13c$Editing is where writing gets good. Read your draft out loud. Mark words that add nothing, repeated ideas, vague claims, and sentences you had to read twice.

Common cuts: "very", "really", "in order to", "it is important to note that", and throat-clearing openings.

Ask AI for a **diagnosis**, not a rewrite: *List the 5 weakest sentences in this draft and say why.* Then you fix them.$t13c$, $t13d$Cutting and tightening$t13d$, $t13e$Submit:

1. A draft excerpt (150+ words).
2. The AI's list of five weak sentences.
3. Your fixes.
4. The word count before and after.$t13e$, $t13f$[{"criterion": "Cuts are justified", "max_points": 40, "guidance": "Each cut removes something that added nothing."}, {"criterion": "Fixes are yours", "max_points": 30, "guidance": "You rewrote the sentences, not the AI."}, {"criterion": "Tighter, same meaning", "max_points": 30, "guidance": "Shorter without losing the point."}]$t13f$::jsonb, 15, 'text', false),
  (14, $t14a$Clarity: plain words and active voice$t14a$, $t14b$Replace jargon and passive sentences with clear, active ones.$t14b$, $t14c$Clear writing uses everyday words and active voice ("The team fixed the bug", not "The bug was fixed by the team").

Checks: Could a smart 12-year-old follow it? Is the subject of each sentence doing something? Are there long chains of "of" and "which"?

Use AI to **flag** passive voice and jargon: *Highlight every passive sentence and every term a beginner might not know.* Then rewrite them yourself, or ask for two alternatives and pick one.$t14c$, $t14d$Writing plainly$t14d$, $t14e$Submit:

1. A paragraph before.
2. The passive sentences and jargon the AI flagged.
3. The paragraph after.
4. How many passive sentences there were before and after.$t14e$, $t14f$[{"criterion": "Passive voice and jargon fixed", "max_points": 40, "guidance": "The flagged items are now clear."}, {"criterion": "Meaning preserved", "max_points": 30, "guidance": "The point did not change."}, {"criterion": "Reads clearly", "max_points": 30, "guidance": "The result is easy to follow."}]$t14f$::jsonb, 15, 'text', false),
  (15, $t15a$Voice: make it sound like you$t15a$, $t15b$Write a voice guide and use it to make AI output sound like you.$t15b$, $t15c$Voice is your habits: sentence length, favourite words, humour, how direct you are. AI output drifts toward a smooth, generic voice.

Make it yours:

1. Write a mini voice guide from three of your own messages: 5 traits, 5 words you use, 5 words you avoid.
2. Paste it into your prompts.
3. Edit by hand: add one specific detail only you know, and cut phrases you would never say.

Read it aloud. If you would not say it, change it.$t15c$, $t15d$Finding and keeping your voice$t15d$, $t15e$Submit:

1. Your voice guide (traits, words you use, words you avoid).
2. A paragraph before your voice edit.
3. The paragraph after.
4. One detail you added that only you would know.$t15e$, $t15f$[{"criterion": "Voice guide is specific", "max_points": 35, "guidance": "Concrete traits and real words, not generic labels."}, {"criterion": "The edit shows your voice", "max_points": 40, "guidance": "The after version sounds noticeably more like you."}, {"criterion": "Personal detail", "max_points": 25, "guidance": "A specific detail that only you could add."}]$t15f$::jsonb, 15, 'text', false),
  (16, $t16a$Rhythm, openings and endings$t16a$, $t16b$Vary sentence length and strengthen the first and last lines.$t16b$, $t16c$Vary sentence length: short sentences land points; longer ones carry explanation. Three long sentences in a row tire the reader.

**Openings:** get to the point in the first two lines.
**Endings:** finish on the takeaway or the next step, not a summary of what you already said.

Ask AI: *Give me 3 alternative openings and 3 alternative endings for this piece.* Choose or blend, then read the piece aloud once more.$t16c$, $t16d$Openings, endings and rhythm$t16d$, $t16e$Submit:

1. Your original opening and ending.
2. The AI's alternatives.
3. Your final opening and ending.
4. Why they are stronger.$t16e$, $t16f$[{"criterion": "Opening gets to the point", "max_points": 35, "guidance": "The reader knows what this is about quickly."}, {"criterion": "Ending gives a takeaway or next step", "max_points": 35, "guidance": "Not a repeat of the middle."}, {"criterion": "Reasoning", "max_points": 30, "guidance": "Explains the improvement."}]$t16f$::jsonb, 15, 'text', false),
  (17, $t17a$Line edit with AI: ask for critique, not a rewrite$t17a$, $t17b$Use AI as an editor while keeping the pen in your own hand.$t17b$, $t17c$If AI rewrites everything, you learn nothing and lose your voice. Use it as an editor:

- *Act as a strict editor. Give feedback on clarity, structure and voice. Do not rewrite.*
- *Where would a reader get confused or bored?*
- *Give three specific edits ranked by impact.*

Then apply the edits yourself, in your own words. Keep what improves the piece and ignore what does not.$t17c$, $t17d$Working with AI as an editor$t17d$, $t17e$Submit:

1. A draft excerpt.
2. The AI's feedback, pasted.
3. The three edits you applied, and any you rejected.
4. A reason for each decision.$t17e$, $t17f$[{"criterion": "Asked for critique, not a rewrite", "max_points": 30, "guidance": "The prompt kept the writing yours."}, {"criterion": "Edits applied by you", "max_points": 40, "guidance": "Changes are in your own words."}, {"criterion": "Rejections are reasoned", "max_points": 30, "guidance": "Explains why you ignored some advice."}]$t17f$::jsonb, 15, 'text', false),
  (18, $t18a$Module project: edit a weak draft$t18a$, $t18b$Turn a weak draft into something clear and recognisably yours.$t18b$, $t18c$Show Module 3. Take a weak draft (your own from Module 2, or a rough set of paragraphs you write on purpose) and edit it into something clear and yours.

Show the before and after, and the choices you made: cuts, clarity fixes, voice and rhythm.

Your work is scored on the rubric below. You can revise and resubmit.$t18c$, $t18d$Editing to a professional standard$t18d$, $t18e$Submit:

1. The draft before (200 to 300 words).
2. The edited version.
3. At least five specific edits with a reason for each.
4. Your voice guide.$t18e$, $t18f$[{"criterion": "Clearer", "max_points": 30, "guidance": "The after version is easier to follow."}, {"criterion": "Sounds like you", "max_points": 25, "guidance": "Matches your voice guide."}, {"criterion": "Edits are explained", "max_points": 25, "guidance": "Each edit has a reason."}, {"criterion": "Meaning preserved", "max_points": 20, "guidance": "The point survives the edit."}]$t18f$::jsonb, 45, 'text', true),
  (19, $t19a$Why AI gets facts wrong$t19a$, $t19b$See for yourself how often confident AI answers are wrong.$t19b$, $t19c$AI writes what **sounds** right, not what it has checked. It can invent quotes, statistics, sources, dates and even people, and state them confidently. These made-up facts are often called hallucinations.

**Higher risk:** numbers, names, dates, quotes, laws, medical or financial claims, and anything recent.
**Lower risk:** rewriting text you supplied, structure, brainstorming and tone.

Rule: never publish a fact you have not checked.$t19c$, $t19d$Knowing where AI is unreliable$t19d$, $t19e$Ask an AI five factual questions in an area you know well (or can verify). Submit:

1. A table: question, AI answer, verdict (right, partly wrong, wrong), and how you checked.
2. The pattern you noticed in the mistakes.$t19e$, $t19f$[{"criterion": "Real verification done", "max_points": 40, "guidance": "Each answer was checked against something reliable."}, {"criterion": "Table is honest", "max_points": 30, "guidance": "Errors are recorded, not hidden."}, {"criterion": "Pattern insight", "max_points": 30, "guidance": "Says what kind of facts went wrong."}]$t19f$::jsonb, 15, 'text', false),
  (20, $t20a$Verify claims: the checking routine$t20a$, $t20b$Use a repeatable routine to check every claim in a piece.$t20b$, $t20c$A simple routine for every published piece:

1. **Highlight** every claim that can be true or false (numbers, names, dates, "studies show").
2. **Check** each against a primary or reputable source (an official site, the original study, a recognised publication).
3. **Fix or cut** anything you cannot confirm.
4. **Note** the source.

Ask AI to **list** claims to check, not to confirm them: *List every factual claim in this text as a checklist.* Confirming is your job.$t20c$, $t20d$Fact-checking method$t20d$, $t20e$Submit:

1. A text of 150+ words.
2. The AI's claim list.
3. Your check of each claim: source and verdict.$t20e$, $t20f$[{"criterion": "Claims listed completely", "max_points": 30, "guidance": "Nothing checkable was missed."}, {"criterion": "Checked against real sources", "max_points": 45, "guidance": "Each verdict points to a source you opened."}, {"criterion": "Fixes or cuts made", "max_points": 25, "guidance": "Unconfirmed claims were corrected or removed."}]$t20f$::jsonb, 15, 'text', false),
  (21, $t21a$Sources and quotes$t21a$, $t21b$Find credible sources, open them, and cite them properly.$t21b$, $t21c$Cite what you rely on. Link to the source or name it (author, title, date). Do not use a quote unless you have seen it in the original. If AI gives you a quote or a link, open it: broken links and invented quotes are common.

Search tools that show their sources can help you find things faster, but they still make mistakes, so you still open the source.

Paraphrase in your own words, and credit ideas that are not yours.$t21c$, $t21d$Sourcing and citing$t21d$, $t21e$Find three credible sources for claims in your piece. For each, submit:

1. The link or citation.
2. A one-line summary in your own words.
3. What you verified inside the source.$t21e$, $t21f$[{"criterion": "Sources are credible and relevant", "max_points": 40, "guidance": "Reputable and actually about the claim."}, {"criterion": "Opened and summarised", "max_points": 35, "guidance": "Shows you read the source."}, {"criterion": "Cited properly", "max_points": 25, "guidance": "Author, title or link is given."}]$t21f$::jsonb, 15, 'text', false),
  (22, $t22a$Names, numbers and dates: the high-risk details$t22a$, $t22b$Catch the small errors that cause the biggest embarrassment.$t22b$, $t22c$The smallest details cause the biggest embarrassments: a wrong name, a wrong date, a misquoted price.

Check: the spelling of every name (people, brands, places); dates and days of the week; numbers and units; currency; links.

Trick: read the piece backwards, line by line, for names and numbers only. Ask a friend to read it too.

Never rely on "AI, please double-check yourself" as your only check.$t22c$, $t22d$Detail checking$t22d$, $t22e$List every name, number and date in your piece (at least eight). For each, submit the source you used to verify it and the result. Note any corrections you made.$t22e$, $t22f$[{"criterion": "List is complete", "max_points": 35, "guidance": "All names, numbers and dates are covered."}, {"criterion": "Verified with real sources", "max_points": 45, "guidance": "Each one has a source."}, {"criterion": "Corrections applied", "max_points": 20, "guidance": "Errors were fixed in the text."}]$t22f$::jsonb, 15, 'text', false),
  (23, $t23a$Disclosure and originality: honest use of AI$t23a$, $t23b$Write down how you will use AI honestly, and check your work is original.$t23b$, $t23c$Use AI honestly. Where it matters (school, clients, journalism, contests), follow the rules: say when AI helped, and never present AI output as fully your own where that is not allowed.

**Originality:** check that your piece is not copying an existing text. Search two distinctive sentences. Do not paste other people's work into prompts without permission.

**Detectors:** AI-detection tools are unreliable and can flag human writing. Do not rely on them and do not try to game them. Focus on doing your own thinking, editing and checking, and on being honest.$t23c$, $t23d$Honest, original AI use$t23d$, $t23e$Submit:

1. Your personal AI-use note (100 to 150 words): what you use AI for, what you always do yourself, and how you disclose it.
2. The result of an originality search on two distinctive sentences from your piece.$t23e$, $t23f$[{"criterion": "Note is specific and honest", "max_points": 45, "guidance": "Clear about what AI does and what you do."}, {"criterion": "Originality check done", "max_points": 30, "guidance": "Shows the search and the result."}, {"criterion": "Clear boundaries", "max_points": 25, "guidance": "States where you will and will not use AI."}]$t23f$::jsonb, 15, 'text', false),
  (24, $t24a$Module project: a fact-checked one-pager$t24a$, $t24b$Publish-ready accuracy: write a short explainer and verify every claim.$t24b$, $t24c$Show Module 4. Write a one-page explainer (250 to 350 words) on a topic where facts matter, using AI to draft or structure it, then verify everything.

Success looks like a piece where every claim has a source you opened, and where you are honest about how AI was used.

Your work is scored on the rubric below. You can revise and resubmit.$t24c$, $t24d$Accuracy and honesty$t24d$, $t24e$Submit:

1. The one-pager (250 to 350 words).
2. A claims table: claim, source link, verified (yes or no), and any change made.
3. A two-sentence note on how you used AI.$t24e$, $t24f$[{"criterion": "Accuracy and verification", "max_points": 40, "guidance": "Claims are correct and checked against sources."}, {"criterion": "Sources cited", "max_points": 25, "guidance": "Readers can find the sources."}, {"criterion": "Clarity", "max_points": 20, "guidance": "Easy to read and well organised."}, {"criterion": "Honest AI note", "max_points": 15, "guidance": "Says clearly how AI was used."}]$t24f$::jsonb, 45, 'text', true),
  (25, $t25a$Capstone 1: choose your topic and audience$t25a$, $t25b$Set up the piece you will publish: brief, claim and evidence.$t25b$, $t25c$The capstone brings everything together: a 400-word post you would be proud to publish. Choose a topic you know, an audience you can name and a goal.

Test it: Can you state the claim in one sentence? Do you have at least two real examples or experiences? Can you verify the facts?

Write the brief (audience, goal, tone) and the claim. Keep the scope small.$t25c$, $t25d$Scoping a real piece$t25d$, $t25e$Submit:

1. Your brief (audience, goal, tone).
2. Your claim in one sentence.
3. The real examples and the sources you plan to use.$t25e$, $t25f$[{"criterion": "Brief is specific", "max_points": 35, "guidance": "A named reader, a clear goal and a tone."}, {"criterion": "Claim is clear", "max_points": 35, "guidance": "One sentence you can defend."}, {"criterion": "Evidence is available", "max_points": 30, "guidance": "Real examples and sources are ready."}]$t25f$::jsonb, 15, 'text', false),
  (26, $t26a$Capstone 2: outline and draft$t26a$, $t26b$Write the first full draft of your capstone post.$t26b$, $t26c$Use your process: outline (claim, proof, close), then draft section by section with your own examples. Aim for about 400 words, but a clear 350 beats a padded 450.

Write your own opening. Let AI help extend and structure, not invent.$t26c$, $t26d$Drafting a finished piece$t26d$, $t26e$Submit your outline and your first draft (350 to 450 words).$t26e$, $t26f$[{"criterion": "Follows the structure", "max_points": 35, "guidance": "Claim, proof and close are all present."}, {"criterion": "Real examples", "max_points": 35, "guidance": "Examples are yours."}, {"criterion": "Complete draft", "max_points": 30, "guidance": "A whole piece of about the right length."}]$t26f$::jsonb, 30, 'text', false),
  (27, $t27a$Capstone 3: edit round one, structure and cuts$t27a$, $t27b$Strengthen structure and cut what does not earn its place.$t27b$, $t27c$Read your draft cold (after a break). Do a structure pass: Is the claim clear in the first two lines? Does each paragraph earn its place? What can you cut by 15 percent?

Use AI as a critic (diagnose, do not rewrite), then apply the cuts yourself.$t27c$, $t27d$Structural editing$t27d$, $t27e$Submit the revised draft, your three biggest structure changes, and the word count before and after.$t27e$, $t27f$[{"criterion": "Structure improved", "max_points": 40, "guidance": "The piece is clearer and better organised."}, {"criterion": "Cuts are purposeful", "max_points": 30, "guidance": "What was cut was not needed."}, {"criterion": "Changes explained", "max_points": 30, "guidance": "Names the three biggest changes."}]$t27f$::jsonb, 15, 'text', false),
  (28, $t28a$Capstone 4: edit round two, voice and clarity$t28a$, $t28b$Make it sound like you and read clearly.$t28b$, $t28c$Second pass: voice and clarity. Use your voice guide. Replace generic phrases with specifics. Fix passive voice and jargon. Read it aloud. Make sure the opening hooks and the ending gives the takeaway.$t28c$, $t28d$Voice and clarity polish$t28d$, $t28e$Submit the revised draft and five specific voice or clarity edits, each shown as a before and after phrase.$t28e$, $t28f$[{"criterion": "Sounds like you", "max_points": 40, "guidance": "Matches your voice guide."}, {"criterion": "Clear and plain", "max_points": 30, "guidance": "Jargon and passive voice are handled."}, {"criterion": "Edits are specific", "max_points": 30, "guidance": "Real before and after phrases."}]$t28f$::jsonb, 15, 'text', false),
  (29, $t29a$Capstone 5: fact-check and finish$t29a$, $t29b$Verify every claim and give the piece a clean finish.$t29b$, $t29c$Run your checking routine: highlight claims, verify with sources, cite, fix or cut, and re-check names, numbers and dates. Add your short AI-use note if the context calls for it. Then a final proofread for spelling and formatting.$t29c$, $t29d$Verification and finishing$t29d$, $t29e$Submit the final text, your claims and sources table, and your AI-use note.$t29e$, $t29f$[{"criterion": "Facts verified", "max_points": 45, "guidance": "Every claim is checked against a source."}, {"criterion": "Sources cited", "max_points": 25, "guidance": "Readers can follow them."}, {"criterion": "Clean finish", "max_points": 30, "guidance": "Proofread and well formatted."}]$t29f$::jsonb, 15, 'text', false),
  (30, $t30a$Capstone 6: publish and share$t30a$, $t30b$Publish your post and share it with the community.$t30b$, $t30c$Publish your post somewhere real: a blog, LinkedIn, Medium, Substack, a Notion page or a public document. Then share it in the NEXTGEN Discord and ask for one piece of feedback. Sharing is part of the skill: readers show you what works.

Submit the final post for scoring, together with where it is published. Your work is scored on the rubric below, and you can revise and resubmit.$t30c$, $t30d$Publishing and getting feedback$t30d$, $t30e$Submit:

1. The final post (350 to 450 words).
2. The link where it is published (or where you will publish it).
3. A short note (3 to 5 sentences) on what you changed between your first draft and this final version, and why.

Then share it in the Discord.$t30e$, $t30f$[{"criterion": "Clarity", "max_points": 30, "guidance": "Easy to follow, with a clear claim."}, {"criterion": "Voice", "max_points": 25, "guidance": "Sounds like a real person, with specific detail."}, {"criterion": "Accuracy", "max_points": 25, "guidance": "Claims are correct and sourced."}, {"criterion": "Evidence of editing", "max_points": 20, "guidance": "The note shows real improvement between drafts."}]$t30f$::jsonb, 45, 'text', true)
) as v(n, title, objective, lesson_md, skill_focus, assignment_md, rubric, est_minutes, submission_type, ai_evaluate)
where t.slug = 'content'
on conflict (track_id, day_number) do nothing;
