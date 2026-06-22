// ⚠️ PLACEHOLDER testimonials — fictional examples written for layout only.
// They are NOT real people or real quotes. Replace with real, consented
// testimonials (pass a `testimonials` prop) before promoting these publicly.
const DEFAULT_TESTIMONIALS = [
  { quote: "I wrote my first useful prompt on day one and actually used it at work that same afternoon.", name: "Ama", role: "Started at Novice" },
  { quote: "I had zero tech background. One small assignment a day made it feel doable instead of overwhelming.", name: "Daniel", role: "AI Basic" },
  { quote: "The community is the part I didn't expect. People actually answer when you're stuck.", name: "Priya", role: "Community member" },
  { quote: "Showing up for one task a day added up a lot faster than I thought it would.", name: "Marcus", role: "30-day path" },
  { quote: "It finally clicked that AI is a skill you practice, not a magic button you press.", name: "Lena", role: "Intermediate" },
  { quote: "I went from just curious to shipping a small project I could actually show people.", name: "Tunde", role: "Expert track" },
];

function initials(name) {
  return name
    .split(" ")
    .map((w) => w[0])
    .join("")
    .slice(0, 2)
    .toUpperCase();
}

function TestimonialCard({ quote, name, role }) {
  return (
    <figure className="h-full rounded-xl border border-border bg-[color-mix(in_srgb,var(--foreground)_4%,var(--background))] p-6 transition-shadow hover:ring-2 hover:ring-primary motion-reduce:transition-none">
      <blockquote className="text-sm leading-relaxed text-foreground">&ldquo;{quote}&rdquo;</blockquote>
      <figcaption className="mt-5 flex items-center gap-3">
        <span
          aria-hidden="true"
          className="flex h-9 w-9 shrink-0 items-center justify-center rounded-full border border-border text-xs font-semibold text-muted-foreground"
        >
          {initials(name)}
        </span>
        <span className="flex flex-col">
          <span className="text-sm font-semibold text-foreground">{name}</span>
          <span className="text-xs text-muted-foreground">{role}</span>
        </span>
      </figcaption>
    </figure>
  );
}

export function Testimonials({ testimonials = DEFAULT_TESTIMONIALS }) {
  if (!testimonials || testimonials.length === 0) return null;
  return (
    <section id="testimonials" className="mx-auto max-w-6xl px-6 py-20 sm:py-28">
      <h2 className="font-heading text-3xl font-semibold tracking-tight text-foreground sm:text-4xl">
        What members say
      </h2>
      <div className="mt-10 grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
        {testimonials.map((t, i) => (
          <TestimonialCard key={`${t.name}-${i}`} quote={t.quote} name={t.name} role={t.role} />
        ))}
      </div>
    </section>
  );
}
