-- Apps & tools Skill Labs (days 91-120). Published; appended after the core path.
insert into public.day
  (track_id, tier_id, day_number, title, objective, lesson_md, skill_focus, assignment_md, rubric,
   est_minutes, is_published, credit_budget, submission_type, ai_evaluate, requires_review)
select t.id, ti.id, v.n, v.title, v.objective, v.lesson_md, v.skill_focus, v.assignment_md, v.rubric,
       v.est_minutes, true, null, v.submission_type, v.ai_evaluate, v.requires_review
from public.track t
join public.tier ti on ti.track_id = t.id and ti.slug = 'grandmaster'
cross join (values
  (91, $t91a$Skill Lab: State: what an app remembers about each thing$t91a$, $t91b$Model the states an item can be in.$t91b$, $t91c$Most apps track things that move through states: an order is new, paid, packed, shipped or cancelled. Write the allowed states and which moves are legal (you cannot ship a cancelled order). Show the current state clearly on screen. Bugs often come from missing or impossible states.

**Worked example:** Booking states: requested, confirmed, completed, cancelled. Rule: only confirmed bookings can be completed.

**Common mistake:** Letting any status change to any other status.$t91c$, $t91d$Skill Lab: State: what an app remembers about each thing$t91d$, $t91e$Draw a state diagram (text or image) for one thing in your tool with all legal moves and one impossible move you block.$t91e$, $t91f$[{"criterion": "States complete", "max_points": 40, "guidance": "All states listed."}, {"criterion": "Legal moves defined", "max_points": 35, "guidance": "Clear rules."}, {"criterion": "Impossible move blocked", "max_points": 25, "guidance": "Explained."}]$t91f$::jsonb, 45, 'text', false, false),
  (92, $t92a$Skill Lab: Workflows and triggers inside an app$t92a$, $t92b$Design what happens when something changes.$t92b$, $t92c$A workflow is: when this happens, check that, then do this. Write it in plain words first. Add a failure path (what if the email fails?) and an audit line (what was done, when, by whom). Keep workflows small and testable.

**Worked example:** When a booking is confirmed, send an email, add it to the calendar, and log the action; if email fails, mark 'needs follow-up'.

**Common mistake:** Only designing the happy path.$t92c$, $t92d$Skill Lab: Workflows and triggers inside an app$t92d$, $t92e$Design three workflows for your tool with triggers, checks, actions and failure paths.$t92e$, $t92f$[{"criterion": "Triggers and actions clear", "max_points": 40, "guidance": "Precise."}, {"criterion": "Failure paths", "max_points": 35, "guidance": "Present."}, {"criterion": "Audit trail", "max_points": 25, "guidance": "Logged."}]$t92f$::jsonb, 45, 'text', false, false),
  (93, $t93a$Skill Lab: Debugging by reading logs and errors$t93a$, $t93b$Find causes calmly.$t93b$, $t93c$Reproduce the problem, read the error message exactly, check recent changes, and narrow down by testing one thing at a time. Copy the error and the steps into your AI assistant with what you expected. Fix, retest, and write what caused it.

**Worked example:** Error 'null value in column phone' means the form allowed an empty phone. Fix the form validation and retest.

**Common mistake:** Changing five things at once hoping the bug disappears.$t93c$, $t93d$Skill Lab: Debugging by reading logs and errors$t93d$, $t93e$Find and fix three real or planted bugs in your tool. For each: steps to reproduce, cause, fix, retest.$t93e$, $t93f$[{"criterion": "Bugs reproduced", "max_points": 30, "guidance": "Steps."}, {"criterion": "Causes found", "max_points": 40, "guidance": "Not guessed."}, {"criterion": "Retested", "max_points": 30, "guidance": "Verified."}]$t93f$::jsonb, 45, 'text', false, false),
  (94, $t94a$Skill Lab: Reading simple code and version control$t94a$, $t94b$Understand enough code to steer AI and stay safe.$t94b$, $t94c$You do not need to write code to read it. Learn to spot inputs, conditions and outputs in a few lines, and to ask AI to explain a block line by line. Use version history (or Git) so every change is recorded and reversible, with clear messages.

**Worked example:** Ask: 'Explain this function line by line and list what could go wrong.' Then commit the fix with a message 'Reject empty phone numbers'.

**Common mistake:** Accepting generated code you cannot explain.$t94c$, $t94d$Skill Lab: Reading simple code and version control$t94d$, $t94e$Take a 20-line code sample from your tool or a public example, explain it line by line, and note two risks. Include a sample version log with three clear messages.$t94e$, $t94f$[{"criterion": "Explanation accurate", "max_points": 40, "guidance": "Correct."}, {"criterion": "Risks noticed", "max_points": 30, "guidance": "Real."}, {"criterion": "Clear change messages", "max_points": 30, "guidance": "Meaningful."}]$t94f$::jsonb, 45, 'text', false, false),
  (95, $t95a$Skill Lab: Lab 1 project: a spec and a bug-fix report$t95a$, $t95b$Show you can reason about how a tool behaves.$t95b$, $t95c$Show Lab 1. Deliver a **behaviour spec** (states, legal moves, workflows with failure paths) and a **bug-fix report** with three bugs, with screenshots of before and after.

Success looks like a spec another builder could implement.

**Worked example:** Spec for a booking tool with four states, three workflows, and three bugs fixed with retests.

**Common mistake:** Skipping evidence that the fixes work.

Your work is scored on the rubric below. You can revise and resubmit.$t95c$, $t95d$Skill Lab: Lab 1 project: a spec and a bug-fix report$t95d$, $t95e$Submit the spec and the report with screenshots.

**Evidence:** paste *direct* links to screenshots (.png/.jpg/.webp), one per line, and describe what they show.$t95e$, $t95f$[{"criterion": "Spec quality", "max_points": 35, "guidance": "Complete."}, {"criterion": "Bugs fixed and verified", "max_points": 35, "guidance": "Evidence."}, {"criterion": "Failure paths", "max_points": 15, "guidance": "Covered."}, {"criterion": "Clarity", "max_points": 15, "guidance": "Readable."}]$t95f$::jsonb, 120, 'link', true, false),
  (96, $t96a$Skill Lab: APIs and JSON in plain language$t96a$, $t96b$Understand how tools talk to each other.$t96b$, $t96c$An API lets one tool ask another for data or an action. A request has a place (URL), a method (get, post), and often a key. The reply is usually JSON, a labelled list of values. Read the docs' examples, test with a safe request first, and never expose keys.

**Worked example:** GET a public weather API; the reply has 'temp' and 'city' fields you show on a card.

**Common mistake:** Pasting a secret key into a public page.$t96c$, $t96d$Skill Lab: APIs and JSON in plain language$t96d$, $t96e$Pick a free public API, make a test request, and explain each part of the request and the reply fields.$t96e$, $t96f$[{"criterion": "Request parts explained", "max_points": 40, "guidance": "Correct."}, {"criterion": "Reply understood", "max_points": 30, "guidance": "Fields."}, {"criterion": "Key handled safely", "max_points": 30, "guidance": "Protected."}]$t96f$::jsonb, 45, 'text', false, false),
  (97, $t97a$Skill Lab: Spreadsheets and databases: choosing storage$t97a$, $t97b$Pick the simplest safe storage.$t97b$, $t97c$Spreadsheets are fine for small, low-risk data with one editor. Use a real database when several people write, when rules matter or when data is sensitive. Plan backups and export either way.

**Worked example:** A club sign-up sheet in a spreadsheet; a paid booking system in a database with permissions.

**Common mistake:** Storing sensitive personal data in an open sheet.$t97c$, $t97d$Skill Lab: Spreadsheets and databases: choosing storage$t97d$, $t97e$Compare storage for three tools you could build, with the choice and reasons.$t97e$, $t97f$[{"criterion": "Right choice for risk", "max_points": 40, "guidance": "Sensible."}, {"criterion": "Reasons clear", "max_points": 30, "guidance": "Specific."}, {"criterion": "Backup plan", "max_points": 30, "guidance": "Included."}]$t97f$::jsonb, 45, 'text', false, false),
  (98, $t98a$Skill Lab: Webhooks and integrations$t98a$, $t98b$Connect services reliably.$t98b$, $t98c$A webhook is a message another service sends when something happens. Verify who sent it, handle duplicates by storing processed ids, retry safely, and log every event. Use an automation platform for simple links.

**Worked example:** Payment provider sends 'paid'; your app checks the signature, marks the order paid once, ignores repeats.

**Common mistake:** Trusting any request that arrives at your address.$t98c$, $t98d$Skill Lab: Webhooks and integrations$t98d$, $t98e$Design an integration between your tool and one service: trigger, data, verification, duplicates, failure handling.$t98e$, $t98f$[{"criterion": "Verification", "max_points": 35, "guidance": "Present."}, {"criterion": "Duplicates handled", "max_points": 35, "guidance": "Planned."}, {"criterion": "Failure handling", "max_points": 30, "guidance": "Defined."}]$t98f$::jsonb, 45, 'text', false, false),
  (99, $t99a$Skill Lab: Importing, exporting and data hygiene$t99a$, $t99b$Move data in and out safely.$t99b$, $t99c$Users need to import a spreadsheet and export their data. Validate each row, show a preview and errors, keep the original, and never overwrite without a backup. Provide export in a common format.

**Worked example:** CSV import with a preview: 48 rows OK, 2 rejected with reasons, nothing saved until the user confirms.

**Common mistake:** Silently skipping bad rows.$t99c$, $t99d$Skill Lab: Importing, exporting and data hygiene$t99d$, $t99e$Design and test an import flow with 20 sample rows including five bad ones. Submit the results.$t99e$, $t99f$[{"criterion": "Validation clear", "max_points": 40, "guidance": "Rules."}, {"criterion": "Preview and confirm", "max_points": 30, "guidance": "Safe."}, {"criterion": "Bad rows explained", "max_points": 30, "guidance": "Helpful."}]$t99f$::jsonb, 45, 'text', false, false),
  (100, $t100a$Skill Lab: Lab 2 project: a tool that uses a live API$t100a$, $t100b$Deliver a tool with outside data and safe handling.$t100b$, $t100c$Show Lab 2. Build or specify a **tool that uses a real API**, with import/export, safe key handling, error states and a data storage rationale.

Success looks like it works with real data and fails gracefully.

**Worked example:** A local events board that pulls public events, lets users save favourites and export them.

**Common mistake:** No error state when the outside service is down.

Your work is scored on the rubric below. You can revise and resubmit.$t100c$, $t100d$Skill Lab: Lab 2 project: a tool that uses a live API$t100d$, $t100e$Submit screenshots of the working tool and an error state, the API and storage rationale, and your key-handling notes.

**Evidence:** paste *direct* links to screenshots (.png/.jpg/.webp), one per line, and describe what they show.$t100e$, $t100f$[{"criterion": "Works with real data", "max_points": 30, "guidance": "Shown."}, {"criterion": "Error handling", "max_points": 25, "guidance": "Graceful."}, {"criterion": "Safe keys and data", "max_points": 25, "guidance": "Protected."}, {"criterion": "Rationale", "max_points": 20, "guidance": "Clear."}]$t100f$::jsonb, 150, 'link', true, false),
  (101, $t101a$Skill Lab: Mobile-first and installable tools$t101a$, $t101b$Make tools work on phones.$t101b$, $t101c$Most users are on phones. Use large tap targets, one main action per screen, readable text and forms that use the right keyboard. Consider making the tool installable on a home screen and usable with a weak connection.

**Worked example:** A field-notes tool with a big 'Add note' button, camera upload and a save that retries when offline.

**Common mistake:** Testing only on a desktop screen.$t101c$, $t101d$Skill Lab: Mobile-first and installable tools$t101d$, $t101e$Test your tool on a phone and fix five issues. Submit before and after screenshots.

**Evidence:** paste *direct* links to screenshots (.png/.jpg/.webp), one per line, and describe what they show.$t101e$, $t101f$[{"criterion": "Real phone testing", "max_points": 35, "guidance": "Evidence."}, {"criterion": "Fixes effective", "max_points": 40, "guidance": "Better."}, {"criterion": "Five issues named", "max_points": 25, "guidance": "Specific."}]$t101f$::jsonb, 45, 'link', false, false),
  (102, $t102a$Skill Lab: Onboarding and empty states$t102a$, $t102b$Help new users succeed fast.$t102b$, $t102c$The first minute decides if people stay. Show a single next step, pre-fill an example, and explain empty screens with an action. Measure steps to first success and remove any that are not needed.

**Worked example:** An empty list says 'No jobs yet. Add your first job' with an example button.

**Common mistake:** A long welcome tour with no action.$t102c$, $t102d$Skill Lab: Onboarding and empty states$t102d$, $t102e$Redesign first-run for your tool and measure steps before and after.

**Evidence:** paste *direct* links to screenshots (.png/.jpg/.webp), one per line, and describe what they show.$t102e$, $t102f$[{"criterion": "Fewer steps", "max_points": 40, "guidance": "Measured."}, {"criterion": "Clear next action", "max_points": 35, "guidance": "Obvious."}, {"criterion": "Empty states helpful", "max_points": 25, "guidance": "Guiding."}]$t102f$::jsonb, 45, 'link', false, false),
  (103, $t103a$Skill Lab: Notifications and reminders that respect users$t103a$, $t103b$Communicate at the right time.$t103b$, $t103c$Send few, useful, timely messages. Let users choose channels and times, always allow opt-out, and never send marketing without consent. Batch when possible and include the action in the message.

**Worked example:** One daily digest at 8am instead of five separate emails.

**Common mistake:** Sending every event as its own notification.$t103c$, $t103d$Skill Lab: Notifications and reminders that respect users$t103d$, $t103e$Design a notification plan with types, timing, opt-out and an example message.$t103e$, $t103f$[{"criterion": "Useful and timely", "max_points": 40, "guidance": "Relevant."}, {"criterion": "Opt-out and consent", "max_points": 35, "guidance": "Present."}, {"criterion": "Message quality", "max_points": 25, "guidance": "Clear."}]$t103f$::jsonb, 45, 'text', false, false),
  (104, $t104a$Skill Lab: Accessibility and internationalisation$t104a$, $t104b$Make tools usable by more people.$t104b$, $t104c$Support keyboard use, screen readers (labels and headings), contrast and resizable text. Store dates, currency and text so other languages and formats can be added later, and avoid text inside images.

**Worked example:** Buttons have text labels; dates show in the user's format; the interface has room for longer German words.

**Common mistake:** Hard-coding text and formats.$t104c$, $t104d$Skill Lab: Accessibility and internationalisation$t104d$, $t104e$Audit five screens for accessibility and language readiness and fix the top five issues.

**Evidence:** paste *direct* links to screenshots (.png/.jpg/.webp), one per line, and describe what they show.$t104e$, $t104f$[{"criterion": "Issues real", "max_points": 35, "guidance": "Specific."}, {"criterion": "Fixes applied", "max_points": 40, "guidance": "Shown."}, {"criterion": "Language readiness", "max_points": 25, "guidance": "Considered."}]$t104f$::jsonb, 45, 'link', false, false),
  (105, $t105a$Skill Lab: Lab 3 project: a mobile-first tool with great first-run$t105a$, $t105b$Deliver a tool real people can use on a phone.$t105b$, $t105c$Show Lab 3. Deliver a **mobile-first version** of your tool with a strong onboarding flow, empty states, a notification plan and an accessibility pass.

Success looks like a first-time user reaching value in a minute.

**Worked example:** A volunteer scheduling tool where a new user picks a shift in three taps.

**Common mistake:** No test with a first-time user.

Your work is scored on the rubric below. You can revise and resubmit.$t105c$, $t105d$Skill Lab: Lab 3 project: a mobile-first tool with great first-run$t105d$, $t105e$Submit phone screenshots, a first-time user test note, the notification plan and the accessibility fixes.

**Evidence:** paste *direct* links to screenshots (.png/.jpg/.webp), one per line, and describe what they show.$t105e$, $t105f$[{"criterion": "Mobile usability", "max_points": 30, "guidance": "Works."}, {"criterion": "Onboarding effective", "max_points": 30, "guidance": "Measured."}, {"criterion": "Accessibility", "max_points": 20, "guidance": "Handled."}, {"criterion": "Notification plan", "max_points": 20, "guidance": "Respectful."}]$t105f$::jsonb, 150, 'link', true, false),
  (106, $t106a$Skill Lab: Environments: test, staging and live$t106a$, $t106b$Change safely.$t106b$, $t106c$Keep a test copy separate from the live app with its own data. Try changes there first, then release. Never test with real customers' data, and keep secrets different in each environment.

**Worked example:** A test copy with fake customers; a checklist before copying a change to live.

**Common mistake:** Editing the live app directly.$t106c$, $t106d$Skill Lab: Environments: test, staging and live$t106d$, $t106e$Set up a test copy and a release checklist. Submit screenshots and the checklist.

**Evidence:** paste *direct* links to screenshots (.png/.jpg/.webp), one per line, and describe what they show.$t106e$, $t106f$[{"criterion": "Separate environments", "max_points": 40, "guidance": "Shown."}, {"criterion": "Release checklist", "max_points": 35, "guidance": "Practical."}, {"criterion": "No real data in test", "max_points": 25, "guidance": "Confirmed."}]$t106f$::jsonb, 45, 'link', false, false),
  (107, $t107a$Skill Lab: Domains, hosting and going public$t107a$, $t107b$Publish your tool properly.$t107b$, $t107c$A domain gives a memorable address; hosting serves the app. Connect the domain, enable secure connections, check access settings so the right people can see it, and test the public address as a stranger would.

**Worked example:** Buy a domain, point it to the host, confirm the padlock, then test signed out.

**Common mistake:** Publishing without checking that private pages are actually private.$t107c$, $t107d$Skill Lab: Domains, hosting and going public$t107d$, $t107e$Publish your tool at a public address (or a staging address) and test it signed out. Submit screenshots and findings.

**Evidence:** paste *direct* links to screenshots (.png/.jpg/.webp), one per line, and describe what they show.$t107e$, $t107f$[{"criterion": "Published and reachable", "max_points": 40, "guidance": "Works."}, {"criterion": "Privacy tested", "max_points": 35, "guidance": "Signed out."}, {"criterion": "Findings honest", "max_points": 25, "guidance": "Reported."}]$t107f$::jsonb, 45, 'link', false, false),
  (108, $t108a$Skill Lab: Monitoring, backups and incidents$t108a$, $t108b$Know when it breaks and recover.$t108b$, $t108c$Set uptime checks and error alerts, back up data on a schedule and practise a restore. Write an incident note template: what happened, impact, cause, fix, prevention. Tell users honestly when something goes wrong.

**Worked example:** Alert on error rate above 2 percent; daily backup restored to a test copy once a month.

**Common mistake:** Never testing a restore.$t108c$, $t108d$Skill Lab: Monitoring, backups and incidents$t108d$, $t108e$Set up monitoring and a backup and write a one-page incident plan.

**Evidence:** paste *direct* links to screenshots (.png/.jpg/.webp), one per line, and describe what they show.$t108e$, $t108f$[{"criterion": "Monitoring set up", "max_points": 35, "guidance": "Evidence."}, {"criterion": "Restore tested", "max_points": 35, "guidance": "Done."}, {"criterion": "Incident plan", "max_points": 30, "guidance": "Clear."}]$t108f$::jsonb, 45, 'link', false, false),
  (109, $t109a$Skill Lab: Costs and limits$t109a$, $t109b$Keep spending predictable.$t109b$, $t109c$List every cost (hosting, database, AI calls, email, storage, domain). Set budget alerts and per-user limits, cache repeated work, and review monthly. Know what happens if usage doubles.

**Worked example:** Costs at 100 users: 24 pounds; at 1,000: 110; cap AI calls at 30 per user per month.

**Common mistake:** No limits on a paid AI feature.$t109c$, $t109d$Skill Lab: Costs and limits$t109d$, $t109e$Build a cost model at 100, 1,000 and 10,000 users with three cost controls.$t109e$, $t109f$[{"criterion": "Costs complete", "max_points": 40, "guidance": "All items."}, {"criterion": "Controls practical", "max_points": 35, "guidance": "Three."}, {"criterion": "Assumptions stated", "max_points": 25, "guidance": "Clear."}]$t109f$::jsonb, 45, 'text', false, false),
  (110, $t110a$Skill Lab: Lab 4 project: a live tool with an operations pack$t110a$, $t110b$Deliver a live tool you can support.$t110b$, $t110c$Show Lab 4. Deliver a **live (or staging) tool** with a test environment, release checklist, monitoring, backup and restore evidence, cost model and incident plan.

Success looks like something you could hand to a client.

**Worked example:** A booking tool live on a domain with alerts, daily backups and a documented restore.

**Common mistake:** Calling it live with no way to see errors.

Your work is scored on the rubric below. You can revise and resubmit.$t110c$, $t110d$Skill Lab: Lab 4 project: a live tool with an operations pack$t110d$, $t110e$Submit screenshots of the live tool, monitoring, backup restore, the cost model and the incident plan.

**Evidence:** paste *direct* links to screenshots (.png/.jpg/.webp), one per line, and describe what they show.$t110e$, $t110f$[{"criterion": "Live and reachable", "max_points": 25, "guidance": "Works."}, {"criterion": "Operations evidence", "max_points": 35, "guidance": "Real."}, {"criterion": "Cost model", "max_points": 20, "guidance": "Sound."}, {"criterion": "Incident plan", "max_points": 20, "guidance": "Clear."}]$t110f$::jsonb, 180, 'link', true, false),
  (111, $t111a$Skill Lab: Pricing and packaging a tool$t111a$, $t111b$Choose a fair pricing model.$t111b$, $t111c$Options: free with paid extras, per seat, usage-based, flat monthly. Price to your costs and the value created, test willingness to pay with real people, and be clear about limits and refunds. Use a payment provider's test mode until you are ready.

**Worked example:** Free for 5 jobs a month, 9 pounds for unlimited, refund within 14 days.

**Common mistake:** Pricing below cost because 'it is cheap to run'.$t111c$, $t111d$Skill Lab: Pricing and packaging a tool$t111d$, $t111e$Design pricing for your tool with unit economics and evidence from five potential users.$t111e$, $t111f$[{"criterion": "Unit economics sound", "max_points": 40, "guidance": "Numbers."}, {"criterion": "Real evidence", "max_points": 35, "guidance": "Five people."}, {"criterion": "Terms clear", "max_points": 25, "guidance": "Refunds and limits."}]$t111f$::jsonb, 45, 'text', false, false),
  (112, $t112a$Skill Lab: Landing pages and honest marketing$t112a$, $t112b$Explain the tool clearly.$t112b$, $t112c$A landing page answers: what is it, who is it for, why trust it and what to do next. Show real screenshots, real numbers and real quotes with permission. Do not invent testimonials or inflate results.

**Worked example:** Hero: 'Never double-book a chair again', screenshot, three benefits, one real quote, 'Try free'.

**Common mistake:** Inventing social proof.$t112c$, $t112d$Skill Lab: Landing pages and honest marketing$t112d$, $t112e$Design or write a landing page for your tool. Submit screenshots or copy with proof sources.

**Evidence:** paste *direct* links to screenshots (.png/.jpg/.webp), one per line, and describe what they show.$t112e$, $t112f$[{"criterion": "Clear promise", "max_points": 35, "guidance": "Understandable."}, {"criterion": "Honest proof", "max_points": 40, "guidance": "Real."}, {"criterion": "One next step", "max_points": 25, "guidance": "Clear."}]$t112f$::jsonb, 45, 'link', false, false),
  (113, $t113a$Skill Lab: Product analytics and iteration$t113a$, $t113b$Learn from usage without spying.$t113b$, $t113c$Track a few events tied to questions: sign-up, first success, week-4 return. Use privacy-friendly analytics, explain it in your privacy note and honour consent. Review weekly and decide one change.

**Worked example:** Question: where do people drop off? Events: started form, finished form.

**Common mistake:** Tracking everything with no question.$t113c$, $t113d$Skill Lab: Product analytics and iteration$t113d$, $t113e$Define five events with the question each answers and mock up a weekly review.$t113e$, $t113f$[{"criterion": "Events tied to questions", "max_points": 40, "guidance": "Purposeful."}, {"criterion": "Privacy respected", "max_points": 35, "guidance": "Consent."}, {"criterion": "Decision defined", "max_points": 25, "guidance": "Actionable."}]$t113f$::jsonb, 45, 'text', false, false),
  (114, $t114a$Skill Lab: Support, docs and community$t114a$, $t114b$Look after users after launch.$t114b$, $t114c$Offer an easy way to ask for help, publish a short guide and changelog, reply within a stated time and tag feedback by theme. Close the loop by telling users what you fixed.

**Worked example:** A help page, a feedback button on every screen and a monthly 'what we fixed' post.

**Common mistake:** Collecting feedback and never replying.$t114c$, $t114d$Skill Lab: Support, docs and community$t114d$, $t114e$Set up a support channel and triage ten items into themes with actions.$t114e$, $t114f$[{"criterion": "Channel easy", "max_points": 30, "guidance": "Simple."}, {"criterion": "Triage useful", "max_points": 40, "guidance": "Themes."}, {"criterion": "Loop closed", "max_points": 30, "guidance": "Users told."}]$t114f$::jsonb, 45, 'text', false, false),
  (115, $t115a$Skill Lab: Lab 5 project: a launch kit$t115a$, $t115b$Deliver everything needed to launch.$t115b$, $t115c$Show Lab 5. Deliver a **launch kit**: pricing model, landing page, analytics plan, support setup and a 30-day launch plan with targets.

Success looks like a plan you could start tomorrow.

**Worked example:** Launch plan: 20 first users from two communities, weekly release notes, target of 10 active users after 30 days.

**Common mistake:** A launch plan with no numbers.

Your work is scored on the rubric below. You can revise and resubmit.$t115c$, $t115d$Skill Lab: Lab 5 project: a launch kit$t115d$, $t115e$Submit the pricing, landing page, analytics plan, support setup and launch plan.

**Evidence:** paste *direct* links to screenshots (.png/.jpg/.webp), one per line, and describe what they show.$t115e$, $t115f$[{"criterion": "Pricing and economics", "max_points": 25, "guidance": "Sound."}, {"criterion": "Landing page honesty", "max_points": 25, "guidance": "True."}, {"criterion": "Analytics and support", "max_points": 25, "guidance": "Practical."}, {"criterion": "Launch plan", "max_points": 25, "guidance": "Measurable."}]$t115f$::jsonb, 150, 'link', true, false),
  (116, $t116a$Skill Lab: Portfolio of tools$t116a$, $t116b$Show what you built and why.$t116b$, $t116c$Show three tools with the problem, your role, screenshots, results and what you learned. Be honest about what AI tools generated and what you decided. Include a live link where possible.

**Worked example:** A case study: the problem, three screens, 10 active users, one mistake and its fix.

**Common mistake:** Screenshots with no story.$t116c$, $t116d$Skill Lab: Portfolio of tools$t116d$, $t116e$Draft a portfolio with two tool case studies.

**Evidence:** paste *direct* links to screenshots (.png/.jpg/.webp), one per line, and describe what they show.$t116e$, $t116f$[{"criterion": "Problem and result shown", "max_points": 40, "guidance": "Clear."}, {"criterion": "Honest about AI", "max_points": 30, "guidance": "Stated."}, {"criterion": "Lessons", "max_points": 30, "guidance": "Specific."}]$t116f$::jsonb, 45, 'link', false, false),
  (117, $t117a$Skill Lab: Building tools for clients$t117a$, $t117b$Scope and deliver client tools.$t117b$, $t117c$Discover the real problem, write a scope with exclusions, agree on acceptance tests, deliver in stages and hand over documentation. Agree ownership of data and code and who pays for tools and hosting.

**Worked example:** Scope: booking tool, 3 screens, excludes payments, acceptance tests listed, handover guide.

**Common mistake:** No acceptance tests, so 'done' is arguable.$t117c$, $t117d$Skill Lab: Building tools for clients$t117d$, $t117e$Write a client scope, acceptance tests and handover checklist for a small tool.$t117e$, $t117f$[{"criterion": "Scope and exclusions", "max_points": 40, "guidance": "Precise."}, {"criterion": "Acceptance tests", "max_points": 35, "guidance": "Testable."}, {"criterion": "Handover", "max_points": 25, "guidance": "Complete."}]$t117f$::jsonb, 45, 'text', false, false),
  (118, $t118a$Skill Lab: Maintenance, retainers and pricing$t118a$, $t118b$Keep tools running profitably.$t118b$, $t118c$Tools need updates, backups and support. Offer a monthly maintenance plan with clear inclusions and response times. Price by hours and risk, and record what you did each month.

**Worked example:** Retainer: 120 a month, monitoring, backups, two small changes, response within one working day.

**Common mistake:** Doing free maintenance forever.$t118c$, $t118d$Skill Lab: Maintenance, retainers and pricing$t118d$, $t118e$Write a maintenance offer with inclusions, price, response time and exit terms.$t118e$, $t118f$[{"criterion": "Inclusions clear", "max_points": 40, "guidance": "Defined."}, {"criterion": "Pricing logic", "max_points": 30, "guidance": "Reasoned."}, {"criterion": "Exit terms", "max_points": 30, "guidance": "Fair."}]$t118f$::jsonb, 45, 'text', false, false),
  (119, $t119a$Skill Lab: Ethics, privacy and responsibility$t119a$, $t119b$Build responsibly.$t119b$, $t119c$State how you protect data, handle mistakes and use AI. Refuse to build tools that deceive or harm. Keep records of consent and be ready to delete data on request.

**Worked example:** A one-page standard: data minimum, deletion on request, AI use disclosed, no dark patterns.

**Common mistake:** Collecting data because it might be useful later.$t119c$, $t119d$Skill Lab: Ethics, privacy and responsibility$t119d$, $t119e$Write your builder standards (200 words) and a data handling checklist.$t119e$, $t119f$[{"criterion": "Specific commitments", "max_points": 40, "guidance": "Concrete."}, {"criterion": "Checklist practical", "max_points": 30, "guidance": "Usable."}, {"criterion": "Deletion and consent", "max_points": 30, "guidance": "Covered."}]$t119f$::jsonb, 45, 'text', false, false),
  (120, $t120a$Skill Lab: Lab 6 project: your builder showcase$t120a$, $t120b$Present your work and services.$t120b$, $t120c$Show Lab 6. Publish a **showcase**: two tool case studies, your services and prices, your standards and a maintenance offer. Share it in the NEXTGEN Discord and ask for one piece of feedback.

Success looks like something you would send to a real client.

**Worked example:** A page with two case studies, three packages, the standards and a contact button.

**Common mistake:** Sharing without asking for feedback.

Your work is scored on the rubric below. You can revise and resubmit.$t120c$, $t120d$Skill Lab: Lab 6 project: your builder showcase$t120d$, $t120e$Submit screenshots or links of the showcase and a 150-word reflection on what to improve next.

**Evidence:** paste *direct* links to screenshots (.png/.jpg/.webp), one per line, and describe what they show.$t120e$, $t120f$[{"criterion": "Quality of work", "max_points": 30, "guidance": "Strong."}, {"criterion": "Business readiness", "max_points": 25, "guidance": "Clear."}, {"criterion": "Standards and honesty", "max_points": 25, "guidance": "Real."}, {"criterion": "Reflection", "max_points": 20, "guidance": "Specific."}]$t120f$::jsonb, 150, 'link', true, false)
) as v(n, title, objective, lesson_md, skill_focus, assignment_md, rubric, est_minutes, submission_type, ai_evaluate, requires_review)
where t.slug = 'apps'
on conflict (track_id, day_number) do nothing;
