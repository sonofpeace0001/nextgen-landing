import { useEffect, useMemo, useState } from "react";
import { Copy, Check, ChevronDown } from "lucide-react";
import { fetchResources, filterResources, KIND_LABEL } from "../lib/resources.js";
import { GOALS } from "../lib/goalTracks.js";
import { Markdown } from "../components/Markdown.jsx";

const CATEGORIES = [
  { id: "all", label: "All" },
  { id: "general", label: "Start here" },
  ...GOALS.filter((g) => g.id !== "unsure").map((g) => ({ id: g.id, label: g.label })),
];
const KINDS = [{ id: "all", label: "All types" }, ...Object.entries(KIND_LABEL).map(([id, label]) => ({ id, label }))];

function Chip({ active, onClick, children }) {
  return (
    <button
      type="button"
      onClick={onClick}
      aria-pressed={active}
      className={`min-h-[36px] rounded-full border px-3.5 text-[13px] font-medium transition-colors ${
        active ? "border-primary bg-primary/10 text-foreground" : "border-border text-muted-foreground hover:text-foreground"
      }`}
    >
      {children}
    </button>
  );
}

function ResourceCard({ r, label }) {
  const [open, setOpen] = useState(false);
  const [copied, setCopied] = useState(false);
  const copy = async () => {
    try {
      await navigator.clipboard.writeText(`${r.title}\n\n${r.body_md}`);
      setCopied(true);
      setTimeout(() => setCopied(false), 1500);
    } catch {
      /* clipboard can be blocked; nothing else to do */
    }
  };
  return (
    <article className="rounded-xl border border-border">
      <button
        type="button"
        onClick={() => setOpen((o) => !o)}
        aria-expanded={open}
        className="flex w-full items-start justify-between gap-4 p-5 text-left"
      >
        <span>
          <span className="mb-1.5 flex flex-wrap gap-2 text-[11px] font-medium uppercase tracking-wide text-muted-foreground">
            <span>{label}</span>
            <span aria-hidden="true">·</span>
            <span>{KIND_LABEL[r.kind] ?? r.kind}</span>
          </span>
          <span className="block text-[16px] font-semibold text-foreground">{r.title}</span>
          {r.summary && <span className="mt-1 block text-sm text-muted-foreground">{r.summary}</span>}
        </span>
        <ChevronDown size={18} aria-hidden="true" className={`mt-1 shrink-0 text-muted-foreground transition-transform ${open ? "rotate-180" : ""}`} />
      </button>
      {open && (
        <div className="border-t border-border px-5 pb-5 pt-4 text-[15px] text-foreground">
          <Markdown text={r.body_md} />
          <button
            type="button"
            onClick={copy}
            className="mt-2 inline-flex min-h-[40px] items-center gap-2 rounded-lg border border-border px-4 text-sm font-medium transition-colors hover:border-primary"
          >
            {copied ? <Check size={16} aria-hidden="true" /> : <Copy size={16} aria-hidden="true" />}
            {copied ? "Copied" : "Copy to use"}
          </button>
        </div>
      )}
    </article>
  );
}

export function ResourceBrowser() {
  const [items, setItems] = useState(null);
  const [error, setError] = useState("");
  const [category, setCategory] = useState("all");
  const [kind, setKind] = useState("all");
  const [query, setQuery] = useState("");

  useEffect(() => {
    fetchResources().then(setItems).catch(() => setError("Could not load the library. Try again in a moment."));
  }, []);

  const labelFor = useMemo(() => Object.fromEntries(CATEGORIES.map((c) => [c.id, c.label])), []);
  const shown = useMemo(() => (items ? filterResources(items, { category, kind, query }) : []), [items, category, kind, query]);

  return (
    <div>
      <p className="max-w-2xl text-[15px] leading-relaxed text-muted-foreground">
        Glossaries, tool guides, templates, checklists, how-tos and sample prompts for every NEXTGEN category. Open a card, read it, and copy what you need.
      </p>
      <div>
        <label className="mt-6 block">
          <span className="sr-only">Search the library</span>
          <input
            type="search"
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            placeholder="Search: lighting, prompt, invoice, SQL…"
            className="h-11 w-full rounded-lg border border-border bg-background px-4 text-sm text-foreground placeholder:text-muted-foreground focus:border-primary focus:outline-none"
          />
        </label>

        <div className="mt-5 flex flex-wrap gap-2" role="group" aria-label="Category">
          {CATEGORIES.map((c) => (
            <Chip key={c.id} active={category === c.id} onClick={() => setCategory(c.id)}>{c.label}</Chip>
          ))}
        </div>
        <div className="mt-3 flex flex-wrap gap-2" role="group" aria-label="Type">
          {KINDS.map((k) => (
            <Chip key={k.id} active={kind === k.id} onClick={() => setKind(k.id)}>{k.label}</Chip>
          ))}
        </div>

        <div className="mt-8 flex flex-col gap-3">
          {error && <p className="text-sm text-red-400">{error}</p>}
          {!items && !error && <p className="text-sm text-muted-foreground">Loading…</p>}
          {items && shown.length === 0 && <p className="text-sm text-muted-foreground">Nothing matches. Try another word or clear a filter.</p>}
          {shown.map((r) => (
            <ResourceCard key={r.id} r={r} label={labelFor[r.category] ?? r.category} />
          ))}
        </div>

      </div>
    </div>
  );
}
