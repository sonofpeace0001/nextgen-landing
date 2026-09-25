-- Deepen Pro-tier lessons for business: worked example and common mistake (idempotent).
update public.day d
   set lesson_md = d.lesson_md || v.extra
  from (values
  (31, $x31$

**Worked example:** 'I help independent cafes fill quiet weekday lunches with three weekly Instagram posts.' Proof: two real posts with reach numbers.

**Common mistake:** Claims you cannot prove.$x31$),
  (32, $x32$

**Worked example:** Small 180 (3 posts), Standard 280 (5 posts + report), Premium 450 (10 posts + strategy call).

**Common mistake:** Ten options.$x32$),
  (33, $x33$

**Worked example:** A quiet lunch worth 8 covers x 9 pounds x 5 days = 360 a week; price at 280 a month is a fraction.

**Common mistake:** Inventing the client's numbers.$x33$),
  (34, $x34$

**Worked example:** Ask: 'What did you try last?' 'What made you look for help now?' Summarise back in an email.

**Common mistake:** Pitching before diagnosing.$x34$),
  (35, $x35$

**Worked example:** Proposal: mirrors their words, three options, timeline, 14-day validity, next step.

**Common mistake:** A proposal longer than they will read.$x35$),
  (36, $x36$

**Worked example:** Sales pack: positioning, packages, value case, proposal for a real or realistic client.

**Common mistake:** Undocumented assumptions.$x36$),
  (37, $x37$

**Worked example:** Scope: 12 posts/month; excludes photography and paid ads; acceptance: client approves within 2 days; change request form.

**Common mistake:** No exclusions.$x37$),
  (38, $x38$

**Worked example:** Milestones: brief (day 2), drafts (day 7), revisions (day 10), publish (day 12); buffer 2 days; approvals recorded.

**Common mistake:** No approval points.$x38$),
  (39, $x39$

**Worked example:** QA checklist: spelling, brand colours, alt text, links, claims sourced; second reader.

**Common mistake:** Checking your own work only.$x39$),
  (40, $x40$

**Worked example:** Late payment: 'A reminder that invoice 14 is 7 days overdue; under our terms a late fee applies from day 14.'

**Common mistake:** Emotional messages.$x40$),
  (41, $x41$

**Worked example:** Report: posts 12, saves +18%, enquiries 5; next: test carousels.

**Common mistake:** Vanity metrics.$x41$),
  (42, $x42$

**Worked example:** Kit: scope, milestones, QA checklist, difficult-client scripts, one report.

**Common mistake:** Templates with no worked example.$x42$),
  (43, $x43$

**Worked example:** Automate reminders and invoice drafting; keep client messages personal; note tool has no client files.

**Common mistake:** Sharing client data with unvetted tools.$x43$),
  (44, $x44$

**Worked example:** One project becomes a case study, a 'lessons' post and a checklist; permission recorded.

**Common mistake:** Posting client results without permission.$x44$),
  (45, $x45$

**Worked example:** Partners: photographers, printers; offer a free audit for their customers; referral terms in writing; disclose commission.

**Common mistake:** Undisclosed commissions.$x45$),
  (46, $x46$

**Worked example:** Retainer: 280 a month, 3-month minimum, quarterly review, 30-day exit.

**Common mistake:** Locking clients in unfairly.$x46$),
  (47, $x47$

**Worked example:** Dashboard: leads 20, calls 6, wins 2, average project 280, margin 60%; decision: raise Premium.

**Common mistake:** Tracking nothing.$x47$),
  (48, $x48$

**Worked example:** Plan: target clients, channels, content, partners, retainers, metrics, risks.

**Common mistake:** A plan with no numbers.$x48$),
  (49, $x49$

**Worked example:** Clauses: scope, payment, IP, confidentiality, liability cap, termination; lawyer reviews template.

**Common mistake:** Copying a contract you do not understand.$x49$),
  (50, $x50$

**Worked example:** IP: 'Client owns final designs on payment; I keep my tools and drafts; AI-assisted work disclosed.'

**Common mistake:** Ambiguity about AI use.$x50$),
  (51, $x51$

**Worked example:** Set aside 25% of income for tax; separate business account; monthly receipts routine; accountant reviews.

**Common mistake:** Mixing personal and business money.$x51$),
  (52, $x52$

**Worked example:** Risk plan: illness (backup contact), data loss (weekly backup), late client (deposit).

**Common mistake:** No backup plan.$x52$),
  (53, $x53$

**Worked example:** Claims audit: 'Best in Bristol' removed (unprovable); 'Posts in 2 days' kept (true).

**Common mistake:** Inflating claims.$x53$),
  (54, $x54$

**Worked example:** Compliance kit: contract, IP clause, money system, risk plan, claims audit.

**Common mistake:** Skipping the claims audit.$x54$),
  (55, $x55$

**Worked example:** Interview five cafe owners; time and consistency are top pains.

**Common mistake:** Interviewing only friends.$x55$),
  (56, $x56$

**Worked example:** Offer system: positioning, three packages, scope template, delivery process.

**Common mistake:** Prices with no delivery process.$x56$),
  (57, $x57$

**Worked example:** Pilot for one cafe becomes a case study with permission.

**Common mistake:** Using results without permission.$x57$),
  (58, $x58$

**Worked example:** 20 messages, 6 replies, 3 calls, 1 proposal accepted.

**Common mistake:** Not tracking outreach.$x58$),
  (59, $x59$

**Worked example:** Contract, invoice, records, risk plan, privacy practice ready.

**Common mistake:** No privacy practice.$x59$),
  (60, $x60$

**Worked example:** Six-month plan: 4 clients, 1,200 a month, referrals started; evidence summary and lessons.

**Common mistake:** No metrics.$x60$)
  ) as v(n, extra), public.track t
 where t.id = d.track_id and t.slug = 'business' and d.day_number = v.n
   and d.lesson_md not like '%**Worked example:**%';
