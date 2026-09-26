-- Research & data Skill Labs (days 91-120). Published; appended after the core path.
insert into public.day
  (track_id, tier_id, day_number, title, objective, lesson_md, skill_focus, assignment_md, rubric,
   est_minutes, is_published, credit_budget, submission_type, ai_evaluate, requires_review)
select t.id, ti.id, v.n, v.title, v.objective, v.lesson_md, v.skill_focus, v.assignment_md, v.rubric,
       v.est_minutes, true, null, v.submission_type, v.ai_evaluate, v.requires_review
from public.track t
join public.tier ti on ti.track_id = t.id and ti.slug = 'grandmaster'
cross join (values
  (91, $t91a$Skill Lab: Discovery and synthesis: two different jobs$t91a$, $t91b$Use the right AI tool for each research stage.$t91b$, $t91c$Research has stages. **Discovery** finds what exists: a search assistant that cites web sources is good here. **Synthesis** works on a fixed set of documents you have gathered: a notebook-style tool that answers only from your sources is good there. Then you do the thinking: judge the sources, build the argument and write. Never skip opening the original sources. [CREAO](https://agent.creao.ai/@Sonofpeace) (referral link) can run scheduled research digests that remember your sources.

**Worked example:** Use a citing search tool to find twenty candidate sources, pick eight, load them into a document tool, ask questions across them and check each answer against the text.

**Common mistake:** Asking a tool to write the review without reading any source yourself.$t91c$, $t91d$Skill Lab: Discovery and synthesis: two different jobs$t91d$, $t91e$Run this three-stage workflow on one question. Submit your source list, five questions asked of the document set and the answers you verified.$t91e$, $t91f$[{"criterion": "Stages used correctly", "max_points": 35, "guidance": "Distinct."}, {"criterion": "Answers verified", "max_points": 45, "guidance": "Checked against text."}, {"criterion": "Sources judged", "max_points": 20, "guidance": "Rated."}]$t91f$::jsonb, 45, 'text', false, false),
  (92, $t92a$Skill Lab: Prompting for research$t92a$, $t92b$Ask research questions that produce checkable answers.$t92b$, $t92c$Ask for claims with sources, ask what would contradict the claim, request uncertainty, and specify the time period and place. Ask the tool to list what it could not find. Save good prompts as templates.

**Worked example:** 'Summarise what studies from 2020 to 2026 say about X in adults. For each claim give the source and sample size and say how sure the evidence is.'

**Common mistake:** Asking 'is X true?' and accepting a yes or no.$t92c$, $t92d$Skill Lab: Prompting for research$t92d$, $t92e$Write five research prompts (claim, contradiction, uncertainty, gaps, comparison) for a question of your choice and record what each gave.$t92e$, $t92f$[{"criterion": "Prompts well formed", "max_points": 40, "guidance": "Specific."}, {"criterion": "Results recorded", "max_points": 30, "guidance": "Honest."}, {"criterion": "Verification noted", "max_points": 30, "guidance": "Checked."}]$t92f$::jsonb, 45, 'text', false, false),
  (93, $t93a$Skill Lab: Reading and extracting from many documents$t93a$, $t93b$Pull structured facts from a pile of sources.$t93b$, $t93c$Create an extraction table with the same columns for every source (question, method, sample, result, limits, link). Fill it by reading, using AI to propose entries you then verify. Consistency is what makes comparison possible.

**Worked example:** A table of twelve studies with columns for sample size and effect; two entries corrected after checking.

**Common mistake:** Letting the extraction drift between sources.$t93c$, $t93d$Skill Lab: Reading and extracting from many documents$t93d$, $t93e$Build an extraction table for eight sources with a verification note for each row.$t93e$, $t93f$[{"criterion": "Consistent table", "max_points": 40, "guidance": "Same columns."}, {"criterion": "Rows verified", "max_points": 40, "guidance": "Checked."}, {"criterion": "Limits captured", "max_points": 20, "guidance": "Recorded."}]$t93f$::jsonb, 45, 'text', false, false),
  (94, $t94a$Skill Lab: Detecting AI errors and fabricated sources$t94a$, $t94b$Catch hallucinations before they spread.$t94b$, $t94c$Check that every cited paper exists, the quote is in the text and the number matches. Look for citations with plausible titles you cannot find, statistics without a source and overconfident wording. Keep an error log to learn where your tools fail.

**Worked example:** Of twelve AI citations, ten found; two invented; both removed and logged.

**Common mistake:** Assuming a cited source exists because it looks real.$t94c$, $t94d$Skill Lab: Detecting AI errors and fabricated sources$t94d$, $t94e$Ask an AI for ten cited claims on a topic, verify each, and submit an error log with counts.$t94e$, $t94f$[{"criterion": "Every citation checked", "max_points": 45, "guidance": "Complete."}, {"criterion": "Log honest", "max_points": 30, "guidance": "Counts."}, {"criterion": "Lessons drawn", "max_points": 25, "guidance": "Insight."}]$t94f$::jsonb, 45, 'text', false, false),
  (95, $t95a$Skill Lab: Lab 1 project: an AI-assisted literature brief$t95a$, $t95b$Deliver a verified brief.$t95b$, $t95c$Show Lab 1. Deliver a **literature brief** (800 words) on a question, built with the three-stage workflow, an extraction table, an error log and every claim verified.

Success looks like a brief you would put your name to.

**Worked example:** A brief on whether reminders improve course completion, with twelve sources and an error log.

**Common mistake:** No record of verification.

Your work is scored on the rubric below. You can revise and resubmit.$t95c$, $t95d$Skill Lab: Lab 1 project: an AI-assisted literature brief$t95d$, $t95e$Submit the brief, source list, extraction table and error log.$t95e$, $t95f$[{"criterion": "Accuracy and verification", "max_points": 35, "guidance": "Checked."}, {"criterion": "Synthesis quality", "max_points": 30, "guidance": "Insightful."}, {"criterion": "Workflow documented", "max_points": 20, "guidance": "Clear."}, {"criterion": "Honest limits", "max_points": 15, "guidance": "Stated."}]$t95f$::jsonb, 150, 'text', true, false),
  (96, $t96a$Skill Lab: SQL basics: asking a database questions$t96a$, $t96b$Query data with select, where, group and join.$t96b$, $t96c$A database is tables of rows. SELECT chooses columns, WHERE filters rows, GROUP BY summarises, ORDER BY sorts and JOIN combines tables through a shared key. Start with one small question, run it, check the result on a few rows by hand, then add one clause at a time. AI can draft queries; you must read and test them.

**Worked example:** SELECT region, AVG(price) FROM orders WHERE date >= '2026-01-01' GROUP BY region ORDER BY 2 DESC.

**Common mistake:** Running a query you cannot explain.$t96c$, $t96d$Skill Lab: SQL basics: asking a database questions$t96d$, $t96e$Write five queries on a sample dataset (provided by you or public), explain each in a sentence and check one by hand.$t96e$, $t96f$[{"criterion": "Queries correct", "max_points": 40, "guidance": "Work."}, {"criterion": "Explanations accurate", "max_points": 30, "guidance": "Clear."}, {"criterion": "Hand check done", "max_points": 30, "guidance": "Verified."}]$t96f$::jsonb, 45, 'text', false, false),
  (97, $t97a$Skill Lab: Joins and data models$t97a$, $t97b$Combine tables safely.$t97b$, $t97c$A join needs a matching key. Check row counts before and after: an unexpected jump means duplicates. Understand one-to-many relationships and avoid counting the same thing twice.

**Worked example:** Customers join orders: 500 customers, 1,240 orders; counting customers after the join would give 1,240 unless you use distinct counts.

**Common mistake:** Trusting a join without checking counts.$t97c$, $t97d$Skill Lab: Joins and data models$t97d$, $t97e$Join two tables, explain the relationship and show row counts before and after with a check for duplicates.$t97e$, $t97f$[{"criterion": "Join correct", "max_points": 40, "guidance": "Right key."}, {"criterion": "Counts checked", "max_points": 35, "guidance": "Reported."}, {"criterion": "Relationship explained", "max_points": 25, "guidance": "Clear."}]$t97f$::jsonb, 45, 'text', false, false),
  (98, $t98a$Skill Lab: Python and notebooks for analysis$t98a$, $t98b$Automate repeatable analysis.$t98b$, $t98c$A notebook mixes code, results and notes. Load data, clean it, summarise and chart it in steps you can rerun. Use AI to draft code, then run it on a tiny sample where you know the answer. Save the environment details.

**Worked example:** Load a CSV, drop duplicates, group by month, chart the trend, test on ten rows first.

**Common mistake:** Pasting code you never ran on a known example.$t98c$, $t98d$Skill Lab: Python and notebooks for analysis$t98d$, $t98e$Describe a notebook analysis of a public dataset (steps, one chart, one known-answer test) and include your key results.$t98e$, $t98f$[{"criterion": "Steps reproducible", "max_points": 40, "guidance": "Clear."}, {"criterion": "Known-answer test", "max_points": 30, "guidance": "Done."}, {"criterion": "Results correct", "max_points": 30, "guidance": "Checked."}]$t98f$::jsonb, 45, 'text', false, false),
  (99, $t99a$Skill Lab: Dashboards and decision-ready reporting$t99a$, $t99b$Design dashboards people use.$t99b$, $t99c$A dashboard answers a few recurring questions: headline numbers, trends, exceptions. Show definitions of each metric, the date range and the data source. Limit to one screen, remove chart junk and set alerts on changes that matter.

**Worked example:** Top row: three headline numbers; middle: trend lines; bottom: a table of exceptions with definitions.

**Common mistake:** Twenty charts and no definitions.$t99c$, $t99d$Skill Lab: Dashboards and decision-ready reporting$t99d$, $t99e$Design a one-screen dashboard for a real question with metric definitions and refresh cadence.$t99e$, $t99f$[{"criterion": "Answers clear questions", "max_points": 40, "guidance": "Focused."}, {"criterion": "Definitions and sources", "max_points": 30, "guidance": "Present."}, {"criterion": "Readable", "max_points": 30, "guidance": "Simple."}]$t99f$::jsonb, 45, 'text', false, false),
  (100, $t100a$Skill Lab: Lab 2 project: a data analysis with queries and a dashboard$t100a$, $t100b$Deliver analysis you can defend.$t100b$, $t100c$Show Lab 2. Deliver an **analysis** of a public dataset: five queries, a join with count checks, a notebook outline, a dashboard design, and a two-page findings note.

Success looks like numbers a colleague could reproduce.

**Worked example:** City transport data: monthly trips by route, joined to route type, with a dashboard design and three findings.

**Common mistake:** No metric definitions.

Your work is scored on the rubric below. You can revise and resubmit.$t100c$, $t100d$Skill Lab: Lab 2 project: a data analysis with queries and a dashboard$t100d$, $t100e$Submit the queries, count checks, notebook outline, dashboard design and findings note.$t100e$, $t100f$[{"criterion": "Analysis correct", "max_points": 35, "guidance": "Verified."}, {"criterion": "Reproducible", "max_points": 25, "guidance": "Clear."}, {"criterion": "Dashboard design", "max_points": 20, "guidance": "Useful."}, {"criterion": "Findings honest", "max_points": 20, "guidance": "Limits."}]$t100f$::jsonb, 180, 'text', true, false),
  (101, $t101a$Skill Lab: Variation, distributions and outliers$t101a$, $t101b$Understand what averages hide.$t101b$, $t101c$Look at the spread, not only the average. Histograms show the shape; the median resists outliers; the standard deviation measures typical spread. Investigate outliers: some are errors, some are the story.

**Worked example:** Average salary 52k, median 41k: a few very high salaries pull the average up.

**Common mistake:** Reporting the mean of a skewed distribution as typical.$t101c$, $t101d$Skill Lab: Variation, distributions and outliers$t101d$, $t101e$Analyse a numeric column: shape, median, mean, spread and two outliers with your judgement on each.$t101e$, $t101f$[{"criterion": "Measures correct", "max_points": 40, "guidance": "Accurate."}, {"criterion": "Outliers judged", "max_points": 30, "guidance": "Reasoned."}, {"criterion": "Shape described", "max_points": 30, "guidance": "Clear."}]$t101f$::jsonb, 45, 'text', false, false),
  (102, $t102a$Skill Lab: Sampling, margins and uncertainty$t102a$, $t102b$Say how sure you are.$t102b$, $t102c$A sample estimates a population with a margin of error that shrinks as the sample grows and depends on how it was chosen. A biased sample is not fixed by size. Report ranges, not single numbers.

**Worked example:** A survey of 400 gives roughly a 5-point margin; a self-selected online poll may be biased whatever its size.

**Common mistake:** Reporting 53 percent as if it were exact.$t102c$, $t102d$Skill Lab: Sampling, margins and uncertainty$t102d$, $t102e$Take a survey result you find in the news, explain its sample, margin and possible bias, and rewrite the claim honestly.$t102e$, $t102f$[{"criterion": "Bias identified", "max_points": 40, "guidance": "Specific."}, {"criterion": "Uncertainty stated", "max_points": 35, "guidance": "Range."}, {"criterion": "Rewrite honest", "max_points": 25, "guidance": "Careful."}]$t102f$::jsonb, 45, 'text', false, false),
  (103, $t103a$Skill Lab: Comparing groups and testing changes$t103a$, $t103b$Tell signal from noise.$t103b$, $t103c$To compare two groups, look at the difference and an interval around it, not only a test result. Check group sizes, whether groups were comparable and whether you tested many things (which increases false alarms). For experiments, decide the test before you run it.

**Worked example:** Version B lifts sign-ups by 2 points (interval -1 to 5): promising but not proven; keep testing.

**Common mistake:** Declaring a winner after two days.$t103c$, $t103d$Skill Lab: Comparing groups and testing changes$t103d$, $t103e$Analyse a two-group comparison (public or made-up but labelled) and write a conclusion with interval and limits.$t103e$, $t103f$[{"criterion": "Difference and interval", "max_points": 40, "guidance": "Reported."}, {"criterion": "Comparability considered", "max_points": 30, "guidance": "Discussed."}, {"criterion": "Conclusion careful", "max_points": 30, "guidance": "Honest."}]$t103f$::jsonb, 45, 'text', false, false),
  (104, $t104a$Skill Lab: Causation, confounders and study design$t104a$, $t104b$Choose designs that support your claim.$t104b$, $t104c$Randomised experiments can show cause; observational data usually cannot. Look for confounders, selection effects and reverse causation. When you cannot experiment, say what the design allows and what it does not.

**Worked example:** People who take vitamins are healthier, but they also exercise more: a confounder.

**Common mistake:** Claiming a cause from a correlation.$t104c$, $t104d$Skill Lab: Causation, confounders and study design$t104d$, $t104e$Take three claims and for each name the design needed, the likely confounder and the strongest honest wording.$t104e$, $t104f$[{"criterion": "Designs suited", "max_points": 35, "guidance": "Right."}, {"criterion": "Confounders named", "max_points": 35, "guidance": "Real."}, {"criterion": "Wording honest", "max_points": 30, "guidance": "Scoped."}]$t104f$::jsonb, 45, 'text', false, false),
  (105, $t105a$Skill Lab: Lab 3 project: an inference report$t105a$, $t105b$Deliver honest quantitative conclusions.$t105b$, $t105c$Show Lab 3. Deliver a **two-page inference report** on a real dataset or study with spread, uncertainty, group comparison, confounder discussion and a plain-language conclusion.

Success looks like conclusions that match the evidence and no more.

**Worked example:** A report on whether a training course improved test scores, with intervals and a confounder discussion.

**Common mistake:** Confident language beyond the data.

Your work is scored on the rubric below. You can revise and resubmit.$t105c$, $t105d$Skill Lab: Lab 3 project: an inference report$t105d$, $t105e$Submit the report and your data source.$t105e$, $t105f$[{"criterion": "Method and accuracy", "max_points": 35, "guidance": "Correct."}, {"criterion": "Uncertainty and limits", "max_points": 30, "guidance": "Honest."}, {"criterion": "Plain communication", "max_points": 20, "guidance": "Clear."}, {"criterion": "Sources", "max_points": 15, "guidance": "Cited."}]$t105f$::jsonb, 150, 'text', true, false),
  (106, $t106a$Skill Lab: Interviews and coding$t106a$, $t106b$Learn from what people say.$t106b$, $t106c$Plan open questions, record with consent, transcribe, then code segments with short labels and group them into themes. Keep quotes as evidence. Use AI to propose codes but check each against the text and look for evidence that disagrees.

**Worked example:** Ten interviews coded into three themes with two quotes each and one dissenting view.

**Common mistake:** Cherry-picking quotes that fit your idea.$t106c$, $t106d$Skill Lab: Interviews and coding$t106d$, $t106e$Code five interview or comment excerpts, build themes and include a dissenting example.$t106e$, $t106f$[{"criterion": "Codes grounded", "max_points": 40, "guidance": "Quotes."}, {"criterion": "Themes sound", "max_points": 30, "guidance": "Coherent."}, {"criterion": "Dissent included", "max_points": 30, "guidance": "Honest."}]$t106f$::jsonb, 45, 'text', false, false),
  (107, $t107a$Skill Lab: Surveys done well$t107a$, $t107b$Design surveys that measure what you mean.$t107b$, $t107c$Define what you want to know, ask one thing per question, use neutral wording, pilot with five people and keep it short. Plan who might not respond and how you will report that.

**Worked example:** A ten-question survey piloted with five; two questions rewritten for clarity.

**Common mistake:** Leading questions like 'How much do you love...?'$t107c$, $t107d$Skill Lab: Surveys done well$t107d$, $t107e$Write and pilot a survey and submit the changes you made after the pilot.$t107e$, $t107f$[{"criterion": "Neutral questions", "max_points": 40, "guidance": "Clear."}, {"criterion": "Pilot changes", "max_points": 35, "guidance": "Real."}, {"criterion": "Non-response considered", "max_points": 25, "guidance": "Noted."}]$t107f$::jsonb, 45, 'text', false, false),
  (108, $t108a$Skill Lab: Mixed methods: combining numbers and stories$t108a$, $t108b$Use each to explain the other.$t108b$, $t108c$Numbers show what and how much; interviews show why. Use one to find patterns and the other to explain them, and check that they do not contradict. Report both with their limits.

**Worked example:** Usage data shows drop-off at step three; interviews reveal the form asks for information users do not have yet.

**Common mistake:** Treating the two as separate reports.$t108c$, $t108d$Skill Lab: Mixed methods: combining numbers and stories$t108d$, $t108e$Combine a small dataset and three interviews (or comments) into a one-page explanation with limits.$t108e$, $t108f$[{"criterion": "Methods complement", "max_points": 40, "guidance": "Connected."}, {"criterion": "Evidence for each claim", "max_points": 30, "guidance": "Shown."}, {"criterion": "Limits stated", "max_points": 30, "guidance": "Honest."}]$t108f$::jsonb, 45, 'text', false, false),
  (109, $t109a$Skill Lab: Research ethics and privacy$t109a$, $t109b$Protect participants.$t109b$, $t109c$Get informed consent, collect the minimum, anonymise, store securely, delete on schedule and get ethics review where required. Sensitive topics need extra care and support information.

**Worked example:** A consent script, anonymised IDs, encrypted storage and a deletion date.

**Common mistake:** Keeping names beside quotes in the analysis file.$t109c$, $t109d$Skill Lab: Research ethics and privacy$t109d$, $t109e$Write an ethics plan for a study with people: consent text, data protection, withdrawal and deletion.$t109e$, $t109f$[{"criterion": "Consent clear", "max_points": 30, "guidance": "Plain."}, {"criterion": "Data protection", "max_points": 40, "guidance": "Concrete."}, {"criterion": "Withdrawal and deletion", "max_points": 30, "guidance": "Included."}]$t109f$::jsonb, 45, 'text', false, false),
  (110, $t110a$Skill Lab: Lab 4 project: a mixed-methods study$t110a$, $t110b$Deliver a small, ethical study.$t110b$, $t110c$Show Lab 4. Deliver a **mixed-methods study**: a short survey (at least ten responses), five coded interviews or comments, an ethics plan and a two-page report.

Success looks like conclusions that use both kinds of evidence honestly.

**Worked example:** Why do members leave a community? Survey plus five interviews, with three themes and limits.

**Common mistake:** No ethics plan.

Your work is scored on the rubric below. You can revise and resubmit.$t110c$, $t110d$Skill Lab: Lab 4 project: a mixed-methods study$t110d$, $t110e$Submit the survey and results, coded excerpts, ethics plan and report.$t110e$, $t110f$[{"criterion": "Method and rigour", "max_points": 30, "guidance": "Sound."}, {"criterion": "Integration of evidence", "max_points": 25, "guidance": "Connected."}, {"criterion": "Ethics", "max_points": 25, "guidance": "Handled."}, {"criterion": "Honest limits", "max_points": 20, "guidance": "Stated."}]$t110f$::jsonb, 210, 'text', true, false),
  (111, $t111a$Skill Lab: Data storytelling$t111a$, $t111b$Turn analysis into a story.$t111b$, $t111c$A story has context, a question, a finding, a meaning and an action. Start with the answer for busy readers, use one chart per point, annotate the takeaway and cite the source. Cut everything that does not support the message.

**Worked example:** Slide: 'Late payments cost us 14 percent of revenue' with one chart and the recommended fix.

**Common mistake:** Presenting every analysis step in order.$t111c$, $t111d$Skill Lab: Data storytelling$t111d$, $t111e$Rewrite an analysis as a five-part story with one annotated chart. Submit it.$t111e$, $t111f$[{"criterion": "Answer first", "max_points": 35, "guidance": "Clear."}, {"criterion": "Chart honest and annotated", "max_points": 35, "guidance": "Clear."}, {"criterion": "Action stated", "max_points": 30, "guidance": "Specific."}]$t111f$::jsonb, 45, 'text', false, false),
  (112, $t112a$Skill Lab: Briefings for decision-makers$t112a$, $t112b$Write short, useful briefs.$t112b$, $t112c$Lead with the recommendation, then evidence, options with trade-offs, risks and next steps. One page, plain words, and a confidence statement. Separate facts, judgement and assumptions.

**Worked example:** A one-page brief with three options, cost, risk and a recommended first step.

**Common mistake:** Burying the recommendation.$t112c$, $t112d$Skill Lab: Briefings for decision-makers$t112d$, $t112e$Write a one-page briefing for a real or realistic decision with three options and confidence.$t112e$, $t112f$[{"criterion": "Recommendation first", "max_points": 35, "guidance": "Clear."}, {"criterion": "Options fair", "max_points": 35, "guidance": "Balanced."}, {"criterion": "Confidence stated", "max_points": 30, "guidance": "Honest."}]$t112f$::jsonb, 45, 'text', false, false),
  (113, $t113a$Skill Lab: Presenting and defending your findings$t113a$, $t113b$Handle questions well.$t113b$, $t113c$Prepare the three hardest questions, know your data's limits, admit what you do not know and follow up in writing. Show your method briefly and invite challenge.

**Worked example:** Q: 'Could this be seasonal?' A: 'Possibly; here is the same period last year, which shows a smaller change.'

**Common mistake:** Defending weak evidence instead of acknowledging limits.$t113c$, $t113d$Skill Lab: Presenting and defending your findings$t113d$, $t113e$Write a five-minute presentation script and the three hardest questions with answers.$t113e$, $t113f$[{"criterion": "Script clear", "max_points": 30, "guidance": "Structured."}, {"criterion": "Hard questions real", "max_points": 40, "guidance": "Tough."}, {"criterion": "Honest limits", "max_points": 30, "guidance": "Stated."}]$t113f$::jsonb, 45, 'text', false, false),
  (114, $t114a$Skill Lab: Monitoring, alerts and research routines$t114a$, $t114b$Keep learning on autopilot, safely.$t114b$, $t114c$Set alerts for new papers, news and data updates, review weekly, and keep a note system with source, date and confidence. Use scheduled AI digests only as leads, and verify anything you act on.

**Worked example:** A weekly digest of new studies on your topic, filed into a notes table with a confidence field.

**Common mistake:** Acting on a digest without opening the sources.$t114c$, $t114d$Skill Lab: Monitoring, alerts and research routines$t114d$, $t114e$Design your research routine: alerts, weekly review, notes template and verification rule.$t114e$, $t114f$[{"criterion": "Routine practical", "max_points": 40, "guidance": "Usable."}, {"criterion": "Verification rule", "max_points": 35, "guidance": "Present."}, {"criterion": "Notes template good", "max_points": 25, "guidance": "Sourced."}]$t114f$::jsonb, 45, 'text', false, false),
  (115, $t115a$Skill Lab: Lab 5 project: a decision brief with data story$t115a$, $t115b$Deliver a decision-ready package.$t115b$, $t115c$Show Lab 5. Deliver a **decision package**: one-page brief, five-slide data story, defence Q and A and your research routine.

Success looks like something a manager could act on.

**Worked example:** A package recommending which onboarding change to test first, with evidence and risks.

**Common mistake:** No stated confidence.

Your work is scored on the rubric below. You can revise and resubmit.$t115c$, $t115d$Skill Lab: Lab 5 project: a decision brief with data story$t115d$, $t115e$Submit the brief, story outline, Q and A and routine.$t115e$, $t115f$[{"criterion": "Decision clarity", "max_points": 30, "guidance": "Actionable."}, {"criterion": "Evidence quality", "max_points": 30, "guidance": "Verified."}, {"criterion": "Communication", "max_points": 20, "guidance": "Clear."}, {"criterion": "Honest limits", "max_points": 20, "guidance": "Stated."}]$t115f$::jsonb, 150, 'text', true, false),
  (116, $t116a$Skill Lab: Research and analysis as a service$t116a$, $t116b$Package your skills.$t116b$, $t116c$Offer clear services: literature briefs, dashboard builds, survey studies, market scans. Scope by question and deliverable, agree data access and confidentiality, and price by value and effort.

**Worked example:** Package: market scan (5 competitors, 12 sources, 6 pages) for 450 in five days.

**Common mistake:** Selling 'research' with no defined deliverable.$t116c$, $t116d$Skill Lab: Research and analysis as a service$t116d$, $t116e$Write three service packages with scope, price and confidentiality terms.$t116e$, $t116f$[{"criterion": "Scope clear", "max_points": 40, "guidance": "Defined."}, {"criterion": "Confidentiality terms", "max_points": 30, "guidance": "Present."}, {"criterion": "Pricing logic", "max_points": 30, "guidance": "Reasoned."}]$t116f$::jsonb, 45, 'text', false, false),
  (117, $t117a$Skill Lab: Portfolio of analyses$t117a$, $t117b$Show what you can do.$t117b$, $t117c$Show two or three analyses with the question, method, result and decision it influenced. Use public or permitted data, protect privacy and label what AI helped with. Make one reproducible example.

**Worked example:** A case study with a chart, the method in five lines and the file list for reproducing it.

**Common mistake:** Publishing private data.$t117c$, $t117d$Skill Lab: Portfolio of analyses$t117d$, $t117e$Draft two portfolio case studies with reproducibility notes.$t117e$, $t117f$[{"criterion": "Question to result shown", "max_points": 40, "guidance": "Clear."}, {"criterion": "Privacy handled", "max_points": 30, "guidance": "Safe."}, {"criterion": "Reproducible", "max_points": 30, "guidance": "Notes."}]$t117f$::jsonb, 45, 'text', false, false),
  (118, $t118a$Skill Lab: Working with clients on data$t118a$, $t118b$Handle access and expectations.$t118b$, $t118c$Agree data access, confidentiality, definitions and timelines. Confirm what decision the work supports, deliver drafts early and document assumptions. Store client data securely and delete on request.

**Worked example:** A one-page data-handling agreement and a definitions sheet before analysis begins.

**Common mistake:** Starting analysis before agreeing definitions.$t118c$, $t118d$Skill Lab: Working with clients on data$t118d$, $t118e$Write a data-handling agreement and kickoff checklist.$t118e$, $t118f$[{"criterion": "Agreement specific", "max_points": 40, "guidance": "Clear."}, {"criterion": "Checklist practical", "max_points": 30, "guidance": "Usable."}, {"criterion": "Security and deletion", "max_points": 30, "guidance": "Included."}]$t118f$::jsonb, 45, 'text', false, false),
  (119, $t119a$Skill Lab: Integrity and standards$t119a$, $t119b$State how you work.$t119b$, $t119c$Publish how you verify sources, disclose AI use, handle errors and conflicts of interest. Correct mistakes publicly and keep a change log.

**Worked example:** A standards page with a correction policy and a log of two corrections.

**Common mistake:** Quietly editing mistakes.$t119c$, $t119d$Skill Lab: Integrity and standards$t119d$, $t119e$Write your research standards (200 words) and a correction policy.$t119e$, $t119f$[{"criterion": "Specific", "max_points": 40, "guidance": "Concrete."}, {"criterion": "Correction policy", "max_points": 30, "guidance": "Clear."}, {"criterion": "AI disclosure", "max_points": 30, "guidance": "Honest."}]$t119f$::jsonb, 45, 'text', false, false),
  (120, $t120a$Skill Lab: Lab 6 project: your research showcase$t120a$, $t120b$Present your best work and services.$t120b$, $t120c$Show Lab 6. Publish a **showcase**: two case studies, your services and prices, your standards and a sample brief. Share it in the NEXTGEN Discord and ask for one piece of feedback.

Success looks like something you would send to a real client.

**Worked example:** A page with two case studies, three packages, standards and a contact button.

**Common mistake:** Case studies with no method.

Your work is scored on the rubric below. You can revise and resubmit.$t120c$, $t120d$Skill Lab: Lab 6 project: your research showcase$t120d$, $t120e$Submit the showcase text or links and a 150-word reflection.$t120e$, $t120f$[{"criterion": "Quality of work", "max_points": 30, "guidance": "Rigorous."}, {"criterion": "Business readiness", "max_points": 25, "guidance": "Clear."}, {"criterion": "Integrity", "max_points": 25, "guidance": "Honest."}, {"criterion": "Reflection", "max_points": 20, "guidance": "Specific."}]$t120f$::jsonb, 150, 'text', true, false)
) as v(n, title, objective, lesson_md, skill_focus, assignment_md, rubric, est_minutes, submission_type, ai_evaluate, requires_review)
where t.slug = 'research'
on conflict (track_id, day_number) do nothing;
