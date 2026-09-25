-- Sample prompts: full camera angles, lenses, lighting, moves, grades, transitions and shot recipes for video;
-- stills camera/lighting; and new categories (apps, research and data, motion graphics, business and brand).
-- Idempotent: safe to re-run.
insert into public.prompt_categories (slug, name, description, sort_order) values ($c$apps-tools$c$, $c$Apps & tools$c$, $c$Prompts for planning, building, testing and shipping small tools.$c$, 8) on conflict (slug) do nothing;
insert into public.prompt_categories (slug, name, description, sort_order) values ($c$research-data$c$, $c$Research & data$c$, $c$Prompts for finding, checking and explaining evidence.$c$, 9) on conflict (slug) do nothing;
insert into public.prompt_categories (slug, name, description, sort_order) values ($c$motion-graphics$c$, $c$Motion graphics$c$, $c$Prompts for titles, logos, explainers and social motion.$c$, 10) on conflict (slug) do nothing;
insert into public.prompt_categories (slug, name, description, sort_order) values ($c$business-brand$c$, $c$Business & brand$c$, $c$Prompts for brand identity and client delivery.$c$, 11) on conflict (slug) do nothing;
insert into public.prompt_subcategories (category_id, slug, name, sort_order)
select c.id, $s$camera-angles-by-name$s$, $s$Camera angles, one by one$s$, coalesce((select max(sort_order) from public.prompt_subcategories x where x.category_id=c.id),0)+1
from public.prompt_categories c where c.slug=$s$video$s$ on conflict (category_id, slug) do nothing;
insert into public.prompts (subcategory_id, title, body, swap_note, difficulty, sort_order)
select s.id, v.title, v.body, v.swap_note, v.difficulty, v.ord
from public.prompt_subcategories s
join public.prompt_categories c on c.id=s.category_id and c.slug=$s$video$s$
cross join (values
  ($p1a$Eye-level shot$p1a$, $p1b$Eye-level shot of [subject] [doing action] in [setting], camera at the subject's eye height, natural and neutral, [lighting], [style].$p1b$, $p1c$swap: use for calm, honest, documentary-feeling moments.$p1c$, 'beginner', 1),
  ($p2a$Low-angle shot$p2a$, $p2b$Low-angle shot looking up at [subject] standing in [setting], camera near the ground, [subject] appears powerful and tall, sky or ceiling visible behind, [lighting].$p2b$, $p2c$swap: lower the camera further for more drama.$p2c$, 'beginner', 2),
  ($p3a$High-angle shot$p3a$, $p3b$High-angle shot looking down at [subject] in [setting], camera above eye level, [subject] appears small and vulnerable, [lighting], [style].$p3b$, $p3c$swap: raise the angle to nearly overhead for a stronger effect.$p3c$, 'beginner', 3),
  ($p4a$Bird's-eye (top-down) shot$p4a$, $p4b$Bird's-eye view, camera directly overhead looking straight down at [scene], patterns and layout clearly visible, [lighting], [style].$p4b$, $p4c$swap: use for maps, food, product flat-lays and crowd movement.$p4c$, 'beginner', 4),
  ($p5a$Worm's-eye shot$p5a$, $p5b$Worm's-eye view from ground level looking straight up at [subject or building], strong converging lines, [sky or ceiling], [lighting].$p5b$, $p5c$swap: add a wide lens for exaggerated perspective.$p5c$, 'intermediate', 5),
  ($p6a$Dutch angle (tilted horizon)$p6a$, $p6b$Dutch angle, the camera tilted 20 degrees so the horizon is slanted, [subject] in [tense setting], unsettling mood, [lighting].$p6b$, $p6c$swap: keep the tilt small for unease, large for chaos.$p6c$, 'intermediate', 6),
  ($p7a$Over-the-shoulder shot$p7a$, $p7b$Over-the-shoulder shot from behind [person A], we see the back of their head and shoulder in the foreground, [person B] facing us in sharp focus, [setting], [lighting].$p7b$, $p7c$swap: reverse it for the matching shot in a conversation.$p7c$, 'beginner', 7),
  ($p8a$Point-of-view (POV) shot$p8a$, $p8b$First-person point-of-view shot, we see [what the character sees] as if through their eyes, hands visible at the bottom of frame, [action], [setting].$p8b$, $p8c$swap: add a slight handheld shake for realism.$p8c$, 'beginner', 8),
  ($p9a$Close-up$p9a$, $p9b$Close-up of [subject's face or object], filling the frame, [emotion or detail], shallow depth of field, [lighting].$p9b$, $p9c$swap: use for emotion (faces) or important details (objects).$p9c$, 'beginner', 9),
  ($p10a$Extreme close-up$p10a$, $p10b$Extreme close-up of [an eye, a hand, a texture, a button], macro detail, [lighting], shallow depth of field, [style].$p10b$, $p10c$swap: use to build tension or show a critical detail.$p10c$, 'intermediate', 10),
  ($p11a$Medium shot$p11a$, $p11b$Medium shot of [subject] from the waist up, [action], [setting] visible behind, balanced framing, [lighting].$p11b$, $p11c$swap: the everyday shot for dialogue and demos.$p11c$, 'beginner', 11),
  ($p12a$Wide shot$p12a$, $p12b$Wide shot showing [subject] small within [large setting], the whole environment visible, [time of day], [lighting].$p12b$, $p12c$swap: use to establish place and scale.$p12c$, 'beginner', 12),
  ($p13a$Extreme wide (establishing) shot$p13a$, $p13b$Extreme wide establishing shot of [city, landscape or building], [subject] barely visible, sweeping scale, [time of day], [weather].$p13b$, $p13c$swap: open a scene with this before cutting closer.$p13c$, 'beginner', 13),
  ($p14a$Two-shot$p14a$, $p14b$Two-shot framing [person A] and [person B] side by side in one frame, [relationship or tension], [setting], [lighting].$p14b$, $p14c$swap: change their distance to show closeness or conflict.$p14c$, 'beginner', 14),
  ($p15a$Cowboy (medium-long) shot$p15a$, $p15b$Cowboy shot framing [subject] from mid-thigh up, [gesture or prop] visible, [setting], confident stance, [lighting].$p15b$, $p15c$swap: use for action, confidence and showing props.$p15c$, 'intermediate', 15),
  ($p16a$Insert shot$p16a$, $p16b$Insert shot of [object, e.g. a phone screen, a key, a letter] on [surface], sharp focus, [lighting], no people in frame.$p16b$, $p16c$swap: cut to this to give the viewer key information.$p16c$, 'beginner', 16),
  ($p17a$Reaction shot$p17a$, $p17b$Close-up reaction shot of [person] reacting to [event], the emotion [surprise, joy, dread] visible on their face, [lighting], shallow depth of field.$p17b$, $p17c$swap: hold the shot longer for stronger emotion.$p17c$, 'beginner', 17),
  ($p18a$Profile (side) shot$p18a$, $p18b$Profile shot of [subject] from the side, [action], strong silhouette of their face, [lighting from behind or side].$p18b$, $p18c$swap: use for thoughtful or dignified moments.$p18c$, 'intermediate', 18)
) as v(title, body, swap_note, difficulty, ord)
where s.slug=$s$camera-angles-by-name$s$
  and not exists (select 1 from public.prompts p where p.subcategory_id=s.id and p.title=v.title);
insert into public.prompt_subcategories (category_id, slug, name, sort_order)
select c.id, $s$lenses-depth-of-field$s$, $s$Lenses & depth of field$s$, coalesce((select max(sort_order) from public.prompt_subcategories x where x.category_id=c.id),0)+1
from public.prompt_categories c where c.slug=$s$video$s$ on conflict (category_id, slug) do nothing;
insert into public.prompts (subcategory_id, title, body, swap_note, difficulty, sort_order)
select s.id, v.title, v.body, v.swap_note, v.difficulty, v.ord
from public.prompt_subcategories s
join public.prompt_categories c on c.id=s.category_id and c.slug=$s$video$s$
cross join (values
  ($p19a$Wide-angle lens (24mm)$p19a$, $p19b$[Subject] in [setting], shot on a 24mm wide-angle lens, expansive view, slight perspective stretch at the edges, [lighting].$p19b$, $p19c$swap: go wider (16mm) for interiors and dramatic space.$p19c$, 'beginner', 1),
  ($p20a$Standard lens (35mm)$p20a$, $p20b$[Subject] in [setting], shot on a 35mm lens, natural human-eye perspective, documentary look, [lighting].$p20b$, $p20c$swap: 35mm is a safe default for realistic scenes.$p20c$, 'beginner', 2),
  ($p21a$Portrait lens (85mm)$p21a$, $p21b$Portrait of [person] shot on an 85mm lens, flattering compression, creamy blurred background, [lighting].$p21b$, $p21c$swap: use for interviews and beautiful close-ups.$p21c$, 'beginner', 3),
  ($p22a$Telephoto compression (135mm+)$p22a$, $p22b$[Subject] seen through a 200mm telephoto lens, background compressed close behind them, layers of [buildings or crowd] stacked, [lighting].$p22b$, $p22c$swap: use to make distant things look close together.$p22c$, 'intermediate', 4),
  ($p23a$Fisheye lens$p23a$, $p23b$Fisheye lens view of [subject or scene], strong barrel distortion, the edges curved, energetic and playful, [setting].$p23b$, $p23c$swap: use sparingly for skate, music-video or action looks.$p23c$, 'intermediate', 5),
  ($p24a$Macro lens$p24a$, $p24b$Macro shot of [tiny subject], extreme detail, razor-thin focus plane, [surface texture], [lighting].$p24b$, $p24c$swap: great for food, products and nature.$p24c$, 'intermediate', 6),
  ($p25a$Anamorphic look$p25a$, $p25b$[Subject] in [setting], anamorphic lens look, horizontal blue lens flares, oval bokeh, wide cinematic frame 2.39:1.$p25b$, $p25c$swap: add 'subtle' to keep the flares gentle.$p25c$, 'intermediate', 7),
  ($p26a$Shallow depth of field$p26a$, $p26b$[Subject] in sharp focus, background heavily blurred with soft bokeh, shallow depth of field at f/1.8, [lighting].$p26b$, $p26c$swap: use to separate a subject from a busy background.$p26c$, 'beginner', 8),
  ($p27a$Deep focus$p27a$, $p27b$Deep focus shot, everything from foreground to background sharp at f/11, [subject] and [background element] both clearly visible, [setting].$p27b$, $p27c$swap: use when foreground and background both matter.$p27c$, 'intermediate', 9),
  ($p28a$Rack focus$p28a$, $p28b$Rack focus from [foreground object] in sharp focus to [background subject], the first blurs as the second sharpens, [setting].$p28b$, $p28c$swap: use to move the viewer's attention within a shot.$p28c$, 'intermediate', 10),
  ($p29a$Tilt-shift miniature look$p29a$, $p29b$Tilt-shift photography look of [city or scene] from above, thin band of focus, saturated colours, the scene looks like a miniature model.$p29b$, $p29c$swap: use for playful time-lapse style shots.$p29c$, 'intermediate', 11),
  ($p30a$Vintage lens character$p30a$, $p30b$[Subject] in [setting], shot on a vintage 1970s lens, soft edges, gentle halation and low contrast, warm nostalgic feel.$p30b$, $p30c$swap: pair with film grain for a period look.$p30c$, 'advanced', 12)
) as v(title, body, swap_note, difficulty, ord)
where s.slug=$s$lenses-depth-of-field$s$
  and not exists (select 1 from public.prompts p where p.subcategory_id=s.id and p.title=v.title);
insert into public.prompt_subcategories (category_id, slug, name, sort_order)
select c.id, $s$lighting-setups$s$, $s$Lighting setups$s$, coalesce((select max(sort_order) from public.prompt_subcategories x where x.category_id=c.id),0)+1
from public.prompt_categories c where c.slug=$s$video$s$ on conflict (category_id, slug) do nothing;
insert into public.prompts (subcategory_id, title, body, swap_note, difficulty, sort_order)
select s.id, v.title, v.body, v.swap_note, v.difficulty, v.ord
from public.prompt_subcategories s
join public.prompt_categories c on c.id=s.category_id and c.slug=$s$video$s$
cross join (values
  ($p31a$Three-point lighting$p31a$, $p31b$[Person] lit with classic three-point lighting: a soft key light from the front left, a fill light at half strength from the right, and a rim light behind for separation, [setting].$p31b$, $p31c$swap: use for interviews and corporate video.$p31c$, 'beginner', 1),
  ($p32a$Rembrandt lighting$p32a$, $p32b$Portrait of [person] with Rembrandt lighting: key light at 45 degrees above, a small triangle of light on the shadow-side cheek, dark moody background.$p32b$, $p32c$swap: add a subtle fill to lift the shadows.$p32c$, 'intermediate', 2),
  ($p33a$Butterfly (paramount) lighting$p33a$, $p33b$Beauty shot of [person] with butterfly lighting: a soft key directly above the camera, a small shadow under the nose, glamorous and even.$p33b$, $p33c$swap: use for fashion and beauty scenes.$p33c$, 'intermediate', 3),
  ($p34a$Split lighting$p34a$, $p34b$[Person] lit with split lighting, one half of the face fully lit and the other half in deep shadow, dramatic and mysterious.$p34b$, $p34c$swap: use for villains, tension or duality.$p34c$, 'intermediate', 4),
  ($p35a$Rim / backlight$p35a$, $p35b$[Subject] backlit with a bright rim light outlining their hair and shoulders, the face slightly darker, glowing edge, [setting].$p35b$, $p35c$swap: add haze so the light beams show.$p35c$, 'beginner', 5),
  ($p36a$Silhouette$p36a$, $p36b$Silhouette of [subject] against a bright [sunset, window, or neon sign], no facial detail, strong shape, [setting].$p36b$, $p36c$swap: keep the pose clear so the silhouette reads.$p36c$, 'beginner', 6),
  ($p37a$High-key lighting$p37a$, $p37b$[Subject] in a bright, high-key setup, soft even light, minimal shadows, white or light background, clean and cheerful.$p37b$, $p37c$swap: use for ads, comedy and lifestyle.$p37c$, 'beginner', 7),
  ($p38a$Low-key lighting$p38a$, $p38b$[Subject] in low-key lighting, mostly shadow with one narrow light source, high contrast, moody, [setting].$p38b$, $p38c$swap: use for thrillers, drama and noir.$p38c$, 'beginner', 8),
  ($p39a$Chiaroscuro$p39a$, $p39b$[Subject] in a chiaroscuro scene, strong contrast between light and dark, a single window or candle as the source, painterly, [setting].$p39b$, $p39c$swap: reference an oil-painting mood for richer results.$p39c$, 'advanced', 9),
  ($p40a$Golden hour$p40a$, $p40b$[Subject] at golden hour, warm low sun from the side, long soft shadows, glowing highlights in the hair, [setting].$p40b$, $p40c$swap: use for romance, nostalgia and hope.$p40c$, 'beginner', 10),
  ($p41a$Blue hour$p41a$, $p41b$[Subject] at blue hour just after sunset, cool blue ambient light with warm lights glowing in windows, calm and reflective.$p41b$, $p41c$swap: add city lights for contrast.$p41c$, 'beginner', 11),
  ($p42a$Harsh midday sun$p42a$, $p42b$[Subject] under harsh midday sun, strong overhead light, hard short shadows, bleached highlights, hot and tense, [setting].$p42b$, $p42c$swap: use for deserts, heat and stress.$p42c$, 'intermediate', 12),
  ($p43a$Overcast soft light$p43a$, $p43b$[Subject] outdoors on an overcast day, soft diffused light with no hard shadows, muted colours, even and natural.$p43b$, $p43c$swap: ideal for flattering, natural portraits.$p43c$, 'beginner', 13),
  ($p44a$Neon / cyberpunk glow$p44a$, $p44b$[Subject] at night in a rainy street lit by pink and cyan neon signs, colourful reflections on wet pavement, high contrast.$p44b$, $p44c$swap: choose two neon colours and stick to them.$p44c$, 'beginner', 14),
  ($p45a$Candlelight / firelight$p45a$, $p45b$[Subject] lit only by candlelight, warm flickering orange glow on the face, deep dark surroundings, intimate mood.$p45b$, $p45c$swap: use fireplace light for cosy scenes.$p45c$, 'intermediate', 15),
  ($p46a$Practical lights$p46a$, $p46b$[Scene] lit by practical lights visible in the frame: a table lamp, a neon sign and a TV glow, natural motivated lighting.$p46b$, $p46c$swap: name each lamp so the model places them.$p46c$, 'intermediate', 16),
  ($p47a$Volumetric light / god rays$p47a$, $p47b$[Setting] with volumetric light, visible beams of sunlight through [windows or trees] and floating dust or haze, atmospheric.$p47b$, $p47c$swap: use fog or smoke for stronger beams.$p47c$, 'intermediate', 17),
  ($p48a$Moonlight$p48a$, $p48b$[Subject] in a forest lit by cold moonlight, silver-blue tones, soft shadows, mist near the ground, quiet and eerie.$p48b$, $p48c$swap: add a small warm lantern for contrast.$p48c$, 'beginner', 18),
  ($p49a$Studio softbox product light$p49a$, $p49b$[Product] on a clean surface, lit by a large softbox from the left with a white bounce card on the right, soft shadow, seamless background.$p49b$, $p49c$swap: add a gradient background for a premium look.$p49c$, 'beginner', 19),
  ($p50a$Car headlights at night$p50a$, $p50b$[Subject] standing on a dark road lit by strong car headlights from behind, dust in the beams, dramatic silhouette edges.$p50b$, $p50c$swap: use for suspense and thriller scenes.$p50c$, 'intermediate', 20),
  ($p51a$Screen glow$p51a$, $p51b$[Person] in a dark room lit only by the cold blue glow of a [laptop or phone] screen, reflections in their eyes, isolated mood.$p51b$, $p51c$swap: use for tech, late-night and hacker scenes.$p51c$, 'beginner', 21),
  ($p52a$Under-lighting (horror)$p52a$, $p52b$[Person] lit from below with a hard light, unnatural shadows upward on the face, eerie horror atmosphere, dark background.$p52b$, $p52c$swap: use rarely; it reads as scary or comic.$p52c$, 'intermediate', 22),
  ($p53a$Top light / interrogation$p53a$, $p53b$[Person] sitting under a single hard overhead lamp in a dark room, deep eye shadows, tense interrogation mood.$p53b$, $p53c$swap: swing the lamp slightly for movement.$p53c$, 'intermediate', 23)
) as v(title, body, swap_note, difficulty, ord)
where s.slug=$s$lighting-setups$s$
  and not exists (select 1 from public.prompts p where p.subcategory_id=s.id and p.title=v.title);
insert into public.prompt_subcategories (category_id, slug, name, sort_order)
select c.id, $s$camera-moves-ready$s$, $s$Camera moves, ready to paste$s$, coalesce((select max(sort_order) from public.prompt_subcategories x where x.category_id=c.id),0)+1
from public.prompt_categories c where c.slug=$s$video$s$ on conflict (category_id, slug) do nothing;
insert into public.prompts (subcategory_id, title, body, swap_note, difficulty, sort_order)
select s.id, v.title, v.body, v.swap_note, v.difficulty, v.ord
from public.prompt_subcategories s
join public.prompt_categories c on c.id=s.category_id and c.slug=$s$video$s$
cross join (values
  ($p54a$Dolly in$p54a$, $p54b$Slow dolly in toward [subject], the camera moving smoothly forward, growing intimacy, [setting], [lighting].$p54b$, $p54c$swap: speed it up for urgency.$p54c$, 'beginner', 1),
  ($p55a$Dolly out (pull back)$p55a$, $p55b$Slow dolly out from [detail], the camera pulling back to reveal [wider context], smooth and steady.$p55b$, $p55c$swap: use to reveal a surprise.$p55c$, 'beginner', 2),
  ($p56a$Truck / tracking sideways$p56a$, $p56b$Tracking shot, the camera moves sideways alongside [subject] walking through [setting], smooth, keeping them centred.$p56b$, $p56c$swap: match the camera speed to their walking pace.$p56c$, 'beginner', 3),
  ($p57a$Pan$p57a$, $p57b$Slow pan from left to right across [scene], the camera rotating on a fixed point, revealing [element] at the end.$p57b$, $p57c$swap: reverse the direction to change the feeling.$p57c$, 'beginner', 4),
  ($p58a$Tilt$p58a$, $p58b$Tilt up from [ground element] to [tall subject or sky], the camera pivoting vertically, slow and steady.$p58b$, $p58c$swap: tilt down to reveal something small.$p58c$, 'beginner', 5),
  ($p59a$Crane / jib shot$p59a$, $p59b$Crane shot rising from [close on subject] to a high wide view of [setting], smooth and sweeping, cinematic.$p59b$, $p59c$swap: reverse it to end close on the subject.$p59c$, 'intermediate', 6),
  ($p60a$Handheld$p60a$, $p60b$Handheld camera following [subject], slight natural shake, documentary feel, [setting], [action].$p60b$, $p60c$swap: reduce 'shake' to 'subtle' to avoid nausea.$p60c$, 'beginner', 7),
  ($p61a$Steadicam follow$p61a$, $p61b$Smooth steadicam shot following [subject] from behind as they walk through [long corridor or market], the environment flowing past.$p61b$, $p61c$swap: use for long continuous takes.$p61c$, 'intermediate', 8),
  ($p62a$Orbit / arc shot$p62a$, $p62b$Orbit shot, the camera circles 180 degrees around [subject], keeping them centred while the background rotates, [lighting].$p62b$, $p62c$swap: use for hero reveals and product spins.$p62c$, 'intermediate', 9),
  ($p63a$Whip pan$p63a$, $p63b$Fast whip pan from [subject A] to [subject B] with heavy motion blur in between, energetic transition.$p63b$, $p63c$swap: use as a stylish transition.$p63c$, 'intermediate', 10),
  ($p64a$Dolly zoom (vertigo effect)$p64a$, $p64b$Dolly zoom on [subject], the camera moves backward while the lens zooms in, the background stretches, unsettling realisation.$p64b$, $p64c$swap: use for moments of shock or dread.$p64c$, 'advanced', 11),
  ($p65a$Push-in on a face$p65a$, $p65b$Slow push-in on [person's] face as they realise [event], the camera creeping closer over 6 seconds, shallow depth of field.$p65b$, $p65c$swap: hold longer for stronger emotion.$p65c$, 'beginner', 12),
  ($p66a$Drone reveal$p66a$, $p66b$Drone shot rising and moving forward over [ridge or building] to reveal [landscape or city], smooth, golden hour.$p66b$, $p66c$swap: use for openings and location shots.$p66c$, 'beginner', 13),
  ($p67a$Slow motion$p67a$, $p67b$Slow motion shot of [action, e.g. water splashing, hair blowing], 120 fps look, every droplet visible, [lighting].$p67b$, $p67c$swap: use for impact and beauty moments.$p67c$, 'beginner', 14),
  ($p68a$Timelapse$p68a$, $p68b$Timelapse of [clouds, city traffic, or sunrise] over [setting], fast-moving light and shadow, fixed camera.$p68b$, $p68c$swap: use to show the passage of time.$p68c$, 'beginner', 15),
  ($p69a$Static locked-off shot$p69a$, $p69b$Locked-off static shot of [scene], the camera perfectly still, action unfolding in frame, [lighting].$p69b$, $p69c$swap: stillness adds tension and calm.$p69c$, 'beginner', 16)
) as v(title, body, swap_note, difficulty, ord)
where s.slug=$s$camera-moves-ready$s$
  and not exists (select 1 from public.prompts p where p.subcategory_id=s.id and p.title=v.title);
insert into public.prompt_subcategories (category_id, slug, name, sort_order)
select c.id, $s$colour-grade-look$s$, $s$Colour grade & film look$s$, coalesce((select max(sort_order) from public.prompt_subcategories x where x.category_id=c.id),0)+1
from public.prompt_categories c where c.slug=$s$video$s$ on conflict (category_id, slug) do nothing;
insert into public.prompts (subcategory_id, title, body, swap_note, difficulty, sort_order)
select s.id, v.title, v.body, v.swap_note, v.difficulty, v.ord
from public.prompt_subcategories s
join public.prompt_categories c on c.id=s.category_id and c.slug=$s$video$s$
cross join (values
  ($p70a$Teal and orange$p70a$, $p70b$[Scene] with a teal and orange colour grade, cool teal shadows and warm orange skin tones, blockbuster look.$p70b$, $p70c$swap: keep skin natural; push teal only in the shadows.$p70c$, 'beginner', 1),
  ($p71a$Warm nostalgic film$p71a$, $p71b$[Scene] with warm faded colours, soft contrast, gentle film grain, golden tones, nostalgic memory feel.$p71b$, $p71c$swap: lift the blacks for a vintage look.$p71c$, 'beginner', 2),
  ($p72a$Cold desaturated thriller$p72a$, $p72b$[Scene] with a cold, desaturated grade, blue-grey tones, crushed shadows, tense and bleak.$p72b$, $p72c$swap: keep one warm colour as a focal accent.$p72c$, 'beginner', 3),
  ($p73a$Bleach bypass$p73a$, $p73b$[Scene] with a bleach bypass look, high contrast, low saturation, gritty metallic tones, war-film feel.$p73b$, $p73c$swap: use for tough, raw stories.$p73c$, 'intermediate', 4),
  ($p74a$Black and white$p74a$, $p74b$Black and white [subject and scene], deep blacks, rich mid-tones, fine film grain, timeless contrast.$p74b$, $p74c$swap: add 'high contrast noir' for drama.$p74c$, 'beginner', 5),
  ($p75a$Pastel dreamy$p75a$, $p75b$[Scene] in soft pastel colours, low contrast, gentle glow, dreamy and light, pink and mint palette.$p75b$, $p75c$swap: use for beauty, kids and fashion.$p75c$, 'beginner', 6),
  ($p76a$35mm film stock$p76a$, $p76b$[Scene] shot on 35mm film, visible grain, gentle halation around highlights, rich but natural colours.$p76b$, $p76c$swap: name a stock like Kodak Portra for warmer skin.$p76c$, 'intermediate', 7),
  ($p77a$VHS / retro tape$p77a$, $p77b$[Scene] with a VHS tape look, scanlines, soft colour bleed, tracking glitches and date stamp, 1990s home video.$p77b$, $p77c$swap: use for found-footage and nostalgia.$p77c$, 'beginner', 8),
  ($p78a$Cyberpunk palette$p78a$, $p78b$[Scene] in a cyberpunk palette, magenta and cyan glow, deep purple shadows, wet reflections, futuristic.$p78b$, $p78c$swap: reduce saturation for a subtler look.$p78c$, 'beginner', 9),
  ($p79a$Day-for-night$p79a$, $p79b$[Scene] with a day-for-night look, blue-tinted, underexposed, moonlit feel, soft shadows, shot in daylight.$p79b$, $p79c$swap: add practical lights to sell the illusion.$p79c$, 'intermediate', 10),
  ($p80a$Clean commercial look$p80a$, $p80b$[Product or person] with a clean commercial grade, bright, high clarity, neutral colours, crisp and modern.$p80b$, $p80c$swap: match the brand colour in the accent.$p80c$, 'beginner', 11)
) as v(title, body, swap_note, difficulty, ord)
where s.slug=$s$colour-grade-look$s$
  and not exists (select 1 from public.prompts p where p.subcategory_id=s.id and p.title=v.title);
insert into public.prompt_subcategories (category_id, slug, name, sort_order)
select c.id, $s$transitions-effects$s$, $s$Transitions & effects$s$, coalesce((select max(sort_order) from public.prompt_subcategories x where x.category_id=c.id),0)+1
from public.prompt_categories c where c.slug=$s$video$s$ on conflict (category_id, slug) do nothing;
insert into public.prompts (subcategory_id, title, body, swap_note, difficulty, sort_order)
select s.id, v.title, v.body, v.swap_note, v.difficulty, v.ord
from public.prompt_subcategories s
join public.prompt_categories c on c.id=s.category_id and c.slug=$s$video$s$
cross join (values
  ($p81a$Match cut$p81a$, $p81b$Match cut from [round object A, e.g. a spinning coin] to [round object B, e.g. a planet], the same shape and position linking the two shots.$p81b$, $p81c$swap: match by movement or shape.$p81c$, 'intermediate', 1),
  ($p82a$Smash cut$p82a$, $p82b$Smash cut from a quiet close-up of [subject] to a loud chaotic [wide scene], sudden change in sound and energy.$p82b$, $p82c$swap: use for shock or comedy.$p82c$, 'intermediate', 2),
  ($p83a$Fade to black$p83a$, $p83b$Slow fade to black at the end of [scene], the image dissolving into darkness over 2 seconds.$p83b$, $p83c$swap: fade to white for a dreamy or heavenly ending.$p83c$, 'beginner', 3),
  ($p84a$Cross dissolve$p84a$, $p84b$Cross dissolve between [scene A] and [scene B], the images blending, time passing gently.$p84b$, $p84c$swap: use for time shifts and memories.$p84c$, 'beginner', 4),
  ($p85a$Morph transition$p85a$, $p85b$[Object A] smoothly morphs into [object B], continuous shape change with the same framing, seamless.$p85b$, $p85c$swap: keep both objects centred for a smooth morph.$p85c$, 'intermediate', 5),
  ($p86a$Light leak$p86a$, $p86b$Warm orange light leaks flashing across [scene], overexposed edges, analogue film feel.$p86b$, $p86c$swap: use as a soft transition between shots.$p86c$, 'beginner', 6),
  ($p87a$Freeze frame$p87a$, $p87b$Freeze frame on [moment], the action stops, colour slightly boosted, ready for a title to appear.$p87b$, $p87c$swap: add a stamp of text for a retro feel.$p87c$, 'beginner', 7),
  ($p88a$Glitch effect$p88a$, $p88b$[Scene] with a digital glitch effect, RGB split, pixel blocks, brief stutters, cyber feel.$p88b$, $p88c$swap: use as a short accent, not throughout.$p88c$, 'beginner', 8),
  ($p89a$Speed ramp$p89a$, $p89b$Speed ramp during [action]: normal speed, then slow motion at the moment of impact, then back to normal.$p89b$, $p89c$swap: use for sports and stunts.$p89c$, 'intermediate', 9),
  ($p90a$Split screen$p90a$, $p90b$Split screen showing [scene A] on the left and [scene B] on the right at the same time, matching timing.$p90b$, $p90c$swap: use for comparisons and phone calls.$p90c$, 'intermediate', 10)
) as v(title, body, swap_note, difficulty, ord)
where s.slug=$s$transitions-effects$s$
  and not exists (select 1 from public.prompts p where p.subcategory_id=s.id and p.title=v.title);
insert into public.prompt_subcategories (category_id, slug, name, sort_order)
select c.id, $s$shot-recipes$s$, $s$Complete shot recipes$s$, coalesce((select max(sort_order) from public.prompt_subcategories x where x.category_id=c.id),0)+1
from public.prompt_categories c where c.slug=$s$video$s$ on conflict (category_id, slug) do nothing;
insert into public.prompts (subcategory_id, title, body, swap_note, difficulty, sort_order)
select s.id, v.title, v.body, v.swap_note, v.difficulty, v.ord
from public.prompt_subcategories s
join public.prompt_categories c on c.id=s.category_id and c.slug=$s$video$s$
cross join (values
  ($p91a$The universal shot formula$p91a$, $p91b$[Shot type and angle] of [subject] [action] in [setting], [lighting], shot on [lens], [camera movement], [colour grade or style], [mood].$p91b$, $p91c$swap: fill every slot; leave one out to let the model surprise you.$p91c$, 'beginner', 1),
  ($p92a$Product hero ad$p92a$, $p92b$Slow orbit around [product] on a reflective black surface, low-key lighting with a soft rim light, macro details, water droplets, premium commercial look, 4K.$p92b$, $p92c$swap: change the surface to match the brand.$p92c$, 'beginner', 2),
  ($p93a$Talking-head interview$p93a$, $p93b$Medium close-up of [person] seated, three-point lighting, 85mm lens, shallow depth of field, soft office background, calm and confident.$p93b$, $p93c$swap: change the background to show their industry.$p93c$, 'beginner', 3),
  ($p94a$Action chase$p94a$, $p94b$Handheld tracking shot following [runner] through [crowded market], fast, quick cuts, motion blur, harsh midday sun, urgent energy.$p94b$, $p94c$swap: use a drone for a wider chase.$p94c$, 'intermediate', 4),
  ($p95a$Horror reveal$p95a$, $p95b$Slow push-in down a dark corridor, low-key lighting with one flickering bulb, a [figure] slowly appearing at the end, cold desaturated grade, dread.$p95b$, $p95c$swap: keep the figure partly hidden for more fear.$p95c$, 'intermediate', 5),
  ($p96a$Romantic moment$p96a$, $p96b$Two-shot of [couple] at golden hour, warm rim light, shallow depth of field, slow dolly in, soft pastel warm grade, tender mood.$p96b$, $p96c$swap: use a close-up of their hands for intimacy.$p96c$, 'beginner', 6),
  ($p97a$Documentary b-roll$p97a$, $p97b$Handheld medium shots of [person doing a real task] in [workplace], natural window light, 35mm lens, authentic, slightly imperfect framing.$p97b$, $p97c$swap: add close-ups of hands for variety.$p97c$, 'beginner', 7),
  ($p98a$Music video moment$p98a$, $p98b$Low-angle orbit around [singer] on a dark stage, neon rim lights in magenta and cyan, haze, slow motion, anamorphic flares.$p98b$, $p98c$swap: match the colours to the song's mood.$p98c$, 'intermediate', 8),
  ($p99a$Real estate walkthrough$p99a$, $p99b$Smooth steadicam walk through a bright modern [room type], wide 16mm lens, soft natural light, clean and spacious, gentle forward motion.$p99b$, $p99c$swap: end with a slow tilt to the view.$p99c$, 'beginner', 9),
  ($p100a$Travel opener$p100a$, $p100b$Drone shot rising over [landmark] at golden hour, wide vista, warm light, then cut to close-ups of local details, uplifting cinematic travel look.$p100b$, $p100c$swap: add slow motion for the second shot.$p100c$, 'beginner', 10),
  ($p101a$Food close-up$p101a$, $p101b$Macro shot of [dish] being served, steam rising, warm side light, shallow depth of field, slow motion drizzle of sauce, appetising.$p101b$, $p101c$swap: add a hand entering the frame for scale.$p101c$, 'beginner', 11),
  ($p102a$Fashion shot$p102a$, $p102b$Low-angle tracking shot of [model] walking toward camera on [street], wind in the clothes, hard sun, slow motion, high-fashion look.$p102b$, $p102c$swap: change the location to match the collection.$p102c$, 'intermediate', 12)
) as v(title, body, swap_note, difficulty, ord)
where s.slug=$s$shot-recipes$s$
  and not exists (select 1 from public.prompts p where p.subcategory_id=s.id and p.title=v.title);
insert into public.prompt_subcategories (category_id, slug, name, sort_order)
select c.id, $s$camera-lighting-stills$s$, $s$Camera & lighting for still images$s$, coalesce((select max(sort_order) from public.prompt_subcategories x where x.category_id=c.id),0)+1
from public.prompt_categories c where c.slug=$s$image$s$ on conflict (category_id, slug) do nothing;
insert into public.prompts (subcategory_id, title, body, swap_note, difficulty, sort_order)
select s.id, v.title, v.body, v.swap_note, v.difficulty, v.ord
from public.prompt_subcategories s
join public.prompt_categories c on c.id=s.category_id and c.slug=$s$image$s$
cross join (values
  ($p103a$Portrait with soft window light$p103a$, $p103b$Portrait of [person], soft window light from the left, shot on an 85mm lens at f/1.8, blurred background, natural skin, [mood].$p103b$, $p103c$swap: move the window for different shadow shapes.$p103c$, 'beginner', 1),
  ($p104a$Product on seamless background$p104a$, $p104b$[Product] on a seamless [colour] background, softbox lighting, soft shadow beneath, sharp focus, commercial photography.$p104b$, $p104c$swap: add reflections for a glossy surface.$p104c$, 'beginner', 2),
  ($p105a$Low-angle hero image$p105a$, $p105b$Low-angle photo of [subject], wide lens, dramatic sky, strong perspective, hero pose, [lighting].$p105b$, $p105c$swap: use for posters and album art.$p105c$, 'beginner', 3),
  ($p106a$Overhead flat lay$p106a$, $p106b$Overhead flat lay of [items] arranged neatly on [surface], soft even light, clean composition, negative space at the top for text.$p106b$, $p106c$swap: change the surface colour to match the brand.$p106c$, 'beginner', 4),
  ($p107a$Golden hour outdoor portrait$p107a$, $p107b$[Person] outdoors at golden hour, warm backlight, hair glowing, shallow depth of field, soft lens flare, [setting].$p107b$, $p107c$swap: face them into the light for warmer skin.$p107c$, 'beginner', 5),
  ($p108a$Dramatic side-lit portrait$p108a$, $p108b$Dramatic portrait of [person], one hard light from the side, deep shadows on the other half, dark background, high contrast.$p108b$, $p108c$swap: add a small rim light for shape.$p108c$, 'intermediate', 6),
  ($p109a$Night street photo$p109a$, $p109b$[Subject] on a night street lit by neon signs and car lights, wet pavement reflections, 35mm lens, cinematic still.$p109b$, $p109c$swap: name your two main neon colours.$p109c$, 'beginner', 7),
  ($p110a$Macro texture detail$p110a$, $p110b$Macro photo of [texture: leaf, fabric, watch gear], extreme detail, thin focus plane, side lighting to show texture.$p110b$, $p110c$swap: use for backgrounds and product details.$p110c$, 'intermediate', 8),
  ($p111a$Wide environmental portrait$p111a$, $p111b$Wide environmental portrait of [person] in their [workplace], 24mm lens, showing their tools and surroundings, natural light.$p111b$, $p111c$swap: use for about-us pages and stories.$p111c$, 'intermediate', 9),
  ($p112a$Silhouette at sunset$p112a$, $p112b$Silhouette of [subject] against a large orange sunset sky, strong shape, minimal detail, wide composition.$p112b$, $p112c$swap: place them on the rule-of-thirds line.$p112c$, 'beginner', 10)
) as v(title, body, swap_note, difficulty, ord)
where s.slug=$s$camera-lighting-stills$s$
  and not exists (select 1 from public.prompts p where p.subcategory_id=s.id and p.title=v.title);
insert into public.prompt_subcategories (category_id, slug, name, sort_order)
select c.id, $s$build-an-app$s$, $s$Build an app$s$, coalesce((select max(sort_order) from public.prompt_subcategories x where x.category_id=c.id),0)+1
from public.prompt_categories c where c.slug=$s$apps-tools$s$ on conflict (category_id, slug) do nothing;
insert into public.prompts (subcategory_id, title, body, swap_note, difficulty, sort_order)
select s.id, v.title, v.body, v.swap_note, v.difficulty, v.ord
from public.prompt_subcategories s
join public.prompt_categories c on c.id=s.category_id and c.slug=$s$apps-tools$s$
cross join (values
  ($p113a$Write a one-page product brief$p113a$, $p113b$Write a one-page product brief for a tool that helps [user] with [problem]. Include: the one job it does, three user stories, the screens, the data it stores, and two things it will not do in version one.$p113b$, $p113c$swap: add a target time (for example 'buildable in one afternoon').$p113c$, 'beginner', 1),
  ($p114a$Turn a brief into build prompts$p114a$, $p114b$Break this brief into five small build prompts I can give an AI app builder one at a time, each with a clear result I can check: [paste brief]$p114b$, $p114c$swap: ask for acceptance tests after each prompt.$p114c$, 'beginner', 2),
  ($p115a$Design the data table$p115a$, $p115b$Design a simple database table for [tool]. List each field, its type, why it is needed, and mark any personal data. Suggest what to leave out.$p115b$, $p115c$swap: ask for a second table linked to the first.$p115c$, 'beginner', 3),
  ($p116a$Write acceptance tests$p116a$, $p116b$For this feature: [describe]. Write five acceptance tests in the form 'When I do X, I should see Y', including one edge case and one mistake case.$p116b$, $p116c$swap: ask for expected error messages too.$p116c$, 'intermediate', 4),
  ($p117a$Wireframe in words$p117a$, $p117b$Describe the layout of the [screen name] screen of [tool] from top to bottom, with the main action obvious. Then list three things a first-time user might get wrong.$p117b$, $p117c$swap: ask for a mobile version.$p117c$, 'beginner', 5),
  ($p118a$Write friendly error messages$p118a$, $p118b$Rewrite these error messages so they say what happened and what to do next, in friendly plain English: [paste messages]$p118b$, $p118c$swap: add your brand voice.$p118c$, 'beginner', 6),
  ($p119a$Plan roles and permissions$p119a$, $p119b$For [tool], list the user roles and a table of what each role can view, add, edit and delete. Point out any risky permission.$p119b$, $p119c$swap: ask for a test plan to check one restriction.$p119c$, 'intermediate', 7),
  ($p120a$Draft a privacy note$p120a$, $p120b$Write a short plain-English privacy note for [tool] saying what data it collects, why, who can see it, and how to delete it. This is a draft for a lawyer to review.$p120b$, $p120c$swap: add the country your users are in.$p120c$, 'beginner', 8)
) as v(title, body, swap_note, difficulty, ord)
where s.slug=$s$build-an-app$s$
  and not exists (select 1 from public.prompts p where p.subcategory_id=s.id and p.title=v.title);
insert into public.prompt_subcategories (category_id, slug, name, sort_order)
select c.id, $s$debug-test-ship$s$, $s$Debug, test and ship$s$, coalesce((select max(sort_order) from public.prompt_subcategories x where x.category_id=c.id),0)+1
from public.prompt_categories c where c.slug=$s$apps-tools$s$ on conflict (category_id, slug) do nothing;
insert into public.prompts (subcategory_id, title, body, swap_note, difficulty, sort_order)
select s.id, v.title, v.body, v.swap_note, v.difficulty, v.ord
from public.prompt_subcategories s
join public.prompt_categories c on c.id=s.category_id and c.slug=$s$apps-tools$s$
cross join (values
  ($p121a$Explain a bug$p121a$, $p121b$This is what I expected: [expected]. This is what happened: [actual]. Here is the relevant part of my app: [paste]. List three likely causes, most likely first, and how to check each.$p121b$, $p121c$swap: paste the error message too.$p121c$, 'beginner', 1),
  ($p122a$Ten-check test list$p122a$, $p122b$Make a test list of ten checks for [tool]: normal use, empty input, very long input, wrong type, double-click, and going back. Give the expected result for each.$p122b$, $p122c$swap: focus on the payment or sign-in flow.$p122c$, 'beginner', 2),
  ($p123a$Security check$p123a$, $p123b$Review [tool] for common problems: exposed keys, missing access checks, trusting user input, and public links to private data. List what to test and how to fix each.$p123b$, $p123c$swap: ask it to rank by risk.$p123c$, 'intermediate', 3),
  ($p124a$Write a changelog entry$p124a$, $p124b$Write a short changelog entry for these changes in plain language for users: [list changes]$p124b$, $p124c$swap: add a 'known issues' line.$p124c$, 'beginner', 4),
  ($p125a$Plan a beta$p125a$, $p125b$Plan a two-week beta for [tool] with ten real users: how to invite them, what to ask, what to measure, and how to decide what to fix first.$p125b$, $p125c$swap: shorten to one week.$p125c$, 'beginner', 5),
  ($p126a$Write user guide steps$p126a$, $p126b$Write step-by-step instructions for [task] in [tool] for a first-time user, with one short sentence per step and a note where a screenshot helps.$p126b$, $p126c$swap: add a troubleshooting section.$p126c$, 'beginner', 6),
  ($p127a$Estimate AI costs$p127a$, $p127b$My app makes about [number] AI calls per user per month at roughly [cost] each. Estimate the cost for 100, 1,000 and 10,000 users and suggest three ways to reduce it.$p127b$, $p127c$swap: add a per-user cap.$p127c$, 'intermediate', 7),
  ($p128a$Post-launch feedback triage$p128a$, $p128b$Group this user feedback into themes, count them, and suggest the top three things to fix first with reasons: [paste feedback]$p128b$, $p128c$swap: separate bugs from feature requests.$p128c$, 'beginner', 8)
) as v(title, body, swap_note, difficulty, ord)
where s.slug=$s$debug-test-ship$s$
  and not exists (select 1 from public.prompts p where p.subcategory_id=s.id and p.title=v.title);
insert into public.prompt_subcategories (category_id, slug, name, sort_order)
select c.id, $s$research-sources$s$, $s$Research & sources$s$, coalesce((select max(sort_order) from public.prompt_subcategories x where x.category_id=c.id),0)+1
from public.prompt_categories c where c.slug=$s$research-data$s$ on conflict (category_id, slug) do nothing;
insert into public.prompts (subcategory_id, title, body, swap_note, difficulty, sort_order)
select s.id, v.title, v.body, v.swap_note, v.difficulty, v.ord
from public.prompt_subcategories s
join public.prompt_categories c on c.id=s.category_id and c.slug=$s$research-data$s$
cross join (values
  ($p129a$Turn a topic into a question$p129a$, $p129b$Turn the topic '[topic]' into one specific research question I can answer, plus four sub-questions and the type of evidence that would answer each.$p129b$, $p129c$swap: add a time period and place.$p129c$, 'beginner', 1),
  ($p130a$Search plan$p130a$, $p130b$Suggest a search plan for '[question]': keywords and synonyms, the best types of sources, what date range, and what would make me exclude a source.$p130b$, $p130c$swap: ask for search strings for a specific database.$p130c$, 'beginner', 2),
  ($p131a$Rate a source$p131a$, $p131b$Help me judge this source: [paste link or text]. Ask me questions about the author, date, evidence, funding and bias, then summarise how much to trust it and why.$p131b$, $p131c$swap: compare two sources at once.$p131c$, 'beginner', 3),
  ($p132a$Summarise a paper honestly$p132a$, $p132b$Summarise this paper in 150 words: question, method, sample, main finding, limits. Quote the sentences you used and do not add anything that is not in the text: [paste]$p132b$, $p132c$swap: ask for what the paper cannot show.$p132c$, 'intermediate', 4),
  ($p133a$Check a claim$p133a$, $p133b$Check this claim: '[claim]'. List what evidence would support it and what would contradict it, then help me search for both. Tell me if you cannot verify anything.$p133b$, $p133c$swap: ask for the original source of a statistic.$p133c$, 'beginner', 5),
  ($p134a$Compare sources that disagree$p134a$, $p134b$These two sources disagree: [A] and [B]. Compare definitions, populations, dates and methods, and suggest why they might differ.$p134b$, $p134c$swap: ask what extra data would settle it.$p134c$, 'intermediate', 6),
  ($p135a$Write a one-page briefing$p135a$, $p135b$Write a one-page briefing for [decision-maker] on [question]: answer first, three findings with sources, limits, and a recommendation with confidence. Use only the facts I paste: [paste].$p135b$, $p135c$swap: add an options table.$p135c$, 'beginner', 7),
  ($p136a$Interview guide$p136a$, $p136b$Write eight neutral, open interview questions for [type of person] about [topic], avoiding leading questions, plus a consent line to read at the start.$p136b$, $p136c$swap: add follow-up probes.$p136c$, 'beginner', 8)
) as v(title, body, swap_note, difficulty, ord)
where s.slug=$s$research-sources$s$
  and not exists (select 1 from public.prompts p where p.subcategory_id=s.id and p.title=v.title);
insert into public.prompt_subcategories (category_id, slug, name, sort_order)
select c.id, $s$data-analysis$s$, $s$Data analysis$s$, coalesce((select max(sort_order) from public.prompt_subcategories x where x.category_id=c.id),0)+1
from public.prompt_categories c where c.slug=$s$research-data$s$ on conflict (category_id, slug) do nothing;
insert into public.prompts (subcategory_id, title, body, swap_note, difficulty, sort_order)
select s.id, v.title, v.body, v.swap_note, v.difficulty, v.ord
from public.prompt_subcategories s
join public.prompt_categories c on c.id=s.category_id and c.slug=$s$research-data$s$
cross join (values
  ($p137a$Describe a dataset$p137a$, $p137b$Here is a sample of my data: [paste 20 rows]. Describe the columns, likely units, missing values and anything odd that I should check before analysing.$p137b$, $p137c$swap: ask for a cleaning checklist.$p137c$, 'beginner', 1),
  ($p138a$Clean data plan$p138a$, $p138b$Suggest a step-by-step plan to clean this dataset: duplicates, spelling variants, wrong types, outliers and blanks. Tell me how to keep a log of every change: [describe data]$p138b$, $p138c$swap: ask for spreadsheet formulas.$p138c$, 'beginner', 2),
  ($p139a$Pick the right chart$p139a$, $p139b$I want to show [comparison, trend, share or relationship] using these columns: [list]. Recommend the best chart, what to label, and how to avoid misleading the reader.$p139b$, $p139c$swap: ask for a second option.$p139c$, 'beginner', 3),
  ($p140a$Explain a statistic simply$p140a$, $p140b$Explain what [statistic, e.g. median, confidence interval, correlation] means to someone with no maths background, with one example and one common mistake.$p140b$, $p140c$swap: use your own data as the example.$p140c$, 'beginner', 4),
  ($p141a$Spot correlation vs cause$p141a$, $p141b$Here is a finding: [finding]. List three alternative explanations other than 'A caused B', and how I could test each.$p141b$, $p141c$swap: ask what study design would prove it.$p141c$, 'intermediate', 5),
  ($p142a$Spreadsheet formulas$p142a$, $p142b$Write spreadsheet formulas for: [describe goal, e.g. percent change by month, average by region]. Explain each formula in one sentence and give a test with sample numbers.$p142b$, $p142c$swap: specify Excel or Google Sheets.$p142c$, 'beginner', 6),
  ($p143a$Check an AI analysis$p143a$, $p143b$Here is an analysis an AI gave me: [paste]. List five ways to verify it by hand using the raw data and what a mistake would look like.$p143b$, $p143c$swap: ask for a small test dataset with a known answer.$p143c$, 'intermediate', 7),
  ($p144a$Write findings for a non-expert$p144a$, $p144b$Rewrite these findings for a non-expert audience: plain language, one main message, what is certain, what is uncertain, what to do next: [paste findings]$p144b$, $p144c$swap: set a word limit.$p144c$, 'beginner', 8)
) as v(title, body, swap_note, difficulty, ord)
where s.slug=$s$data-analysis$s$
  and not exists (select 1 from public.prompts p where p.subcategory_id=s.id and p.title=v.title);
insert into public.prompt_subcategories (category_id, slug, name, sort_order)
select c.id, $s$titles-logos$s$, $s$Titles & logos$s$, coalesce((select max(sort_order) from public.prompt_subcategories x where x.category_id=c.id),0)+1
from public.prompt_categories c where c.slug=$s$motion-graphics$s$ on conflict (category_id, slug) do nothing;
insert into public.prompts (subcategory_id, title, body, swap_note, difficulty, sort_order)
select s.id, v.title, v.body, v.swap_note, v.difficulty, v.ord
from public.prompt_subcategories s
join public.prompt_categories c on c.id=s.category_id and c.slug=$s$motion-graphics$s$
cross join (values
  ($p145a$Animated title reveal$p145a$, $p145b$Animate the text '[title]' with a smooth reveal: letters fade and slide up over 0.6 seconds with ease-out, hold for 2 seconds, then fade out. Clean [font style], [colour palette], centred.$p145b$, $p145c$swap: change the reveal to a mask wipe.$p145c$, 'beginner', 1),
  ($p146a$Logo sting$p146a$, $p146b$A 3-second logo sting: [logo] builds from [simple shapes] with ease-out motion, small settle at the end, holds on a clean final frame with a soft glow, [brand colours].$p146b$, $p146c$swap: add a subtle sound cue.$p146c$, 'beginner', 2),
  ($p147a$Lower third$p147a$, $p147b$Design an animated lower third: a [colour] bar slides in from the left in 0.4 seconds, the name '[name]' and title '[role]' fade in, hold 4 seconds, exit in reverse.$p147b$, $p147c$swap: add the brand logo at the end.$p147c$, 'beginner', 3),
  ($p148a$Kinetic typography$p148a$, $p148b$Kinetic typography for this line: '[quote]'. Each word appears in time with the speech, important words larger and bolder, ease-out motion, [palette].$p148b$, $p148c$swap: use a calmer, slower rhythm.$p148c$, 'intermediate', 4),
  ($p149a$Icon animation set$p149a$, $p149b$Animate three simple icons ([icons]) drawing on over 0.5 seconds each with the same easing, consistent line weight, [colour palette].$p149b$, $p149c$swap: add a small bounce for playful brands.$p149c$, 'beginner', 5),
  ($p150a$Countdown / intro$p150a$, $p150b$A 5-second countdown intro for [event]: numbers pop in with a small scale animation, a coloured ring fills around each, ending with the title.$p150b$, $p150c$swap: use a vertical version for stories.$p150c$, 'beginner', 6),
  ($p151a$Background loops$p151a$, $p151b$A seamless 6-second looping background of [abstract shapes, gradients or particles] in [palette], slow movement, no sharp flashes, suitable behind text.$p151b$, $p151c$swap: darker for text legibility.$p151c$, 'beginner', 7),
  ($p152a$Motion style guide$p152a$, $p152b$Write a one-page motion style guide for [brand]: base timing, easing types, allowed effects, colours, fonts, and three do and don't examples.$p152b$, $p152c$swap: add a short usage rule for reduced motion.$p152c$, 'intermediate', 8)
) as v(title, body, swap_note, difficulty, ord)
where s.slug=$s$titles-logos$s$
  and not exists (select 1 from public.prompts p where p.subcategory_id=s.id and p.title=v.title);
insert into public.prompt_subcategories (category_id, slug, name, sort_order)
select c.id, $s$explainers-social$s$, $s$Explainers & social motion$s$, coalesce((select max(sort_order) from public.prompt_subcategories x where x.category_id=c.id),0)+1
from public.prompt_categories c where c.slug=$s$motion-graphics$s$ on conflict (category_id, slug) do nothing;
insert into public.prompts (subcategory_id, title, body, swap_note, difficulty, sort_order)
select s.id, v.title, v.body, v.swap_note, v.difficulty, v.ord
from public.prompt_subcategories s
join public.prompt_categories c on c.id=s.category_id and c.slug=$s$motion-graphics$s$
cross join (values
  ($p153a$30-second explainer script$p153a$, $p153b$Write a 30-second explainer script for [product or idea]: problem (5s), idea (5s), three steps (15s), result (5s). Simple words, one idea per scene, plus a description of the visuals for each scene.$p153b$, $p153c$swap: aim at a specific audience.$p153c$, 'beginner', 1),
  ($p154a$Storyboard frames$p154a$, $p154b$Create a storyboard of six frames for this script: [paste]. For each frame describe the visual, the motion and the timing in seconds.$p154b$, $p154c$swap: ask for colour notes.$p154c$, 'beginner', 2),
  ($p155a$Animated chart$p155a$, $p155b$Describe how to animate this chart: [data]. Reveal one series at a time, highlight the key point, label clearly, and add a source line at the end.$p155b$, $p155c$swap: keep the axis honest, starting at zero.$p155c$, 'intermediate', 3),
  ($p156a$Social ad hook$p156a$, $p156b$Design the first 3 seconds of a vertical social video for [offer]: a bold question on screen, quick zoom, captions, and a visual that stops the scroll.$p156b$, $p156c$swap: test two different hooks.$p156c$, 'beginner', 4),
  ($p157a$Product feature demo$p157a$, $p157b$Animate a 20-second demo of [feature]: highlight the button with a soft glow, show the result, and end on the outcome with a short caption.$p157b$, $p157c$swap: add a cursor animation.$p157c$, 'beginner', 5),
  ($p158a$Infographic in motion$p158a$, $p158b$Turn this information into a 20-second animated infographic with three icons, numbers counting up, and a clear closing statement: [paste]$p158b$, $p158c$swap: use your brand colours.$p158c$, 'intermediate', 6),
  ($p159a$Caption style$p159a$, $p159b$Design a caption style for vertical videos: large white text with a dark outline, two lines maximum, words highlighted in [colour] as they are spoken.$p159b$, $p159c$swap: use bolder highlights for energy.$p159c$, 'beginner', 7),
  ($p160a$Reduced-motion version$p160a$, $p160b$Suggest how to redesign this animation for viewers who prefer reduced motion: [describe animation]. Keep the meaning but remove parallax, flashing and fast movement.$p160b$, $p160c$swap: give a static version too.$p160c$, 'intermediate', 8)
) as v(title, body, swap_note, difficulty, ord)
where s.slug=$s$explainers-social$s$
  and not exists (select 1 from public.prompts p where p.subcategory_id=s.id and p.title=v.title);
insert into public.prompt_subcategories (category_id, slug, name, sort_order)
select c.id, $s$brand-identity$s$, $s$Brand identity$s$, coalesce((select max(sort_order) from public.prompt_subcategories x where x.category_id=c.id),0)+1
from public.prompt_categories c where c.slug=$s$business-brand$s$ on conflict (category_id, slug) do nothing;
insert into public.prompts (subcategory_id, title, body, swap_note, difficulty, sort_order)
select s.id, v.title, v.body, v.swap_note, v.difficulty, v.ord
from public.prompt_subcategories s
join public.prompt_categories c on c.id=s.category_id and c.slug=$s$business-brand$s$
cross join (values
  ($p161a$Brand strategy in a page$p161a$, $p161b$Write a one-page brand strategy for [business]: audience, what we do better than alternatives, three brand adjectives, three things we are not, and a one-sentence promise.$p161b$, $p161c$swap: ask for a competitor comparison.$p161c$, 'beginner', 1),
  ($p162a$Brand voice guide$p162a$, $p162b$Create a brand voice guide for [business]: three traits each with a do and don't, five words we use, five we avoid, and a sample paragraph.$p162b$, $p162c$swap: add example replies to a complaint.$p162c$, 'beginner', 2),
  ($p163a$Name ideas$p163a$, $p163b$Suggest 20 name ideas for [business] that are easy to spell, easy to say, and suggest [value]. Group them by style and flag any that may be hard to trademark.$p163b$, $p163c$swap: ask for domain-style versions.$p163c$, 'beginner', 3),
  ($p164a$Logo concept brief$p164a$, $p164b$Write a brief for a logo for [business]: audience, feeling, shapes to explore, colours to try, things to avoid, and where it will be used first.$p164b$, $p164c$swap: ask for five concept directions.$p164c$, 'beginner', 4),
  ($p165a$Colour palette with roles$p165a$, $p165b$Suggest a colour palette for [brand] with primary, accent, background, text and two neutrals. Give hex codes and check that text on background has at least 4.5:1 contrast.$p165b$, $p165c$swap: ask for a dark-mode version.$p165c$, 'intermediate', 5),
  ($p166a$Font pairing$p166a$, $p166b$Suggest two font pairings for [brand] (one for headings, one for body) with reasons, and note that they must be free for commercial use.$p166b$, $p166c$swap: ask for a serif and a sans option.$p166c$, 'beginner', 6),
  ($p167a$Tagline options$p167a$, $p167b$Write 15 tagline options for [business] under 7 words each in different styles (benefit, curiosity, promise) and pick the three strongest with reasons.$p167b$, $p167c$swap: ask for a version in another language.$p167c$, 'beginner', 7),
  ($p168a$Imagery style block$p168a$, $p168b$Write a reusable image prompt block for [brand]: subject rules, lighting, colour treatment, framing and things to avoid, so every image looks consistent.$p168b$, $p168c$swap: add three reference descriptions.$p168c$, 'intermediate', 8)
) as v(title, body, swap_note, difficulty, ord)
where s.slug=$s$brand-identity$s$
  and not exists (select 1 from public.prompts p where p.subcategory_id=s.id and p.title=v.title);
insert into public.prompt_subcategories (category_id, slug, name, sort_order)
select c.id, $s$client-delivery$s$, $s$Client delivery$s$, coalesce((select max(sort_order) from public.prompt_subcategories x where x.category_id=c.id),0)+1
from public.prompt_categories c where c.slug=$s$business-brand$s$ on conflict (category_id, slug) do nothing;
insert into public.prompts (subcategory_id, title, body, swap_note, difficulty, sort_order)
select s.id, v.title, v.body, v.swap_note, v.difficulty, v.ord
from public.prompt_subcategories s
join public.prompt_categories c on c.id=s.category_id and c.slug=$s$business-brand$s$
cross join (values
  ($p169a$Discovery call questions$p169a$, $p169b$Write ten open questions for a discovery call with a [type of client] about [service], covering goals, past attempts, constraints, budget and timing.$p169b$, $p169c$swap: add a short summary email template.$p169c$, 'beginner', 1),
  ($p170a$Proposal draft$p170a$, $p170b$Draft a two-page proposal for [client] using their words about their problem: [notes]. Include three options, timeline, price, what is not included, and one clear next step.$p170b$, $p170c$swap: add an FAQ section.$p170c$, 'beginner', 2),
  ($p171a$Scope with exclusions$p171a$, $p171b$Write a project scope for [service]: deliverables, exclusions, assumptions, acceptance criteria, revision rounds and a change request process.$p171b$, $p171c$swap: add payment milestones.$p171c$, 'beginner', 3),
  ($p172a$Onboarding email$p172a$, $p172b$Write a friendly onboarding email for a new client of [service] with next steps, what I need from them, timeline, and how we will communicate.$p172b$, $p172c$swap: add a short questionnaire.$p172c$, 'beginner', 4),
  ($p173a$Handle scope creep$p173a$, $p173b$Write a polite message to a client who asked for extra work outside the agreed scope. Offer a paid option and keep the relationship warm: [describe request].$p173b$, $p173c$swap: firmer tone for repeat cases.$p173c$, 'beginner', 5),
  ($p174a$Honest AI-use policy$p174a$, $p174b$Write a short client-facing note explaining how I use AI in my work, what I check by hand, and how I protect confidential information.$p174b$, $p174c$swap: adapt for a regulated industry.$p174c$, 'beginner', 6),
  ($p175a$Case study draft$p175a$, $p175b$Write a case study from these facts only: client [type], problem [ ], what I did [ ], results [numbers]. Do not add anything not listed and mark anything I should confirm with the client.$p175b$, $p175c$swap: ask for a shorter social version.$p175c$, 'beginner', 7),
  ($p176a$Invoice follow-up$p176a$, $p176b$Write three polite follow-up messages for an overdue invoice: day 3, day 10 and day 20, each firmer, referring to the agreed terms.$p176b$, $p176c$swap: add a late-fee mention.$p176c$, 'beginner', 8)
) as v(title, body, swap_note, difficulty, ord)
where s.slug=$s$client-delivery$s$
  and not exists (select 1 from public.prompts p where p.subcategory_id=s.id and p.title=v.title);
