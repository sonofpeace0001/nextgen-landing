-- Goal-based curriculum · Phase 0 foundation.
--
-- Purely additive and UNPUBLISHED: nothing here is visible to members until an
-- admin publishes a track or day. Adds
--   1. the columns the goal-based plan needs (member goals, tool stack, tool
--      cards, credit budget, rubric version, submission type),
--   2. a secure set_my_goals() function (profile columns are locked to
--      display_name, so goals must be written through a definer function),
--   3. nine goal tracks with their four tiers (no day frames yet; days are
--      created per wave as each track is authored),
--   4. a Foundations track with three authored, unpublished Basic days.
-- Idempotent: safe to run twice.

-- 1) Columns -------------------------------------------------------------
alter table public.profile
  add column if not exists goals text[] not null default '{}';

alter table public.track
  add column if not exists goal_tags text[] not null default '{}',
  add column if not exists tool_stack jsonb not null default '[]'::jsonb;

alter table public.day
  add column if not exists tool_cards jsonb not null default '[]'::jsonb,
  add column if not exists credit_budget int check (credit_budget is null or credit_budget >= 0),
  add column if not exists rubric_version int not null default 1,
  add column if not exists submission_type text not null default 'text'
    check (submission_type in ('text', 'link', 'image', 'video', 'audio', 'file'));

-- 2) Member goals (max 3, only known goal ids) --------------------------
create or replace function public.set_my_goals(p_goals text[])
returns text[]
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid   uuid := auth.uid();
  v_clean text[];
begin
  if v_uid is null then
    raise exception 'Not authenticated';
  end if;

  select coalesce(array_agg(g), '{}')
    into v_clean
    from (
      select distinct g
        from unnest(coalesce(p_goals, '{}')) as g
       where g = any (array['graphics','content','apps','agents','film','motion','audio','research','business','unsure'])
       limit 3
    ) s;

  update public.profile set goals = v_clean where id = v_uid;
  return v_clean;
end;
$$;

revoke all on function public.set_my_goals(text[]) from public;
grant execute on function public.set_my_goals(text[]) to authenticated;

-- 3) Goal tracks (unpublished) -------------------------------------------
insert into public.track (slug, title, description, sort_order, is_published, goal_tags, tool_stack) values
  ('graphics', 'Graphics and design',
   'Design posters, ads, thumbnails and brand visuals that look properly art-directed.', 10, false, array['graphics'],
   $j$[{"name":"CREAO","role":"primary","note":"images, brand memory, portfolio page","url":"https://agent.creao.ai/@Sonofpeace"},{"name":"Ideogram","note":"text inside images"},{"name":"Nano Banana","note":"editing and consistency"},{"name":"Midjourney","note":"art direction"},{"name":"Adobe Firefly","note":"commercially safer"},{"name":"Canva","note":"layout and export"}]$j$::jsonb),
  ('content', 'Content and writing',
   'Write clear, original posts, newsletters, scripts and articles in your own voice, faster.', 11, false, array['content'],
   $j$[{"name":"CREAO","role":"primary","note":"voice memory, repurposing, scheduled runs","url":"https://agent.creao.ai/@Sonofpeace"},{"name":"Claude, ChatGPT, Gemini","note":"drafting and editing"},{"name":"Perplexity","note":"sourced research"},{"name":"Notion","note":"content calendar"}]$j$::jsonb),
  ('apps', 'Apps and tools',
   'Build working web apps and internal tools by describing them, then ship them to a live link.', 12, false, array['apps'],
   $j$[{"name":"CREAO","role":"primary","note":"apps with a built-in copilot, integrations","url":"https://agent.creao.ai/@Sonofpeace"},{"name":"Lovable","note":"polished first builds"},{"name":"Bolt","note":"speed"},{"name":"Replit","note":"learning to code"},{"name":"v0","note":"React interfaces"},{"name":"Cursor","note":"editing real code"},{"name":"Supabase and Vercel","note":"data and hosting"}]$j$::jsonb),
  ('agents', 'AI agents and automation',
   'Automate real work with agents that run on a schedule and ask before they act.', 13, false, array['agents'],
   $j$[{"name":"CREAO","role":"primary","note":"chat to agent, connectors, schedules, approval gates","url":"https://agent.creao.ai/@Sonofpeace"},{"name":"n8n","note":"flexible, self-hostable"},{"name":"Zapier","note":"widest app catalogue"},{"name":"Make","note":"visual scenarios"}]$j$::jsonb),
  ('film', 'AI film and video',
   'Make short films, ads and social videos with consistent characters, real camera language and clean audio.', 14, false, array['film'],
   $j$[{"name":"CREAO","role":"primary","note":"storyboards, video, images, voiceover","url":"https://agent.creao.ai/@Sonofpeace"},{"name":"Veo","note":"cinematic quality"},{"name":"Kling","note":"motion and native audio"},{"name":"Runway","note":"camera control and editing"},{"name":"CapCut or DaVinci Resolve","note":"edit and grade"},{"name":"ElevenLabs","note":"voice"}]$j$::jsonb),
  ('motion', 'Motion graphics',
   'Animate titles, logos, explainers and interfaces so information moves with purpose.', 15, false, array['motion'],
   $j$[{"name":"CREAO","role":"primary","note":"concept, storyboard, assets, voiceover, template variants","url":"https://agent.creao.ai/@Sonofpeace"},{"name":"Jitter","note":"interface and social motion"},{"name":"After Effects","note":"frame-level precision"},{"name":"Rive","note":"interactive animation"},{"name":"Remotion","note":"motion as code"}]$j$::jsonb),
  ('audio', 'Audio, music and voice',
   'Produce voiceovers, podcasts, songs and sound design with clear rights.', 16, false, array['audio'],
   $j$[{"name":"CREAO","role":"primary","note":"scripts, 20+ voices, recurring audio jobs","url":"https://agent.creao.ai/@Sonofpeace"},{"name":"ElevenLabs","note":"voice, dubbing, effects, music"},{"name":"Suno","note":"full songs"},{"name":"Udio","note":"instrumental and electronic"},{"name":"Descript","note":"edit by text"}]$j$::jsonb),
  ('research', 'Research and data',
   'Find and check information, analyse data, and turn it into decisions, reports and dashboards.', 17, false, array['research'],
   $j$[{"name":"CREAO","role":"primary","note":"browse, extract, connect to Sheets, scheduled digests","url":"https://agent.creao.ai/@Sonofpeace"},{"name":"Perplexity","note":"sourced search"},{"name":"NotebookLM","note":"source-grounded notes"},{"name":"Google Sheets","note":"data work"},{"name":"Looker Studio","note":"dashboards"}]$j$::jsonb),
  ('business', 'Business and freelancing',
   'Turn AI skills into an offer, clients and a repeatable service. Optional track, opened only if members ask for it.', 18, false, array['business'],
   $j$[{"name":"CREAO","role":"primary","note":"lead lists, outreach drafts, proposals, follow-ups with approval","url":"https://agent.creao.ai/@Sonofpeace"},{"name":"Notion or Sheets","note":"pipeline tracking"},{"name":"Canva","note":"proposals and decks"}]$j$::jsonb),
  ('foundations', 'Foundations',
   'Three shared days for everyone: how AI works, prompting, and using it safely. Then follow your goal.', 5, false, array[]::text[],
   $j$[{"name":"CREAO","role":"primary","note":"your first AI chat","url":"https://agent.creao.ai/@Sonofpeace"}]$j$::jsonb)
on conflict (slug) do nothing;

-- All four tiers for the eight full goal tracks; Foundations only needs Basic.
insert into public.tier (track_id, slug, title, ordinal)
select t.id, v.slug::tier_slug, v.title, v.ordinal
from public.track t,
  (values ('basic','Basic',1), ('pro','Pro',2), ('expert','Expert',3), ('grandmaster','Grandmaster',4)) as v(slug, title, ordinal)
where t.slug in ('graphics','content','apps','agents','film','motion','audio','research','business')
on conflict (track_id, slug) do nothing;

insert into public.tier (track_id, slug, title, ordinal)
select t.id, 'basic'::tier_slug, 'Basic', 1
from public.track t
where t.slug = 'foundations'
on conflict (track_id, slug) do nothing;

-- 4) Foundations: three authored, UNPUBLISHED days ----------------------
insert into public.day
  (track_id, tier_id, day_number, title, objective, lesson_md, skill_focus, assignment_md, rubric,
   est_minutes, is_published, credit_budget, submission_type)
select t.id, ti.id, v.n, v.title, v.objective, v.lesson_md, v.skill_focus, v.assignment_md, v.rubric,
       v.est_minutes, false, v.credit_budget, v.submission_type
from public.track t
join public.tier ti on ti.track_id = t.id and ti.slug = 'basic'
cross join (values
  (1,
   'How AI works, and what you want from it',
   'Explain in your own words what an AI model does, and decide what you want from NEXTGEN.',
   $a$## What an AI model actually does

An AI model is software trained on huge amounts of text, images or audio. When you give it a prompt, it predicts a useful response from the patterns it has seen. That is why it is fast at drafting, rewriting, summarising, brainstorming and making variations.

## What it is not

- It does not know your situation unless you tell it.
- It can sound sure and still be wrong. Check any fact that matters.
- It is not the designer, writer or engineer. You are. It is your assistant.

## Agents in one sentence

An agent is a model plus tools (email, spreadsheets, the web), a memory of your preferences and a schedule, so it can do a task for you again and again. You will build several here.

## Your role

You give direction, judge the result and decide what ships. Every lesson on NEXTGEN follows the same loop: brief, generate, review, improve.

## Today

Decide what you want out of this. Your goal decides which track you follow next.$a$,
   'Thinking of AI as a collaborator you direct',
   $b$Write five short answers:

1. One thing AI is good at that you have seen or tried.
2. One way it can go wrong.
3. Your main goal in one sentence (for example: design posters for my business, or automate my weekly reports).
4. One small project you want to finish in the next 30 days.
5. What would make you proud 90 days from now?$b$,
   $c$[{"criterion":"Clear goal","max_points":40,"guidance":"States a specific goal that a stranger could understand."},{"criterion":"Realistic first project","max_points":30,"guidance":"Small enough to finish in 30 days and connected to the goal."},{"criterion":"Honest view of AI","max_points":30,"guidance":"Names one real strength and one real limit."}]$c$::jsonb,
   10, 0, 'text'),
  (2,
   'Prompting basics and your first CREAO chat',
   'Write a prompt with context, task, format and an example, then improve it twice.',
   $a$## A prompt is a brief

Weak prompts are vague. Strong prompts give the model what a good freelancer would need.

**Context + Task + Format + Example**

- **Context:** who it is for and why.
- **Task:** the exact thing to produce.
- **Format:** length, structure, tone.
- **Example:** a sample of what good looks like. Optional, and very powerful.

## Iterate, do not restart

Read the result, name what is wrong, and ask for that change. Three short rounds beat one giant prompt.

## Your first CREAO chat

CREAO is the tool we use first in every track because it can do the whole job in one place: it writes, generates images, video and voice, connects to your apps, and can turn a chat into an agent that runs on a schedule.

[Create your free CREAO account](https://agent.creao.ai/@Sonofpeace) (this is a referral link) and ask it to do one small task connected to your goal. Its free plan is small and credit-based, so keep today's chat short. If you run out, any free chatbot works for this lesson.

## Today

Write a prompt with all four parts, run it, then improve it twice.$a$,
   'Briefing an AI clearly, then iterating',
   $b$Submit:

1. Your first prompt.
2. Your final prompt after two improvements.
3. The best result, pasted as text or as a link.
4. Two sentences on what you changed and why it improved the result.$b$,
   $c$[{"criterion":"Specific context","max_points":30,"guidance":"The prompt says who it is for and why, not just what to make."},{"criterion":"Clear output format","max_points":25,"guidance":"Length, structure or tone is stated."},{"criterion":"Iteration shown","max_points":25,"guidance":"The final prompt is clearly better than the first, and the change is visible."},{"criterion":"Reflection","max_points":20,"guidance":"Explains what changed and why it helped."}]$c$::jsonb,
   15, 5, 'text'),
  (3,
   'Use AI safely and set up your portfolio',
   'Set three personal rules for using AI, and create the page where your projects will live.',
   $a$## Three habits that protect you

**Privacy.** Never paste passwords, bank details, ID numbers or private client files into an AI tool. Assume anything you type could be stored.

**Rights and consent.** Do not clone a real person's voice or face without their clear permission. Check the licence before using generated work commercially.

**Honesty.** Say when AI helped, wherever it matters (school, clients, journalism). Check facts and names before you publish.

## Your portfolio

Every project you finish on NEXTGEN goes on one page you own. It can be a Notion page, a Google Doc or a simple site built with CREAO. It grows into the proof you show clients and employers.

## Today

Create the page, add your goal, and write three rules for how you will use AI.$a$,
   'Using AI responsibly and building proof of work',
   $b$Submit the link to your portfolio page. On it, write:

- your name,
- your goal in one sentence,
- three personal rules for using AI (for example about privacy, credit and checking facts).$b$,
   $c$[{"criterion":"Portfolio page exists and opens","max_points":35,"guidance":"The link works for a stranger and shows the required items."},{"criterion":"Goal is specific","max_points":30,"guidance":"One clear sentence, not a slogan."},{"criterion":"Personal rules are concrete","max_points":35,"guidance":"Each rule is something you could actually follow or break."}]$c$::jsonb,
   15, 0, 'link')
) as v(n, title, objective, lesson_md, skill_focus, assignment_md, rubric, est_minutes, credit_budget, submission_type)
where t.slug = 'foundations'
on conflict (track_id, day_number) do nothing;

-- Safety check for Foundations day 3 (auto-graded; needs both answers right).
insert into public.day_check (day_id, type, items, pass_pct)
select d.id, 'mcq'::check_type,
  $q$[{"q":"Which is safe to paste into an AI tool?","options":["A client's bank details","A public blog post you wrote","Your account password"],"answer":1},{"q":"Before cloning someone's voice you should...","options":["Just do it if it is for fun","Get their clear permission","Change the pitch slightly"],"answer":1}]$q$::jsonb,
  100
from public.day d
join public.track t on t.id = d.track_id and t.slug = 'foundations'
where d.day_number = 3
  and not exists (select 1 from public.day_check dc where dc.day_id = d.id);
