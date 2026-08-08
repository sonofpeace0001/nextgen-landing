# NEXTGEN

Landing page for NEXTGEN — the future-skills community. Built with React + Vite.

## Develop

```bash
npm install
npm run dev
```

## Build

```bash
npm run build
```

Output is written to `dist/`.

## Deploy on Vercel

This is a standard Vite project. On Vercel:

- **Framework preset:** Vite
- **Build command:** `npm run build`
- **Output directory:** `dist`

Importing the GitHub repo into Vercel auto-detects all three.

## VIP settings

VIP settings are edited in Supabase Studio → `site_settings` table. No deploy
needed — the site reads them on page load. Keys:

| key | valid values |
| --- | --- |
| `vip_intake_date` | a display date like `March 3`, or `TBA` (shows "to be announced" and switches the CTA to waitlist mode) |
| `vip_seats_left` | a whole number as text, e.g. `8`. `0` (or less) shows "this intake is full" and switches to waitlist mode |
| `vip_checkout_url` | full URL for the "reserve a seat" button |
| `vip_waitlist_url` | full URL for the "join the waitlist" button |

The browser has read-only access (RLS: SELECT for anon only); writes happen only
through the dashboard.

## Elite Prompt Library

`/#/prompts` is a members perk: a code-gated library of prompts. There is no
admin UI for it by design — everything is edited in Supabase Studio.

**Access code** — also a `site_settings` row, same table as VIP above:

| key | valid values |
| --- | --- |
| `elite_prompt_code` | any text string. Members type this to unlock the library for their browser session. Rotate it any time from Studio — no deploy needed. |

The code check is light gating for a members perk, not a security boundary —
the prompt tables are already world-readable (see below), and the code just
decides whether the library UI shows in that browser tab. It is remembered in
`sessionStorage` only, so it re-locks when the tab is closed.

**Content** — three tables, edited directly in Studio → Table editor:

| table | purpose |
| --- | --- |
| `prompt_categories` | top-level sections (Writing, Image, Video, …). `sort_order` controls display order. |
| `prompt_subcategories` | sub-sections within a category, linked by `category_id`. |
| `prompts` | the actual prompts, linked by `subcategory_id`. `difficulty` must be `beginner`, `intermediate`, or `advanced`. |

All three are anon-readable (RLS SELECT policy) with no write policies — add,
edit, or remove prompts only from the dashboard (service role).
