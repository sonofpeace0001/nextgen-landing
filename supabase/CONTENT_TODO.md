# Curriculum content status

- **AI track** — Basic tier authored: 24 real days (objective · lesson · skill focus ·
  assignment · rubric + an MCQ check each) in migration `20260607100006_seed_ai_basic.sql`.

## TODO-2 — Web3 & Freelancing day content (NOT authored)

The Web3 and Freelancing tracks have their **tier/level structure** (Basic →
Grandmaster, Novice/Intermediate/Advanced → 90/60/30 days), and the marketing track
cards display that structure correctly. But the **day-by-day content is not written**.

Do **not** generate placeholder content. The client will supply real Web3 and
Freelancing curriculum. Until then:
- Enrolling Novice in those tracks needs at least the Basic tier's first day published,
  or path generation throws "No published days in <tier>".
- Author content the same way as the AI seed (a new idempotent seed migration, or via
  the Supabase Table Editor — both are data-driven, no code change).
