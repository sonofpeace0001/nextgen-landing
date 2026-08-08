-- Elite Prompt Library: categories -> subcategories -> prompts, plus the access
-- code (stored in the existing site_settings table so the owner can rotate it
-- from the Supabase dashboard with no redeploy).
--
-- RLS: anon/authenticated get SELECT only on all three tables. There are
-- deliberately NO insert/update/delete policies for anon or authenticated —
-- content is managed entirely via the Supabase dashboard (service role bypasses
-- RLS there). The in-app code check is light gating for a members perk, not a
-- security boundary — see the comment in src/lib/prompts.js.

create table public.prompt_categories (
  id          serial primary key,
  slug        text unique not null,
  name        text not null,
  description text,
  sort_order  int not null default 0
);

create table public.prompt_subcategories (
  id          serial primary key,
  category_id int not null references public.prompt_categories(id) on delete cascade,
  slug        text not null,
  name        text not null,
  sort_order  int not null default 0,
  unique (category_id, slug)
);

create table public.prompts (
  id              serial primary key,
  subcategory_id  int not null references public.prompt_subcategories(id) on delete cascade,
  title           text not null,
  body            text not null,
  swap_note       text,
  difficulty      text not null default 'beginner'
                    check (difficulty in ('beginner', 'intermediate', 'advanced')),
  sort_order      int not null default 0
);

create index prompts_subcategory_idx on public.prompts (subcategory_id);
create index prompt_subcategories_category_idx on public.prompt_subcategories (category_id);

alter table public.prompt_categories    enable row level security;
alter table public.prompt_subcategories enable row level security;
alter table public.prompts              enable row level security;

create policy "prompt_categories readable by all"
  on public.prompt_categories for select
  to anon, authenticated
  using (true);

create policy "prompt_subcategories readable by all"
  on public.prompt_subcategories for select
  to anon, authenticated
  using (true);

create policy "prompts readable by all"
  on public.prompts for select
  to anon, authenticated
  using (true);

-- Access code. Owner rotates this from Supabase Studio -> site_settings table,
-- no deploy needed. site_settings already has RLS (anon SELECT only, no writes)
-- from the earlier migration, so this row is read-only from the browser too.
insert into public.site_settings (key, value) values
  ('elite_prompt_code', 'CHANGEME')
on conflict (key) do nothing;

-- ── categories ────────────────────────────────────────────────────────────
insert into public.prompt_categories (slug, name, description, sort_order) values
  ('writing', 'Writing', 'Prompts for academic, professional, social, creative, and technical writing.', 1),
  ('image', 'Image', 'Prompts for generating, designing, and editing images.', 2),
  ('video', 'Video', 'Prompts for shots, movement, lighting, and pacing.', 3),
  ('agents-automation', 'Agents & automation', 'Prompts for building agents, workflows, and integrations.', 4),
  ('learning', 'Learning', 'Prompts for teaching yourself, testing yourself, and explaining hard ideas.', 5),
  ('money-work', 'Money & work', 'Prompts for freelancing, proposals, pricing, and finding clients.', 6),
  ('audio', 'Audio', 'Prompts for voiceover, sound design, and music.', 7);

-- ── subcategories ────────────────────────────────────────────────────────
insert into public.prompt_subcategories (category_id, slug, name, sort_order)
select c.id, x.sub_slug, x.sub_name, x.sub_sort
from public.prompt_categories c
join (values
  ('writing', 'academic', 'Academic', 1),
  ('writing', 'professional', 'Professional', 2),
  ('writing', 'social', 'Social', 3),
  ('writing', 'creative', 'Creative', 4),
  ('writing', 'technical', 'Technical', 5),
  ('image', 'generation', 'Generation', 1),
  ('image', 'graphic-design', 'Graphic design', 2),
  ('image', 'editing', 'Editing', 3),
  ('image', 'photography-styles', 'Photography styles', 4),
  ('image', 'text-in-image', 'Text in image', 5),
  ('video', 'shot-types-camera-angles', 'Shot types & camera angles', 1),
  ('video', 'camera-movement', 'Camera movement', 2),
  ('video', 'lighting', 'Lighting', 3),
  ('video', 'drone-aerial', 'Drone & aerial', 4),
  ('video', 'style-mood', 'Style & mood', 5),
  ('video', 'motion-pacing', 'Motion & pacing', 6),
  ('agents-automation', 'building-agents', 'Building agents', 1),
  ('agents-automation', 'workflows', 'Workflows', 2),
  ('agents-automation', 'integrations', 'Integrations', 3),
  ('learning', 'self-teaching', 'Self-teaching', 1),
  ('learning', 'quizzing-yourself', 'Quizzing yourself', 2),
  ('learning', 'explaining-hard-concepts', 'Explaining hard concepts', 3),
  ('money-work', 'freelancing', 'Freelancing', 1),
  ('money-work', 'proposals', 'Proposals', 2),
  ('money-work', 'pricing', 'Pricing', 3),
  ('money-work', 'finding-clients', 'Finding clients', 4),
  ('audio', 'voiceover', 'Voiceover', 1),
  ('audio', 'sound-design', 'Sound design', 2),
  ('audio', 'music', 'Music', 3)
) as x(cat_slug, sub_slug, sub_name, sub_sort) on x.cat_slug = c.slug;

-- ── prompts (2 examples per subcategory, so the UI is testable end to end) ──
insert into public.prompts (subcategory_id, title, body, swap_note, difficulty, sort_order)
select s.id, x.title, x.body, x.swap_note, x.difficulty, x.sort_order
from public.prompt_subcategories s
join public.prompt_categories c on c.id = s.category_id
join (values
  -- writing / academic
  ('writing', 'academic', 'Summarize a research paper', 'Summarize the attached paper in plain English: the main question, the method, the result, and one limitation. Keep it under 200 words.', 'swap: paste your own paper, or change 200 words to the length you need.', 'beginner', 1),
  ('writing', 'academic', 'Turn notes into a literature review paragraph', 'Turn these bullet-point notes into one literature review paragraph in an academic tone, with each source referenced by author and year: [paste notes]', 'swap: add a citation style such as APA or MLA if your program requires one.', 'intermediate', 2),
  -- writing / professional
  ('writing', 'professional', 'Write a professional email', 'Write a short, professional email to [recipient] about [topic]. Keep it to 3 short paragraphs, a clear ask in the first line, and a polite close.', 'swap: change the tone to more formal or more casual depending on who you are writing to.', 'beginner', 1),
  ('writing', 'professional', 'Turn rough notes into a status update', 'Turn these rough notes into a clear weekly status update for my manager: what is done, what is in progress, what is blocked. [paste notes]', 'swap: add your team name or project name so it reads specific, not generic.', 'intermediate', 2),
  -- writing / social
  ('writing', 'social', 'Write a caption for a photo post', 'Write a short, honest caption for this photo: [describe the photo]. One line, no hashtags, sounds like a real person.', 'swap: ask for 3 versions and pick the one that sounds most like you.', 'beginner', 1),
  ('writing', 'social', 'Turn a long post into a thread', 'Break this long post into a short thread of 5 to 6 posts, one idea per post. The first post has to hook attention in one line: [paste post]', 'swap: change the post count to fit the platform you are posting on.', 'intermediate', 2),
  -- writing / creative
  ('writing', 'creative', 'Start a short story from one sentence', 'Write the opening paragraph of a short story that starts with this line: [your line]. Keep the tone [describe tone].', 'swap: give it a genre, such as mystery or sci-fi, for a very different result.', 'beginner', 1),
  ('writing', 'creative', 'Get unstuck on a scene', 'Here is a scene I am stuck on: [paste scene]. Suggest 3 different directions it could go, one sentence each.', 'swap: ask what the character is thinking instead of what happens next.', 'intermediate', 2),
  -- writing / technical
  ('writing', 'technical', 'Explain an error message', 'Explain this error message in plain English and suggest one likely fix: [paste error]', 'swap: paste the surrounding code too if the fix needs more context.', 'beginner', 1),
  ('writing', 'technical', 'Write documentation from code', 'Write a short comment for this function explaining what it does, its inputs, and its output: [paste code]', 'swap: ask for a README section instead if it is for a whole project.', 'intermediate', 2),

  -- image / generation
  ('image', 'generation', 'Generate a first image from an idea', 'A [subject] in [style], [lighting], [angle]. Keep it clean and uncluttered.', 'swap: change one variable at a time, style then lighting then angle, to learn what each one does.', 'beginner', 1),
  ('image', 'generation', 'Generate consistent variations', 'Same subject and style as before, but change only the [background, pose, or color] to [new value].', 'swap: keep everything the same except the one variable you are testing.', 'intermediate', 2),
  -- image / graphic-design
  ('image', 'graphic-design', 'Design a simple logo concept', 'A simple, modern logo concept for [brand name], a [one-line description of the business]. Minimal, one or two colors, works small.', 'swap: ask for 3 concepts at once and pick a direction before refining one.', 'beginner', 1),
  ('image', 'graphic-design', 'Design a social post template', 'A social media post template for [platform] with space for a headline and a short caption, in the style of [reference].', 'swap: describe your actual brand colors instead of naming a reference.', 'intermediate', 2),
  -- image / editing
  ('image', 'editing', 'Remove the background from a photo', 'Remove the background from this photo and replace it with [a plain color or a new scene].', 'swap: try a transparent background if you need the subject alone.', 'beginner', 1),
  ('image', 'editing', 'Fix lighting in a photo', 'Adjust this photo so the lighting looks more [natural, bright, or moody], without changing the subject.', 'swap: describe the time of day you want it to look like.', 'intermediate', 2),
  -- image / photography-styles
  ('image', 'photography-styles', 'Try a specific photography style', 'A photo of [subject] in the style of [film photography, golden hour, or studio portrait].', 'swap: name a specific era or photographer style you like for a more precise result.', 'beginner', 1),
  ('image', 'photography-styles', 'Match a mood, not just a subject', 'A photo of [subject] that feels [calm, tense, or nostalgic]. Focus on light and color to create that mood.', 'swap: describe a memory or scene that has that mood, and use that instead.', 'intermediate', 2),
  -- image / text-in-image
  ('image', 'text-in-image', 'Add clean text to an image', 'An image with the text "[your text]" in large, clean lettering, on a [background description].', 'swap: keep the text short. Long text rarely renders cleanly.', 'beginner', 1),
  ('image', 'text-in-image', 'Design a quote graphic', 'A simple quote graphic with the text "[your quote]" centered, minimal background, readable font.', 'swap: describe a font mood such as bold, handwritten, or elegant instead of a specific font name.', 'intermediate', 2),

  -- video / shot-types-camera-angles
  ('video', 'shot-types-camera-angles', 'Describe a shot precisely', 'A [wide shot, close-up, or over-the-shoulder shot] of [subject], [camera angle: eye level, low angle, or high angle].', 'swap: change only the shot type to see how much it changes the feel.', 'beginner', 1),
  ('video', 'shot-types-camera-angles', 'Storyboard a short sequence', 'Storyboard 4 shots for a 10-second scene of [describe the scene], naming the shot type for each.', 'swap: ask for the shots in order: establishing, close-up, reaction, then wide.', 'intermediate', 2),
  -- video / camera-movement
  ('video', 'camera-movement', 'Describe basic camera movement', 'A [pan, tilt, or dolly-in] shot of [subject], slow and steady.', 'swap: try a handheld movement instead of a smooth one for a rawer feel.', 'beginner', 1),
  ('video', 'camera-movement', 'Combine movement with subject action', 'A slow dolly-in on [subject] as they [action], camera stays at eye level.', 'swap: change the pace from slow to quick to change the energy.', 'intermediate', 2),
  -- video / lighting
  ('video', 'lighting', 'Set a lighting mood', '[subject], lit by [golden hour, soft window light, or harsh overhead light].', 'swap: describe where the light source is coming from for more control.', 'beginner', 1),
  ('video', 'lighting', 'Match lighting across a scene', 'Keep the lighting consistent with [reference description] across this whole sequence: [describe shots]', 'swap: name the time of day instead of a vague mood word.', 'intermediate', 2),
  -- video / drone-aerial
  ('video', 'drone-aerial', 'Describe a basic aerial shot', 'A drone shot flying over [location], [high or low] altitude, [slow or fast] movement.', 'swap: add a direction, such as flying toward the coastline, for a clearer result.', 'beginner', 1),
  ('video', 'drone-aerial', 'Aerial shot with a reveal', 'A drone shot that starts close on [small subject] and pulls back to reveal [wider scene].', 'swap: change what is being revealed to fit your story.', 'intermediate', 2),
  -- video / style-mood
  ('video', 'style-mood', 'Set an overall visual style', 'Footage of [subject] in the visual style of [genre or era], color graded [warm, cool, or muted].', 'swap: reference a specific film or show you know instead of a genre.', 'beginner', 1),
  ('video', 'style-mood', 'Build a mood board in words', 'Describe the visual mood for a video about [topic] in one paragraph: colors, pace, lighting, and one reference.', 'swap: reuse this description as the brief for every other prompt in the same project.', 'intermediate', 2),
  -- video / motion-pacing
  ('video', 'motion-pacing', 'Describe the pacing of a cut', 'A sequence of quick cuts, each under 1 second, showing [list of quick moments].', 'swap: slow it down to 2 to 3 second cuts for a calmer pace.', 'beginner', 1),
  ('video', 'motion-pacing', 'Match pacing to a feeling', 'Edit pacing that feels [urgent, relaxed, or building], starting slow and [speeding up or staying steady].', 'swap: describe the feeling with a comparison, such as waking up slowly, for a clearer result.', 'intermediate', 2),

  -- agents-automation / building-agents
  ('agents-automation', 'building-agents', 'Define what one agent should do', 'Describe an AI agent whose only job is to [one clear task]. What information does it need, and what does it hand back.', 'swap: start with the smallest possible version of the task before adding more.', 'beginner', 1),
  ('agents-automation', 'building-agents', 'Write system instructions for an agent', 'Write the system instructions for an agent that [task]. Include what it should never do.', 'swap: add 2 to 3 example inputs and outputs to make the instructions concrete.', 'intermediate', 2),
  -- agents-automation / workflows
  ('agents-automation', 'workflows', 'Map a manual process into steps', 'List the steps I currently do by hand for [task], in order, as a numbered list.', 'swap: mark which steps could be automated and which need a human.', 'beginner', 1),
  ('agents-automation', 'workflows', 'Design a simple automation', 'Design a workflow that does [task] automatically when [trigger happens]. Name each step and what tool could do it.', 'swap: replace the trigger with a schedule instead of an event, or the other way around.', 'intermediate', 2),
  -- agents-automation / integrations
  ('agents-automation', 'integrations', 'Plan connecting two tools', 'I want [tool A] to send information to [tool B] when [event happens]. What is the simplest way to connect them.', 'swap: name the specific data that needs to move, not just the tool names.', 'beginner', 1),
  ('agents-automation', 'integrations', 'Debug a broken integration', 'This automation between [tool A] and [tool B] stopped working after [what changed]. What are the most likely causes, in order.', 'swap: paste the actual error message if you have one.', 'intermediate', 2),

  -- learning / self-teaching
  ('learning', 'self-teaching', 'Build a beginner learning plan', 'I know nothing about [topic]. Give me a simple 5-step plan to learn the basics, one step at a time.', 'swap: add how much time you have per day so the plan fits your schedule.', 'beginner', 1),
  ('learning', 'self-teaching', 'Find the gaps in your understanding', 'I think I understand [topic]. Ask me 5 questions that would reveal what I am actually missing.', 'swap: answer the questions, then ask it to grade your answers honestly.', 'intermediate', 2),
  -- learning / quizzing-yourself
  ('learning', 'quizzing-yourself', 'Get quizzed on a topic', 'Quiz me on [topic] with 5 short questions, one at a time. Tell me if I am right after each answer.', 'swap: ask for harder questions once the first 5 feel easy.', 'beginner', 1),
  ('learning', 'quizzing-yourself', 'Turn notes into a quiz', 'Turn these notes into a 10-question quiz, mixing easy and hard questions: [paste notes]', 'swap: ask for the answer key separately so you can test yourself first.', 'intermediate', 2),
  -- learning / explaining-hard-concepts
  ('learning', 'explaining-hard-concepts', 'Explain it like you are new to it', 'Explain [concept] like I have never heard of it before. Use one simple example.', 'swap: ask it to explain the same thing again with a different example if the first one does not land.', 'beginner', 1),
  ('learning', 'explaining-hard-concepts', 'Compare it to something familiar', 'Explain [hard concept] by comparing it to [something familiar, such as cooking or driving]. Keep the comparison going the whole way through.', 'swap: pick the comparison yourself. It works better when it is something you already know well.', 'intermediate', 2),

  -- money-work / freelancing
  ('money-work', 'freelancing', 'Describe your services clearly', 'Write a 3-sentence description of what I offer as a freelancer, for someone who has never heard of me: [describe your skills]', 'swap: write it twice, once for a client and once for your own bio. The tone should differ slightly.', 'beginner', 1),
  ('money-work', 'freelancing', 'Set your starting rate', 'I do [type of work] and I am starting out. Given [your situation], what is a reasonable range to charge, and what should I ask about the project before quoting.', 'swap: mention your location and experience level for a more useful range.', 'intermediate', 2),
  -- money-work / proposals
  ('money-work', 'proposals', 'Draft a short project proposal', 'Write a short proposal for [project]: what I will do, how long it will take, and what I need from the client to start.', 'swap: add your price at the end once you have settled on a number.', 'beginner', 1),
  ('money-work', 'proposals', 'Tighten a proposal that is too long', 'Shorten this proposal to the essentials without losing the important parts: [paste proposal]', 'swap: ask it to keep the price and timeline exactly as written, and only trim the rest.', 'intermediate', 2),
  -- money-work / pricing
  ('money-work', 'pricing', 'Compare pricing models', 'I am deciding between charging by the hour, by the project, or a monthly retainer for [type of work]. What is the tradeoff of each.', 'swap: describe your actual client type. The right model depends on it.', 'beginner', 1),
  ('money-work', 'pricing', 'Explain a price increase to a client', 'Write a short, direct message telling an existing client my rate is going up to [new rate], effective [date].', 'swap: add one sentence about why, if you want to give a reason.', 'intermediate', 2),
  -- money-work / finding-clients
  ('money-work', 'finding-clients', 'Find where your clients already are', 'I offer [service] to [type of client]. Where online do people like that already ask for help.', 'swap: be specific about the client industry or size for a sharper answer.', 'beginner', 1),
  ('money-work', 'finding-clients', 'Write a cold outreach message', 'Write a short, specific outreach message to [type of prospect] about [service], mentioning one real detail about their situation: [detail]', 'swap: never send this without filling in a real, specific detail. Generic outreach gets ignored.', 'intermediate', 2),

  -- audio / voiceover
  ('audio', 'voiceover', 'Write a voiceover script', 'Write a 30-second voiceover script for [purpose], in a [warm, energetic, or calm] voice.', 'swap: read it out loud once. If you stumble, the sentence is too long.', 'beginner', 1),
  ('audio', 'voiceover', 'Adjust tone for the same script', 'Rewrite this voiceover script to sound more [confident, friendly, or urgent], same length: [paste script]', 'swap: ask for 2 versions side by side to compare tone directly.', 'intermediate', 2),
  -- audio / sound-design
  ('audio', 'sound-design', 'Describe a sound for a scene', 'Describe the sound design for a scene where [describe the scene]. What is in the background, and what stands out.', 'swap: describe what should be quiet, not just what should be loud.', 'beginner', 1),
  ('audio', 'sound-design', 'Build a simple sound palette', 'List 5 sounds that would build the mood of [setting or mood], from background texture to one key sound effect.', 'swap: order them from most subtle to most noticeable.', 'intermediate', 2),
  -- audio / music
  ('audio', 'music', 'Describe a music mood', 'Describe the music for [scene or project] in plain terms: tempo, instruments, and the feeling it should give.', 'swap: reference a mood instead of a genre if you do not know genre names. Waiting for good news works as well as any genre name.', 'beginner', 1),
  ('audio', 'music', 'Match music to pacing', 'Describe how the music should change as [scene] builds. Where should it stay simple, and where should it grow.', 'swap: mark the exact moment, in seconds or by action, where the change should happen.', 'intermediate', 2)
) as x(cat_slug, sub_slug, title, body, swap_note, difficulty, sort_order)
  on x.cat_slug = c.slug and x.sub_slug = s.slug;
