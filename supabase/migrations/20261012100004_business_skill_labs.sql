-- Earning with AI skills Skill Labs (days 91-120). Published; appended after the core path.
insert into public.day
  (track_id, tier_id, day_number, title, objective, lesson_md, skill_focus, assignment_md, rubric,
   est_minutes, is_published, credit_budget, submission_type, ai_evaluate, requires_review)
select t.id, ti.id, v.n, v.title, v.objective, v.lesson_md, v.skill_focus, v.assignment_md, v.rubric,
       v.est_minutes, true, null, v.submission_type, v.ai_evaluate, v.requires_review
from public.track t
join public.tier ti on ti.track_id = t.id and ti.slug = 'grandmaster'
cross join (values
  (91, $t91a$Skill Lab: Commodity work versus solutions work$t91a$, $t91b$Choose where you compete.$t91b$, $t91c$Reports on the freelance market suggest generic AI output such as basic content and image generation is crowded and low-paid, while solution work such as automations, custom agents, data analysis and tailored systems is less crowded and better paid. Clients buy results, not hours or prompts. Pick a specific problem for a specific type of client, and be honest that income varies and is never guaranteed.

**Worked example:** Instead of 'AI blog posts for anyone', offer 'a weekly lead-follow-up automation for physiotherapy clinics'.

**Common mistake:** Copying a claim like 'earn thousands a month' into your sales page.$t91c$, $t91d$Skill Lab: Commodity work versus solutions work$t91d$, $t91e$Compare five possible offers on competition, price potential, skill fit and risk. Choose one with reasons.$t91e$, $t91f$[{"criterion": "Comparison reasoned", "max_points": 40, "guidance": "Criteria."}, {"criterion": "Choice fits skills", "max_points": 30, "guidance": "Realistic."}, {"criterion": "No income promises", "max_points": 30, "guidance": "Honest."}]$t91f$::jsonb, 45, 'text', false, false),
  (92, $t92a$Skill Lab: Demand research before you build$t92a$, $t92b$Test whether anyone will pay.$t92b$, $t92c$Talk to ten people in your target group about the problem, what they do today, what it costs them and whether they have paid to solve it. Look for urgent pain, budget and a decision maker. Compliments are not demand; a small paid pilot is.

**Worked example:** Ten conversations: four describe a costly, recurring problem; two agree to a paid pilot.

**Common mistake:** Asking friends whether they like the idea.$t92c$, $t92d$Skill Lab: Demand research before you build$t92d$, $t92e$Run five conversations (or a plan and script if you cannot yet) and record the pains, current spend and willingness to pay.$t92e$, $t92f$[{"criterion": "Real evidence", "max_points": 40, "guidance": "Conversations."}, {"criterion": "Money signals", "max_points": 35, "guidance": "Spend and budget."}, {"criterion": "Honest verdict", "max_points": 25, "guidance": "Includes doubts."}]$t92f$::jsonb, 45, 'text', false, false),
  (93, $t93a$Skill Lab: Productised services$t93a$, $t93b$Package work so it is clear and repeatable.$t93b$, $t93c$A productised service has a fixed scope, price and timeline: 'Automation audit in 3 days for 300', 'Lead-follow-up workflow setup for 900 with a 100 monthly care plan'. Fixed packages reduce negotiation and scope creep and help clients say yes. Reported market ranges for setup and monthly care vary widely; set yours from your costs and value.

**Worked example:** Three tiers: audit, build, care plan, each with deliverables, exclusions and timeline.

**Common mistake:** Selling hours with an open scope.$t93c$, $t93d$Skill Lab: Productised services$t93d$, $t93e$Design three productised packages with deliverables, exclusions, price and timeline.$t93e$, $t93f$[{"criterion": "Fixed scope", "max_points": 35, "guidance": "Clear."}, {"criterion": "Price logic", "max_points": 35, "guidance": "Costs and value."}, {"criterion": "Exclusions listed", "max_points": 30, "guidance": "Explicit."}]$t93f$::jsonb, 45, 'text', false, false),
  (94, $t94a$Skill Lab: Value-based pricing and proving return$t94a$, $t94b$Price by result.$t94b$, $t94c$Estimate what the outcome is worth (hours saved, revenue gained, errors avoided) using the client's own numbers, price a fair fraction and prove it with a baseline and a follow-up measure. Be honest about uncertainty and do not invent figures.

**Worked example:** A clinic loses 6 hours a week on follow-ups; the workflow saves about 4 hours; priced at a share of the yearly value.

**Common mistake:** Guessing the client's numbers.$t94c$, $t94d$Skill Lab: Value-based pricing and proving return$t94d$, $t94e$Build a value case for one offer using the client's numbers (or clearly labelled assumptions) with baseline, projected saving and price.$t94e$, $t94f$[{"criterion": "Numbers sourced", "max_points": 40, "guidance": "Client or labelled."}, {"criterion": "Fair pricing", "max_points": 30, "guidance": "Reasoned."}, {"criterion": "Proof plan", "max_points": 30, "guidance": "Measure."}]$t94f$::jsonb, 45, 'text', false, false),
  (95, $t95a$Skill Lab: Lab 1 project: a validated offer$t95a$, $t95b$Deliver an offer with evidence.$t95b$, $t95c$Show Lab 1. Deliver a **validated offer**: niche choice, five conversations, three packages, a value case and a one-page offer with no income promises.

Success looks like an offer a stranger could buy.

**Worked example:** Offer for physiotherapy clinics: audit 250, build 900, care plan 120 a month, with evidence from six conversations.

**Common mistake:** An offer with no evidence of demand.

Your work is scored on the rubric below. You can revise and resubmit.$t95c$, $t95d$Skill Lab: Lab 1 project: a validated offer$t95d$, $t95e$Submit the comparison, conversation notes, packages, value case and offer page.$t95e$, $t95f$[{"criterion": "Evidence of demand", "max_points": 30, "guidance": "Real."}, {"criterion": "Packages and pricing", "max_points": 30, "guidance": "Clear."}, {"criterion": "Value case honest", "max_points": 25, "guidance": "Sourced."}, {"criterion": "Offer clarity", "max_points": 15, "guidance": "Understandable."}]$t95f$::jsonb, 150, 'text', true, false),
  (96, $t96a$Skill Lab: Outreach that respects people$t96a$, $t96b$Contact prospects honestly.$t96b$, $t96c$Personal, specific and useful beats mass. Research one detail, offer one helpful observation, ask a single question and make opting out easy. Follow the rules for cold contact in your country and platform, and stop when someone says no.

**Worked example:** 'I noticed your booking page has no reminders; here is a two-line fix. Would a 10-minute look be useful?'

**Common mistake:** Sending hundreds of identical automated messages.$t96c$, $t96d$Skill Lab: Outreach that respects people$t96d$, $t96e$Write outreach for five specific prospects with one personalised observation each and an opt-out line.$t96e$, $t96f$[{"criterion": "Personalised and useful", "max_points": 45, "guidance": "Specific."}, {"criterion": "Respectful and lawful", "max_points": 30, "guidance": "Opt-out."}, {"criterion": "One clear ask", "max_points": 25, "guidance": "Simple."}]$t96f$::jsonb, 45, 'text', false, false),
  (97, $t97a$Skill Lab: Discovery calls and qualification$t97a$, $t97b$Find real needs and fit.$t97b$, $t97c$Ask about goals, past attempts, cost of the problem, budget, timeline and decision makers. Qualify: is there pain, budget and authority? Say no to poor fits. Summarise back in writing.

**Worked example:** After the call: 'You lose about six hours a week chasing enquiries, want a fix by March and can spend up to 1,000. Is that right?'

**Common mistake:** Pitching before diagnosing.$t97c$, $t97d$Skill Lab: Discovery calls and qualification$t97d$, $t97e$Write a discovery script (ten questions), run one call or role-play and submit notes and a summary email.$t97e$, $t97f$[{"criterion": "Questions probing", "max_points": 35, "guidance": "Good."}, {"criterion": "Qualification clear", "max_points": 35, "guidance": "Criteria."}, {"criterion": "Summary sent", "max_points": 30, "guidance": "Confirmed."}]$t97f$::jsonb, 45, 'text', false, false),
  (98, $t98a$Skill Lab: Proposals and pricing pages$t98a$, $t98b$Ask for the decision clearly.$t98b$, $t98c$A proposal repeats their problem in their words, states the outcome, scope, exclusions, timeline, price and one next step, with a validity date. Offer two or three options and make the middle one the natural choice. Keep to two pages.

**Worked example:** Options: audit only, audit plus build, build plus care plan; valid for 14 days.

**Common mistake:** A generic proposal with your life story.$t98c$, $t98d$Skill Lab: Proposals and pricing pages$t98d$, $t98e$Write a two-page proposal from your discovery summary with three options.$t98e$, $t98f$[{"criterion": "Their problem in their words", "max_points": 30, "guidance": "Mirrors."}, {"criterion": "Scope and price clear", "max_points": 40, "guidance": "Precise."}, {"criterion": "Next step clear", "max_points": 30, "guidance": "One."}]$t98f$::jsonb, 45, 'text', false, false),
  (99, $t99a$Skill Lab: Referrals, partners and community$t99a$, $t99b$Grow through relationships.$t99b$, $t99c$Ask delighted clients for one introduction, partner with complementary providers, share useful work in communities and follow up. Agree referral terms in writing and disclose commissions.

**Worked example:** A web designer refers clients needing automation; you refer clients needing a site; terms written.

**Common mistake:** Undisclosed commissions.$t99c$, $t99d$Skill Lab: Referrals, partners and community$t99d$, $t99e$Design a referral system with three partner types, terms and a simple tracker.$t99e$, $t99f$[{"criterion": "Partners fit", "max_points": 35, "guidance": "Complementary."}, {"criterion": "Terms written", "max_points": 35, "guidance": "Clear."}, {"criterion": "Tracking", "max_points": 30, "guidance": "Present."}]$t99f$::jsonb, 45, 'text', false, false),
  (100, $t100a$Skill Lab: Lab 2 project: a client acquisition system$t100a$, $t100b$Deliver a system with real activity.$t100b$, $t100c$Show Lab 2. Deliver a **client acquisition pack**: outreach for ten prospects, discovery script and notes, a proposal, a referral plan and a tracker with real numbers from at least two weeks of activity.

Success looks like honest numbers and clear learning.

**Worked example:** Ten outreach messages, four replies, two calls, one proposal, one paid pilot.

**Common mistake:** Inflating results.

Your work is scored on the rubric below. You can revise and resubmit.$t100c$, $t100d$Skill Lab: Lab 2 project: a client acquisition system$t100d$, $t100e$Submit all documents and the tracker.$t100e$, $t100f$[{"criterion": "Real activity", "max_points": 30, "guidance": "Numbers."}, {"criterion": "Quality of materials", "max_points": 30, "guidance": "Strong."}, {"criterion": "Learning applied", "max_points": 20, "guidance": "Insight."}, {"criterion": "Honesty", "max_points": 20, "guidance": "Accurate."}]$t100f$::jsonb, 180, 'text', true, false),
  (101, $t101a$Skill Lab: Scoping and project management$t101a$, $t101b$Deliver without chaos.$t101b$, $t101c$Write deliverables, exclusions, assumptions, acceptance criteria and a change request process. Plan milestones with buffers and confirm approvals in writing. Track time against your quote.

**Worked example:** Change request: 'Adding SMS reminders is outside scope: 3 hours, 180. Approve?'

**Common mistake:** Saying yes to small extras until the project is unprofitable.$t101c$, $t101d$Skill Lab: Scoping and project management$t101d$, $t101e$Write a project scope, milestone plan and change request template.$t101e$, $t101f$[{"criterion": "Scope precise", "max_points": 35, "guidance": "Clear."}, {"criterion": "Milestones and buffers", "max_points": 35, "guidance": "Realistic."}, {"criterion": "Change process", "max_points": 30, "guidance": "Defined."}]$t101f$::jsonb, 45, 'text', false, false),
  (102, $t102a$Skill Lab: Building with AI agents safely for clients$t102a$, $t102b$Use AI tools without risking client data.$t102b$, $t102c$Check what data each tool stores and where, use client data only under agreement, keep least-privilege access and approvals, and record what is automated. Tell clients how you use AI. Never put confidential data into tools you have not vetted.

**Worked example:** A data map lists each tool, the data it sees, its retention and the client's consent.

**Common mistake:** Pasting client documents into any free tool.$t102c$, $t102d$Skill Lab: Building with AI agents safely for clients$t102d$, $t102e$Create a client data map for a project with tools, data, retention and consent.$t102e$, $t102f$[{"criterion": "Map complete", "max_points": 40, "guidance": "Every tool."}, {"criterion": "Consent and retention", "max_points": 35, "guidance": "Handled."}, {"criterion": "Least privilege", "max_points": 25, "guidance": "Applied."}]$t102f$::jsonb, 45, 'text', false, false),
  (103, $t103a$Skill Lab: Quality assurance and handover$t103a$, $t103b$Finish well.$t103b$, $t103c$Test against acceptance criteria, document how to use and maintain the work, train the client, and hand over access. Ask for feedback and a testimonial with permission.

**Worked example:** A handover pack: guide, credentials transfer, support terms and a 30-day check-in.

**Common mistake:** Delivering without documentation.$t103c$, $t103d$Skill Lab: Quality assurance and handover$t103d$, $t103e$Write a QA checklist and handover pack outline for one project.$t103e$, $t103f$[{"criterion": "QA real", "max_points": 35, "guidance": "Specific."}, {"criterion": "Handover complete", "max_points": 40, "guidance": "Usable."}, {"criterion": "Follow-up planned", "max_points": 25, "guidance": "Check-in."}]$t103f$::jsonb, 45, 'text', false, false),
  (104, $t104a$Skill Lab: Care plans, retainers and support$t104a$, $t104b$Create steady, fair income.$t104b$, $t104c$Offer a monthly plan for monitoring, updates and a small number of changes, with response times and an exit path. Price against hours and risk, report monthly and review value quarterly.

**Worked example:** Care plan 120 a month: monitoring, backups, two small changes, response within one working day.

**Common mistake:** Unlimited support at a flat price.$t104c$, $t104d$Skill Lab: Care plans, retainers and support$t104d$, $t104e$Design a care plan with inclusions, price, response times, exit terms and a monthly report template.$t104e$, $t104f$[{"criterion": "Inclusions clear", "max_points": 35, "guidance": "Defined."}, {"criterion": "Pricing logic", "max_points": 30, "guidance": "Reasoned."}, {"criterion": "Report and exit", "max_points": 35, "guidance": "Present."}]$t104f$::jsonb, 45, 'text', false, false),
  (105, $t105a$Skill Lab: Lab 3 project: a delivery system$t105a$, $t105b$Deliver templates that make projects repeatable.$t105b$, $t105c$Show Lab 3. Deliver a **delivery system**: scope template, change request form, data map, QA checklist, handover pack and care plan, with one filled example.

Success looks like a project you could run twice as fast next time.

**Worked example:** A complete kit filled in for a fictional clinic project.

**Common mistake:** Templates with no example.

Your work is scored on the rubric below. You can revise and resubmit.$t105c$, $t105d$Skill Lab: Lab 3 project: a delivery system$t105d$, $t105e$Submit the templates and the worked example.$t105e$, $t105f$[{"criterion": "Completeness", "max_points": 30, "guidance": "All parts."}, {"criterion": "Practical", "max_points": 30, "guidance": "Usable."}, {"criterion": "Client protection", "max_points": 25, "guidance": "Fair."}, {"criterion": "Clarity", "max_points": 15, "guidance": "Readable."}]$t105f$::jsonb, 150, 'text', true, false),
  (106, $t106a$Skill Lab: Money systems and tax basics$t106a$, $t106b$Run a tidy small business.$t106b$, $t106c$Separate business money, invoice promptly, record every income and cost, set aside a share for tax, and know your local registration and reporting rules. Use an accountant. This is not tax advice.

**Worked example:** Monthly routine: reconcile, set aside 25 percent, review overdue invoices.

**Common mistake:** Mixing personal and business money.$t106c$, $t106d$Skill Lab: Money systems and tax basics$t106d$, $t106e$Design your money system: accounts, invoice process, records, tax set-aside and monthly routine.$t106e$, $t106f$[{"criterion": "System practical", "max_points": 40, "guidance": "Usable."}, {"criterion": "Records", "max_points": 30, "guidance": "Kept."}, {"criterion": "Advice noted", "max_points": 30, "guidance": "Limits."}]$t106f$::jsonb, 45, 'text', false, false),
  (107, $t107a$Skill Lab: Contracts, IP and liability$t107a$, $t107b$Protect both sides.$t107b$, $t107c$Agree scope, payment, ownership, confidentiality, liability limits, termination and how AI tools are used. Understand who owns generated work under your tools' terms and your country's law. Get a lawyer to review a template. This is not legal advice.

**Worked example:** A contract clause stating that the client owns final deliverables on payment and you keep your tools and methods.

**Common mistake:** Working without a signed agreement.$t107c$, $t107d$Skill Lab: Contracts, IP and liability$t107d$, $t107e$Draft a one-page agreement and list five questions for a lawyer.$t107e$, $t107f$[{"criterion": "Key terms covered", "max_points": 40, "guidance": "Complete."}, {"criterion": "AI and IP addressed", "max_points": 30, "guidance": "Stated."}, {"criterion": "Questions good", "max_points": 30, "guidance": "Specific."}]$t107f$::jsonb, 45, 'text', false, false),
  (108, $t108a$Skill Lab: Marketing and authority without hype$t108a$, $t108b$Attract clients with proof.$t108b$, $t108c$Publish case studies, teaching posts and honest results. Use measured outcomes, permission for quotes and clear labelling of AI-assisted work. Avoid inflated claims, fake reviews and guarantees.

**Worked example:** A case study: baseline 6 hours a week, after 2 hours, with the client's approved quote.

**Common mistake:** Claiming results you cannot prove.$t108c$, $t108d$Skill Lab: Marketing and authority without hype$t108d$, $t108e$Plan a 90-day authority programme with three case-study or teaching pieces and how you will get permission and evidence.$t108e$, $t108f$[{"criterion": "Evidence plan", "max_points": 40, "guidance": "Real."}, {"criterion": "Honest claims", "max_points": 35, "guidance": "Provable."}, {"criterion": "Realistic", "max_points": 25, "guidance": "Feasible."}]$t108f$::jsonb, 45, 'text', false, false),
  (109, $t109a$Skill Lab: Metrics and business health$t109a$, $t109b$Track what matters.$t109b$, $t109c$Track leads, conversion, average project value, delivery hours, margin, retention and cash. Review monthly and decide one change. Keep a simple runway calculation.

**Worked example:** Dashboard: 20 leads, 6 calls, 2 wins, average 900, margin 60 percent, runway 4 months.

**Common mistake:** Tracking revenue only.$t109c$, $t109d$Skill Lab: Metrics and business health$t109d$, $t109e$Build a monthly dashboard with example data and one decision.$t109e$, $t109f$[{"criterion": "Metrics right", "max_points": 40, "guidance": "Relevant."}, {"criterion": "Data plausible", "max_points": 30, "guidance": "Realistic."}, {"criterion": "Decision made", "max_points": 30, "guidance": "Actionable."}]$t109f$::jsonb, 45, 'text', false, false),
  (110, $t110a$Skill Lab: Lab 4 project: business operating pack$t110a$, $t110b$Deliver the paperwork and systems.$t110b$, $t110c$Show Lab 4. Deliver an **operating pack**: money system, agreement draft, authority plan, dashboard and a risk register.

Success looks like a business that could pass a friendly review.

**Worked example:** A one-person automation studio pack with monthly routines and risk plan.

**Common mistake:** No risk register.

Your work is scored on the rubric below. You can revise and resubmit.$t110c$, $t110d$Skill Lab: Lab 4 project: business operating pack$t110d$, $t110e$Submit the pack.$t110e$, $t110f$[{"criterion": "Completeness", "max_points": 30, "guidance": "All parts."}, {"criterion": "Practicality", "max_points": 30, "guidance": "Usable."}, {"criterion": "Risk and legal awareness", "max_points": 25, "guidance": "Realistic."}, {"criterion": "Honesty", "max_points": 15, "guidance": "Limits."}]$t110f$::jsonb, 150, 'text', true, false),
  (111, $t111a$Skill Lab: Using AI agents to run your own business$t111a$, $t111b$Automate the admin, not the relationship.$t111b$, $t111c$Agents can draft proposals, prepare outreach research, chase invoices and prepare reports. Keep approval on everything sent to clients, protect confidential data and log what was automated. Protect your reputation by keeping the human parts human.

**Worked example:** An invoice-chase agent drafts reminders for approval and logs each send.

**Common mistake:** Letting an agent email clients unsupervised.$t111c$, $t111d$Skill Lab: Using AI agents to run your own business$t111d$, $t111e$Design three internal automations with approval points, data handling and logs.$t111e$, $t111f$[{"criterion": "Approvals placed", "max_points": 40, "guidance": "Right steps."}, {"criterion": "Data handled", "max_points": 30, "guidance": "Careful."}, {"criterion": "Logs", "max_points": 30, "guidance": "Present."}]$t111f$::jsonb, 45, 'text', false, false),
  (112, $t112a$Skill Lab: Hiring and subcontracting$t112a$, $t112b$Add capacity carefully.$t112b$, $t112c$Write clear role briefs, run a paid trial task, agree rights and confidentiality in writing, set quality checks and remember you remain responsible to the client. Pay fairly and on time.

**Worked example:** A paid two-hour trial, a written brief, a quality checklist and a confidentiality agreement.

**Common mistake:** Delegating without a brief or agreement.$t112c$, $t112d$Skill Lab: Hiring and subcontracting$t112d$, $t112e$Write a role brief, trial task, agreement outline and quality checklist.$t112e$, $t112f$[{"criterion": "Brief clear", "max_points": 30, "guidance": "Precise."}, {"criterion": "Trial and pay fair", "max_points": 35, "guidance": "Reasonable."}, {"criterion": "Quality and confidentiality", "max_points": 35, "guidance": "Covered."}]$t112f$::jsonb, 45, 'text', false, false),
  (113, $t113a$Skill Lab: Building a small team or partnership$t113a$, $t113b$Grow beyond one person.$t113b$, $t113c$Decide what you will and will not delegate, define roles, use written partner agreements for splits and decisions, and keep processes documented so others can run them.

**Worked example:** A partnership agreement with roles, revenue split, decision rules and an exit clause.

**Common mistake:** Starting a partnership on a handshake.$t113c$, $t113d$Skill Lab: Building a small team or partnership$t113d$, $t113e$Draft roles and a partnership outline (splits, decisions, exit) for a possible collaboration.$t113e$, $t113f$[{"criterion": "Roles clear", "max_points": 35, "guidance": "Defined."}, {"criterion": "Terms fair", "max_points": 35, "guidance": "Balanced."}, {"criterion": "Exit included", "max_points": 30, "guidance": "Present."}]$t113f$::jsonb, 45, 'text', false, false),
  (114, $t114a$Skill Lab: Reputation, reviews and difficult moments$t114a$, $t114b$Handle problems well.$t114b$, $t114c$Respond quickly and honestly to mistakes and complaints, fix what you can, learn and record. Ask happy clients for reviews with permission, never fake them, and end unhealthy engagements professionally.

**Worked example:** A missed deadline message: what happened, new date, what changes to prevent it.

**Common mistake:** Ignoring a complaint until it grows.$t114c$, $t114d$Skill Lab: Reputation, reviews and difficult moments$t114d$, $t114e$Write three messages: an apology for a mistake, a firm boundary, and a request for a review.$t114e$, $t114f$[{"criterion": "Honest and specific", "max_points": 40, "guidance": "Clear."}, {"criterion": "Fix offered", "max_points": 30, "guidance": "Concrete."}, {"criterion": "Professional tone", "max_points": 30, "guidance": "Calm."}]$t114f$::jsonb, 45, 'text', false, false),
  (115, $t115a$Skill Lab: Lab 5 project: a scale plan$t115a$, $t115b$Deliver a plan to grow safely.$t115b$, $t115c$Show Lab 5. Deliver a **12-month scale plan**: services, capacity, hiring or partners, automations, targets, risks and what you will not do.

Success looks like a plan that protects quality.

**Worked example:** Plan to reach six retainer clients by month twelve, with one subcontractor and two internal automations.

**Common mistake:** Targets with no capacity plan.

Your work is scored on the rubric below. You can revise and resubmit.$t115c$, $t115d$Skill Lab: Lab 5 project: a scale plan$t115d$, $t115e$Submit the plan.$t115e$, $t115f$[{"criterion": "Targets and capacity", "max_points": 30, "guidance": "Realistic."}, {"criterion": "Systems and delegation", "max_points": 25, "guidance": "Sound."}, {"criterion": "Risks handled", "max_points": 25, "guidance": "Named."}, {"criterion": "Ethics and honesty", "max_points": 20, "guidance": "Clear."}]$t115f$::jsonb, 150, 'text', true, false),
  (116, $t116a$Skill Lab: Ethics in selling AI services$t116a$, $t116b$Sell honestly.$t116b$, $t116c$Do not promise guaranteed income or results, disclose AI use where relevant, never fake reviews or portfolios, protect client data and refuse work that harms people. Tell clients what AI cannot do.

**Worked example:** A sales page that states typical results as examples, not promises, and lists limits.

**Common mistake:** Guarantees you cannot control.$t116c$, $t116d$Skill Lab: Ethics in selling AI services$t116d$, $t116e$Audit your own sales claims: list each claim, the evidence and any change.$t116e$, $t116f$[{"criterion": "Claims audited", "max_points": 45, "guidance": "All."}, {"criterion": "Evidence real", "max_points": 35, "guidance": "Verified."}, {"criterion": "Changes made", "max_points": 20, "guidance": "Honest."}]$t116f$::jsonb, 45, 'text', false, false),
  (117, $t117a$Skill Lab: Continuing to learn and stay current$t117a$, $t117b$Keep your edge.$t117b$, $t117c$Tools and prices change quickly. Set a learning budget, rebuild one project in a new tool each quarter, follow a few trusted sources and review your offers twice a year. Keep principles ahead of tools.

**Worked example:** Quarterly review: what to stop, start and keep.

**Common mistake:** Chasing every new tool.$t117c$, $t117d$Skill Lab: Continuing to learn and stay current$t117d$, $t117e$Write a six-month learning and offer review plan.$t117e$, $t117f$[{"criterion": "Goals specific", "max_points": 40, "guidance": "Measurable."}, {"criterion": "Focus", "max_points": 30, "guidance": "Selective."}, {"criterion": "Review scheduled", "max_points": 30, "guidance": "Dated."}]$t117f$::jsonb, 45, 'text', false, false),
  (118, $t118a$Skill Lab: Community, mentoring and giving back$t118a$, $t118b$Share what you learn.$t118b$, $t118c$Teach in the community, mentor a newer member and publish templates. Helping others builds trust and sharpens your own skills. Ask for and give specific feedback.

**Worked example:** Post a template with a short guide and ask one specific question.

**Common mistake:** Promoting yourself in every reply.$t118c$, $t118d$Skill Lab: Community, mentoring and giving back$t118d$, $t118e$Share one helpful resource in the NEXTGEN Discord and summarise the responses.$t118e$, $t118f$[{"criterion": "Resource useful", "max_points": 40, "guidance": "Helpful."}, {"criterion": "Question specific", "max_points": 30, "guidance": "Clear."}, {"criterion": "Learning noted", "max_points": 30, "guidance": "Reflected."}]$t118f$::jsonb, 45, 'text', false, false),
  (119, $t119a$Skill Lab: Your first 90 days plan$t119a$, $t119b$Turn learning into action.$t119b$, $t119c$Set weekly actions for outreach, delivery and learning with measurable targets, and review every Friday. Start small, keep a log and adjust.

**Worked example:** Week plan: 10 outreach messages, 2 calls, 1 proposal, 3 hours learning.

**Common mistake:** Targets with no weekly actions.$t119c$, $t119d$Skill Lab: Your first 90 days plan$t119d$, $t119e$Write a 90-day plan with weekly actions, targets and a review routine.$t119e$, $t119f$[{"criterion": "Actions weekly", "max_points": 40, "guidance": "Clear."}, {"criterion": "Targets measurable", "max_points": 30, "guidance": "Numbers."}, {"criterion": "Review routine", "max_points": 30, "guidance": "Present."}]$t119f$::jsonb, 45, 'text', false, false),
  (120, $t120a$Skill Lab: Lab 6 project: your launch pack$t120a$, $t120b$Present your business and share it.$t120b$, $t120c$Show Lab 6. Publish your **launch pack**: offer page, packages and prices, proof (case study with permission), agreement draft, standards and 90-day plan. Share it in the NEXTGEN Discord and ask for one piece of feedback.

Success looks like something you would send to a real client.

**Worked example:** A one-page offer, three packages, one case study, standards and a plan.

**Common mistake:** Sharing without asking for feedback.

Your work is scored on the rubric below. You can revise and resubmit.$t120c$, $t120d$Skill Lab: Lab 6 project: your launch pack$t120d$, $t120e$Submit the launch pack text or links and a 150-word reflection.$t120e$, $t120f$[{"criterion": "Offer and proof", "max_points": 30, "guidance": "Strong."}, {"criterion": "Business readiness", "max_points": 25, "guidance": "Complete."}, {"criterion": "Ethics and honesty", "max_points": 25, "guidance": "Clear."}, {"criterion": "Plan and reflection", "max_points": 20, "guidance": "Specific."}]$t120f$::jsonb, 150, 'text', true, false)
) as v(n, title, objective, lesson_md, skill_focus, assignment_md, rubric, est_minutes, submission_type, ai_evaluate, requires_review)
where t.slug = 'business'
on conflict (track_id, day_number) do nothing;
