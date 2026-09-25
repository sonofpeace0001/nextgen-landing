-- Deepen Basic-tier lessons for apps: add a worked example and a common mistake (idempotent).
update public.day d
   set lesson_md = d.lesson_md || v.extra
  from (values
  (1, $x1$

**Worked example:** A hairdresser gets booking requests by text and double-books. Input: name, date, service. Logic: refuse a slot already taken. Output: a daily list for the salon.

**Common mistake:** Choosing a huge idea (an 'all-in-one business app') instead of one weekly annoyance.$x1$),
  (2, $x2$

**Worked example:** Brief: 'For salon owners. One job: stop double bookings. Screens: booking form, day list. Stores: name, phone, date, time, service. Will not: take payments or send texts in v1.'

**Common mistake:** Writing features without saying what the tool must not do, so the builder adds things you never wanted.$x2$),
  (3, $x3$

**Worked example:** Prompt: 'Build a booking app with a form (name, phone, date, time, service) and a day list sorted by time. Reject a booking if the time is already taken.' Then click every button before changing anything.

**Common mistake:** Asking for the finished product in one go and not testing the first version.$x3$),
  (4, $x4$

**Worked example:** Good: 'On the day list, show the service name in bold under each time.' Bad: 'make the list nicer'. If it breaks, undo and ask for a smaller change.

**Common mistake:** Stacking five changes in one prompt, then not knowing which one broke the page.$x4$),
  (5, $x5$

**Worked example:** Test list: empty form, 300-character name, a date in the past, two people booking the same slot, double-clicking Save, pressing Back mid-form.

**Common mistake:** Only testing with the tidy example you had in mind while building.$x5$),
  (6, $x6$

**Worked example:** Watch one real person book an appointment without helping. Note where they pause: that is your first fix list.

**Common mistake:** Judging the tool yourself instead of letting someone else try it.$x6$),
  (7, $x7$

**Worked example:** Bookings table: id, client_name (text), phone (text), starts_at (date+time), service (choice), status (choice). Phone is personal data: collect it only if you will actually call.

**Common mistake:** Adding fields 'just in case', which creates data you must protect and users must fill in.$x7$),
  (8, $x8$

**Worked example:** Phone: required, digits only, 7 to 15 long. Error text: 'Enter your phone number, digits only.' Date: cannot be in the past.

**Common mistake:** Showing 'Invalid input' with no hint how to fix it.$x8$),
  (9, $x9$

**Worked example:** With 30 bookings, add a search by name and a status filter (upcoming, done, cancelled), sorted by start time by default.

**Common mistake:** Testing lists with 3 rows, so slow or messy behaviour appears only after launch.$x9$),
  (10, $x10$

**Worked example:** Owner: see and edit all bookings. Staff: see and edit their own. Visitor: sees nothing. Test by signing in as staff and trying to open the owner page.

**Common mistake:** Hiding a button and calling it security; the page or data is still reachable.$x10$),
  (11, $x11$

**Worked example:** Use one heading size, 16px body text, one accent colour for buttons, and 44px-tall tap targets. Check on a phone in daylight.

**Common mistake:** Using five colours and three fonts because the builder offered them.$x11$),
  (12, $x12$

**Worked example:** Screenshot set: form with an error, list with 30 rows, search result, a staff view showing only their bookings.

**Common mistake:** Submitting a list of features instead of evidence that they work.$x12$),
  (13, $x13$

**Worked example:** Rule: 'If a booking is within 2 hours and unconfirmed, mark it red.' Test: 1h unconfirmed = red, 3h unconfirmed = normal, 1h confirmed = normal.

**Common mistake:** Describing a rule in a vague sentence, so the builder guesses a different rule.$x13$),
  (14, $x14$

**Worked example:** AI job: turn a pasted text message ('Can I get a trim Thursday around 3?') into a draft booking the user checks and edits before saving.

**Common mistake:** Letting AI save straight to the database without a human check.$x14$),
  (15, $x15$

**Worked example:** Trigger: new booking saved. Action: email the salon. Store the email service key in the platform's secret settings, never in the page.

**Common mistake:** Pasting an API key into the page code where anyone can view it.$x15$),
  (16, $x16$

**Worked example:** Send a reminder 24 hours before, once, with a 'cancel' link. Provide a setting to turn reminders off.

**Common mistake:** Sending several reminders a day, which makes users switch them off or leave.$x16$),
  (17, $x17$

**Worked example:** Empty list: 'No bookings yet. Add the first one.' Error: 'We could not save that. Check your connection and try again.'

**Common mistake:** Letting raw technical errors appear on screen.$x17$),
  (18, $x18$

**Worked example:** Show the rule turning a booking red, the AI draft being edited, the reminder email received, and the empty and error states.

**Common mistake:** Skipping error states because the demo path works.$x18$),
  (19, $x19$

**Worked example:** Privacy note: 'We store your name and phone to manage your booking. Only the salon sees them. Email us to delete them.'

**Common mistake:** Copying a long legal text you have not read.$x19$),
  (20, $x20$

**Worked example:** Check: can a stranger guess booking ids in the URL? Try /booking/1, /booking/2. If it opens other people's data, fix access rules.

**Common mistake:** Assuming the platform makes everything secure by default.$x20$),
  (21, $x21$

**Worked example:** Home page loads in 4.2 seconds; compressing three photos brings it to 1.8. AI cost: about 0.6 pence per draft, capped at 200 a month.

**Common mistake:** Ignoring AI usage costs until the first bill.$x21$),
  (22, $x22$

**Worked example:** Guide: 'Add a booking' in 4 steps with 2 screenshots, 'Cancel a booking', 'Find a client', and an email for help.

**Common mistake:** Writing a guide that describes screens instead of tasks.$x22$),
  (23, $x23$

**Worked example:** Three testers: two missed the Save button (too pale), one could not find search. Fix both, then retest with someone new.

**Common mistake:** Defending the design instead of watching where people struggle.$x23$),
  (24, $x24$

**Worked example:** Pack: privacy note, five security checks with results, guide, and a feedback log showing two fixes.

**Common mistake:** Launching without writing down what you checked.$x24$),
  (25, $x25$

**Worked example:** Interview a florist: 'Tell me about the last time you lost an order.' Capture exact words and how often it happens.

**Common mistake:** Asking leading questions ('Wouldn't an app help?').$x25$),
  (26, $x26$

**Worked example:** Sketch the three screens on paper and photograph them; list each field and where it appears.

**Common mistake:** Starting to build before the screens and data are agreed.$x26$),
  (27, $x27$

**Worked example:** Build only the core: add order, list orders, mark done. Run your ten tests.

**Common mistake:** Adding extras before the core works.$x27$),
  (28, $x28$

**Worked example:** Add one feature that saves time, such as an automatic 'ready' email, plus friendly errors and a phone-friendly layout.

**Common mistake:** Adding several features at once.$x28$),
  (29, $x29$

**Worked example:** Give the florist the tool for a day. Note what they ignore, misread and love. Fix the top two.

**Common mistake:** Treating feedback as a verdict rather than a to-do list.$x29$),
  (30, $x30$

**Worked example:** Case study: 'Before: orders on sticky notes, two lost a month. After: 40 orders logged, none lost in 3 weeks. Next: reminders.'

**Common mistake:** Claiming results you did not measure.$x30$)
  ) as v(n, extra), public.track t
 where t.id = d.track_id and t.slug = 'apps' and d.day_number = v.n
   and d.lesson_md not like '%**Worked example:**%';
