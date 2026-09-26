-- AI agents & automation Skill Labs (days 91-120). Published; appended after the core path.
insert into public.day
  (track_id, tier_id, day_number, title, objective, lesson_md, skill_focus, assignment_md, rubric,
   est_minutes, is_published, credit_budget, submission_type, ai_evaluate, requires_review)
select t.id, ti.id, v.n, v.title, v.objective, v.lesson_md, v.skill_focus, v.assignment_md, v.rubric,
       v.est_minutes, true, null, v.submission_type, v.ai_evaluate, v.requires_review
from public.track t
join public.tier ti on ti.track_id = t.id and ti.slug = 'grandmaster'
cross join (values
  (91, $t91a$Skill Lab: Tool use and the Model Context Protocol$t91a$, $t91b$Understand how agents connect to tools.$t91b$, $t91c$Agents act through tools: search, read a file, send a message. The Model Context Protocol (MCP) is a common standard for describing tools and connecting them to agents, so one tool can work with many agents. Each connection is a permission, so decide what each tool can read and change, and prefer read-only.

**Worked example:** An agent is connected to a calendar tool for reading availability and a drafts tool for writing emails, but not to a send tool.

**Common mistake:** Connecting every available tool because it is easy.$t91c$, $t91d$Skill Lab: Tool use and the Model Context Protocol$t91d$, $t91e$List five tools an agent could use for a real task, and for each the permission level (read, draft, act) and why.$t91e$, $t91f$[{"criterion": "Permissions justified", "max_points": 45, "guidance": "Least privilege."}, {"criterion": "Tools relevant", "max_points": 30, "guidance": "Fit the task."}, {"criterion": "Risks named", "max_points": 25, "guidance": "Specific."}]$t91f$::jsonb, 45, 'text', false, false),
  (92, $t92a$Skill Lab: Designing a tool an agent can use$t92a$, $t92b$Write a clear tool specification.$t92b$, $t92c$A good tool has a clear name, a one-sentence purpose, typed inputs with examples, predictable outputs and helpful errors ('date must be YYYY-MM-DD'). Make tools small and single-purpose. Test each tool alone before giving it to an agent.

**Worked example:** find_free_slots(date, duration_minutes) returns up to five slots; error 'duration must be 15 to 120'.

**Common mistake:** One giant tool that does many things.$t92c$, $t92d$Skill Lab: Designing a tool an agent can use$t92d$, $t92e$Write specifications for three tools (name, purpose, inputs, outputs, errors) and test each manually.$t92e$, $t92f$[{"criterion": "Specs clear", "max_points": 40, "guidance": "Precise."}, {"criterion": "Errors helpful", "max_points": 30, "guidance": "Recoverable."}, {"criterion": "Tested alone", "max_points": 30, "guidance": "Evidence."}]$t92f$::jsonb, 45, 'text', false, false),
  (93, $t93a$Skill Lab: Secure connections and secrets$t93a$, $t93b$Protect credentials and data.$t93b$, $t93c$Use scoped, expiring credentials, store secrets in a vault or the platform's secret settings, never in prompts or logs, and rotate them. Review what each connection can access. Treat data from tools as untrusted input.

**Worked example:** Read-only token that expires in 24 hours, stored in secrets, with access limited to one folder.

**Common mistake:** Pasting a master key into a prompt.$t93c$, $t93d$Skill Lab: Secure connections and secrets$t93d$, $t93e$Write a secrets and access policy for your agent (six rules) and audit one existing connection against it.$t93e$, $t93f$[{"criterion": "Rules concrete", "max_points": 40, "guidance": "Practical."}, {"criterion": "Audit real", "max_points": 35, "guidance": "Findings."}, {"criterion": "Rotation plan", "max_points": 25, "guidance": "Defined."}]$t93f$::jsonb, 45, 'text', false, false),
  (94, $t94a$Skill Lab: Testing tools and agents together$t94a$, $t94b$Check that the agent uses tools correctly.$t94b$, $t94c$Run scenarios where the right tool choice is obvious, ambiguous or a trap. Record which tool was called with what input, and whether the outcome was right. Fix descriptions and errors before touching the prompt.

**Worked example:** Scenario: 'Book me a meeting Friday' should call free-slots first, then create a draft, not book directly.

**Common mistake:** Testing only whether the final answer looks good.$t94c$, $t94d$Skill Lab: Testing tools and agents together$t94d$, $t94e$Run ten scenarios (three obvious, four ambiguous, three traps) and record tool calls and outcomes.$t94e$, $t94f$[{"criterion": "Scenarios varied", "max_points": 35, "guidance": "Range."}, {"criterion": "Tool calls recorded", "max_points": 35, "guidance": "Evidence."}, {"criterion": "Fixes made", "max_points": 30, "guidance": "Applied."}]$t94f$::jsonb, 45, 'text', false, false),
  (95, $t95a$Skill Lab: Lab 1 project: a tool kit for an agent$t95a$, $t95b$Deliver safe, tested tools.$t95b$, $t95c$Show Lab 1. Deliver a **tool kit** for one agent: five tool specs, a permission table, a secrets policy and a ten-scenario test log.

Success looks like an agent that uses tools correctly and safely.

**Worked example:** Scheduling assistant: read calendar, find slots, create draft invitation, ask for confirmation, log actions.

**Common mistake:** No record of failures.

Your work is scored on the rubric below. You can revise and resubmit.$t95c$, $t95d$Skill Lab: Lab 1 project: a tool kit for an agent$t95d$, $t95e$Submit the specs, permission table, policy and test log with failures explained.$t95e$, $t95f$[{"criterion": "Tool quality", "max_points": 30, "guidance": "Clear."}, {"criterion": "Least privilege", "max_points": 25, "guidance": "Applied."}, {"criterion": "Testing", "max_points": 30, "guidance": "Evidence."}, {"criterion": "Honesty", "max_points": 15, "guidance": "Failures reported."}]$t95f$::jsonb, 120, 'text', true, false),
  (96, $t96a$Skill Lab: Retrieval: giving agents the right knowledge$t96a$, $t96b$Ground answers in your documents.$t96b$, $t96c$Retrieval-augmented generation finds relevant passages first, then answers from them. Prepare documents, split them into meaningful chunks, search by meaning and keywords, and pass only the best passages. Require quotes and 'not found' when the answer is missing.

**Worked example:** A policy assistant retrieves three passages and answers with quotes and page numbers.

**Common mistake:** Dumping every document into the prompt.$t96c$, $t96d$Skill Lab: Retrieval: giving agents the right knowledge$t96d$, $t96e$Prepare five documents for retrieval: cleaned text, chunking approach, and ten test questions with expected sources.$t96e$, $t96f$[{"criterion": "Documents prepared", "max_points": 30, "guidance": "Clean."}, {"criterion": "Chunking reasoned", "max_points": 30, "guidance": "Sensible."}, {"criterion": "Test questions useful", "max_points": 40, "guidance": "Cover cases."}]$t96f$::jsonb, 45, 'text', false, false),
  (97, $t97a$Skill Lab: Chunking, metadata and freshness$t97a$, $t97b$Keep retrieval accurate and current.$t97b$, $t97c$Chunk by meaning (headings, paragraphs), add metadata (source, date, owner), remove outdated versions and re-index on change. Tell the agent to prefer the newest source and to show its date.

**Worked example:** Each chunk carries source, section and date; the policy from 2026 supersedes 2024.

**Common mistake:** Leaving old versions searchable.$t97c$, $t97d$Skill Lab: Chunking, metadata and freshness$t97d$, $t97e$Add metadata and a freshness rule to your document set and show two questions where it matters.$t97e$, $t97f$[{"criterion": "Metadata useful", "max_points": 35, "guidance": "Relevant."}, {"criterion": "Freshness handled", "max_points": 40, "guidance": "Rule."}, {"criterion": "Examples show effect", "max_points": 25, "guidance": "Evidence."}]$t97f$::jsonb, 45, 'text', false, false),
  (98, $t98a$Skill Lab: Citations, confidence and refusals$t98a$, $t98b$Make answers checkable.$t98b$, $t98c$Require every claim to cite a source passage, show confidence in plain words and refuse when evidence is weak. Provide a way for users to open the source and report a wrong answer.

**Worked example:** Answer: 'Refunds within 30 days (Policy, section 3)' and a link to the passage.

**Common mistake:** Fluent answers with no source.$t98c$, $t98d$Skill Lab: Citations, confidence and refusals$t98d$, $t98e$Test 15 questions (five answerable, five partially, five unanswerable) and score citation and refusal quality.$t98e$, $t98f$[{"criterion": "Citations correct", "max_points": 40, "guidance": "Verified."}, {"criterion": "Refusals correct", "max_points": 35, "guidance": "Honest."}, {"criterion": "Scoring clear", "max_points": 25, "guidance": "Measured."}]$t98f$::jsonb, 45, 'text', false, false),
  (99, $t99a$Skill Lab: Evaluating retrieval quality$t99a$, $t99b$Measure whether retrieval finds the right passages.$t99b$, $t99c$For each test question record whether the right passage was retrieved (recall) and whether irrelevant ones crowded it out. Improve chunking, search settings and questions, then re-measure.

**Worked example:** Before: right passage in top three for 12 of 20 questions; after chunk changes: 17 of 20.

**Common mistake:** Judging by a couple of impressive answers.$t99c$, $t99d$Skill Lab: Evaluating retrieval quality$t99d$, $t99e$Measure retrieval on 20 questions before and after one change and report the numbers.$t99e$, $t99f$[{"criterion": "Measured properly", "max_points": 40, "guidance": "Numbers."}, {"criterion": "Change explained", "max_points": 30, "guidance": "Reasoned."}, {"criterion": "Improvement shown", "max_points": 30, "guidance": "Evidence."}]$t99f$::jsonb, 45, 'text', false, false),
  (100, $t100a$Skill Lab: Lab 2 project: a grounded knowledge agent$t100a$, $t100b$Deliver an agent that answers from sources with an evaluation.$t100b$, $t100c$Show Lab 2. Deliver a **grounded agent** for a real document set with citations, refusals, freshness rules and a retrieval evaluation.

Success looks like answers you can trace and trust.

**Worked example:** A club handbook assistant with cited answers, 20-question evaluation and a report of failures.

**Common mistake:** No unanswerable questions in the test set.

Your work is scored on the rubric below. You can revise and resubmit.$t100c$, $t100d$Skill Lab: Lab 2 project: a grounded knowledge agent$t100d$, $t100e$Submit the document set summary, the agent instructions, evaluation results and failure analysis.$t100e$, $t100f$[{"criterion": "Grounded and cited", "max_points": 30, "guidance": "Traceable."}, {"criterion": "Evaluation rigour", "max_points": 30, "guidance": "Measured."}, {"criterion": "Refusal behaviour", "max_points": 20, "guidance": "Correct."}, {"criterion": "Honesty", "max_points": 20, "guidance": "Failures."}]$t100f$::jsonb, 150, 'text', true, false),
  (101, $t101a$Skill Lab: Workflow platforms: triggers, steps and data$t101a$, $t101b$Build automations on no-code platforms.$t101b$, $t101c$Platforms such as Zapier, Make and n8n chain triggers and actions. Learn the pieces: trigger, filter, action, data mapping, loops and delays. Test each step with sample data, and keep names clear so someone else can read the flow. Start with the smallest useful flow.

**Worked example:** New form response, add a row to a sheet, notify the team, and mark the row 'notified'.

**Common mistake:** Building a fifteen-step flow before testing step one.$t101c$, $t101d$Skill Lab: Workflow platforms: triggers, steps and data$t101d$, $t101e$Build a three-step automation with test data and screenshot each step's output.$t101e$, $t101f$[{"criterion": "Flow works", "max_points": 40, "guidance": "Evidence."}, {"criterion": "Each step tested", "max_points": 30, "guidance": "Screens."}, {"criterion": "Names clear", "max_points": 30, "guidance": "Readable."}]$t101f$::jsonb, 45, 'text', false, false),
  (102, $t102a$Skill Lab: Error handling, retries and idempotency$t102a$, $t102b$Make automations dependable.$t102b$, $t102c$Steps fail. Add retries with limits, an error path that alerts a person, and idempotency (running the same event twice must not double-charge or double-send). Log what happened and keep failed items for review.

**Worked example:** If sending fails, retry twice, then add to a 'needs attention' sheet and email the owner.

**Common mistake:** Assuming every step always works.$t102c$, $t102d$Skill Lab: Error handling, retries and idempotency$t102d$, $t102e$Add error handling and duplicate protection to your automation and test by breaking a step on purpose.$t102e$, $t102f$[{"criterion": "Error path works", "max_points": 40, "guidance": "Tested."}, {"criterion": "Duplicates prevented", "max_points": 35, "guidance": "Shown."}, {"criterion": "Logging", "max_points": 25, "guidance": "Present."}]$t102f$::jsonb, 45, 'text', false, false),
  (103, $t103a$Skill Lab: Human approvals in automations$t103a$, $t103b$Put people in the loop where it matters.$t103b$, $t103c$Insert approval steps before anything hard to undo: sending to customers, spending, deleting. Show the reviewer exactly what will happen and give approve, edit and reject options, with a timeout that fails safely.

**Worked example:** An approval message with the draft email and 'Send', 'Edit' or 'Reject'; no answer in 24 hours means it does not send.

**Common mistake:** Approval steps that silently approve on timeout.$t103c$, $t103d$Skill Lab: Human approvals in automations$t103d$, $t103e$Add an approval step to a flow and document what the reviewer sees and each outcome.$t103e$, $t103f$[{"criterion": "Approval placed well", "max_points": 35, "guidance": "Risky steps."}, {"criterion": "Reviewer information clear", "max_points": 35, "guidance": "Understandable."}, {"criterion": "Safe timeout", "max_points": 30, "guidance": "Fail safe."}]$t103f$::jsonb, 45, 'text', false, false),
  (104, $t104a$Skill Lab: Scheduling, batching and cost$t104a$, $t104b$Run automations efficiently.$t104b$, $t104c$Schedule work when it is needed, batch small items, avoid polling too often and set spending and run limits. Watch usage and costs monthly.

**Worked example:** Hourly digest instead of a run for every email; a monthly cap and alert at 80 percent.

**Common mistake:** Polling every minute for something that changes daily.$t104c$, $t104d$Skill Lab: Scheduling, batching and cost$t104d$, $t104e$Estimate runs and cost at three volumes for your automation and set two limits.$t104e$, $t104f$[{"criterion": "Estimate sensible", "max_points": 40, "guidance": "Numbers."}, {"criterion": "Limits set", "max_points": 35, "guidance": "Defined."}, {"criterion": "Batching used", "max_points": 25, "guidance": "Considered."}]$t104f$::jsonb, 45, 'text', false, false),
  (105, $t105a$Skill Lab: Lab 3 project: a dependable automation$t105a$, $t105b$Deliver a workflow with error handling and approval.$t105b$, $t105c$Show Lab 3. Deliver an **automation** with at least five steps, error handling, duplicate protection, an approval step, a log and a cost estimate.

Success looks like something that survives a bad day.

**Worked example:** Lead handling: form to sheet, draft reply, approval, send, log, with a broken step demonstrated.

**Common mistake:** Only showing the happy path.

Your work is scored on the rubric below. You can revise and resubmit.$t105c$, $t105d$Skill Lab: Lab 3 project: a dependable automation$t105d$, $t105e$Submit the flow description, test results including a deliberate failure, the approval design and the cost estimate.$t105e$, $t105f$[{"criterion": "Works and tested", "max_points": 30, "guidance": "Evidence."}, {"criterion": "Failure handling", "max_points": 30, "guidance": "Shown."}, {"criterion": "Approval and safety", "max_points": 25, "guidance": "Right place."}, {"criterion": "Cost", "max_points": 15, "guidance": "Estimated."}]$t105f$::jsonb, 150, 'text', true, false),
  (106, $t106a$Skill Lab: Traces: seeing what an agent did$t106a$, $t106b$Inspect every step.$t106b$, $t106c$A trace records what the agent saw, thought, called and returned at each step. Read traces to find why a run failed: missing context, a wrong tool, an unclear instruction. Keep traces for a limited time and protect personal data inside them.

**Worked example:** The trace shows the agent never received the customer's currency; add it to the input.

**Common mistake:** Guessing why it failed instead of reading the trace.$t106c$, $t106d$Skill Lab: Traces: seeing what an agent did$t106d$, $t106e$Read three failed runs and write the root cause and fix for each.$t106e$, $t106f$[{"criterion": "Root causes found", "max_points": 45, "guidance": "Not symptoms."}, {"criterion": "Fixes sensible", "max_points": 30, "guidance": "Applied."}, {"criterion": "Privacy noted", "max_points": 25, "guidance": "Considered."}]$t106f$::jsonb, 45, 'text', false, false),
  (107, $t107a$Skill Lab: Evaluation sets and model-graded checks$t107a$, $t107b$Test at scale, carefully.$t107b$, $t107c$Build a set of realistic tasks with expected outcomes. Use rules for exact checks and a model as a judge for fuzzy ones, then compare the judge with human ratings on a sample before trusting it.

**Worked example:** A judge model agrees with a human on 18 of 20 tickets; the two disagreements are studied.

**Common mistake:** Trusting an automated judge without checking it.$t107c$, $t107d$Skill Lab: Evaluation sets and model-graded checks$t107d$, $t107e$Create a 20-task evaluation, run it, and compare a judge with human ratings on ten items.$t107e$, $t107f$[{"criterion": "Tasks realistic", "max_points": 30, "guidance": "Varied."}, {"criterion": "Judge checked", "max_points": 40, "guidance": "Human comparison."}, {"criterion": "Results honest", "max_points": 30, "guidance": "Reported."}]$t107f$::jsonb, 45, 'text', false, false),
  (108, $t108a$Skill Lab: Monitoring quality, cost and safety$t108a$, $t108b$Watch agents in production.$t108b$, $t108c$Track success rate, harmful errors, cost per task, response time and human interventions. Set alerts and review a random sample each week. Record every incident and what changed afterwards.

**Worked example:** Dashboard alert if success falls below 85 percent or cost per task doubles.

**Common mistake:** Watching only the average, which hides rare serious errors.$t108c$, $t108d$Skill Lab: Monitoring quality, cost and safety$t108d$, $t108e$Design a monitoring plan with six metrics, thresholds and a weekly review routine.$t108e$, $t108f$[{"criterion": "Metrics balanced", "max_points": 40, "guidance": "Success and harm."}, {"criterion": "Thresholds sensible", "max_points": 30, "guidance": "Reasoned."}, {"criterion": "Review routine", "max_points": 30, "guidance": "Defined."}]$t108f$::jsonb, 45, 'text', false, false),
  (109, $t109a$Skill Lab: Safe rollouts and rollbacks$t109a$, $t109b$Change agents without surprises.$t109b$, $t109c$Version prompts, tools and settings. Test on the evaluation set, release to a small share of traffic, watch the metrics and keep a one-step rollback.

**Worked example:** New prompt v4 tested on 25 tasks, released to 10 percent for two days, rolled back when cost rose.

**Common mistake:** Editing the live prompt directly.$t109c$, $t109d$Skill Lab: Safe rollouts and rollbacks$t109d$, $t109e$Write a rollout and rollback plan for one change with test gates and stop conditions.$t109e$, $t109f$[{"criterion": "Gates defined", "max_points": 40, "guidance": "Clear."}, {"criterion": "Staged release", "max_points": 30, "guidance": "Small first."}, {"criterion": "Rollback ready", "max_points": 30, "guidance": "One step."}]$t109f$::jsonb, 45, 'text', false, false),
  (110, $t110a$Skill Lab: Lab 4 project: an observed, evaluated agent$t110a$, $t110b$Deliver an agent you can measure and trust.$t110b$, $t110c$Show Lab 4. Deliver an **agent with an evaluation set, trace analysis, monitoring plan and rollout plan**, with a report of what you improved.

Success looks like measurable improvement backed by evidence.

**Worked example:** Support triage agent: 25-task evaluation, success from 72 to 88 percent after two trace-driven fixes.

**Common mistake:** Reporting only the final result.

Your work is scored on the rubric below. You can revise and resubmit.$t110c$, $t110d$Skill Lab: Lab 4 project: an observed, evaluated agent$t110d$, $t110e$Submit the evaluation set, before and after results, trace analysis, monitoring and rollout plans.$t110e$, $t110f$[{"criterion": "Evaluation rigour", "max_points": 30, "guidance": "Real."}, {"criterion": "Improvement evidence", "max_points": 30, "guidance": "Numbers."}, {"criterion": "Monitoring and rollout", "max_points": 25, "guidance": "Practical."}, {"criterion": "Honesty", "max_points": 15, "guidance": "Limits."}]$t110f$::jsonb, 150, 'text', true, false),
  (111, $t111a$Skill Lab: Sales and lead operations$t111a$, $t111b$Automate outreach preparation, not spam.$t111b$, $t111c$Enrich leads from public sources, draft personal messages for approval, log activity and follow up on time. Respect consent and anti-spam law, honour opt-outs and never send bulk unreviewed messages.

**Worked example:** The agent researches a company, drafts a two-line personal note and waits for approval.

**Common mistake:** Sending mass automated cold messages.$t111c$, $t111d$Skill Lab: Sales and lead operations$t111d$, $t111e$Design a lead-handling agent with data sources, approval, opt-out handling and a compliance note.$t111e$, $t111f$[{"criterion": "Approval and opt-out", "max_points": 40, "guidance": "Present."}, {"criterion": "Public sources only", "max_points": 30, "guidance": "Ethical."}, {"criterion": "Compliance noted", "max_points": 30, "guidance": "Considered."}]$t111f$::jsonb, 45, 'text', false, false),
  (112, $t112a$Skill Lab: Support and customer operations$t112a$, $t112b$Answer safely and escalate well.$t112b$, $t112c$Ground answers in approved content, hand off angry, legal or high-value cases, never promise refunds outside policy and measure both speed and harm.

**Worked example:** Handoff rules list refund over 100, legal words and repeated contact; harms tracked include wrong promises.

**Common mistake:** Measuring only how fast tickets close.$t112c$, $t112d$Skill Lab: Support and customer operations$t112d$, $t112e$Design a support agent with topics, sources, handoffs, five success metrics and five harm metrics.$t112e$, $t112f$[{"criterion": "Handoffs clear", "max_points": 35, "guidance": "Rules."}, {"criterion": "Balanced metrics", "max_points": 40, "guidance": "Success and harm."}, {"criterion": "Grounded", "max_points": 25, "guidance": "Sources."}]$t112f$::jsonb, 45, 'text', false, false),
  (113, $t113a$Skill Lab: Finance, admin and reporting operations$t113a$, $t113b$Automate carefully with numbers.$t113b$, $t113c$For invoices, expenses and reports use validation, reconciliation and human sign-off. Keep original records untouched, log changes, and never let an agent move money without approval.

**Worked example:** An agent extracts invoice data, checks totals, flags mismatches and prepares a batch for approval.

**Common mistake:** Letting an agent pay invoices unattended.$t113c$, $t113d$Skill Lab: Finance, admin and reporting operations$t113d$, $t113e$Design an invoice-processing agent with validation, reconciliation, logs and approvals.$t113e$, $t113f$[{"criterion": "Validation real", "max_points": 35, "guidance": "Checks."}, {"criterion": "Approvals and logs", "max_points": 40, "guidance": "Present."}, {"criterion": "Originals kept", "max_points": 25, "guidance": "Protected."}]$t113f$::jsonb, 45, 'text', false, false),
  (114, $t114a$Skill Lab: People and recruiting operations$t114a$, $t114b$Handle personal data with extra care.$t114b$, $t114c$Hiring and HR involve personal and sensitive data and legal duties that vary by country. Use agents for scheduling and drafting, keep humans in every decision about people, avoid biased screening and document your process.

**Worked example:** An agent schedules interviews and drafts feedback summaries; humans decide who advances.

**Common mistake:** Auto-rejecting candidates by score.$t114c$, $t114d$Skill Lab: People and recruiting operations$t114d$, $t114e$Design a scheduling and drafting agent for hiring with privacy and fairness safeguards.$t114e$, $t114f$[{"criterion": "Human decisions kept", "max_points": 40, "guidance": "Clear."}, {"criterion": "Privacy and fairness", "max_points": 35, "guidance": "Considered."}, {"criterion": "Documentation", "max_points": 25, "guidance": "Present."}]$t114f$::jsonb, 45, 'text', false, false),
  (115, $t115a$Skill Lab: Lab 5 project: a domain agent playbook$t115a$, $t115b$Deliver a safe playbook for one business area.$t115b$, $t115c$Show Lab 5. Deliver a **playbook** for one domain (sales, support, finance or people): use case, agent design, data map, approvals, metrics (success and harm), risks and compliance notes.

Success looks like a design a manager could approve.

**Worked example:** Support playbook with five handoff rules, ten metrics and a privacy map.

**Common mistake:** Ignoring legal and privacy questions for the sector.

Your work is scored on the rubric below. You can revise and resubmit.$t115c$, $t115d$Skill Lab: Lab 5 project: a domain agent playbook$t115d$, $t115e$Submit the playbook.$t115e$, $t115f$[{"criterion": "Design sound", "max_points": 30, "guidance": "Coherent."}, {"criterion": "Safeguards", "max_points": 30, "guidance": "Approvals."}, {"criterion": "Metrics balanced", "max_points": 20, "guidance": "Success and harm."}, {"criterion": "Compliance awareness", "max_points": 20, "guidance": "Considered."}]$t115f$::jsonb, 150, 'text', true, false),
  (116, $t116a$Skill Lab: Finding automation opportunities in a business$t116a$, $t116b$Spot high-value, low-risk jobs.$t116b$, $t116c$Interview staff about repeated, rule-based tasks, time them, rate error cost and data sensitivity, and rank by value and safety. Start where errors are cheap and volume is high.

**Worked example:** Ranking: invoice reminders (high volume, low risk) before contract review (low volume, high risk).

**Common mistake:** Starting with the most impressive task.$t116c$, $t116d$Skill Lab: Finding automation opportunities in a business$t116d$, $t116e$Interview two people, list ten tasks, score them and choose the first three to automate.$t116e$, $t116f$[{"criterion": "Scoring reasoned", "max_points": 40, "guidance": "Criteria."}, {"criterion": "Real interviews", "max_points": 30, "guidance": "Two."}, {"criterion": "Choice sensible", "max_points": 30, "guidance": "Low risk first."}]$t116f$::jsonb, 45, 'text', false, false),
  (117, $t117a$Skill Lab: Proving return on investment$t117a$, $t117b$Show the value honestly.$t117b$, $t117c$Measure the baseline first, then time saved, error change, cost and satisfaction after. Include setup, maintenance and checking time. Report ranges and limits.

**Worked example:** Baseline 4 hours a week; after: 1.5 hours including checking; cost 12 a month.

**Common mistake:** Ignoring the time spent checking the agent.$t117c$, $t117d$Skill Lab: Proving return on investment$t117d$, $t117e$Create an ROI report for one automation with baseline, results, costs and limits.$t117e$, $t117f$[{"criterion": "Baseline real", "max_points": 35, "guidance": "Measured."}, {"criterion": "Costs complete", "max_points": 35, "guidance": "Included."}, {"criterion": "Limits stated", "max_points": 30, "guidance": "Honest."}]$t117f$::jsonb, 45, 'text', false, false),
  (118, $t118a$Skill Lab: Pricing and packaging automation services$t118a$, $t118b$Offer services fairly.$t118b$, $t118c$Package by outcome: an audit, a build, a monthly care plan. Price by value and effort, include support and change requests, and agree ownership, data handling and what happens if the platform changes.

**Worked example:** Audit 300, build 1,200, care plan 150 a month with monitoring and two changes.

**Common mistake:** Building for a client with no maintenance agreement.$t118c$, $t118d$Skill Lab: Pricing and packaging automation services$t118d$, $t118e$Write your service packages, prices and a short agreement outline.$t118e$, $t118f$[{"criterion": "Packages clear", "max_points": 40, "guidance": "Defined."}, {"criterion": "Terms fair", "max_points": 30, "guidance": "Balanced."}, {"criterion": "Data and platform risks", "max_points": 30, "guidance": "Covered."}]$t118f$::jsonb, 45, 'text', false, false),
  (119, $t119a$Skill Lab: Regulation, ethics and accountability$t119a$, $t119b$Build responsibly.$t119b$, $t119c$Know that rules on automated decisions, privacy and sector duties vary and change; get advice for regulated uses. Keep audit trails, disclose automation to affected people and provide a human route.

**Worked example:** A disclosure line, an audit log and a route to a human on every customer-facing agent.

**Common mistake:** Hiding that a customer is talking to an automated system.$t119c$, $t119d$Skill Lab: Regulation, ethics and accountability$t119d$, $t119e$Write your agent standards and a disclosure and escalation template.$t119e$, $t119f$[{"criterion": "Standards specific", "max_points": 40, "guidance": "Concrete."}, {"criterion": "Disclosure honest", "max_points": 30, "guidance": "Clear."}, {"criterion": "Human route", "max_points": 30, "guidance": "Present."}]$t119f$::jsonb, 45, 'text', false, false),
  (120, $t120a$Skill Lab: Lab 6 project: your automation showcase$t120a$, $t120b$Present your work and services.$t120b$, $t120c$Show Lab 6. Publish a **showcase**: two automation case studies with ROI, your service packages, standards and a care plan. Share it in the NEXTGEN Discord and ask for one piece of feedback.

Success looks like something you would send to a real client.

**Worked example:** A page with two case studies, three packages, the standards and a contact button.

**Common mistake:** Case studies with no measured results.

Your work is scored on the rubric below. You can revise and resubmit.$t120c$, $t120d$Skill Lab: Lab 6 project: your automation showcase$t120d$, $t120e$Submit the showcase text or links and a 150-word reflection on what to improve next.$t120e$, $t120f$[{"criterion": "Case study quality", "max_points": 30, "guidance": "Measured."}, {"criterion": "Business readiness", "max_points": 25, "guidance": "Clear."}, {"criterion": "Standards and honesty", "max_points": 25, "guidance": "Real."}, {"criterion": "Reflection", "max_points": 20, "guidance": "Specific."}]$t120f$::jsonb, 150, 'text', true, false)
) as v(n, title, objective, lesson_md, skill_focus, assignment_md, rubric, est_minutes, submission_type, ai_evaluate, requires_review)
where t.slug = 'agents'
on conflict (track_id, day_number) do nothing;
