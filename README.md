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
