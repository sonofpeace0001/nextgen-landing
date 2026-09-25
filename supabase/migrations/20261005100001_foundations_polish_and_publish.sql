-- Foundations polish (worked demonstration, a named loop, a next step) and publication of the
-- goal tracks: Foundations plus the Basic and Pro tiers (days 1-60) of the nine goal tracks.
-- Expert and Grandmaster (days 61-90) stay unpublished until they are deepened.

update public.day d
   set lesson_md = d.lesson_md || $a$

## Try it in two minutes

Open any AI chat and type: "Explain what you can and cannot do for someone who wants to <your goal>." Read the answer with one question in mind: what would I have to check myself?$a$
  from public.track t
 where t.id = d.track_id and t.slug = 'foundations' and d.day_number = 1
   and d.lesson_md not like '%## Try it in two minutes%';

update public.day d
   set lesson_md = d.lesson_md || $b$

## See the difference

**Weak:** "Write a post about my bakery."

**Stronger:** "You are writing for students who live near my bakery (context). Write an Instagram caption announcing our new vegan brownie (task). Friendly, under 40 words, one emoji, ending with a question (format). Match this style: 'Warm cookies, cold weather, zero regrets.' (example)"

Then iterate: "Shorter, and mention it is only 2 pounds." Keep your best prompts in a note. A small collection of prompts that work is the first thing you own.$b$
  from public.track t
 where t.id = d.track_id and t.slug = 'foundations' and d.day_number = 2
   and d.lesson_md not like '%## See the difference%';

update public.day d
   set lesson_md = d.lesson_md || $c$

## Example rules

- "I never paste client files or personal details into a public AI tool."
- "I say when AI helped on work I hand in or sell."
- "I open every source and check every number before I share it."

## Next: choose your path

When your page is ready, [pick your goal path](#/start) so the next lessons match what you want to build.$c$
  from public.track t
 where t.id = d.track_id and t.slug = 'foundations' and d.day_number = 3
   and d.lesson_md not like '%## Example rules%';

-- Publish
update public.track set is_published = true
 where slug in ('foundations','graphics','content','apps','agents','film','motion','audio','research','business');

update public.day d
   set is_published = true
  from public.track t
 where t.id = d.track_id
   and ((t.slug = 'foundations') or (t.slug in ('graphics','content','apps','agents','film','motion','audio','research','business') and d.day_number between 1 and 60));
