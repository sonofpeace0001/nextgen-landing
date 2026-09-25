# Launching the goal-based Academy

Everything below is built and deployed. Nothing is visible to members until you publish it.

## What exists

| Area | State |
|---|---|
| Foundations (3 days) | Written, unpublished. Every member is auto-enrolled once published (`ensure_foundations()`). |
| 9 goal tracks | Graphics, Content, Apps, Agents, Film, Motion, Audio, Research, Business. Basic and Pro fully authored and deepened. Expert and Grandmaster authored as outlines. All unpublished. |
| AI scorer | Edge function `evaluate-submission`. Needs `ANTHROPIC_API_KEY`; without it every AI-scored day waits for a person. |
| Approval gate | Only approved (`scored`) work unlocks the next day. Admin > Review shows the AI score, criteria, feedback, confidence and flags. |
| Discord share | Edge function `share-to-discord`, opt-in, score 80+, webhook in the `DISCORD_WEBHOOK_URL` secret. |
| Calibration | `scripts/calibration/` runner and README. The bundled gold set is synthetic. |

## Before you publish

1. **Secrets** (Supabase project `hvwuozfsdckopxlbailm`)
   - `npx supabase secrets set ANTHROPIC_API_KEY=... --project-ref hvwuozfsdckopxlbailm`
   - Optional: `EVAL_MODEL` (default `claude-sonnet-5`).
   - Rotate the Discord webhook (it was shared in chat) and set the new one as `DISCORD_WEBHOOK_URL`.
   - Rotate the `mod_bot_service` database password (it is in the migration history in plaintext) and commit or `supabase migration repair` the three mod_bot migrations.
2. **Read the content.** Admin > Content lists each day. Read at least Foundations and the Basic tier of the first goals you open.
3. **Publish order.** Foundations first, then one or two goals (Content and Graphics are the most complete), then more as you have capacity to review.
4. **Watch the queue.** Days with `requires_review` (Film, Motion, Audio projects) and any low-confidence or flagged AI result land in Admin > Review.

## First week checks

- Sign in as a new member: Foundations should appear first and be the only path until they pick a goal.
- Submit a scored day and confirm feedback appears; submit a project day and approve it in Admin > Review, then confirm the next day opens.
- Score 80+ and press Share: confirm one post appears in Discord (post is opt-in and only once per submission).
- Hand-grade about 20 real submissions per level and run `node scripts/calibration/calibrate.mjs` (see its README). Audit 10% of live AI scores weekly.

## Known limits

- Video, audio and non-image links cannot be viewed by the scorer, so those days are human-reviewed.
- Expert and Grandmaster lessons are outlines; deepen them once members reach them.
- CREAO credit costs are not measured yet, so `credit_budget` is empty.
- The Elite gate on Intermediate/Advanced entry is unchanged.
