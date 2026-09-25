# Calibrating the AI scorer

The scorer is only as trustworthy as its agreement with a careful human. Do this before
relying on scores, and repeat after any rubric or model change.

1. Collect about 20 real submissions per level (Basic, Pro, Expert, Grandmaster), covering weak, middling and strong work.
2. Grade each by hand against the rubric: 0 (not yet), 1 (partly), 2 (yes) per criterion. Do it blind, before seeing the AI result.
3. Put them in a JSON file shaped like `gold-business-offer.json` (`levels` is your grade per criterion, in rubric order).
4. Run: `ANTHROPIC_API_KEY=... node scripts/calibration/calibrate.mjs <file>`
5. Targets: mean score error under 8 points, criterion agreement 70% exact / 95% within one level, pass-fail agreement 90%.
6. Read every two-level disagreement. Usually the rubric guidance is vague: tighten it, bump `rubric_version`, re-run.
7. Keep a weekly audit: sample 10% of live AI-scored submissions in Admin and compare.

`gold-business-offer.json` is a synthetic starter set written by the course author. It checks that the harness works and
shows the shape; it is not a substitute for real member work.
