-- Graphics & design, Basic tier (days 1-30). Authored content, UNPUBLISHED until a person reviews it in Admin.
insert into public.day
  (track_id, tier_id, day_number, title, objective, lesson_md, skill_focus, assignment_md, rubric,
   est_minutes, is_published, credit_budget, submission_type, ai_evaluate)
select t.id, ti.id, v.n, v.title, v.objective, v.lesson_md, v.skill_focus, v.assignment_md, v.rubric,
       v.est_minutes, false, null, v.submission_type, v.ai_evaluate
from public.track t
join public.tier ti on ti.track_id = t.id and ti.slug = 'basic'
cross join (values
  (1, $t1a$What image AI does: from words to pictures$t1a$, $t1b$Generate your first image and compare it honestly with the idea in your head.$t1b$, $t1c$Image AI turns a text description into a picture, or edits a picture you give it. It learned from huge numbers of images and captions, so it is good at common subjects and styles, and less reliable with exact text, precise counts, hands and specific real people or brands.

Three things you can do:

- **Text to image:** describe it and get a picture.
- **Image to image:** change an existing picture.
- **Image plus text:** give a reference and describe the change.

Your job is **art direction**: decide what the image is for, then describe it clearly.

We use CREAO first because it can generate images and run your whole workflow in one place ([sign up here](https://agent.creao.ai/@Sonofpeace), a referral link). Other good options include Ideogram, Nano Banana (Gemini), Midjourney and Adobe Firefly. The skills are the same in all of them.

**How to share an image:** paste a *direct* link that ends in .png, .jpg or .webp (for example, upload it to Discord, right-click the image and copy its link, or use an image host). A link to a web page cannot be viewed by the scorer.$t1c$, $t1d$Prompting an image and judging the result$t1d$, $t1e$Generate one simple image in any tool. Submit:

1. The direct image link.
2. The tool you used.
3. The exact prompt.
4. Two sentences: what matched your idea, and what did not?$t1e$, $t1f$[{"criterion": "Prompt is recorded and clear", "max_points": 30, "guidance": "The exact prompt is given and says what is in the picture."}, {"criterion": "Honest comparison to the idea", "max_points": 40, "guidance": "Says what matched and what did not."}, {"criterion": "Image and tool shared correctly", "max_points": 30, "guidance": "A working direct image link and the tool name."}]$t1f$::jsonb, 20, 'link', false),
  (2, $t2a$Subject and action: say what is in the frame$t2a$, $t2b$Show how detail changes the picture by writing the same idea three ways.$t2b$, $t2c$Start with **who or what, doing what, where.** "A street vendor" is vague; "A middle-aged street vendor arranging oranges into a pyramid at a sunny outdoor market" is clear.

Be concrete about the number of subjects, age, clothing and objects, the action, the place and the time of day. Leave out what you do not need: extra details compete with each other.

Try one sentence for the main subject and one for the setting.

**How to share an image:** paste a *direct* link that ends in .png, .jpg or .webp (for example, upload it to Discord, right-click the image and copy its link, or use an image host). A link to a web page cannot be viewed by the scorer.$t2c$, $t2d$Describing subject and action$t2d$, $t2e$Generate the same idea three times with increasing detail (vague, clear, precise). Submit:

1. The three prompts.
2. Three direct image links.
3. One sentence on which detail changed the result most.$t2e$, $t2f$[{"criterion": "Detail increases across prompts", "max_points": 30, "guidance": "Each prompt is clearly more specific than the last."}, {"criterion": "Images shared and comparable", "max_points": 30, "guidance": "Three working links."}, {"criterion": "Insight", "max_points": 40, "guidance": "Says which detail mattered and why."}]$t2f$::jsonb, 20, 'link', false),
  (3, $t3a$Style and medium: photo, illustration, 3D, flat$t3a$, $t3b$Steer the look with medium and style words.$t3b$, $t3c$Style words steer the look: "photograph", "watercolour illustration", "3D render", "flat vector", "cinematic still", "pencil sketch". Name the **medium** first, then details (lens, brushwork, materials).

Avoid naming living artists to copy their exact style. Describe the qualities instead ("soft pastel palette, thick outlines, playful proportions").

Keep one style per image. Mixing five styles produces mush.

**How to share an image:** paste a *direct* link that ends in .png, .jpg or .webp (for example, upload it to Discord, right-click the image and copy its link, or use an image host). A link to a web page cannot be viewed by the scorer.$t3c$, $t3d$Choosing a visual style$t3d$, $t3e$Use one subject and four styles. Submit:

1. The subject sentence.
2. Four prompts and four direct image links.
3. For each style, what you would use it for (for example a poster, an app icon or a thumbnail).$t3e$, $t3f$[{"criterion": "Styles are clearly different", "max_points": 35, "guidance": "The four images look like different media."}, {"criterion": "Qualities, not artist names", "max_points": 25, "guidance": "Describes the look instead of copying an artist."}, {"criterion": "Matched to a use", "max_points": 40, "guidance": "Each style has a sensible purpose."}]$t3f$::jsonb, 20, 'link', false),
  (4, $t4a$Light, colour and mood$t4a$, $t4b$Set the feeling of an image with light, palette and mood words.$t4b$, $t4c$Light and colour set the feeling.

- **Light:** "soft window light", "golden hour", "harsh midday sun", "neon at night", "studio lighting with soft shadows".
- **Palette:** "warm earthy tones", "high-contrast black and yellow", "pastel blues and pinks".
- **Mood:** calm, energetic, luxurious, mysterious.

Keep it consistent: warm light with a cold palette confuses the picture. Contrast helps readability: a light subject on a darker background, or the other way round.

**How to share an image:** paste a *direct* link that ends in .png, .jpg or .webp (for example, upload it to Discord, right-click the image and copy its link, or use an image host). A link to a web page cannot be viewed by the scorer.$t4c$, $t4d$Directing light and colour$t4d$, $t4e$Generate one subject with three different light and mood combinations. Submit the three prompts, three direct image links, and which mood fits which brand or audience.$t4e$, $t4f$[{"criterion": "Light and palette named clearly", "max_points": 35, "guidance": "Each prompt states light, colours and mood."}, {"criterion": "Moods are distinct", "max_points": 35, "guidance": "The three feel different."}, {"criterion": "Fit to audience", "max_points": 30, "guidance": "Ties each mood to a real audience."}]$t4f$::jsonb, 20, 'link', false),
  (5, $t5a$Composition and aspect ratio: frame for the platform$t5a$, $t5b$Match the shape and framing of an image to where it will be used.$t5b$, $t5c$Composition is where things sit. Useful terms: close-up, wide shot, low angle, overhead, centred, rule of thirds and **negative space** (empty area for text).

Aspect ratio matches the platform:

- **1:1** square feed posts
- **4:5** portrait feed posts
- **9:16** stories and reels
- **16:9** landscape (YouTube thumbnails, slides)

Ask for it in the prompt or the tool setting. If you plan to add text, ask for "plenty of empty space at the top" so the words have room.

**How to share an image:** paste a *direct* link that ends in .png, .jpg or .webp (for example, upload it to Discord, right-click the image and copy its link, or use an image host). A link to a web page cannot be viewed by the scorer.$t5c$, $t5d$Composition and ratio$t5d$, $t5e$Generate two images of the same subject for two platforms, with different ratios and compositions. Submit the links, the prompts, and which platform each is for.$t5e$, $t5f$[{"criterion": "Ratio matches the platform", "max_points": 35, "guidance": "Shape suits the stated use."}, {"criterion": "Space left for text where needed", "max_points": 35, "guidance": "Composition leaves room."}, {"criterion": "Composition described on purpose", "max_points": 30, "guidance": "Prompts name framing choices."}]$t5f$::jsonb, 20, 'link', false),
  (6, $t6a$Module project: one subject, five styles$t6a$, $t6b$Show you can control style, light and composition on demand.$t6b$, $t6c$Show Module 1. Choose one subject and produce **five images** that demonstrate control: different style, light and composition, each described in a clear prompt.

Success looks like five images that are clearly different on purpose, each matching its prompt, and you can explain which one you would use for what.

Your work is scored on the rubric below. You can revise and resubmit.

**How to share an image:** paste a *direct* link that ends in .png, .jpg or .webp (for example, upload it to Discord, right-click the image and copy its link, or use an image host). A link to a web page cannot be viewed by the scorer.$t6c$, $t6d$Controlling image generation$t6d$, $t6e$Submit:

1. Direct links to five images (one per line).
2. The prompt for each.
3. A short paragraph (3 to 5 sentences): which image you would use for a poster, a profile picture and a thumbnail, and why.$t6e$, $t6f$[{"criterion": "Prompts are clear and specific", "max_points": 25, "guidance": "Each says subject, style, light and framing."}, {"criterion": "Images match prompts and differ on purpose", "max_points": 35, "guidance": "Five distinct results that follow their prompts."}, {"criterion": "Purposeful use choices", "max_points": 25, "guidance": "Sensible reasons for each use."}, {"criterion": "Links work", "max_points": 15, "guidance": "All five images can be viewed."}]$t6f$::jsonb, 45, 'link', true),
  (7, $t7a$Why text breaks in images$t7a$, $t7b$Learn two reliable ways to get clean text.$t7b$, $t7c$Image AI draws letters as shapes, not as words, so text can come out garbled, misspelled or wrong. Newer tools are better, and some (like Ideogram) are built for text, but you must still check every letter.

Strategies:

- Keep text short (1 to 5 words) and put it in quotes in the prompt.
- Ask for a plain background behind it.
- Or leave empty space and add the text later in a design tool.

Always proofread letter by letter.

**How to share an image:** paste a *direct* link that ends in .png, .jpg or .webp (for example, upload it to Discord, right-click the image and copy its link, or use an image host). A link to a web page cannot be viewed by the scorer.$t7c$, $t7d$Getting reliable text$t7d$, $t7e$Try the same short text (three words) two ways: generated inside the image, and added afterwards in a design tool. Submit both direct image links, the prompts, and which was cleaner and why.$t7e$, $t7f$[{"criterion": "Both methods tried", "max_points": 40, "guidance": "One generated text, one added text."}, {"criterion": "Result compared honestly", "max_points": 35, "guidance": "Notes spelling and clarity problems."}, {"criterion": "Prompts recorded", "max_points": 25, "guidance": "Exact prompts are given."}]$t7f$::jsonb, 20, 'link', false),
  (8, $t8a$Headlines that survive: short, high contrast$t8a$, $t8b$Write and place a headline that is readable in a second.$t8b$, $t8c$A headline should be readable in a second. Keep it under 8 words, use a big, bold font, and high contrast against the background (dark on light or light on dark).

Test it: shrink the image to phone size. Can you still read the headline? If not, it is too small, too long or too low in contrast.

Write five headline options (you or AI) and pick the one that says the most in the fewest words.

**How to share an image:** paste a *direct* link that ends in .png, .jpg or .webp (for example, upload it to Discord, right-click the image and copy its link, or use an image host). A link to a web page cannot be viewed by the scorer.$t8c$, $t8d$Headline writing and contrast$t8d$, $t8e$For a real or made-up event or product, submit:

1. Five headline options.
2. The one you chose and why.
3. A direct link to an image with your headline on it.$t8e$, $t8f$[{"criterion": "Headline is short and clear", "max_points": 40, "guidance": "Under 8 words and easy to grasp."}, {"criterion": "High contrast and readable", "max_points": 35, "guidance": "Readable at phone size."}, {"criterion": "Choice is reasoned", "max_points": 25, "guidance": "Explains why this option won."}]$t8f$::jsonb, 20, 'link', false),
  (9, $t9a$Layout basics: hierarchy, alignment, space$t9a$, $t9b$Plan where the eye goes first, second and third.$t9b$, $t9c$**Hierarchy** tells the eye where to look: a big headline, a smaller subhead, a small call to action. **Alignment:** line things up (left aligned is safest). **Space:** leave breathing room; crowded designs look cheap.

Rules of thumb: one focal point per design, no more than two fonts, no more than three colours plus neutrals.

Sketch first: three boxes on paper (headline, image, button) beats guessing.

**How to share an image:** paste a *direct* link that ends in .png, .jpg or .webp (for example, upload it to Discord, right-click the image and copy its link, or use an image host). A link to a web page cannot be viewed by the scorer.$t9c$, $t9d$Layout hierarchy$t9d$, $t9e$Submit a photo or drawing of your layout sketch (direct link), a short description of the hierarchy (what is first, second, third), and a link to a simple design that follows it.$t9e$, $t9f$[{"criterion": "Sketch and hierarchy are clear", "max_points": 40, "guidance": "First, second and third focus are named."}, {"criterion": "Design follows the plan", "max_points": 35, "guidance": "The finished design matches the sketch."}, {"criterion": "Space and alignment", "max_points": 25, "guidance": "Not crowded, lined up."}]$t9f$::jsonb, 20, 'link', false),
  (10, $t10a$Add text afterwards: the reliable method$t10a$, $t10b$Combine a clean AI image with perfect text in a design tool.$t10b$, $t10c$Two methods: (1) generate with the text inside the image; (2) generate a clean image with empty space, then add text in a design tool (Canva, Photopea or Figma). Method 2 is more reliable and gives perfect spelling and fonts.

Use method 2 for anything important (names, prices, dates). Export the final as one image.

**How to share an image:** paste a *direct* link that ends in .png, .jpg or .webp (for example, upload it to Discord, right-click the image and copy its link, or use an image host). A link to a web page cannot be viewed by the scorer.$t10c$, $t10d$Combining image and text$t10d$, $t10e$Make a poster using method 2. Submit a direct link to the final image, the tool you used, every piece of text you added, and how you proofread it.$t10e$, $t10f$[{"criterion": "Method 2 used well", "max_points": 35, "guidance": "A clean image with text added afterwards."}, {"criterion": "Text is correct", "max_points": 40, "guidance": "No spelling mistakes; texts are listed."}, {"criterion": "Proofreading described", "max_points": 25, "guidance": "Says how you checked."}]$t10f$::jsonb, 20, 'link', false),
  (11, $t11a$Templates: reuse what works$t11a$, $t11b$Build a layout you can reuse so a set feels consistent.$t11b$, $t11c$Templates save time and keep things consistent: same layout, fonts and colours, new content. In your design tool, save your best layout as a template or duplicate it.

Define your rules: headline size, subhead size, margins, logo position. Reuse them for every post so it looks like one brand.

Do not copy other people's templates or brand assets without permission; use the ones your tool provides under their licence.

**How to share an image:** paste a *direct* link that ends in .png, .jpg or .webp (for example, upload it to Discord, right-click the image and copy its link, or use an image host). A link to a web page cannot be viewed by the scorer.$t11c$, $t11d$Reusable layouts$t11d$, $t11e$Create a template and use it twice with two different messages. Submit both direct image links and list what stays fixed and what changes.$t11e$, $t11f$[{"criterion": "Two designs share a template", "max_points": 40, "guidance": "Same layout, different content."}, {"criterion": "Fixed and changing parts listed", "max_points": 35, "guidance": "Clear about what stays the same."}, {"criterion": "Both designs are readable", "max_points": 25, "guidance": "Text is legible on both."}]$t11f$::jsonb, 20, 'link', false),
  (12, $t12a$Module project: a poster with headline, subhead and call to action$t12a$, $t12b$Design one clear, readable poster from a real brief.$t12b$, $t12c$Show Module 2. Design **one poster** for a real or made-up event, offer or launch: a strong image, a short headline, a subhead and one call to action (CTA) such as "Register today". Use a 4:5 or 9:16 ratio.

Success looks like: readable at phone size, a clear hierarchy, perfect spelling, and an image that supports the message.

Your work is scored on the rubric below. You can revise and resubmit.

**How to share an image:** paste a *direct* link that ends in .png, .jpg or .webp (for example, upload it to Discord, right-click the image and copy its link, or use an image host). A link to a web page cannot be viewed by the scorer.$t12c$, $t12d$Designing a poster$t12d$, $t12e$Submit:

1. A direct link to the final poster.
2. The brief (audience and goal).
3. The exact text on the poster.
4. A short description of your layout choices.$t12e$, $t12f$[{"criterion": "Fits the brief", "max_points": 30, "guidance": "The poster suits its audience and goal."}, {"criterion": "Hierarchy", "max_points": 25, "guidance": "Headline, subhead and CTA are clearly ordered."}, {"criterion": "Legibility and spelling", "max_points": 25, "guidance": "Readable at phone size and free of mistakes."}, {"criterion": "Image supports the message", "max_points": 20, "guidance": "The picture helps rather than distracts."}]$t12f$::jsonb, 50, 'link', true),
  (13, $t13a$Common AI mistakes$t13a$, $t13b$Build a habit of checking images for the usual flaws.$t13b$, $t13c$Look for: hands and fingers, faces that look slightly off, garbled text, extra objects, melted details, inconsistent shadows, the wrong number of items and strange reflections.

Zoom to 200 percent before you accept an image, and check edges and small details.

A checklist habit: hands, faces, text, edges and logic (does it make sense?).

**How to share an image:** paste a *direct* link that ends in .png, .jpg or .webp (for example, upload it to Discord, right-click the image and copy its link, or use an image host). A link to a web page cannot be viewed by the scorer.$t13c$, $t13d$Quality-checking images$t13d$, $t13e$Generate three images and zoom-check each. Submit the direct links, the flaws you found in each (and how serious), and whether you would fix or regenerate.$t13e$, $t13f$[{"criterion": "Flaws found with the checklist", "max_points": 40, "guidance": "Specific problems, not just it looks fine."}, {"criterion": "Severity judged", "max_points": 30, "guidance": "Distinguishes small from serious flaws."}, {"criterion": "Fix or regenerate decision", "max_points": 30, "guidance": "A sensible call for each image."}]$t13f$::jsonb, 20, 'link', false),
  (14, $t14a$Edit, do not restart$t14a$, $t14b$Fix one flaw with a targeted edit and keep everything else.$t14b$, $t14c$When an image is about 80 percent right, edit instead of starting over. Many tools can change part of an image or follow an instruction such as "keep everything the same but change the jacket to red." Be specific about what stays the same.

Rule: change one thing at a time.

**How to share an image:** paste a *direct* link that ends in .png, .jpg or .webp (for example, upload it to Discord, right-click the image and copy its link, or use an image host). A link to a web page cannot be viewed by the scorer.$t14c$, $t14d$Targeted editing$t14d$, $t14e$Take one image with one flaw and fix it with a targeted edit. Submit the before and after links, the edit prompt, and what you kept the same.$t14e$, $t14f$[{"criterion": "Edit is targeted", "max_points": 40, "guidance": "Only the flawed part changed."}, {"criterion": "Rest of the image preserved", "max_points": 35, "guidance": "Everything else looks the same."}, {"criterion": "Prompt is specific", "max_points": 25, "guidance": "Says what to change and what to keep."}]$t14f$::jsonb, 20, 'link', false),
  (15, $t15a$Backgrounds: remove, replace, extend$t15a$, $t15b$Cut out a subject and place it convincingly in a new scene.$t15b$, $t15c$Common background jobs: **remove** the background (a clean cut-out), **replace** it (place the subject in a new scene) and **extend** it (add space around the image for text or a different ratio).

Check edges (hair, fur, glass) after removal. Match light direction and colour when you place a subject into a new background, or it will look pasted on.

**How to share an image:** paste a *direct* link that ends in .png, .jpg or .webp (for example, upload it to Discord, right-click the image and copy its link, or use an image host). A link to a web page cannot be viewed by the scorer.$t15c$, $t15d$Background editing$t15d$, $t15e$Cut out a subject and place it on two different backgrounds. Submit the links and notes on how you matched the light.$t15e$, $t15f$[{"criterion": "Clean cut-out", "max_points": 35, "guidance": "Edges are tidy."}, {"criterion": "Light matched to the new scene", "max_points": 40, "guidance": "Direction and colour fit."}, {"criterion": "Two backgrounds shown", "max_points": 25, "guidance": "Both results are shared."}]$t15f$::jsonb, 20, 'link', false),
  (16, $t16a$Light and colour corrections$t16a$, $t16b$Apply small corrections that make an image look professional.$t16b$, $t16c$Small corrections make images look professional: brightness, contrast, warmth and saturation. Do not overdo it. Compare with the original.

For a set of images, apply the same adjustments so they look like siblings.

Free tools such as Photopea, Canva or your phone's editor can do all of this.

**How to share an image:** paste a *direct* link that ends in .png, .jpg or .webp (for example, upload it to Discord, right-click the image and copy its link, or use an image host). A link to a web page cannot be viewed by the scorer.$t16c$, $t16d$Basic correction$t16d$, $t16e$Correct an image. Submit the before and after links and the settings you changed, with the reason for each.$t16e$, $t16f$[{"criterion": "Visible improvement", "max_points": 40, "guidance": "The after is better."}, {"criterion": "Not overdone", "max_points": 30, "guidance": "Natural look."}, {"criterion": "Settings and reasons listed", "max_points": 30, "guidance": "Says what changed and why."}]$t16f$::jsonb, 20, 'link', false),
  (17, $t17a$Upscale and clean up$t17a$, $t17b$Increase resolution and remove small blemishes safely.$t17b$, $t17c$Generated images are often small. **Upscaling** increases the resolution (with AI adding detail) for print or large screens. Check the result: upscalers can add odd textures or change faces.

**Clean up:** remove small blemishes, stray objects and noise. Keep your original files.

**How to share an image:** paste a *direct* link that ends in .png, .jpg or .webp (for example, upload it to Discord, right-click the image and copy its link, or use an image host). A link to a web page cannot be viewed by the scorer.$t17c$, $t17d$Upscaling and cleanup$t17d$, $t17e$Upscale one image. Submit both links, the resolution before and after, and any artefacts you noticed and how you handled them.$t17e$, $t17f$[{"criterion": "Resolution increased", "max_points": 35, "guidance": "Before and after sizes are given."}, {"criterion": "Artefacts noticed", "max_points": 40, "guidance": "Honest about what the upscaler changed."}, {"criterion": "Cleanup done", "max_points": 25, "guidance": "Small flaws were removed."}]$t17f$::jsonb, 20, 'link', false),
  (18, $t18a$Module project: fix a flawed image$t18a$, $t18b$Turn an image with real flaws into a clean, natural result.$t18b$, $t18c$Show Module 3. Start with an image that has at least **three real flaws** (generate one and keep the mistakes). Then fix them using targeted edits, background work and corrections.

Success looks like: the after is clearly better, the edits look natural, and you can explain each fix.

Your work is scored on the rubric below. You can revise and resubmit.

**How to share an image:** paste a *direct* link that ends in .png, .jpg or .webp (for example, upload it to Discord, right-click the image and copy its link, or use an image host). A link to a web page cannot be viewed by the scorer.$t18c$, $t18d$Repairing an image$t18d$, $t18e$Submit:

1. Direct links to the before and the after.
2. A list of at least three flaws with the fix for each.
3. The prompts or settings you used.$t18e$, $t18f$[{"criterion": "Flaws identified", "max_points": 25, "guidance": "Real, specific problems."}, {"criterion": "Fixes are effective and natural", "max_points": 40, "guidance": "The after looks right."}, {"criterion": "Process documented", "max_points": 20, "guidance": "Prompts and settings are given."}, {"criterion": "Before and after clear", "max_points": 15, "guidance": "Both links work and can be compared."}]$t18f$::jsonb, 50, 'link', true),
  (19, $t19a$Sizes for social, print and web$t19a$, $t19b$Export one design at the right sizes for different uses.$t19b$, $t19c$Common sizes: square post 1080 by 1080; portrait post 1080 by 1350; story or reel 1080 by 1920; YouTube thumbnail 1280 by 720; slide 1920 by 1080. Print uses a higher resolution (about 300 dpi at the printed size).

Platforms change their specs, so check the current size before you publish. Keep important content away from the edges (safe margins).

**How to share an image:** paste a *direct* link that ends in .png, .jpg or .webp (for example, upload it to Discord, right-click the image and copy its link, or use an image host). A link to a web page cannot be viewed by the scorer.$t19c$, $t19d$Exporting for platforms$t19d$, $t19e$Export one design in three sizes for three uses. Submit the links, the sizes, and what you moved or cropped for each.$t19e$, $t19f$[{"criterion": "Sizes fit the uses", "max_points": 40, "guidance": "Dimensions suit each platform."}, {"criterion": "Safe margins respected", "max_points": 30, "guidance": "Nothing important is cut off."}, {"criterion": "Adjustments explained", "max_points": 30, "guidance": "Says what moved or was cropped."}]$t19f$::jsonb, 20, 'link', false),
  (20, $t20a$File formats$t20a$, $t20b$Choose the right format for each job.$t20b$, $t20c$**PNG:** sharp graphics, text and transparency. **JPG:** photos, smaller files. **WebP:** efficient for the web. **PDF:** print and multi-page documents. **SVG:** logos and icons that scale (vector).

Choose by use: a post is usually PNG or JPG; a website wants an optimised WebP or JPG; a printer wants a high-resolution PDF or PNG. Watch the file size (under a few megabytes for social).

**How to share an image:** paste a *direct* link that ends in .png, .jpg or .webp (for example, upload it to Discord, right-click the image and copy its link, or use an image host). A link to a web page cannot be viewed by the scorer.$t20c$, $t20d$Choosing formats$t20d$, $t20e$Export the same image as PNG and as JPG. Submit both links, the file sizes, and where you would use each and why.$t20e$, $t20f$[{"criterion": "Both formats produced", "max_points": 35, "guidance": "Two working links."}, {"criterion": "File sizes compared", "max_points": 35, "guidance": "Actual sizes are given."}, {"criterion": "Use cases are sensible", "max_points": 30, "guidance": "Explains which suits what."}]$t20f$::jsonb, 20, 'link', false),
  (21, $t21a$One look across a set: a mini style guide$t21a$, $t21b$Write a one-page style card that keeps a set consistent.$t21b$, $t21c$A style guide keeps a set consistent: a **palette** (3 to 5 colours with hex codes), **fonts** (heading and body), the **image mood** (light, colour, style) and **layout rules** (margins, logo place).

Make a one-page style card: name, palette, fonts, three mood words and a sample. Use it in every prompt: *Palette: deep blue #1E3A8A and warm yellow #FACC15.* Consistency is what makes people trust a brand.

**How to share an image:** paste a *direct* link that ends in .png, .jpg or .webp (for example, upload it to Discord, right-click the image and copy its link, or use an image host). A link to a web page cannot be viewed by the scorer.$t21c$, $t21d$Creating a style card$t21d$, $t21e$Make a style card. Submit a direct link to it and the text version of the guide (palette with hex codes, fonts, mood words, layout rules).$t21e$, $t21f$[{"criterion": "Palette and fonts specified", "max_points": 40, "guidance": "Hex codes and named fonts."}, {"criterion": "Mood and layout rules", "max_points": 30, "guidance": "Clear rules someone else could follow."}, {"criterion": "Card is readable", "max_points": 30, "guidance": "Well laid out and legible."}]$t21f$::jsonb, 20, 'link', false),
  (22, $t22a$Reuse a style: references and repeat prompts$t22a$, $t22b$Produce several images that look like they belong together.$t22b$, $t22c$To repeat a look: (1) reuse the same prompt structure and style words; (2) use a reference image (one you generated or own) so the tool follows its style; (3) keep the same seed or settings if the tool supports it.

Change one variable at a time (the subject) and keep the rest. Check the set side by side: do they look like siblings?

**How to share an image:** paste a *direct* link that ends in .png, .jpg or .webp (for example, upload it to Discord, right-click the image and copy its link, or use an image host). A link to a web page cannot be viewed by the scorer.$t22c$, $t22d$Consistency across images$t22d$, $t22e$Make three images in one style. Submit the links, the shared prompt structure, and what stayed the same versus what changed.$t22e$, $t22f$[{"criterion": "Looks like a set", "max_points": 45, "guidance": "The three share a clear style."}, {"criterion": "Prompt structure is shared", "max_points": 30, "guidance": "Reused wording is visible."}, {"criterion": "Constant and changing parts listed", "max_points": 25, "guidance": "Clear about what varied."}]$t22f$::jsonb, 20, 'link', false),
  (23, $t23a$Rights, disclosure and safe use$t23a$, $t23b$Write your own rules for using AI images responsibly.$t23b$, $t23c$Know the rules:

- Check the tool's licence for **commercial use**.
- Do not generate or use images of real people without consent, and never make misleading or intimate images of anyone.
- Do not copy logos or trademarked characters.
- Label AI-made images where a platform or client requires it.

Some tools emphasise commercially safer training data, but always read the current terms. Never use AI to deceive people (fake news, fake endorsements).$t23c$, $t23d$Responsible image use$t23d$, $t23e$Write a short rights checklist of five rules for yourself, and check the licence of the tool you use. Submit both, quoting one relevant line from the licence and linking to it.$t23e$, $t23f$[{"criterion": "Rules are concrete", "max_points": 40, "guidance": "Five rules you could actually follow."}, {"criterion": "Licence actually checked", "max_points": 40, "guidance": "Quotes a real line and links to it."}, {"criterion": "Covers consent and disclosure", "max_points": 20, "guidance": "Mentions real people and labelling."}]$t23f$::jsonb, 20, 'text', false),
  (24, $t24a$Module project: a matched two-piece set with a style card$t24a$, $t24b$Create two graphics that clearly belong together, plus the style card that explains them.$t24b$, $t24c$Show Module 4. Create **two graphics** that clearly belong together (for example a feed post and a story) with a one-page style card, exported at the correct sizes in suitable formats.

Success looks like: obviously the same brand, the right sizes, and a style card someone else could use.

Your work is scored on the rubric below. You can revise and resubmit.

**How to share an image:** paste a *direct* link that ends in .png, .jpg or .webp (for example, upload it to Discord, right-click the image and copy its link, or use an image host). A link to a web page cannot be viewed by the scorer.$t24c$, $t24d$Building a consistent set$t24d$, $t24e$Submit:

1. Direct links to the two graphics.
2. A link to the style card (or its text).
3. The sizes and formats you used.
4. One sentence about the tool licence for commercial use.$t24e$, $t24f$[{"criterion": "Consistency across the set", "max_points": 35, "guidance": "Clearly one brand."}, {"criterion": "Style card is usable", "max_points": 25, "guidance": "Someone else could follow it."}, {"criterion": "Technical correctness", "max_points": 25, "guidance": "Right sizes and formats."}, {"criterion": "Rights note", "max_points": 15, "guidance": "Mentions the licence honestly."}]$t24f$::jsonb, 55, 'link', true),
  (25, $t25a$Capstone 1: brief and audience$t25a$, $t25b$Plan a three-graphic social set for a brand.$t25b$, $t25c$The capstone brings it all together: a **three-graphic social set**. Choose a real or made-up brand (a bakery, a study group, a fitness coach). Write the brief: audience, goal (for example announce a launch) and tone. Plan the three graphics: a feed post (4:5), a story (9:16) and a thumbnail (16:9), and decide the message for each.$t25c$, $t25d$Planning a campaign$t25d$, $t25e$Submit your brief (audience, goal, tone) and the three graphics you will make with the message of each.$t25e$, $t25f$[{"criterion": "Brief is specific", "max_points": 40, "guidance": "A named audience, a clear goal and a tone."}, {"criterion": "Plan is realistic", "max_points": 30, "guidance": "Three achievable graphics."}, {"criterion": "Fits the audience", "max_points": 30, "guidance": "Messages suit the readers."}]$t25f$::jsonb, 20, 'text', false),
  (26, $t26a$Capstone 2: moodboard and style card$t26a$, $t26b$Gather references and define the look of the set.$t26b$, $t26c$Gather five to eight references (colours, styles, layouts) and make your style card: palette with hex codes, fonts, mood words and layout rules. Write a sample prompt you will reuse.

**How to share an image:** paste a *direct* link that ends in .png, .jpg or .webp (for example, upload it to Discord, right-click the image and copy its link, or use an image host). A link to a web page cannot be viewed by the scorer.$t26c$, $t26d$Defining a visual identity$t26d$, $t26e$Submit a description or links for your moodboard, a link to your style card, and your reusable sample prompt.$t26e$, $t26f$[{"criterion": "Moodboard is focused", "max_points": 30, "guidance": "References share a clear direction."}, {"criterion": "Style card is complete", "max_points": 40, "guidance": "Palette, fonts, mood and layout rules."}, {"criterion": "Reusable prompt", "max_points": 30, "guidance": "A prompt structure you can reuse."}]$t26f$::jsonb, 20, 'link', false),
  (27, $t27a$Capstone 3: generate and choose the hero graphic$t27a$, $t27b$Create several options and pick the best with a checklist.$t27b$, $t27c$Generate at least eight options for your feed post. Choose using a checklist: subject, style, light, composition, space for text, and flaws (hands, faces, edges). Keep notes on why you chose the winner.

**How to share an image:** paste a *direct* link that ends in .png, .jpg or .webp (for example, upload it to Discord, right-click the image and copy its link, or use an image host). A link to a web page cannot be viewed by the scorer.$t27c$, $t27d$Selecting with judgment$t27d$, $t27e$Submit direct links to your top three options, the prompts, your chosen one, and your reasons.$t27e$, $t27f$[{"criterion": "Options explored", "max_points": 30, "guidance": "At least three distinct candidates."}, {"criterion": "Checklist applied", "max_points": 40, "guidance": "Reasons refer to the checklist."}, {"criterion": "Choice fits the brief", "max_points": 30, "guidance": "The winner suits the audience and goal."}]$t27f$::jsonb, 20, 'link', false),
  (28, $t28a$Capstone 4: build the story and the thumbnail$t28a$, $t28b$Extend the look to the other two graphics.$t28b$, $t28c$Make the story (9:16) and the thumbnail (16:9) in the same style, using your reusable prompt and reference image. Add text afterwards in a design tool and keep the layout rules from your style card.

**How to share an image:** paste a *direct* link that ends in .png, .jpg or .webp (for example, upload it to Discord, right-click the image and copy its link, or use an image host). A link to a web page cannot be viewed by the scorer.$t28c$, $t28d$Extending a style$t28d$, $t28e$Submit direct links to the story and the thumbnail, and the text on each.$t28e$, $t28f$[{"criterion": "Matches the hero graphic", "max_points": 40, "guidance": "Clearly the same set."}, {"criterion": "Text is correct and readable", "max_points": 35, "guidance": "No mistakes; readable at phone size."}, {"criterion": "Ratios are right", "max_points": 25, "guidance": "Story and thumbnail have the correct shape."}]$t28f$::jsonb, 20, 'link', false),
  (29, $t29a$Capstone 5: polish and export$t29a$, $t29b$Fix flaws, check the text and export at the right sizes.$t29b$, $t29c$Zoom-check every graphic for flaws. Apply small corrections consistently. Proofread all text. Export at the correct sizes and formats and run your rights check (tool licence, real people, logos).

**How to share an image:** paste a *direct* link that ends in .png, .jpg or .webp (for example, upload it to Discord, right-click the image and copy its link, or use an image host). A link to a web page cannot be viewed by the scorer.$t29c$, $t29d$Finishing to a professional standard$t29d$, $t29e$Submit direct links to the three final graphics, the sizes and formats, and confirmation of your proofreading and rights check.$t29e$, $t29f$[{"criterion": "Flaws fixed", "max_points": 35, "guidance": "No obvious mistakes."}, {"criterion": "Sizes and formats are right", "max_points": 35, "guidance": "Suit each use."}, {"criterion": "Proofreading and rights check", "max_points": 30, "guidance": "Both are described."}]$t29f$::jsonb, 20, 'link', false),
  (30, $t30a$Capstone 6: publish and share$t30a$, $t30b$Publish your set and ask the community for feedback.$t30b$, $t30c$Publish your set (or a mock feed) somewhere real, then share it in the NEXTGEN Discord and ask for one piece of feedback. Sharing is part of the skill: viewers show you what works.

Submit your final three graphics for scoring. Your work is scored on the rubric below, and you can revise and resubmit.

**How to share an image:** paste a *direct* link that ends in .png, .jpg or .webp (for example, upload it to Discord, right-click the image and copy its link, or use an image host). A link to a web page cannot be viewed by the scorer.$t30c$, $t30d$Publishing and feedback$t30d$, $t30e$Submit:

1. Direct links to your three final graphics (one per line).
2. Your brief and a link to your style card.
3. A short note (3 to 5 sentences) on what changed between your first drafts and the final versions.

Then share the set in the Discord.$t30e$, $t30f$[{"criterion": "Fits the brief", "max_points": 30, "guidance": "The set suits the audience and goal."}, {"criterion": "Hierarchy and composition", "max_points": 25, "guidance": "Clear focus and good framing."}, {"criterion": "Text legibility", "max_points": 25, "guidance": "Readable and correct."}, {"criterion": "Consistency", "max_points": 20, "guidance": "The three clearly belong together."}]$t30f$::jsonb, 55, 'link', true)
) as v(n, title, objective, lesson_md, skill_focus, assignment_md, rubric, est_minutes, submission_type, ai_evaluate)
where t.slug = 'graphics'
on conflict (track_id, day_number) do nothing;
