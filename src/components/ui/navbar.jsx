import { useState, useEffect } from "react";
import { Menu, X } from "lucide-react";
import { cn } from "@/lib/utils";

// Anchor links to existing page sections. Adjust hrefs if section ids change.
const NAV_LINKS = [
  { label: "What is NEXTGEN", href: "#how" },
  { label: "Learning Paths", href: "#tracks" },
  { label: "Elite", href: "#plans" },
  { label: "FAQ", href: "#faq" },
];

// TODO: point these at the real auth / signup routes if they differ.
const LOGIN_HREF = "#/learn";
const JOIN_HREF = "#/learn";

function useScrolled(threshold = 24) {
  const [scrolled, setScrolled] = useState(false);
  useEffect(() => {
    const onScroll = () => setScrolled(window.scrollY > threshold);
    onScroll();
    window.addEventListener("scroll", onScroll, { passive: true });
    return () => window.removeEventListener("scroll", onScroll);
  }, [threshold]);
  return scrolled;
}

function Wordmark({ onClick }) {
  // Reuses the existing /logo.png asset (no SVG wordmark recreation).
  return (
    <a href="#top" onClick={onClick} className="flex items-center gap-2.5" aria-label="NEXTGEN home">
      <img src="/logo.png" alt="" aria-hidden="true" className="h-7 w-auto" />
      <span className="font-heading text-[17px] font-semibold tracking-tight text-foreground">NEXTGEN</span>
    </a>
  );
}

export function Navbar() {
  const scrolled = useScrolled(24);
  const [open, setOpen] = useState(false);
  const close = () => setOpen(false);

  // Lock body scroll while the mobile panel is open.
  useEffect(() => {
    if (!open) return;
    const prev = document.body.style.overflow;
    document.body.style.overflow = "hidden";
    return () => {
      document.body.style.overflow = prev;
    };
  }, [open]);

  return (
    <header
      className={cn(
        "fixed inset-x-0 top-0 z-50 border-b transition-colors duration-200 motion-reduce:transition-none",
        scrolled
          ? "border-border bg-[color-mix(in_srgb,var(--background)_85%,transparent)] backdrop-blur"
          : "border-transparent bg-transparent",
      )}
    >
      <nav className="mx-auto flex h-16 max-w-6xl items-center justify-between px-6">
        <Wordmark />

        <div className="hidden items-center gap-8 lg:flex">
          {NAV_LINKS.map((link) => (
            <a
              key={link.label}
              href={link.href}
              className="text-sm text-muted-foreground transition-colors hover:text-foreground motion-reduce:transition-none"
            >
              {link.label}
            </a>
          ))}
        </div>

        <div className="hidden items-center gap-3 lg:flex">
          <a
            href={LOGIN_HREF}
            className="text-sm font-medium text-muted-foreground transition-colors hover:text-foreground motion-reduce:transition-none"
          >
            Log in
          </a>
          <a
            href={JOIN_HREF}
            className="inline-flex min-h-[40px] items-center justify-center rounded-lg bg-primary px-4 text-sm font-semibold text-primary-foreground transition-opacity hover:opacity-90 motion-reduce:transition-none"
          >
            Join free
          </a>
        </div>

        <button
          type="button"
          onClick={() => setOpen((v) => !v)}
          aria-label={open ? "Close menu" : "Open menu"}
          aria-expanded={open}
          className="inline-flex h-11 w-11 items-center justify-center text-foreground lg:hidden"
        >
          {open ? <X size={22} /> : <Menu size={22} />}
        </button>
      </nav>

      {/* Mobile slide-in panel */}
      <div
        className={cn(
          "fixed inset-x-0 bottom-0 top-16 z-40 transition-transform duration-200 motion-reduce:transition-none lg:hidden",
          open ? "translate-x-0" : "pointer-events-none translate-x-full",
        )}
        aria-hidden={!open}
      >
        <div className="flex h-full flex-col border-t border-border bg-background px-6 py-4">
          {NAV_LINKS.map((link) => (
            <a
              key={link.label}
              href={link.href}
              onClick={close}
              className="flex min-h-[44px] items-center border-b border-border text-base text-foreground"
            >
              {link.label}
            </a>
          ))}
          <div className="mt-6 flex flex-col gap-3">
            <a
              href={LOGIN_HREF}
              onClick={close}
              className="inline-flex min-h-[44px] items-center justify-center rounded-lg border border-border text-sm font-semibold text-foreground"
            >
              Log in
            </a>
            <a
              href={JOIN_HREF}
              onClick={close}
              className="inline-flex min-h-[44px] items-center justify-center rounded-lg bg-primary text-sm font-semibold text-primary-foreground"
            >
              Join free
            </a>
          </div>
        </div>
      </div>
    </header>
  );
}
