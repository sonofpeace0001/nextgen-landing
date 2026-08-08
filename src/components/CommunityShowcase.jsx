import { useEffect, useRef, useState } from "react";

// Same Discord invite used elsewhere on the page (Landing.jsx's DISCORD_URL) —
// not a new link.
const DISCORD_URL = "https://discord.gg/HDgMdVECwF";

// TODO: add the real screenshot at public/community.png (a daily prompt +
// replies from the NEXTGEN Discord). Until it exists, a neutral bordered
// placeholder renders instead, so the build and the page never break.
const SCREENSHOT_SRC = "/community.png";

const BENEFITS = [
  { title: "A question gets answered", desc: "ask anything, any level, no judgment." },
  { title: "Something new every day", desc: "a prompt or challenge to keep you moving." },
  { title: "People building alongside you", desc: "rough drafts, real projects, shared openly." },
];

const prefersReducedMotion =
  typeof window !== "undefined" && window.matchMedia
    ? window.matchMedia("(prefers-reduced-motion: reduce)").matches
    : false;

function FadeUp({ children, delay = 0 }) {
  const ref = useRef(null);
  const [shown, setShown] = useState(prefersReducedMotion);
  useEffect(() => {
    if (prefersReducedMotion || !ref.current) return;
    const observer = new IntersectionObserver(
      ([entry]) => {
        if (entry.isIntersecting) {
          setShown(true);
          observer.disconnect();
        }
      },
      { threshold: 0.15 },
    );
    observer.observe(ref.current);
    return () => observer.disconnect();
  }, []);
  return (
    <div
      ref={ref}
      className="transition-all duration-700 ease-out motion-reduce:transition-none"
      style={
        prefersReducedMotion
          ? undefined
          : { opacity: shown ? 1 : 0, transform: shown ? "none" : "translateY(14px)", transitionDelay: `${delay}ms` }
      }
    >
      {children}
    </div>
  );
}

function ScreenshotSlot() {
  const [broken, setBroken] = useState(false);
  return (
    <div className="aspect-[4/3] w-full overflow-hidden rounded-xl border border-border sm:aspect-square">
      {broken ? (
        <div className="flex h-full w-full items-center justify-center bg-[color-mix(in_srgb,var(--foreground)_4%,var(--background))] px-6 text-center">
          <span className="text-sm text-muted-foreground">a look inside the NEXTGEN Discord</span>
        </div>
      ) : (
        <img
          src={SCREENSHOT_SRC}
          alt="A daily prompt and replies in the NEXTGEN Discord"
          className="h-full w-full object-cover"
          loading="lazy"
          onError={() => setBroken(true)}
        />
      )}
    </div>
  );
}

export function CommunityShowcase() {
  return (
    <section id="inside" className="mx-auto max-w-6xl px-6 py-24 sm:py-32">
      <div className="grid grid-cols-1 items-center gap-10 lg:grid-cols-2 lg:gap-16">
        <FadeUp>
          <ScreenshotSlot />
        </FadeUp>
        <FadeUp delay={80}>
          <h2 className="font-heading text-3xl font-semibold tracking-tight text-foreground sm:text-4xl">
            This is what it looks like inside
          </h2>
          <div className="mt-8 divide-y divide-border border-t border-border">
            {BENEFITS.map((b) => (
              <div key={b.title} className="py-4">
                <h3 className="text-[15px] font-semibold text-foreground">{b.title}</h3>
                <p className="mt-1 text-sm leading-relaxed text-muted-foreground">{b.desc}</p>
              </div>
            ))}
          </div>
          <a
            href={DISCORD_URL}
            target="_blank"
            rel="noopener noreferrer"
            className="mt-6 inline-flex min-h-[44px] items-center text-sm font-medium text-muted-foreground transition-colors hover:text-foreground motion-reduce:transition-none"
          >
            Join the community
          </a>
        </FadeUp>
      </div>
    </section>
  );
}
