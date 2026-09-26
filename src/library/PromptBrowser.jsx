import { useEffect, useMemo, useState } from "react";
import { Copy, Check } from "lucide-react";
import { fetchCategoriesWithSubcategories, fetchPromptsForSubcategory } from "../lib/prompts.js";

function DifficultyPill({ difficulty }) {
  return (
    <span className="inline-flex items-center rounded-full border border-border px-2 py-0.5 text-[11px] font-medium capitalize text-muted-foreground">
      {difficulty}
    </span>
  );
}

function PromptCard({ prompt }) {
  const [copied, setCopied] = useState(false);

  const copy = async () => {
    try {
      if (navigator.clipboard?.writeText) {
        await navigator.clipboard.writeText(prompt.body);
      } else {
        // Fallback for browsers/contexts without the async Clipboard API.
        const ta = document.createElement("textarea");
        ta.value = prompt.body;
        ta.style.position = "fixed";
        ta.style.opacity = "0";
        document.body.appendChild(ta);
        ta.focus();
        ta.select();
        document.execCommand("copy");
        document.body.removeChild(ta);
      }
      setCopied(true);
      setTimeout(() => setCopied(false), 1500);
    } catch {
      // Clipboard can fail (permissions, insecure context) — fail quietly, no crash.
    }
  };

  return (
    <div className="rounded-xl border border-border p-5">
      <div className="flex items-start justify-between gap-3">
        <h3 className="text-[15px] font-semibold text-foreground">{prompt.title}</h3>
        <DifficultyPill difficulty={prompt.difficulty} />
      </div>
      <pre className="mt-3 whitespace-pre-wrap break-words rounded-lg border border-border bg-[color-mix(in_srgb,var(--foreground)_4%,var(--background))] p-3 font-mono text-[13px] leading-relaxed text-foreground">
        {prompt.body}
      </pre>
      {prompt.swap_note && <p className="mt-2 text-xs text-muted-foreground">{prompt.swap_note}</p>}
      <button
        type="button"
        onClick={copy}
        className="mt-3 inline-flex min-h-[44px] items-center gap-2 rounded-lg border border-border px-4 text-sm font-medium text-foreground transition-colors hover:border-primary"
      >
        {copied ? <Check size={15} className="text-primary" /> : <Copy size={15} />}
        {copied ? "Copied" : "Copy"}
      </button>
    </div>
  );
}

export function PromptBrowser() {
  const [categories, setCategories] = useState(null);
  const [categoriesError, setCategoriesError] = useState("");
  const [selectedCategoryId, setSelectedCategoryId] = useState(null);
  const [selectedSubcategoryId, setSelectedSubcategoryId] = useState(null);
  const [prompts, setPrompts] = useState(null);
  const [promptsError, setPromptsError] = useState("");
  const [promptsLoading, setPromptsLoading] = useState(false);
  const [search, setSearch] = useState("");

  useEffect(() => {
    let active = true;
    fetchCategoriesWithSubcategories()
      .then((cats) => {
        if (!active) return;
        setCategories(cats);
        const first = cats[0];
        if (first) {
          setSelectedCategoryId(first.id);
          setSelectedSubcategoryId(first.prompt_subcategories?.[0]?.id ?? null);
        }
      })
      .catch(() => active && setCategoriesError("could not load the prompt library right now. try refreshing the page."));
    return () => {
      active = false;
    };
  }, []);

  useEffect(() => {
    if (!selectedSubcategoryId) return;
    let active = true;
    setPromptsLoading(true);
    setPromptsError("");
    fetchPromptsForSubcategory(selectedSubcategoryId)
      .then((p) => active && setPrompts(p))
      .catch(() => active && setPromptsError("could not load these prompts right now. try again in a moment."))
      .finally(() => active && setPromptsLoading(false));
    return () => {
      active = false;
    };
  }, [selectedSubcategoryId]);

  const selectedCategory = categories?.find((c) => c.id === selectedCategoryId) ?? null;
  const subcategories = selectedCategory?.prompt_subcategories ?? [];

  const visiblePrompts = useMemo(() => {
    if (!prompts) return [];
    const q = search.trim().toLowerCase();
    if (!q) return prompts;
    return prompts.filter((p) => p.title.toLowerCase().includes(q) || p.body.toLowerCase().includes(q));
  }, [prompts, search]);

  const selectCategory = (cat) => {
    setSelectedCategoryId(cat.id);
    setSelectedSubcategoryId(cat.prompt_subcategories?.[0]?.id ?? null);
    setSearch("");
  };

  if (categoriesError) {
    return (
      <div className="py-16 text-center">
        <p className="text-sm text-muted-foreground">{categoriesError}</p>
      </div>
    );
  }

  if (!categories) {
    return (
      <div className="py-16 text-center">
        <p className="text-sm text-muted-foreground">loading…</p>
      </div>
    );
  }

  return (
    <div>
      <div className="grid grid-cols-1 gap-8 md:grid-cols-[200px_1fr] md:gap-10">
        {/* Categories: sidebar on desktop, horizontal tabs on mobile */}
        <nav className="flex gap-2 overflow-x-auto pb-2 md:flex-col md:overflow-visible md:pb-0">
          {categories.map((cat) => (
            <button
              key={cat.id}
              type="button"
              onClick={() => selectCategory(cat)}
              className={
                "min-h-[44px] shrink-0 rounded-lg px-3 text-left text-sm font-medium transition-colors md:shrink " +
                (cat.id === selectedCategoryId
                  ? "bg-[color-mix(in_srgb,var(--foreground)_6%,var(--background))] text-foreground"
                  : "text-muted-foreground hover:text-foreground")
              }
            >
              {cat.name}
            </button>
          ))}
        </nav>

        <div>
          {selectedCategory?.description && (
            <p className="text-sm text-muted-foreground">{selectedCategory.description}</p>
          )}

          {/* Subcategories */}
          <div className="mt-4 flex flex-wrap gap-2">
            {subcategories.map((sub) => (
              <button
                key={sub.id}
                type="button"
                onClick={() => setSelectedSubcategoryId(sub.id)}
                className={
                  "inline-flex min-h-[36px] items-center rounded-full border px-3 text-sm transition-colors " +
                  (sub.id === selectedSubcategoryId
                    ? "border-primary text-primary"
                    : "border-border text-muted-foreground hover:text-foreground")
                }
              >
                {sub.name}
              </button>
            ))}
          </div>

          {/* Search */}
          <input
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            placeholder="search this category…"
            className="mt-5 h-11 w-full max-w-sm rounded-lg border border-border bg-background px-4 text-sm text-foreground placeholder:text-muted-foreground focus:border-primary focus:outline-none"
          />

          {/* Prompts */}
          <div className="mt-6 grid grid-cols-1 gap-4 sm:grid-cols-2">
            {promptsLoading && <p className="text-sm text-muted-foreground">loading…</p>}
            {!promptsLoading && promptsError && <p className="text-sm text-muted-foreground">{promptsError}</p>}
            {!promptsLoading && !promptsError && prompts && prompts.length === 0 && (
              <p className="text-sm text-muted-foreground">nothing here yet — more prompts coming.</p>
            )}
            {!promptsLoading &&
              !promptsError &&
              prompts &&
              prompts.length > 0 &&
              visiblePrompts.length === 0 && <p className="text-sm text-muted-foreground">no prompts match that search.</p>}
            {!promptsLoading &&
              !promptsError &&
              visiblePrompts.map((p) => <PromptCard key={p.id} prompt={p} />)}
          </div>
        </div>
      </div>
    </div>
  );
}

