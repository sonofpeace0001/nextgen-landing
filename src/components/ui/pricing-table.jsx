import { Check, X } from "lucide-react";
import { cn } from "@/lib/utils";

// TODO: replace with the real "Join free" link/route.
const JOIN_URL = "#/learn";
// TODO: replace with the real "How Elite works" Elite-section anchor.
const ELITE_ANCHOR = "#elite";

const FREE_FEATURES = [
  "Learn AI from zero",
  "Community access",
  "Join the daily challenges",
  "Explore opportunities",
];

const ELITE_EXTRAS = [
  "Structured roadmaps",
  "Early access to programs and tools",
  "Direct guidance",
  "Priority for paid roles and leadership",
  "Elite-only channels",
  "More visibility for your brand",
];

// Shared comparison list: free includes the first group; Elite includes everything.
const ALL_FEATURES = [...FREE_FEATURES, ...ELITE_EXTRAS];

const PLANS = [
  {
    id: "free",
    name: "NEXTGEN",
    priceLabel: "Free",
    priceNote: "for everyone",
    cta: "Join free",
    href: JOIN_URL,
    recommended: false,
    includes: FREE_FEATURES,
  },
  {
    id: "elite",
    name: "NEXTGEN Elite",
    priceLabel: "Earned",
    priceNote: "by contribution",
    cta: "How Elite works",
    href: ELITE_ANCHOR,
    recommended: true,
    includes: ALL_FEATURES,
  },
];

function FeatureRow({ label, included }) {
  const Icon = included ? Check : X;
  return (
    <li className="flex items-start gap-3 py-2">
      <Icon
        size={18}
        strokeWidth={2.5}
        aria-hidden="true"
        className={cn("mt-0.5 shrink-0", included ? "text-primary" : "text-muted-foreground")}
      />
      <span className={cn("text-sm leading-snug", included ? "text-foreground" : "text-muted-foreground")}>
        {label}
      </span>
    </li>
  );
}

export function PricingTable({ onSelect }) {
  const handleSelect = (plan) => (e) => {
    // If a parent passes onSelect, use it; otherwise fall through to the href.
    if (onSelect) {
      e.preventDefault();
      onSelect(plan.id, plan.href);
    }
  };

  return (
    <div className="grid grid-cols-1 gap-5 md:grid-cols-2">
      {PLANS.map((plan) => {
        const includedSet = new Set(plan.includes);
        return (
          <div
            key={plan.id}
            className={cn(
              "flex flex-col rounded-2xl border bg-background p-6 sm:p-8",
              plan.recommended ? "border-primary" : "border-border",
            )}
          >
            <div className="flex items-center justify-between gap-3">
              <h3 className="text-xl font-semibold text-foreground">{plan.name}</h3>
              {plan.recommended && (
                <span className="rounded-full border border-primary px-3 py-1 text-xs font-medium text-primary">
                  Recommended
                </span>
              )}
            </div>

            {/* Price label only — Elite is earned, not a paid subscription, so no dollar amount. */}
            <div className="mt-5 flex items-baseline gap-2">
              <span
                className={cn(
                  "text-3xl font-semibold",
                  plan.recommended ? "text-gradient" : "text-foreground",
                )}
              >
                {plan.priceLabel}
              </span>
              <span className="text-sm text-muted-foreground">{plan.priceNote}</span>
            </div>

            <a
              href={plan.href}
              onClick={handleSelect(plan)}
              className={cn(
                "mt-6 inline-flex min-h-[44px] w-full items-center justify-center rounded-xl px-5 text-sm font-semibold transition-colors motion-reduce:transition-none",
                plan.recommended
                  ? "border border-primary text-foreground hover:bg-primary hover:text-primary-foreground"
                  : "bg-primary text-primary-foreground hover:opacity-90",
              )}
            >
              {plan.cta}
            </a>

            <ul className="mt-6 border-t border-border pt-5">
              {ALL_FEATURES.map((feature) => (
                <FeatureRow key={feature} label={feature} included={includedSet.has(feature)} />
              ))}
            </ul>
          </div>
        );
      })}
    </div>
  );
}
