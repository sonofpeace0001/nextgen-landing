import { useEffect, useMemo, useState } from "react";
import { Copy, Check } from "lucide-react";
import {
  fetchCategoriesWithSubcategories,
  fetchPromptsForSubcategory,
  checkElitePromptCode,
} from "../lib/prompts.js";

// sessionStorage (NOT localStorage) so the unlock only lasts this browser tab
// session — closing the tab re-locks the library next time.
const UNLOCK_KEY = "nextgen_prompts_unlocked";

function TopBar() {
  return (
    <header className="border-b border-border">
      <div className="mx-auto flex h-16 max-w-6xl items-center justify-between px-6">
        <a href="#top" className="flex items-center gap-2.5" aria-label="NEXTGEN home">
          <img src="/logo.png" alt="" aria-hidden="true" className="h-7 w-auto" />
          <span className="font-heading text-[17px] font-semibold tracking-tight text-foreground">NEXTGEN</span>
        </a>
        <a href="#top" className="text-sm text-muted-foreground transition-colors hover:text-foreground">
          back to NEXTGEN
        </a>
      </div>
    </header>
  );
}

function LockedState({ onUnlocked }) {
  const [code, setCode] = useState("");
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState("");

  const submit = async (e) => {
    e.preventDefault();
    setError("");
    if (!code.trim()) return;
    setBusy(true);
    try {
      const ok = await checkElitePromptCode(code);
      if (ok) {
        sessionStorage.setItem(UNLOCK_KEY, "1");
        onUnlocked();
      } else {
        setError("that code isn't right — check the Elite channel for the current one.");
      }
    } catch {
      // Never leak the underlying error (or the code) — just a plain retry message.
      setError("could not check that code right now. try again in a moment.");
    } finally {
      setBusy(false);
    }
  };

  return (
    <div className="mx-auto flex max-w-md flex-col items-center px-6 py-24 text-center sm:py-32">
      <h1 className="font-heading text-3xl font-semibold tracking-tight text-foreground">Elite Prompt Library</h1>
      <p className="mt-4 text-[15px] leading-relaxed text-muted-foreground">
        a growing library of prompts for writing, image, video, agents and more. access is for NEXTGEN Elite
        members.
      </p>

      <form onSubmit={submit} className="mt-8 flex w-full flex-col gap-3 sm:flex-row">
        <input
          value={code}
          onChange={(e) => setCode(e.target.value)}
          placeholder="Elite code"
          autoCapitalize="off"
          autoCorrect="off"
          spellCheck="false"
          className="h-11 flex-1 rounded-lg border border-border bg-background px-4 text-sm text-foreground placeholder:text-muted-foreground focus:border-primary focus:outline-none"
        />
        <button
          type="submit"
          disabled={busy || !code.trim()}
          className="inline-flex min-h-[44px] items-center justify-center rounded-lg bg-primary px-6 text-sm font-semibold text-primary-foreground transition-opacity hover:opacity-90 disabled:opacity-60"
        >
          {busy ? "checking…" : "Unlock"}
        </button>
      </form>
      {error && <p className="mt-3 text-sm text-red-400">{error}</p>}

      <a
        href="#plans"
        className="mt-8 inline-flex min-h-[44px] items-center text-sm text-muted-foreground underline-offset-4 transition-colors hover:text-foreground hover:underline"
      >
        how do I become Elite?
      </a>
    </div>
  );
}

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

function LibraryState() {
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
      <div className="mx-auto max-w-md px-6 py-24 text-center">
        <p className="text-sm text-muted-foreground">{categoriesError}</p>
      </div>
    );
  }

  if (!categories) {
    return (
      <div className="mx-auto max-w-6xl px-6 py-24 text-center">
        <p className="text-sm text-muted-foreground">loading…</p>
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-6xl px-6 py-10 sm:py-14">
      <h1 className="font-heading text-2xl font-semibold tracking-tight text-foreground sm:text-3xl">
        Elite Prompt Library
      </h1>

      <div className="mt-8 grid grid-cols-1 gap-8 md:grid-cols-[200px_1fr] md:gap-10">
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

export default function PromptsApp() {
  const [unlocked, setUnlocked] = useState(
    typeof window !== "undefined" && sessionStorage.getItem(UNLOCK_KEY) === "1",
  );

  return (
    <div className="min-h-screen bg-background text-foreground">
      <TopBar />
      {unlocked ? <LibraryState /> : <LockedState onUnlocked={() => setUnlocked(true)} />}
    </div>
  );
}
