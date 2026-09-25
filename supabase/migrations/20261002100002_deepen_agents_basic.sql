-- Deepen Basic-tier lessons for agents: add a worked example and a common mistake (idempotent).
update public.day d
   set lesson_md = d.lesson_md || v.extra
  from (values
  (1, $x1$

**Worked example:** Sorting emails into folders by fixed rules = automation. Reading a complaint and choosing whether to refund, escalate or reply = agent (with limits).

**Common mistake:** Calling every chatbot an agent.$x1$),
  (2, $x2$

**Worked example:** Steps: new email arrives, read it, decide urgency, draft reply, wait for approval, send. Automate reading and drafting, keep deciding and sending human.

**Common mistake:** Automating a workflow you have never written down.$x2$),
  (3, $x3$

**Worked example:** Role: support triage assistant. Goal: label and draft. Inputs: email text. Tools: read-only inbox. Limits: never send, never promise refunds. Output: label plus a 3-line draft. Stop and ask when angry or legal.

**Common mistake:** Leaving out the 'when to stop and ask a human' rule.$x3$),
  (4, $x4$

**Worked example:** Agent: 'Turn these meeting notes into a summary and action list with owners.' Test with five messy sets of notes and list where it invents owners.

**Common mistake:** Testing only with one clean example.$x4$),
  (5, $x5$

**Worked example:** Agent reads the inbox (read-only), drafts replies (can write drafts), cannot send or delete. Sending needs a click.

**Common mistake:** Giving full access because it is easier to set up.$x5$),
  (6, $x6$

**Worked example:** Ten test cases: clear email, vague email, angry email, email in another language, empty email, and an email that tries to instruct the agent.

**Common mistake:** Reporting only the cases that worked.$x6$),
  (7, $x7$

**Worked example:** v1: 'Summarise notes.' v2 adds 'Use bullet points, max 100 words.' v3 adds 'If no owner is named write TBC.' Compare all three on the same inputs.

**Common mistake:** Rewriting the whole prompt each time, so you cannot tell what helped.$x7$),
  (8, $x8$

**Worked example:** Memory: customer names and preferences (needs consent), not payment details, expire after 90 days.

**Common mistake:** Storing everything forever 'in case'.$x8$),
  (9, $x9$

**Worked example:** Trigger: new support email. Frequency: on arrival, max 20 per hour. Guard: ignore replies to its own drafts to avoid loops.

**Common mistake:** Letting an agent trigger itself through its own output.$x9$),
  (10, $x10$

**Worked example:** Q: 'What is the refund window?' A quotes policy.pdf section 3. Q: 'Do you ship to Mars?' A: 'That is not in the documents.'

**Common mistake:** Accepting fluent answers that have no source.$x10$),
  (11, $x11$

**Worked example:** Check: a person reads every 10th draft; a checklist verifies name, amount and date; wrong drafts go into a log with the cause.

**Common mistake:** Trusting output because it sounds confident.$x11$),
  (12, $x12$

**Worked example:** Show sources cited in answers, the permissions table, and a log of ten runs with two failures explained.

**Common mistake:** Presenting an agent with no evidence of testing.$x12$),
  (13, $x13$

**Worked example:** Stage 1: extract order details. Check: all fields present. Stage 2: draft reply. Check: mentions order number. Stage 3: human approval.

**Common mistake:** One giant instruction doing everything at once.$x13$),
  (14, $x14$

**Worked example:** Rule: refund under 20 pounds and within 30 days goes to auto-draft; anything else goes to a person. Default path: person.

**Common mistake:** No default path for cases you did not predict.$x14$),
  (15, $x15$

**Worked example:** Approval card: shows customer message, proposed reply, and 'Send' or 'Edit' or 'Reject'.

**Common mistake:** Approval screens that hide what will be sent.$x15$),
  (16, $x16$

**Worked example:** Log line: 14:02, ticket 812, action draft_created, result ok. Alert if 5 failures in an hour.

**Common mistake:** No logs, so failures are invisible until a customer complains.$x16$),
  (17, $x17$

**Worked example:** One run costs 1.8 pence; 500 runs a month is 9 pounds. Limit: 800 runs a month, kill switch in settings.

**Common mistake:** No spending cap or stop button.$x17$),
  (18, $x18$

**Worked example:** Diagram with three stages, rules for two branches, an approval step, a failure plan and a cost table.

**Common mistake:** Skipping the failure plan.$x18$),
  (19, $x19$

**Worked example:** Categories: refund, delivery, account, other. Draft only. Anything with legal words goes to you.

**Common mistake:** Letting the agent send replies unseen.$x19$),
  (20, $x20$

**Worked example:** Ask the agent to compare three suppliers with links. Open every link; note the one claim that was wrong.

**Common mistake:** Copying the report without opening sources.$x20$),
  (21, $x21$

**Worked example:** Support agent answers from the FAQ only. If unsure, it says 'I will pass this to a person' and tags the ticket.

**Common mistake:** Letting the agent invent policy to be helpful.$x21$),
  (22, $x22$

**Worked example:** Weekly: agent drafts 5 posts from your voice guide; you approve; it records which performed best.

**Common mistake:** Auto-posting without approval.$x22$),
  (23, $x23$

**Worked example:** Validate: totals match, no duplicate invoice numbers, dates are real. Keep the original file untouched.

**Common mistake:** Overwriting the original data.$x23$),
  (24, $x24$

**Worked example:** Before: 25 minutes per report. After (5 runs): 6 minutes including checking. Errors: 2, both caught in review.

**Common mistake:** Reporting time saved without counting checking time.$x24$),
  (25, $x25$

**Worked example:** Track a week of invoice chasing: 6 hours, 2 late payments missed. Cost of an error: an angry client.

**Common mistake:** Picking a workflow because it sounds impressive.$x25$),
  (26, $x26$

**Worked example:** Diagram: trigger, three stages, approvals, tools with permissions, risks and fixes.

**Common mistake:** A design with no risks listed.$x26$),
  (27, $x27$

**Worked example:** Run ten real invoices: 8 correct, 2 wrong dates. Record the pattern and fix the instruction.

**Common mistake:** Judging by two lucky examples.$x27$),
  (28, $x28$

**Worked example:** Add approval before sending, a log, an alert for failures and a monthly cost cap. Simulate a failure to test.

**Common mistake:** Adding safety features without testing them.$x28$),
  (29, $x29$

**Worked example:** Pilot week: 23 runs, 2 errors, 3 hours saved, user says 'drafts need shorter subject lines'.

**Common mistake:** Ending the pilot without asking the user.$x29$),
  (30, $x30$

**Worked example:** Handover page: what it does, how to pause it, what can go wrong, who to call, where logs live.

**Common mistake:** Assuming others can run it without documentation.$x30$)
  ) as v(n, extra), public.track t
 where t.id = d.track_id and t.slug = 'agents' and d.day_number = v.n
   and d.lesson_md not like '%**Worked example:**%';
