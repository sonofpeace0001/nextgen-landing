import { useEffect, useRef, useState } from "react";
import { ArrowRight } from "lucide-react";

// Same Discord invite used elsewhere on the page (Landing.jsx's DISCORD_URL) —
// not a new link.
const DISCORD_URL = "https://discord.gg/HDgMdVECwF";

// A real screenshot can still be dropped in later at public/community.png (a
// daily prompt + replies from the NEXTGEN Discord) and it will be used
// automatically. Until then — and to avoid publishing real members' names and
// avatars without a deliberate, separate okay — an illustrative, generic mock
// of the chat renders instead. Not a real screenshot, and it doesn't claim to
// be one; captures the same daily-prompt-and-replies feel without using any
// specific person's identity.
const SCREENSHOT_SRC = "/community.png";

const BENEFITS = [
  { title: "A question gets answered", desc: "ask anything, any level, no judgment." },
  { title: "Something new every day", desc: "a prompt or challenge to keep you moving." },
  { title: "People building alongside you", desc: "rough drafts, real projects, shared openly." },
];

const MOCK_MESSAGES = [
  { initials: "?", text: "just shipped my first prompt, feels good" },
  { initials: "?", text: "anyone tried the image track yet? loving it" },
  { initials: "?", text: "welcome! glad you're here, ask anything" },
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

// Illustrative mock of the Discord chat — generic initials, no real names,
// no fabricated member count (reuses the "400+" figure already stated
// elsewhere on the site rather than inventing a new number).
function MockChatPreview() {
  return (
    <div className="flex h-full w-full flex-col justify-between bg-[color-mix(in_srgb,var(--foreground)_4%,var(--background))] p-5">
      <div>
        <div className="flex items-center justify-between border-b border-border pb-3">
          <span className="text-xs font-medium text-muted-foreground"># general-chat</span>
          <span className="flex items-center gap-1.5 text-xs text-muted-foreground">
            <span className="h-1.5 w-1.5 rounded-full bg-primary" aria-hidden="true" />
            active now
          </span>
        </div>

        <div
          className="mt-3 rounded-lg border bg-[color-mix(in_srgb,var(--primary)_8%,transparent)] px-3 py-2"
          style={{ borderColor: "color-mix(in srgb, var(--primary) 40%, transparent)" }}
        >
          <span className="text-[10px] font-semibold uppercase tracking-[0.1em] text-primary">Today's prompt</span>
          <p className="mt-1 text-[13px] text-foreground">Build one small thing with AI in the next ten minutes.</p>
        </div>

        <div className="mt-4 space-y-3">
          {MOCK_MESSAGES.map((m, i) => (
            <div key={i} className="flex items-start gap-2.5">
              <span className="flex h-7 w-7 shrink-0 items-center justify-center rounded-full border border-border text-[10px] font-semibold text-muted-foreground">
                {m.initials}
              </span>
              <p className="mt-0.5 text-[13px] leading-relaxed text-muted-foreground">{m.text}</p>
            </div>
          ))}
        </div>

        <div className="mt-4 flex items-center gap-2 border-t border-border pt-3 text-[13px] text-primary">
          <ArrowRight size={14} aria-hidden="true" />
          <span>Welcome, new builder</span>
        </div>
      </div>

      <p className="mt-4 text-xs text-muted-foreground">400+ builders in the community</p>
    </div>
  );
}

function ScreenshotSlot() {
  const [broken, setBroken] = useState(false);
  return (
    <div className="aspect-[4/3] w-full overflow-hidden rounded-xl border border-border sm:aspect-square">
      {broken ? (
        <MockChatPreview />
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
