# NEXTGEN Academy: current state and runbook

Live at https://nextgenai-web.vercel.app. Last updated 26 September 2026.

## What is live

| Area | State |
|---|---|
| Foundations (3 days) | Published. Every member is auto-enrolled when they open the Academy (`ensure_foundations()`). |
| 9 goal categories | Graphics, Content, Apps, Agents, Film, Motion, Audio, Research, Business. Each has 90 core days (Basic, Pro, Expert, Grandmaster) plus 30 Skill Lab days (91-120). All published. |
| Lessons | Rendered as real markdown (headings, lists, links). Every lesson has a worked example and a common mistake. |
| AI scorer | Edge function `evaluate-submission`. **Needs `ANTHROPIC_API_KEY`.** Without it every AI-scored day waits in Admin > Review. |
| Approval gate | Only approved (`scored`) work unlocks the next day. Admin > Review shows AI score, criteria, feedback, confidence and flags. |
| Human review | Film, Motion and Audio project days (video/audio cannot be scored by the AI) and any low-confidence or flagged result. |
| Discord share | `share-to-discord`: opt-in, score 80+, once per submission. Webhook in the `DISCORD_WEBHOOK_URL` secret. |
| Resource Library | Free at `#/resources`: 62 guides, glossaries, tool guides, templates, checklists and sample prompts. |
| Prompt Library | `#/prompts`, behind the Elite code: 500+ prompts. |
| Privacy and Terms | `#/privacy`, `#/terms`. DRAFTS written from what the app does; have a professional review them and add a contact address. |
| Home | NEXTGEN Academy section with a card for each category. |

## Do these first

1. **Secrets** (Supabase project `hvwuozfsdckopxlbailm`)
   - `npx supabase secrets set ANTHROPIC_API_KEY=... --project-ref hvwuozfsdckopxlbailm` (optional `EVAL_MODEL`, default `claude-sonnet-5`).
   - Rotate the Discord webhook (it was shared in chat) and set the new one as `DISCORD_WEBHOOK_URL`.
   - Rotate the `mod_bot_service` database password (plaintext in the migration history) and commit or `supabase migration repair` the three mod_bot migrations.
2. **Publish check.** Film Day 30 was unpublished in Admin; republish it if that was unintended.
3. **Review Privacy and Terms** with a professional and add a contact address.
4. **Calibrate the scorer.** Hand-grade about 20 real submissions per level and run `node scripts/calibration/calibrate.mjs` (see its README). Audit 10% of live AI scores weekly. The bundled gold set is synthetic.

## First-week checks

- New member: Foundations appears first; all nine goals are listed to enrol in.
- Submit a scored day and a project day; approve the project in Admin > Review and confirm the next day opens.
- Score 80+ and press Share to confirm one Discord post appears.
- Check the site on a phone (no horizontal scrolling was found on the main pages in automated checks).

## Known limits

- Expert, Grandmaster and Skill Lab lessons are concise; deepen them from member feedback.
- Video, audio and non-image links cannot be viewed by the scorer, so those days are human-reviewed.
- CREAO credit costs are not measured, so `credit_budget` is empty.
- Peer-review and mentoring days assume a community with enough members.
- The Elite gate on Intermediate/Advanced entry is unchanged.
- Members cannot delete their own account in the app; they ask on Discord (see Privacy).
