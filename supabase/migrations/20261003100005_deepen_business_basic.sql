-- Deepen Basic-tier lessons for business: add a worked example and a common mistake (idempotent).
update public.day d
   set lesson_md = d.lesson_md || v.extra
  from (values
  (1, $x1$

**Worked example:** Skill: graphics. Offer: 'Three Instagram posts a week for independent cafes, 280 pounds a month, delivered every Monday.'

**Common mistake:** Selling a skill instead of a result.$x1$),
  (2, $x2$

**Worked example:** Customer: cafe owner, 30 to 50, no time to post, wants regulars; found via local business groups.

**Common mistake:** Describing 'everyone'.$x2$),
  (3, $x3$

**Worked example:** Three pieces: a real before-and-after, a practice piece labelled as practice, a short client quote with permission.

**Common mistake:** Showing only pretty work with no results.$x3$),
  (4, $x4$

**Worked example:** 30 hours x 25 = 750 pounds of labour plus 40 tools; price 1,000 as a project or 300 a month for 3 months.

**Common mistake:** Copying a competitor's price without knowing your costs.$x4$),
  (5, $x5$

**Worked example:** 'Hi Sam, I saw your new menu. Your posts do not show the lunch deals; I made a mock-up you can keep.' Personal, useful, no pressure.

**Common mistake:** Copy-pasting the same message to 200 people.$x5$),
  (6, $x6$

**Worked example:** Offer page: who, problem, result, inclusions, price, process, how to start, no invented testimonials.

**Common mistake:** Fake testimonials or guarantees you cannot keep.$x6$),
  (7, $x7$

**Worked example:** Proposal: their problem in their words, three options, timeline, price, next step, valid for 14 days.

**Common mistake:** A generic proposal.$x7$),
  (8, $x8$

**Worked example:** Terms: scope, revisions (2), payment (50 percent up front), ownership after payment, confidentiality, AI use, cancellation.

**Common mistake:** Working without written terms.$x8$),
  (9, $x9$

**Worked example:** Welcome email, eight-question form, timeline with dates and a promise to reply within one working day.

**Common mistake:** Starting work before knowing what the client wants.$x9$),
  (10, $x10$

**Worked example:** Policy: 'I use AI to draft and always review it. I never enter your confidential files into public tools.'

**Common mistake:** Hiding AI use, or pasting client secrets into any tool.$x10$),
  (11, $x11$

**Worked example:** Script: 'I can add that in a second round for 60; shall I add it?'

**Common mistake:** Doing extra work for free until it hurts.$x11$),
  (12, $x12$

**Worked example:** Deliver proposal, terms list, onboarding pack and AI policy for one client.

**Common mistake:** A proposal without an AI-use statement.$x12$),
  (13, $x13$

**Worked example:** Income 1,000; costs 120; tax set aside 25 percent (250); take-home 630. Slow month: income 500.

**Common mistake:** Not setting money aside for tax.$x13$),
  (14, $x14$

**Worked example:** Invoice: items, total, due in 14 days, bank details, late-payment note; follow-up on day 15, 22, 30.

**Common mistake:** Waiting weeks before asking to be paid.$x14$),
  (15, $x15$

**Worked example:** Three templates: proposal, weekly update email, project checklist. Saves 4 hours a month.

**Common mistake:** Rewriting every document from scratch.$x15$),
  (16, $x16$

**Worked example:** Request: 'Could you share one sentence about the result, and may I use your name?'

**Common mistake:** Posting a testimonial without permission.$x16$),
  (17, $x17$

**Worked example:** Risks: missed deadline (message early), copyright (check licences), data leak (limit access), late payment (deposit), illness (backup contact).

**Common mistake:** Ignoring rules on advertising claims.$x17$),
  (18, $x18$

**Worked example:** Business kit: offer, portfolio plan, price sheet, terms, invoice, templates, risk list.

**Common mistake:** Having no simple record of your terms.$x18$),
  (19, $x19$

**Worked example:** Post plan: Mon result, Wed tip, Fri behind-the-scenes; track enquiries from each.

**Common mistake:** Posting daily then burning out.$x19$),
  (20, $x20$

**Worked example:** Ask: 'What happens if you do nothing?' 'What have you tried?' 'What would success look like in 3 months?'

**Common mistake:** Talking more than listening.$x20$),
  (21, $x21$

**Worked example:** 'I missed Friday's draft. It will arrive Monday 10am, with a discount of 10 percent; here is how I will prevent this.'

**Common mistake:** Hiding a problem until the deadline.$x21$),
  (22, $x22$

**Worked example:** Focus: 'I help independent cafes in Bristol get more lunch customers.' Decline: wedding work, logos under 100, unlimited edits.

**Common mistake:** Saying yes to everything.$x22$),
  (23, $x23$

**Worked example:** Subcontractor brief: deliverable, examples, deadline, payment 120, ownership, confidentiality.

**Common mistake:** Delegating with a vague brief.$x23$),
  (24, $x24$

**Worked example:** 90-day plan: 20 messages a week, 5 calls, 2 proposals, 1 client by day 45, tracked weekly.

**Common mistake:** Targets with no numbers.$x24$),
  (25, $x25$

**Worked example:** Interview three cafe owners; the strongest pain is time. Offer: done-for-you weekly posts.

**Common mistake:** Choosing an offer without asking anyone.$x25$),
  (26, $x26$

**Worked example:** Case study: practice project for a fictional cafe, labelled 'practice', showing brief, process and outcome.

**Common mistake:** Passing off practice work as client work.$x26$),
  (27, $x27$

**Worked example:** Price sheet: small 180, standard 280, premium 450; terms; invoice; onboarding.

**Common mistake:** Setting prices after the client asks.$x27$),
  (28, $x28$

**Worked example:** Send 10 messages, get 3 replies, 1 call; note wording that worked.

**Common mistake:** Sending one message and giving up.$x28$),
  (29, $x29$

**Worked example:** Pilot for a friend's shop: proposal, delivery, client says 'more photos next time'.

**Common mistake:** Skipping written feedback.$x29$),
  (30, $x30$

**Worked example:** Launch pack: offer page, case study, price sheet, terms, templates, 90-day plan.

**Common mistake:** Launching with no next-90-days plan.$x30$)
  ) as v(n, extra), public.track t
 where t.id = d.track_id and t.slug = 'business' and d.day_number = v.n
   and d.lesson_md not like '%**Worked example:**%';
