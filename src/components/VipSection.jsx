import { useEffect, useState } from "react";
import { fetchSiteSettings } from "@/lib/settings";

// ── editable values ──────────────────────────────────────────────────────────
// These four are FALLBACKS only. The live values come from Supabase
// (Studio -> Table editor -> site_settings) and can be changed without a
// redeploy — see the README. The fallbacks render while the settings load and
// keep the section working if the fetch ever fails.
const INTAKE_DATE = "TBA"; // e.g. "March 3" — "TBA" switches the section to waitlist mode
const SEATS_LEFT = 8; // seats open in the current intake (8 per intake)
const VIP_CHECKOUT_URL = "#"; // TODO: replace with the real checkout link (in site_settings)
const VIP_WAITLIST_URL = "#"; // TODO: replace with the real waitlist link (in site_settings)
// ─────────────────────────────────────────────────────────────────────────────

const FEATURES = [
  {
    title: "two live 1-on-1 calls a month",
    desc: "45 minutes each, booked on your schedule. come with a goal, leave with a next step.",
  },
  {
    title: "async feedback between calls",
    desc: "send what you're working on, get direct feedback without waiting for a call.",
  },
  {
    title: "a finish line",
    desc: "this is an 8-week program, not an open-ended subscription. you're done when you can build without me.",
  },
];

export function VipSection() {
  const [settings, setSettings] = useState(null);

  useEffect(() => {
    let active = true;
    fetchSiteSettings()
      .then((s) => active && setSettings(s))
      .catch((e) => console.warn("site_settings fetch failed; using fallback VIP values", e));
    return () => {
      active = false;
    };
  }, []);

  const intakeDate = settings?.vip_intake_date ?? INTAKE_DATE;
  const parsedSeats = Number(settings?.vip_seats_left);
  const seatsLeft = Number.isFinite(parsedSeats) ? parsedSeats : SEATS_LEFT;
  const checkoutUrl = settings?.vip_checkout_url ?? VIP_CHECKOUT_URL;
  const waitlistUrl = settings?.vip_waitlist_url ?? VIP_WAITLIST_URL;

  const noDate = intakeDate === "TBA";
  const full = seatsLeft <= 0;
  const waitlistMode = noDate || full;

  const intakeLine = noDate
    ? "next intake: to be announced — join the waitlist"
    : full
      ? "this intake is full — join the waitlist"
      : `next intake: ${intakeDate} · ${seatsLeft} of 8 seats open`;

  return (
    <section id="vip" className="mx-auto max-w-6xl px-6 py-20 sm:py-24">
      <p className="eyebrow text-[13px] font-medium uppercase tracking-[0.14em] text-muted-foreground">
        NEXTGEN VIP
      </p>
      <h2 className="mt-3 max-w-2xl font-heading text-3xl font-semibold tracking-tight text-foreground sm:text-4xl">
        the fast track. 1-on-1, from zero to building.
      </h2>
      <p className="mt-4 max-w-xl text-[15px] leading-relaxed text-muted-foreground">
        eight weeks of direct 1-on-1 guidance from the founder. you come in at zero, you leave
        building real things with AI. limited seats, everyone starts together.
      </p>

      <div className="mt-10 max-w-2xl rounded-xl border border-border">
        {/* feature rows, hairline dividers, no icon cards */}
        <div className="divide-y divide-border px-6 sm:px-8">
          {FEATURES.map((f) => (
            <div key={f.title} className="py-5">
              <h3 className="text-[15px] font-semibold text-foreground">{f.title}</h3>
              <p className="mt-1 text-sm leading-relaxed text-muted-foreground">{f.desc}</p>
            </div>
          ))}
        </div>

        {/* price + CTA */}
        <div className="border-t border-border px-6 py-7 sm:px-8">
          {/* accent use 1 of 2: the price */}
          <div className="text-4xl font-semibold text-primary">$150</div>
          <p className="mt-1 text-sm text-muted-foreground">one-time · 8 weeks · 8 seats per intake</p>
          <p className="mt-3 text-sm text-foreground">{intakeLine}</p>

          <div className="mt-6 flex flex-col items-stretch gap-4 sm:flex-row sm:items-center">
            {/* accent use 2 of 2: the primary CTA */}
            <a
              href={waitlistMode ? waitlistUrl : checkoutUrl}
              className="inline-flex min-h-[44px] items-center justify-center rounded-xl bg-primary px-6 text-sm font-semibold text-primary-foreground transition-opacity hover:opacity-90 motion-reduce:transition-none sm:w-auto"
            >
              {waitlistMode ? "join the waitlist" : "reserve a seat"}
            </a>
            <a
              href="#faq"
              className="inline-flex min-h-[44px] items-center justify-center text-sm text-muted-foreground transition-colors hover:text-foreground motion-reduce:transition-none"
            >
              questions? read the FAQ
            </a>
          </div>

          <p className="mt-5 text-[13px] leading-relaxed text-muted-foreground">
            VIP is paid access to direct guidance. Elite is different — it's earned through
            contribution and can't be bought.
          </p>
        </div>
      </div>
    </section>
  );
}
