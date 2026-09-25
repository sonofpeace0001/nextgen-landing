-- Graphics & design Skill Labs (days 91-120): design fundamentals, UI and web, decks and infographics,
-- photo/product/packaging, tool mastery, career and business. Published; appended after the core path.
insert into public.day
  (track_id, tier_id, day_number, title, objective, lesson_md, skill_focus, assignment_md, rubric,
   est_minutes, is_published, credit_budget, submission_type, ai_evaluate)
select t.id, ti.id, v.n, v.title, v.objective, v.lesson_md, v.skill_focus, v.assignment_md, v.rubric,
       v.est_minutes, true, null, v.submission_type, v.ai_evaluate
from public.track t
join public.tier ti on ti.track_id = t.id and ti.slug = 'grandmaster'
cross join (values
  (91, $t91a$Skill Lab: Four principles that fix most designs$t91a$, $t91b$Apply contrast, repetition, alignment and proximity to a weak layout.$t91b$, $t91c$Most weak designs fail on four things. **Contrast:** make different things clearly different. **Repetition:** reuse fonts, colours and spacing so the design feels unified. **Alignment:** line every element up with something else. **Proximity:** group related items and separate unrelated ones.

Check them in that order and you will fix most layouts without adding anything.

**Worked example:** A flyer has a headline, date, address and price scattered evenly. Group date, address and price in one block (proximity), align it left with the headline (alignment), and make the headline much larger (contrast).

**Common mistake:** Adding more decoration to a layout whose real problem is that nothing is grouped or aligned.

**Sharing images:** paste *direct* links ending .png/.jpg/.webp, one per line, and describe what they show.$t91c$, $t91d$Skill Lab: Four principles that fix most designs$t91d$, $t91e$Find a weak flyer or post (yours or public). Submit direct links to before and after images and one sentence naming which principle you fixed in each change.$t91e$, $t91f$[{"criterion": "Principles named correctly", "max_points": 35, "guidance": "Each fix is tied to a principle."}, {"criterion": "Visible improvement", "max_points": 40, "guidance": "After is clearly better."}, {"criterion": "No new clutter", "max_points": 25, "guidance": "Simpler, not busier."}]$t91f$::jsonb, 40, 'link', false),
  (92, $t92a$Skill Lab: Colour theory you will actually use$t92a$, $t92b$Build a palette from a colour wheel relationship and test its mood.$t92b$, $t92c$Colour relationships give ready-made palettes: **complementary** (opposites, high energy), **analogous** (neighbours, calm), **triadic** (three evenly spaced, playful) and **monochromatic** (one hue, elegant). Use one dominant colour, one supporting colour and one accent, in roughly 60, 30 and 10 percent.

Colours carry associations that vary by culture, so test them with your audience.

**Worked example:** A wellness studio: analogous greens (60 percent sage, 30 percent forest) with a 10 percent warm coral accent on buttons.

**Common mistake:** Using five equally strong colours, so nothing leads the eye.

**Sharing images:** paste *direct* links ending .png/.jpg/.webp, one per line, and describe what they show.$t92c$, $t92d$Skill Lab: Colour theory you will actually use$t92d$, $t92e$Create three palettes for one brand (two relationships of your choice plus one you invent), apply each to the same layout, and say which you would choose and why. Submit direct links.$t92e$, $t92f$[{"criterion": "Relationships used correctly", "max_points": 35, "guidance": "Palettes follow the named rule."}, {"criterion": "Same layout compared fairly", "max_points": 35, "guidance": "Only colour differs."}, {"criterion": "Choice reasoned", "max_points": 30, "guidance": "Ties to audience and mood."}]$t92f$::jsonb, 40, 'link', false),
  (93, $t93a$Skill Lab: Mood boards and creative direction$t93a$, $t93b$Turn a brief into a mood board that guides every later decision.$t93b$, $t93c$A mood board is a decision tool, not a collage. Collect 8 to 12 references, then name what you are taking from each (colour, texture, composition, tone). Cut anything that does not serve the brief. Write three words that summarise the direction.

Use only images you have the right to use, or your own generations, and never copy a specific artist's work.

**Worked example:** Brief: a night market brand. Words: warm, lively, handmade. References give lantern colours, paper textures and hand-lettering; a grey corporate reference is cut.

**Common mistake:** A board of pretty images with no explanation of what each contributes.

**Sharing images:** paste *direct* links ending .png/.jpg/.webp, one per line, and describe what they show.$t93c$, $t93d$Skill Lab: Mood boards and creative direction$t93d$, $t93e$Make a mood board for a brief of your choice with notes on each reference and three direction words. Submit a direct link to the board and the brief.$t93e$, $t93f$[{"criterion": "Board is curated", "max_points": 35, "guidance": "Focused, not a dump."}, {"criterion": "Notes explain contributions", "max_points": 40, "guidance": "Each image has a purpose."}, {"criterion": "Direction words clear", "max_points": 25, "guidance": "Three words that guide choices."}]$t93f$::jsonb, 40, 'link', false),
  (94, $t94a$Skill Lab: Typography in depth$t94a$, $t94b$Choose, pair and set type for readability and personality.$t94b$, $t94c$Learn the categories (serif, sans, slab, script, display) and use display and script only for short text. Set body text at 16 to 18 px with 1.4 to 1.6 line height and 45 to 75 characters per line. Pair fonts by contrast (a serif heading with a sans body) rather than by similarity.

Check readability at small sizes and on a phone before you decide.

**Worked example:** Heading in a bold serif at 40 px, body in a neutral sans at 17 px with 1.5 line height, one accent colour for links.

**Common mistake:** Using two similar fonts that fight each other, or a script font for long paragraphs.

**Sharing images:** paste *direct* links ending .png/.jpg/.webp, one per line, and describe what they show.$t94c$, $t94d$Skill Lab: Typography in depth$t94d$, $t94e$Set the same short article (about 120 words) in three font pairings. Submit direct links and choose the best with reasons about readability and personality.$t94e$, $t94f$[{"criterion": "Three real pairings", "max_points": 30, "guidance": "Clearly different."}, {"criterion": "Readability handled", "max_points": 40, "guidance": "Sizes, spacing, line length."}, {"criterion": "Choice reasoned", "max_points": 30, "guidance": "Personality and audience."}]$t94f$::jsonb, 40, 'link', false),
  (95, $t95a$Skill Lab: Redesign a weak design using the fundamentals$t95a$, $t95b$Show mastery of principles, colour, mood and type in one redesign.$t95b$, $t95c$Show Lab 1. Take a genuinely weak design (a real flyer, menu or post you have permission to use, or one you generate badly on purpose) and redesign it from a brief. Annotate which principle each change applies.

Success looks like a redesign where a stranger can see the hierarchy in two seconds.

**Worked example:** Before: a menu with five fonts and centred everything. After: two fonts, left aligned, prices grouped, sage-and-cream palette, annotations pointing to each change.

**Common mistake:** Redesigning without annotations, so the reasoning is invisible.

Your work is scored on the rubric below. You can revise and resubmit.

**Sharing images:** paste *direct* links ending .png/.jpg/.webp, one per line, and describe what they show.$t95c$, $t95d$Skill Lab: Redesign a weak design using the fundamentals$t95d$, $t95e$Submit direct links to before, after and an annotated version, plus the brief and mood board.$t95e$, $t95f$[{"criterion": "Fundamentals applied correctly", "max_points": 35, "guidance": "Principles, colour and type."}, {"criterion": "Clear hierarchy", "max_points": 30, "guidance": "Readable in two seconds."}, {"criterion": "Annotations explain decisions", "max_points": 20, "guidance": "Reasoned."}, {"criterion": "Fits the brief", "max_points": 15, "guidance": "Suits the audience."}]$t95f$::jsonb, 90, 'link', true),
  (96, $t96a$Skill Lab: Design for screens: layout, grids and breakpoints$t96a$, $t96b$Plan a page that works on phone and desktop.$t96b$, $t96c$Design mobile first: one column, large tap targets (44 px), the main action visible without scrolling. Then widen to two or three columns on desktop using a 12-column grid. Decide the order of content by importance, not by what looks nice.

Sketch the phone layout first; it forces you to prioritise.

**Worked example:** A bakery site: phone shows logo, hero photo, 'Order now' button, then menu. Desktop puts the menu beside the photo.

**Common mistake:** Designing a beautiful desktop page and squeezing it onto a phone afterwards.

**Sharing images:** paste *direct* links ending .png/.jpg/.webp, one per line, and describe what they show.$t96c$, $t96d$Skill Lab: Design for screens: layout, grids and breakpoints$t96d$, $t96e$Design a home page for a small business in phone and desktop versions. Submit direct links and a sentence on what moved and why.$t96e$, $t96f$[{"criterion": "Both sizes designed", "max_points": 35, "guidance": "Phone and desktop."}, {"criterion": "Priorities clear", "max_points": 35, "guidance": "Main action obvious."}, {"criterion": "Grid and spacing", "max_points": 30, "guidance": "Consistent."}]$t96f$::jsonb, 40, 'link', false),
  (97, $t97a$Skill Lab: Components and states$t97a$, $t97b$Design buttons, forms and cards with all their states.$t97b$, $t97c$Interfaces need more than the default look. Every interactive element has states: default, hover, pressed, focus, disabled, error. Design a small kit: primary and secondary buttons, an input with an error message, a card. Keep sizes and spacing on a scale (4, 8, 16, 24).

Focus states matter for keyboard users.

**Worked example:** Primary button: violet, 44 px tall; hover slightly darker; focus with a visible 2 px outline; disabled at 40 percent opacity.

**Common mistake:** Designing only the default state, then improvising the rest in a hurry.

**Sharing images:** paste *direct* links ending .png/.jpg/.webp, one per line, and describe what they show.$t97c$, $t97d$Skill Lab: Components and states$t97d$, $t97e$Create a component sheet with a button, input and card in at least four states. Submit a direct link and list your spacing scale.$t97e$, $t97f$[{"criterion": "States complete", "max_points": 40, "guidance": "Four or more."}, {"criterion": "Consistent scale", "max_points": 30, "guidance": "Spacing and sizes."}, {"criterion": "Accessible focus and errors", "max_points": 30, "guidance": "Visible and clear."}]$t97f$::jsonb, 40, 'link', false),
  (98, $t98a$Skill Lab: From prompt to interface: AI wireframes and screens$t98a$, $t98b$Use AI to explore interface ideas, then refine by hand.$t98b$, $t98c$AI can produce interface concepts quickly. Ask for structure first (sections, hierarchy), then visuals. Treat outputs as sketches: check text, spacing, contrast and real usability, then rebuild the good parts in your design tool.

State the user and task in the prompt: 'a mobile screen for booking a haircut in under 30 seconds'.

**Worked example:** Prompt: 'Mobile booking screen for a barber, one primary button, date picker, clean layout, dark theme.' Choose the best of six, then fix the low-contrast labels.

**Common mistake:** Shipping the generated screen without checking whether text is real, readable and consistent.

**Sharing images:** paste *direct* links ending .png/.jpg/.webp, one per line, and describe what they show.$t98c$, $t98d$Skill Lab: From prompt to interface: AI wireframes and screens$t98d$, $t98e$Generate six interface concepts for one task, choose one, and rebuild or fix it. Submit direct links to your six, the chosen one and the fixed version.$t98e$, $t98f$[{"criterion": "Explored options", "max_points": 30, "guidance": "Six concepts."}, {"criterion": "Chosen and refined", "max_points": 40, "guidance": "Real fixes."}, {"criterion": "Task-focused", "max_points": 30, "guidance": "Serves the user goal."}]$t98f$::jsonb, 40, 'link', false),
  (99, $t99a$Skill Lab: Accessible, honest interface design$t99a$, $t99b$Design interfaces that are usable by everyone and free of dark patterns.$t99b$, $t99c$Check contrast (4.5 to 1 for body text), text size, labels on every input, focus order and error messages that say how to fix the problem. Avoid dark patterns: hidden costs, fake urgency, pre-ticked boxes and confusing cancel buttons. Good design earns trust.

**Worked example:** A sign-up form: labels above inputs, an error 'Enter your email like name@example.com', a visible 'No thanks' option beside 'Subscribe'.

**Common mistake:** Making the unsubscribe or cancel option hard to find.

**Sharing images:** paste *direct* links ending .png/.jpg/.webp, one per line, and describe what they show.$t99c$, $t99d$Skill Lab: Accessible, honest interface design$t99d$, $t99e$Audit one interface you use and redesign one screen to fix five issues. Submit before and after links and your five fixes.$t99e$, $t99f$[{"criterion": "Issues real", "max_points": 35, "guidance": "Five specific problems."}, {"criterion": "Fixes effective", "max_points": 40, "guidance": "Better."}, {"criterion": "No dark patterns", "max_points": 25, "guidance": "Honest choices."}]$t99f$::jsonb, 40, 'link', false),
  (100, $t100a$Skill Lab: Lab 2 project: a landing page design$t100a$, $t100b$Design a complete landing page for a real or realistic offer.$t100b$, $t100c$Show Lab 2. Design a **landing page** (phone and desktop) with a hero, three benefits, proof, FAQ and a clear button, using your component sheet, an accessible palette and honest copy.

Success looks like a stranger understanding the offer and the next step in five seconds.

**Worked example:** Offer: weekend pottery class. Hero photo, headline 'Make your first bowl in one Saturday', three benefits, real testimonial (with permission), FAQ, one 'Book a place' button.

**Common mistake:** Inventing testimonials or numbers for proof.

Your work is scored on the rubric below. You can revise and resubmit.

**Sharing images:** paste *direct* links ending .png/.jpg/.webp, one per line, and describe what they show.$t100c$, $t100d$Skill Lab: Lab 2 project: a landing page design$t100d$, $t100e$Submit direct links to the phone and desktop designs, the component sheet, your palette with contrast values, and the offer and audience.$t100e$, $t100f$[{"criterion": "Clear offer and hierarchy", "max_points": 30, "guidance": "Five-second test."}, {"criterion": "Responsive and consistent", "max_points": 25, "guidance": "System used."}, {"criterion": "Accessibility", "max_points": 25, "guidance": "Contrast and states."}, {"criterion": "Honest content", "max_points": 20, "guidance": "No invented proof."}]$t100f$::jsonb, 120, 'link', true),
  (101, $t101a$Skill Lab: Slide design that people remember$t101a$, $t101b$Design slides with one message each.$t101b$, $t101c$A slide carries one idea. Use a headline that states the takeaway, one visual, and at most three short lines. Keep a template: fixed margins, one font pair, two colours plus neutrals. Use full-bleed images with a dark overlay for section breaks.

If a slide needs to be read, it is a document, not a slide.

**Worked example:** Instead of 'Sales overview' with five bullets, the slide says 'Sales grew 24 percent in Q3' with one simple chart.

**Common mistake:** Putting the whole script on the slide.

**Sharing images:** paste *direct* links ending .png/.jpg/.webp, one per line, and describe what they show.$t101c$, $t101d$Skill Lab: Slide design that people remember$t101d$, $t101e$Redesign three text-heavy slides into single-message slides. Submit before and after direct links.$t101e$, $t101f$[{"criterion": "One message per slide", "max_points": 40, "guidance": "Clear takeaway."}, {"criterion": "Visual supports", "max_points": 30, "guidance": "Relevant."}, {"criterion": "Consistent template", "max_points": 30, "guidance": "Unified."}]$t101f$::jsonb, 40, 'link', false),
  (102, $t102a$Skill Lab: Pitch decks and story structure$t102a$, $t102b$Structure a deck as a story.$t102b$, $t102c$A good pitch tells a story: problem, solution, proof, market, plan, ask. Ten to twelve slides is enough. Lead with the problem in the audience's words, and end with a clear request. Use AI for drafting outlines and images, but every number must be true and sourced.

**Worked example:** Startup deck: problem (slide 2), product demo (4), traction with real numbers (6), the ask (11).

**Common mistake:** Inventing traction numbers to look impressive.

**Sharing images:** paste *direct* links ending .png/.jpg/.webp, one per line, and describe what they show.$t102c$, $t102d$Skill Lab: Pitch decks and story structure$t102d$, $t102e$Outline a 10-slide deck for a real or realistic project with a headline for each slide. Submit the outline and a designed title and one content slide.$t102e$, $t102f$[{"criterion": "Story flow", "max_points": 40, "guidance": "Problem to ask."}, {"criterion": "Headlines state takeaways", "max_points": 30, "guidance": "Clear."}, {"criterion": "Honest numbers", "max_points": 30, "guidance": "Sourced or labelled example."}]$t102f$::jsonb, 40, 'link', false),
  (103, $t103a$Skill Lab: Infographics that explain$t103a$, $t103b$Turn information into a clear visual explanation.$t103b$, $t103c$An infographic answers one question. Choose the structure (process, comparison, timeline, statistic), simplify the data, use consistent icons, and put the key number largest. Cite sources at the bottom and never distort proportions.

**Worked example:** Question: how does recycling work? A five-step vertical process with numbered icons and one big statistic, sources listed.

**Common mistake:** Cramming twenty facts into one graphic.

**Sharing images:** paste *direct* links ending .png/.jpg/.webp, one per line, and describe what they show.$t103c$, $t103d$Skill Lab: Infographics that explain$t103d$, $t103e$Create an infographic answering one question with real sourced data. Submit a direct link and your sources.$t103e$, $t103f$[{"criterion": "One clear question", "max_points": 30, "guidance": "Focused."}, {"criterion": "Accurate and sourced", "max_points": 40, "guidance": "Real data."}, {"criterion": "Readable design", "max_points": 30, "guidance": "Hierarchy and icons."}]$t103f$::jsonb, 40, 'link', false),
  (104, $t104a$Skill Lab: Data visualisation for designers$t104a$, $t104b$Design honest, clear charts.$t104b$, $t104c$Pick the chart that matches the question: bars to compare, lines for change over time, a single number for a headline. Start bar axes at zero, label directly, use colour to highlight the point and grey for the rest. Remove gridlines and chart junk.

**Worked example:** A line chart of monthly sign-ups with the growth month in violet, everything else grey, and the takeaway as the title.

**Common mistake:** Truncating an axis to make a small change look big.

**Sharing images:** paste *direct* links ending .png/.jpg/.webp, one per line, and describe what they show.$t104c$, $t104d$Skill Lab: Data visualisation for designers$t104d$, $t104e$Design three charts from real public data. Submit direct links, the data source and each chart's takeaway title.$t104e$, $t104f$[{"criterion": "Right chart types", "max_points": 35, "guidance": "Fit the question."}, {"criterion": "Honest scales", "max_points": 35, "guidance": "Accurate."}, {"criterion": "Clear takeaway", "max_points": 30, "guidance": "Titles say it."}]$t104f$::jsonb, 40, 'link', false),
  (105, $t105a$Skill Lab: Lab 3 project: an eight-slide deck with an infographic$t105a$, $t105b$Deliver a designed deck that tells a story with true data.$t105b$, $t105c$Show Lab 3. Design an **eight-slide deck** for a real or realistic project with one infographic and one chart, a consistent template, and a clear ask.

Success looks like a deck someone could present without extra explanation.

**Worked example:** Deck: cover, problem, solution, how it works (infographic), results (chart), plan, team, ask.

**Common mistake:** Using stock statistics you cannot source.

Your work is scored on the rubric below. You can revise and resubmit.

**Sharing images:** paste *direct* links ending .png/.jpg/.webp, one per line, and describe what they show.$t105c$, $t105d$Skill Lab: Lab 3 project: an eight-slide deck with an infographic$t105d$, $t105e$Submit direct links to all eight slides (one per line), your sources, and the story in three sentences.$t105e$, $t105f$[{"criterion": "Story and structure", "max_points": 30, "guidance": "Clear flow."}, {"criterion": "Design consistency", "max_points": 25, "guidance": "Template."}, {"criterion": "Honest data and sources", "max_points": 25, "guidance": "Verified."}, {"criterion": "Readability", "max_points": 20, "guidance": "One message per slide."}]$t105f$::jsonb, 120, 'link', true),
  (106, $t106a$Skill Lab: Photo retouching and cleanup with AI$t106a$, $t106b$Retouch a photo naturally.$t106b$, $t106c$Fix exposure and colour first, then remove distractions, then retouch skin or surfaces lightly. Use AI removal and generative fill for small areas and keep the original file. Natural beats perfect: leave texture.

**Worked example:** A product photo: brighten shadows, remove a stray cable with generative fill, match colour, keep the fabric texture.

**Common mistake:** Over-smoothing until the image looks plastic.

**Sharing images:** paste *direct* links ending .png/.jpg/.webp, one per line, and describe what they show.$t106c$, $t106d$Skill Lab: Photo retouching and cleanup with AI$t106d$, $t106e$Retouch two photos you own. Submit before and after direct links and a note listing each edit in order.$t106e$, $t106f$[{"criterion": "Natural result", "max_points": 40, "guidance": "Not over-processed."}, {"criterion": "Edits in sensible order", "max_points": 30, "guidance": "Listed."}, {"criterion": "Original kept", "max_points": 30, "guidance": "Confirmed."}]$t106f$::jsonb, 40, 'link', false),
  (107, $t107a$Skill Lab: Product photography with AI backgrounds$t107a$, $t107b$Create scenes for a real product honestly.$t107b$, $t107c$Photograph the real product on a plain surface with soft light from the side, then place it in a generated scene that matches light direction, colour and scale. Add a contact shadow. The product itself must remain accurate: do not generate a product that differs from what you sell.

**Worked example:** A ceramic mug photographed by a window, placed into a generated kitchen scene lit from the same side, with a soft shadow.

**Common mistake:** Letting the model change the product's shape or logo.

**Sharing images:** paste *direct* links ending .png/.jpg/.webp, one per line, and describe what they show.$t107c$, $t107d$Skill Lab: Product photography with AI backgrounds$t107d$, $t107e$Create three scenes for one real object. Submit direct links, your original photo and what you kept the same.$t107e$, $t107f$[{"criterion": "Product accurate", "max_points": 40, "guidance": "Unchanged."}, {"criterion": "Light matches", "max_points": 35, "guidance": "Believable."}, {"criterion": "Three scenes", "max_points": 25, "guidance": "Distinct."}]$t107f$::jsonb, 40, 'link', false),
  (108, $t108a$Skill Lab: Mockups: bringing designs into the real world$t108a$, $t108b$Present designs in context.$t108b$, $t108c$Mockups place your design on packaging, screens, signs or clothing. Use template mockups from your design tool, keep perspective and lighting consistent, and make sure the design is not distorted. Show several angles.

**Worked example:** A logo on a tote bag, a mug and a shopfront sign, all with the same soft daylight.

**Common mistake:** Stretching a logo to fit a mockup shape.

**Sharing images:** paste *direct* links ending .png/.jpg/.webp, one per line, and describe what they show.$t108c$, $t108d$Skill Lab: Mockups: bringing designs into the real world$t108d$, $t108e$Create four mockups of one design. Submit direct links and note any distortion you fixed.$t108e$, $t108f$[{"criterion": "Design accurate", "max_points": 40, "guidance": "Not stretched."}, {"criterion": "Consistent light and perspective", "max_points": 35, "guidance": "Believable."}, {"criterion": "Variety", "max_points": 25, "guidance": "Four contexts."}]$t108f$::jsonb, 40, 'link', false),
  (109, $t109a$Skill Lab: Packaging and label design$t109a$, $t109b$Design a label with required information and shelf impact.$t109b$, $t109c$Packaging must be seen from two metres and hold required information (name, ingredients, weights, legal marks that vary by country). Start with a dieline (the flat template), keep text inside safe margins, and plan for print with bleed and correct colour. Check the rules for your product type.

**Worked example:** A honey jar label: big name, small illustration, required details in a clear block, all inside safe margins on the printer's template.

**Common mistake:** Designing without the printer's dieline or legal information.

**Sharing images:** paste *direct* links ending .png/.jpg/.webp, one per line, and describe what they show.$t109c$, $t109d$Skill Lab: Packaging and label design$t109d$, $t109e$Design a label for a real or made-up product on a dieline. Submit direct links to the flat and a mockup and list the required information you included.$t109e$, $t109f$[{"criterion": "Fits the dieline", "max_points": 30, "guidance": "Margins and bleed."}, {"criterion": "Required info included", "max_points": 35, "guidance": "Complete."}, {"criterion": "Shelf impact", "max_points": 35, "guidance": "Clear from a distance."}]$t109f$::jsonb, 40, 'link', false),
  (110, $t110a$Skill Lab: Lab 4 project: a packaging concept$t110a$, $t110b$Deliver a packaging concept with product imagery and mockups.$t110b$, $t110c$Show Lab 4. Design a **packaging concept** for a product: label on a dieline, an honest product image, three mockups, and a one-page rationale.

Success looks like something a printer could quote from.

**Worked example:** Product: a small-batch chilli sauce. Bold label, real bottle photograph, mockups on a shelf, in a gift box and on a market stall.

**Common mistake:** Showing a mockup with no flat file a printer could use.

Your work is scored on the rubric below. You can revise and resubmit.

**Sharing images:** paste *direct* links ending .png/.jpg/.webp, one per line, and describe what they show.$t110c$, $t110d$Skill Lab: Lab 4 project: a packaging concept$t110d$, $t110e$Submit direct links to the dieline design, product image, three mockups, and your rationale (150 words) including print notes.$t110e$, $t110f$[{"criterion": "Design quality", "max_points": 30, "guidance": "Strong."}, {"criterion": "Print readiness", "max_points": 25, "guidance": "Dieline, margins."}, {"criterion": "Honest product depiction", "max_points": 25, "guidance": "Accurate."}, {"criterion": "Rationale", "max_points": 20, "guidance": "Reasoned."}]$t110f$::jsonb, 120, 'link', true),
  (111, $t111a$Skill Lab: The tool map: which tool for which job$t111a$, $t111b$Match tools to jobs.$t111b$, $t111c$No single tool does everything. Use image generators for concepts and assets, an editor for fixes, a layout tool for text and templates, a vector tool for logos, and a workspace like [CREAO](https://agent.creao.ai/@Sonofpeace) (referral link) to run repeatable workflows and agents. Others worth knowing include Firefly, Midjourney, Ideogram, Canva, Figma and Photopea.

Pick tools by the job and the licence, not the hype.

**Worked example:** Job: a menu with prices. Generate the food image in one tool, add all text in a layout tool, export a print PDF.

**Common mistake:** Trying to make text-heavy layouts inside an image generator.$t111c$, $t111d$Skill Lab: The tool map: which tool for which job$t111d$, $t111e$Build your own tool map: five jobs, the tool you would use, why and its licence for commercial use.$t111e$, $t111f$[{"criterion": "Jobs and tools matched", "max_points": 40, "guidance": "Sensible."}, {"criterion": "Reasons given", "max_points": 30, "guidance": "Specific."}, {"criterion": "Licence checked", "max_points": 30, "guidance": "Documented."}]$t111f$::jsonb, 40, 'text', false),
  (112, $t112a$Skill Lab: Prompt parameters and controls$t112a$, $t112b$Use the controls tools provide.$t112b$, $t112c$Beyond the words, tools give controls: aspect ratio, style strength, reference images, seeds, negative instructions and variation settings. Learn the two or three that matter in your main tool, change one at a time, and record what each did.

**Worked example:** Same prompt at 1:1 and 4:5, then with a reference image at low and high strength; a table records the differences.

**Common mistake:** Changing five settings at once and learning nothing.

**Sharing images:** paste *direct* links ending .png/.jpg/.webp, one per line, and describe what they show.$t112c$, $t112d$Skill Lab: Prompt parameters and controls$t112d$, $t112e$Run a controlled test of three settings in one tool on one prompt. Submit direct links and a table of what each changed.$t112e$, $t112f$[{"criterion": "Controlled test", "max_points": 40, "guidance": "One change at a time."}, {"criterion": "Results recorded", "max_points": 30, "guidance": "Table."}, {"criterion": "Lessons useful", "max_points": 30, "guidance": "Insight."}]$t112f$::jsonb, 40, 'link', false),
  (113, $t113a$Skill Lab: Speed and scale: batches, templates and automation$t113a$, $t113b$Produce many assets quickly.$t113b$, $t113c$Batch by preparing a prompt block, a naming scheme and a checklist. Generate in sets, pick the best, and edit in bulk. Use templates for repeat layouts, and automate repetitive steps with an agent where safe, keeping a person to approve.

**Worked example:** Twelve product images from one style block, checked against a five-point checklist, exported with consistent names.

**Common mistake:** Publishing a batch without checking each image.

**Sharing images:** paste *direct* links ending .png/.jpg/.webp, one per line, and describe what they show.$t113c$, $t113d$Skill Lab: Speed and scale: batches, templates and automation$t113d$, $t113e$Produce a batch of eight on-brand assets with a documented workflow. Submit direct links and your checklist and approval rate.$t113e$, $t113f$[{"criterion": "Consistent batch", "max_points": 40, "guidance": "On brand."}, {"criterion": "Workflow documented", "max_points": 30, "guidance": "Steps."}, {"criterion": "Quality checked", "max_points": 30, "guidance": "Approval rate."}]$t113f$::jsonb, 40, 'link', false),
  (114, $t114a$Skill Lab: Cost, credits and licences$t114a$, $t114b$Manage what you spend and what you may use.$t114b$, $t114c$Track credits per approved asset, set a monthly budget, and reuse assets. Read licences for commercial use, stock, fonts and generated content. Keep a record of prompts and sources in case of disputes.

**Worked example:** Ledger: 120 credits spent, 18 assets approved, 6.7 credits each; two fonts checked for commercial licence.

**Common mistake:** Not tracking spend until the credits run out.$t114c$, $t114d$Skill Lab: Cost, credits and licences$t114d$, $t114e$Create a cost and licence ledger for a project of at least ten assets.$t114e$, $t114f$[{"criterion": "Costs tracked", "max_points": 40, "guidance": "Numbers."}, {"criterion": "Licences checked", "max_points": 35, "guidance": "Real."}, {"criterion": "Records kept", "max_points": 25, "guidance": "Prompts and sources."}]$t114f$::jsonb, 40, 'text', false),
  (115, $t115a$Skill Lab: Lab 5 project: one brief, three tools$t115a$, $t115b$Compare tools honestly on the same job.$t115b$, $t115c$Show Lab 5. Take **one brief** and produce the asset with three different tool combinations, then compare quality, control, time, cost and licence.

Success looks like a fair test and a clear recommendation.

**Worked example:** Brief: a poster for a book fair, made with a generator + Canva, a different generator + Figma, and CREAO's workflow; time and credits recorded for each.

**Common mistake:** Comparing tools on different briefs.

Your work is scored on the rubric below. You can revise and resubmit.

**Sharing images:** paste *direct* links ending .png/.jpg/.webp, one per line, and describe what they show.$t115c$, $t115d$Skill Lab: Lab 5 project: one brief, three tools$t115d$, $t115e$Submit direct links to all three results, a comparison table (quality, control, time, cost, licence) and your recommendation.$t115e$, $t115f$[{"criterion": "Fair comparison", "max_points": 35, "guidance": "Same brief."}, {"criterion": "Evidence in table", "max_points": 30, "guidance": "Real measures."}, {"criterion": "Recommendation reasoned", "max_points": 20, "guidance": "Clear."}, {"criterion": "Quality of outputs", "max_points": 15, "guidance": "Good."}]$t115f$::jsonb, 120, 'link', true),
  (116, $t116a$Skill Lab: Portfolio that gets you hired$t116a$, $t116b$Build a portfolio that shows thinking, not just pictures.$t116b$, $t116c$Show three to five projects. For each: the brief, your role, the process (sketches, options, decisions), the result and what you learned. Label AI-assisted work honestly and say what you did by hand. Make it fast to load and easy to scan.

**Worked example:** A case study page: brief, three explored directions, chosen one with reasons, final mockups, a line on results.

**Common mistake:** Showing only finished images with no explanation.$t116c$, $t116d$Skill Lab: Portfolio that gets you hired$t116d$, $t116e$Publish or draft a portfolio page with two case studies. Submit the link (or direct images) and the case study text.$t116e$, $t116f$[{"criterion": "Process shown", "max_points": 40, "guidance": "Decisions."}, {"criterion": "Honest labelling", "max_points": 30, "guidance": "AI use stated."}, {"criterion": "Easy to scan", "max_points": 30, "guidance": "Clear layout."}]$t116f$::jsonb, 40, 'text', false),
  (117, $t117a$Skill Lab: Finding and pricing design work$t117a$, $t117b$Price and find your first clients.$t117b$, $t117c$Choose a niche (for example cafes or coaches), price by project with a clear scope, and find clients through people you know, communities and direct outreach that is personal and honest. Record every enquiry.

**Worked example:** Offer: brand starter kit for cafes, 450, two revision rounds, delivered in 10 days.

**Common mistake:** Pricing without a defined scope.$t117c$, $t117d$Skill Lab: Finding and pricing design work$t117d$, $t117e$Write your offer, price sheet and a ten-name outreach list with a reason for each.$t117e$, $t117f$[{"criterion": "Offer and scope clear", "max_points": 40, "guidance": "Defined."}, {"criterion": "Pricing reasoned", "max_points": 30, "guidance": "Logic."}, {"criterion": "Outreach realistic", "max_points": 30, "guidance": "Reasons."}]$t117f$::jsonb, 40, 'text', false),
  (118, $t118a$Skill Lab: Briefs, feedback and revisions$t118a$, $t118b$Run a design project smoothly.$t118b$, $t118c$Start with a written brief, agree the number of revision rounds, present options with reasoning, and take feedback against the goals rather than taste. Keep versions and approvals in writing.

**Worked example:** Feedback 'make it pop' becomes a question: 'Which element should stand out first?'

**Common mistake:** Redesigning after every comment with no agreed goals.$t118c$, $t118d$Skill Lab: Briefs, feedback and revisions$t118d$, $t118e$Write a design brief template and a feedback protocol, and test it on a friend's project. Submit both and what you learned.$t118e$, $t118f$[{"criterion": "Brief template usable", "max_points": 35, "guidance": "Complete."}, {"criterion": "Feedback protocol", "max_points": 35, "guidance": "Clear."}, {"criterion": "Tested for real", "max_points": 30, "guidance": "Evidence."}]$t118f$::jsonb, 40, 'text', false),
  (119, $t119a$Skill Lab: Rights, contracts and ethics for designers$t119a$, $t119b$Protect yourself and your clients.$t119b$, $t119c$Agree who owns the final work and when, whether AI tools were used, what happens to source files, and what you will not make (misleading, harmful or infringing work). Keep a record of licences. This is not legal advice; get a lawyer to review contracts.

**Worked example:** A one-page agreement: scope, payment, ownership on payment, AI-use disclosure, revision limit, cancellation.

**Common mistake:** Working with no written agreement.$t119c$, $t119d$Skill Lab: Rights, contracts and ethics for designers$t119d$, $t119e$Draft a one-page design agreement and an ethics statement (what you will not do).$t119e$, $t119f$[{"criterion": "Agreement covers key terms", "max_points": 40, "guidance": "Complete."}, {"criterion": "AI disclosure", "max_points": 30, "guidance": "Included."}, {"criterion": "Ethics statement", "max_points": 30, "guidance": "Specific."}]$t119f$::jsonb, 40, 'text', false),
  (120, $t120a$Skill Lab: Lab 6 project: your showcase$t120a$, $t120b$Present your best work and share it with the community.$t120b$, $t120c$Show Lab 6. Publish a **showcase**: three projects from the Skill Labs with process and results, your offer and price sheet, and an honest statement of how you use AI. Then share it in the NEXTGEN Discord and ask for one piece of feedback.

Success looks like something you would send to a real client.

**Worked example:** Showcase page: three case studies, a services section with prices, a short honest 'how I work' note, and a contact button.

**Common mistake:** Sharing without asking for feedback.

Your work is scored on the rubric below. You can revise and resubmit.

**Sharing images:** paste *direct* links ending .png/.jpg/.webp, one per line, and describe what they show.$t120c$, $t120d$Skill Lab: Lab 6 project: your showcase$t120d$, $t120e$Submit direct links to your best three images, a link or text of the showcase, and a 150-word reflection on what you would improve next.$t120e$, $t120f$[{"criterion": "Quality of work", "max_points": 30, "guidance": "Professional."}, {"criterion": "Process and honesty", "max_points": 25, "guidance": "Shown."}, {"criterion": "Business readiness", "max_points": 25, "guidance": "Offer and terms."}, {"criterion": "Reflection", "max_points": 20, "guidance": "Specific."}]$t120f$::jsonb, 150, 'link', true)
) as v(n, title, objective, lesson_md, skill_focus, assignment_md, rubric, est_minutes, submission_type, ai_evaluate)
where t.slug = 'graphics'
on conflict (track_id, day_number) do nothing;
