import { cn } from "@/lib/utils";

const X_URL = "https://x.com/G_NEXTGEN";

const COLUMNS = [
  {
    title: "Community",
    links: [
      { label: "Join", href: "#/learn" },
      { label: "FAQ", href: "#faq" },
    ],
  },
  {
    title: "About",
    links: [
      { label: "What is NEXTGEN", href: "#how" },
      { label: "Learning Paths", href: "#tracks" },
      { label: "Elite", href: "#plans" },
    ],
  },
  {
    title: "Social",
    links: [{ label: "X / Twitter", href: X_URL, external: true }],
  },
];

function XIcon({ className }) {
  return (
    <svg viewBox="0 0 24 24" fill="currentColor" aria-hidden="true" className={cn("h-[18px] w-[18px]", className)}>
      <path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z" />
    </svg>
  );
}

const linkClass =
  "text-sm text-muted-foreground transition-colors hover:text-primary motion-reduce:transition-none";

export function Footer() {
  const year = new Date().getFullYear();
  return (
    <footer className="border-t border-border">
      <div className="mx-auto max-w-6xl px-6 py-12">
        <div className="flex flex-col gap-10 md:flex-row md:justify-between">
          {/* Brand */}
          <div className="max-w-xs">
            <a href="#top" className="flex items-center gap-2.5" aria-label="NEXTGEN home">
              <img src="/logo.png" alt="" aria-hidden="true" className="h-7 w-auto" />
              <span className="font-heading text-[17px] font-semibold tracking-tight text-foreground">NEXTGEN</span>
            </a>
            <p className="mt-3 text-sm text-muted-foreground">learn AI from zero</p>
          </div>

          {/* Link columns */}
          <div className="grid grid-cols-1 gap-8 sm:grid-cols-3">
            {COLUMNS.map((col) => (
              <div key={col.title}>
                <h3 className="text-sm font-semibold text-foreground">{col.title}</h3>
                <ul className="mt-3 space-y-2.5">
                  {col.links.map((link) => (
                    <li key={link.label}>
                      <a
                        href={link.href}
                        className={linkClass}
                        {...(link.external ? { target: "_blank", rel: "noopener noreferrer" } : {})}
                      >
                        {link.label}
                      </a>
                    </li>
                  ))}
                </ul>
              </div>
            ))}
          </div>
        </div>

        {/* Bottom row */}
        <div className="mt-10 flex flex-col gap-4 border-t border-border pt-6 sm:flex-row sm:items-center sm:justify-between">
          <p className="text-sm text-muted-foreground">© {year} NEXTGEN</p>
          <div className="flex items-center gap-4">
            <a
              href={X_URL}
              target="_blank"
              rel="noopener noreferrer"
              aria-label="NEXTGEN on X"
              className="text-muted-foreground transition-colors hover:text-primary motion-reduce:transition-none"
            >
              <XIcon />
            </a>
          </div>
        </div>
      </div>
    </footer>
  );
}
