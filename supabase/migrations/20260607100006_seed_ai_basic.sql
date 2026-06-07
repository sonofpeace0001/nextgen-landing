-- Phase 6 · Seed the AI track end-to-end: the full Basic tier (24 days), plus the
-- four tier shells. Real curriculum content. Idempotent via ON CONFLICT so a local
-- `db reset` and the hosted push both land the same data.
-- (Non-devs can add/edit further days in the Supabase Table Editor — no code needed.)

do $$
declare
  v_track uuid;
  v_basic uuid;
begin
  insert into public.track (slug, title, description, sort_order, is_published)
  values ('ai', 'AI', 'Practical AI skills, from your first prompt to shipping real work.', 1, true)
  on conflict (slug) do update
    set title = excluded.title, description = excluded.description, is_published = true
  returning id into v_track;

  insert into public.tier (track_id, slug, title, ordinal) values
    (v_track, 'basic', 'Basic', 1),
    (v_track, 'pro', 'Pro', 2),
    (v_track, 'expert', 'Expert', 3),
    (v_track, 'grandmaster', 'Grandmaster', 4)
  on conflict (track_id, slug) do nothing;

  select id into v_basic from public.tier where track_id = v_track and slug = 'basic';

  insert into public.day
    (track_id, tier_id, day_number, objective, lesson_md, skill_focus, assignment_md, rubric, est_minutes, is_published)
  values
    (v_track, v_basic, 1,
     'Understand the main AI assistants and pick the right one for a task.',
     'ChatGPT is a strong all-rounder. Claude handles long documents and careful reasoning. Gemini ties into Google for research. Grok lives in X for real-time posts. Match the tool to the job instead of defaulting to one.',
     'Choosing a tool on purpose instead of by habit.',
     'List three tasks you do most weeks and name which assistant you would use for each, with a reason.',
     '[{"criterion":"Tool choice fits the task","max_points":10,"guidance":"Each pick is justified."},{"criterion":"Reasoning is specific","max_points":10,"guidance":"Not generic."}]'::jsonb, 25, true),

    (v_track, v_basic, 2,
     'Write prompts that are clear and specific enough to get a useful answer.',
     'Vague prompts get vague answers. State what you want, for whom, and in what form. Replace "write about marketing" with "write a 100-word intro to email marketing for small bakery owners".',
     'Turning a vague request into a precise one.',
     'Take one vague prompt and rewrite it three times, each more specific. Note how the output changes.',
     '[{"criterion":"Specificity improves across versions","max_points":10,"guidance":""},{"criterion":"Audience and format are stated","max_points":10,"guidance":""}]'::jsonb, 20, true),

    (v_track, v_basic, 3,
     'Apply the CCSF formula to structure any prompt.',
     'CCSF means Context, Constraints, Specifics, Format. Give context first, then constraints like length and tone, then the specifics of the task, then the output format. This one habit lifts quality fast.',
     'Structuring prompts with a repeatable formula.',
     'Write one prompt that clearly labels all four CCSF parts.',
     '[{"criterion":"All four parts present","max_points":10,"guidance":""},{"criterion":"Parts are correctly used","max_points":10,"guidance":""}]'::jsonb, 25, true),

    (v_track, v_basic, 4,
     'Use roles to shape tone and expertise.',
     'Telling the model to act as a specific expert sharpens answers. "Act as a friendly tax advisor" produces different output than a blank prompt. Roles set tone, depth, and vocabulary.',
     'Assigning a useful role.',
     'Rewrite a prompt to include a clear expert role and compare the answers.',
     '[{"criterion":"Role is specific and relevant","max_points":10,"guidance":""},{"criterion":"Compares the difference","max_points":10,"guidance":""}]'::jsonb, 20, true),

    (v_track, v_basic, 5,
     'Teach the model by giving examples.',
     'Few-shot prompting means showing one or two examples of the input and output you want before your real request. The model copies the pattern. It works well for formatting and style.',
     'Writing examples that set a pattern.',
     'Give two examples of a product description, then ask for a third in the same style.',
     '[{"criterion":"Examples set a clear pattern","max_points":10,"guidance":""},{"criterion":"Output matches the pattern","max_points":10,"guidance":""}]'::jsonb, 25, true),

    (v_track, v_basic, 6,
     'Get step-by-step reasoning for harder problems.',
     'Asking the model to think step by step before answering improves accuracy on multi-step tasks. Add "reason step by step, then give the final answer".',
     'Prompting for reasoning.',
     'Take a small word problem and prompt for step-by-step reasoning.',
     '[{"criterion":"Prompt asks for reasoning","max_points":10,"guidance":""},{"criterion":"Notes the effect on accuracy","max_points":10,"guidance":""}]'::jsonb, 20, true),

    (v_track, v_basic, 7,
     'Use the RTF and RACE frameworks to structure prompts.',
     'RTF is Role, Task, Format. RACE is Role, Action, Context, Expectation. Both force you to state who, what, and how. Pick one and keep it handy.',
     'Applying a named framework.',
     'Write the same request using both RTF and RACE.',
     '[{"criterion":"Both frameworks applied correctly","max_points":10,"guidance":""},{"criterion":"Request stays consistent","max_points":10,"guidance":""}]'::jsonb, 25, true),

    (v_track, v_basic, 8,
     'Use CRISPE and TAG for richer prompts.',
     'CRISPE covers Capacity and role, Insight, Statement, Personality, Experiment. TAG is Task, Action, Goal. Reach for these when a plain prompt is not enough.',
     'Choosing a framework to fit the job.',
     'Use TAG to write a prompt with a clear task, action, and goal.',
     '[{"criterion":"Task, action, and goal are clear","max_points":10,"guidance":""},{"criterion":"Prompt is usable","max_points":10,"guidance":""}]'::jsonb, 20, true),

    (v_track, v_basic, 9,
     'Set defaults with system prompts and custom instructions.',
     'System prompts and custom instructions tell the assistant how to behave across a whole chat. Set your role, preferences, and tone once instead of repeating them.',
     'Configuring persistent instructions.',
     'Write a custom-instruction block describing how you want answers formatted.',
     '[{"criterion":"Instructions are clear and reusable","max_points":10,"guidance":""},{"criterion":"Covers tone and format","max_points":10,"guidance":""}]'::jsonb, 20, true),

    (v_track, v_basic, 10,
     'Get clean lists, tables, and JSON.',
     'Ask explicitly for the output shape: a numbered list, a markdown table, or JSON with named fields. Specifying structure makes answers reusable downstream.',
     'Controlling output format.',
     'Ask for the same data as a table and as JSON.',
     '[{"criterion":"Both formats requested clearly","max_points":10,"guidance":""},{"criterion":"Output is well structured","max_points":10,"guidance":""}]'::jsonb, 25, true),

    (v_track, v_basic, 11,
     'Draft blogs, emails, and summaries with AI.',
     'AI is strong at first drafts. Give it the audience, goal, and length, then edit for voice. Do not ship the first draft unedited.',
     'Drafting then editing.',
     'Draft a 120-word email to a client, then edit it for your own voice.',
     '[{"criterion":"Draft meets the brief","max_points":10,"guidance":""},{"criterion":"Edited for voice","max_points":10,"guidance":""}]'::jsonb, 25, true),

    (v_track, v_basic, 12,
     'Summarize and extract from documents.',
     'Paste or attach a document and ask for a summary, key points, or specific extracts. State what matters to you so the model focuses there.',
     'Extracting signal from long text.',
     'Summarize a long article into five bullet points and one action.',
     '[{"criterion":"Summary is accurate and tight","max_points":10,"guidance":""},{"criterion":"Action is useful","max_points":10,"guidance":""}]'::jsonb, 25, true),

    (v_track, v_basic, 13,
     'Use AI to explain, write, and debug code.',
     'Even non-coders can use AI to read and fix small scripts. Paste the code and the error, then ask for a plain-language explanation plus a fix.',
     'Working with code via AI.',
     'Ask AI to explain a short code snippet in plain English.',
     '[{"criterion":"Explanation is understood","max_points":10,"guidance":""},{"criterion":"Included code and context","max_points":10,"guidance":""}]'::jsonb, 25, true),

    (v_track, v_basic, 14,
     'Improve a weak answer through follow-ups.',
     'A first answer is a starting point. Tell the model what was wrong and what to change. Iterating beats rewriting the prompt from scratch.',
     'Giving corrective feedback.',
     'Take a mediocre answer and improve it across two follow-up turns.',
     '[{"criterion":"Feedback is specific","max_points":10,"guidance":""},{"criterion":"Answer measurably improves","max_points":10,"guidance":""}]'::jsonb, 20, true),

    (v_track, v_basic, 15,
     'Spot and prevent made-up facts.',
     'AI can state false things confidently. Verify names, numbers, and quotes. Ask for sources and treat anything checkable as unverified until you check it.',
     'Verifying AI claims.',
     'Find one AI answer with a checkable fact and verify it.',
     '[{"criterion":"Identified a checkable claim","max_points":10,"guidance":""},{"criterion":"Verified it properly","max_points":10,"guidance":""}]'::jsonb, 20, true),

    (v_track, v_basic, 16,
     'Generate images with Midjourney, DALL-E, or Ideogram.',
     'Image tools turn text into pictures. Midjourney leans artistic, DALL-E is flexible, Ideogram handles text inside images well. Start simple and iterate.',
     'Picking an image tool.',
     'Generate one idea in an image tool and describe what you changed between tries.',
     '[{"criterion":"Produced an image","max_points":10,"guidance":""},{"criterion":"Described the iteration","max_points":10,"guidance":""}]'::jsonb, 25, true),

    (v_track, v_basic, 17,
     'Write prompts that describe subject, style, and composition.',
     'A good image prompt names the subject, the style, the lighting, and the framing. "A red bicycle, watercolor, soft morning light, side view" beats "a bike".',
     'Describing images precisely.',
     'Write three image prompts that vary only the style.',
     '[{"criterion":"Prompts are descriptive","max_points":10,"guidance":""},{"criterion":"Only style varies","max_points":10,"guidance":""}]'::jsonb, 20, true),

    (v_track, v_basic, 18,
     'Write hooks, captions, and threads.',
     'Short-form content lives or dies on the first line. Use AI to draft ten hooks, then pick the strongest. Keep captions tight and specific.',
     'Writing scroll-stopping hooks.',
     'Generate ten hooks for one idea and choose the best, with a reason.',
     '[{"criterion":"Ten distinct hooks","max_points":10,"guidance":""},{"criterion":"Choice is justified","max_points":10,"guidance":""}]'::jsonb, 20, true),

    (v_track, v_basic, 19,
     'Turn one idea into many pieces.',
     'One strong idea becomes a thread, a short video script, a carousel, and a newsletter. Repurposing multiplies your output without new ideas.',
     'Multiplying one idea.',
     'Take one idea and outline it as three different formats.',
     '[{"criterion":"Three real formats","max_points":10,"guidance":""},{"criterion":"Core idea stays intact","max_points":10,"guidance":""}]'::jsonb, 25, true),

    (v_track, v_basic, 20,
     'Run quick competitor and market scans.',
     'Ask AI to outline a market, list competitors, or summarize trends as a starting map. Then verify the specifics. It saves hours of blank-page research.',
     'Using AI as a research starting point.',
     'Ask AI for five competitors in a niche with one differentiator each, then sanity-check one.',
     '[{"criterion":"Useful starting map","max_points":10,"guidance":""},{"criterion":"Verified at least one fact","max_points":10,"guidance":""}]'::jsonb, 25, true),

    (v_track, v_basic, 21,
     'Build a reusable prompt library.',
     'Save the prompts that work. A personal library of tested prompts turns one-off wins into a repeatable system. Organize by task.',
     'Capturing what works.',
     'Save five prompts you have used, labeled by task.',
     '[{"criterion":"Five reusable prompts","max_points":10,"guidance":""},{"criterion":"Labeled by task","max_points":10,"guidance":""}]'::jsonb, 20, true),

    (v_track, v_basic, 22,
     'Know when not to use AI and how to use it responsibly.',
     'AI can be biased, can leak private data, and should not make high-stakes decisions alone. Do not paste secrets. Keep a human in the loop for anything that matters.',
     'Using AI responsibly.',
     'List two tasks where you would NOT rely on AI and explain why.',
     '[{"criterion":"Sensible no-go cases","max_points":10,"guidance":""},{"criterion":"Clear reasoning","max_points":10,"guidance":""}]'::jsonb, 20, true),

    (v_track, v_basic, 23,
     'Chain prompts into a small workflow.',
     'Real value comes from chaining steps: research, draft, edit, format. Treat AI as a pipeline, not a single magic prompt.',
     'Sequencing steps.',
     'Build a three-step prompt workflow for a task you do often.',
     '[{"criterion":"Three connected steps","max_points":10,"guidance":""},{"criterion":"Workflow is repeatable","max_points":10,"guidance":""}]'::jsonb, 25, true),

    (v_track, v_basic, 24,
     'Ship one real deliverable using what you learned.',
     'Pick a real task and finish it end to end with AI: choose the tool, prompt well, iterate, verify, and ship. This is the proof you can do it.',
     'Shipping with AI.',
     'Complete and submit one real deliverable (a post, email, image, or short doc) made with AI, and note your process.',
     '[{"criterion":"Deliverable is complete and real","max_points":15,"guidance":""},{"criterion":"Process shows tier skills","max_points":15,"guidance":""}]'::jsonb, 40, true)
  on conflict (track_id, day_number) do nothing;

  insert into public.day_check (day_id, type, items, pass_pct)
  select d.id, 'mcq'::check_type, c.items, 70
  from (values
    (1,  '[{"q":"Which assistant is generally best for reasoning over a long document?","options":["Grok","Claude","Pick at random"],"answer":1}]'::jsonb),
    (2,  '[{"q":"What most improves a weak prompt?","options":["Making it longer","Adding specifics: audience, goal, format","Using bigger words"],"answer":1}]'::jsonb),
    (3,  '[{"q":"In CCSF, what does the first C stand for?","options":["Code","Context","Cost"],"answer":1}]'::jsonb),
    (4,  '[{"q":"Adding a role mainly changes the model''s...","options":["tone and expertise framing","internet access","price"],"answer":0}]'::jsonb),
    (5,  '[{"q":"Few-shot prompting means...","options":["sending many prompts","showing examples of the desired output","using few words"],"answer":1}]'::jsonb),
    (6,  '[{"q":"Chain-of-thought asks the model to...","options":["answer instantly","reason step by step first","skip steps"],"answer":1}]'::jsonb),
    (7,  '[{"q":"RTF stands for...","options":["Role, Task, Format","Read The File","Run, Test, Fix"],"answer":0}]'::jsonb),
    (8,  '[{"q":"TAG stands for...","options":["Task, Action, Goal","Tag, And, Go","Text, Audio, Graphics"],"answer":0}]'::jsonb),
    (9,  '[{"q":"Custom instructions apply...","options":["to one message","across the whole conversation","never"],"answer":1}]'::jsonb),
    (10, '[{"q":"To get reusable data you should...","options":["ask for a clear format like JSON or a table","hope for the best","ask vaguely"],"answer":0}]'::jsonb),
    (11, '[{"q":"Best practice with an AI first draft is to...","options":["ship it as-is","edit it for accuracy and voice","delete it"],"answer":1}]'::jsonb),
    (12, '[{"q":"Telling the model what you care about when summarizing...","options":["focuses the summary","is pointless","is rude"],"answer":0}]'::jsonb),
    (13, '[{"q":"When debugging with AI you should include...","options":["just the word broken","the code and the error message","nothing"],"answer":1}]'::jsonb),
    (14, '[{"q":"If an answer is weak, the fastest fix is to...","options":["start over","tell the model what to change","give up"],"answer":1}]'::jsonb),
    (15, '[{"q":"A hallucination is...","options":["a confident but false answer","a feature","a type of prompt"],"answer":0}]'::jsonb),
    (16, '[{"q":"Which tool is known for legible text in images?","options":["Ideogram","A spreadsheet","None"],"answer":0}]'::jsonb),
    (17, '[{"q":"A strong image prompt includes...","options":["subject, style, and composition","one word","a phone number"],"answer":0}]'::jsonb),
    (18, '[{"q":"The most important part of short-form is...","options":["the hook / first line","the hashtags","the length"],"answer":0}]'::jsonb),
    (19, '[{"q":"Content repurposing means...","options":["deleting old posts","turning one idea into many formats","copying others"],"answer":1}]'::jsonb),
    (20, '[{"q":"AI research output should be treated as...","options":["final truth","a starting point to verify","useless"],"answer":1}]'::jsonb),
    (21, '[{"q":"A prompt library helps you...","options":["reuse what works","forget prompts","slow down"],"answer":0}]'::jsonb),
    (22, '[{"q":"You should avoid pasting into AI...","options":["public info","private secrets and personal data","your first name"],"answer":1}]'::jsonb),
    (23, '[{"q":"A workflow chains...","options":["one prompt forever","multiple steps toward a result","random prompts"],"answer":1}]'::jsonb),
    (24, '[{"q":"The capstone is about...","options":["watching more videos","shipping a real deliverable","waiting"],"answer":1}]'::jsonb)
  ) as c(dn, items)
  join public.day d on d.track_id = v_track and d.day_number = c.dn
  where not exists (select 1 from public.day_check dc where dc.day_id = d.id);
end $$;
