import { useEffect, useState } from "react";
import { Lock } from "lucide-react";
import { getMyAccess, unlockAccess } from "../lib/access.js";
import { onAuthChange } from "../lib/auth.js";
import { ResourceBrowser } from "./ResourceBrowser.jsx";
import { PromptBrowser } from "./PromptBrowser.jsx";

function TopBar() {
  return (
    <header className="border-b border-border">
      <div className="mx-auto flex h-16 max-w-6xl items-center justify-between px-6">
        <a href="#top" className="flex items-center gap-2.5" aria-label="NEXTGEN home">
          <img src="/logo.png" alt="" aria-hidden="true" className="h-7 w-auto" />
          <span className="font-heading text-[17px] font-semibold tracking-tight text-foreground">NEXTGEN</span>
        </a>
        <nav className="flex items-center gap-5 text-sm text-muted-foreground">
          <a href="#/learn" className="transition-colors hover:text-foreground">Academy</a>
          <a href="#top" className="transition-colors hover:text-foreground">Home</a>
        </nav>
      </div>
    </header>
  );
}

function LockedState({ signedIn, onUnlocked }) {
  const [code, setCode] = useState("");
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState("");

  const submit = async (e) => {
    e.preventDefault();
    setError("");
    if (!code.trim()) return;
    setBusy(true);
    try {
      const ok = await unlockAccess(code);
      if (ok) onUnlocked();
      else setError("That code is not valid. Check the Elite channel for the current one.");
    } catch (err) {
      setError(err.message || "Could not check that code right now. Try again in a moment.");
    } finally {
      setBusy(false);
    }
  };

  return (
    <div className="mx-auto flex max-w-md flex-col items-center px-6 py-20 text-center sm:py-28">
      <span className="grid h-12 w-12 place-items-center rounded-full border border-border text-primary">
        <Lock size={22} aria-hidden="true" />
      </span>
      <h1 className="mt-5 font-heading text-3xl font-semibold tracking-tight text-foreground">NEXTGEN Library</h1>
      <p className="mt-4 text-[15px] leading-relaxed text-muted-foreground">
        Hundreds of ready-to-paste prompts plus glossaries, tool guides, templates and checklists for every category. The Library is for Elite members and people with an access code.
      </p>

      {!signedIn ? (
        <div className="mt-8 flex w-full flex-col gap-3">
          <a
            href="#/learn"
            className="inline-flex min-h-[44px] items-center justify-center rounded-lg bg-primary px-6 text-sm font-semibold text-primary-foreground transition-opacity hover:opacity-90"
          >
            Sign in or create a free account
          </a>
          <p className="text-xs text-muted-foreground">Then come back here and enter your code, or become Elite.</p>
        </div>
      ) : (
        <form onSubmit={submit} className="mt-8 flex w-full flex-col gap-3 sm:flex-row">
          <input
            value={code}
            onChange={(e) => setCode(e.target.value)}
            placeholder="Access code"
            autoCapitalize="off"
            autoCorrect="off"
            spellCheck="false"
            aria-label="Access code"
            className="h-11 flex-1 rounded-lg border border-border bg-background px-4 text-sm text-foreground placeholder:text-muted-foreground focus:border-primary focus:outline-none"
          />
          <button
            type="submit"
            disabled={busy || !code.trim()}
            className="inline-flex min-h-[44px] items-center justify-center rounded-lg bg-primary px-6 text-sm font-semibold text-primary-foreground transition-opacity hover:opacity-90 disabled:opacity-60"
          >
            {busy ? "Checking…" : "Unlock"}
          </button>
        </form>
      )}
      {error && <p className="mt-3 text-sm text-red-400">{error}</p>}

      <a
        href="#plans"
        className="mt-8 inline-flex min-h-[44px] items-center text-sm text-muted-foreground underline-offset-4 transition-colors hover:text-foreground hover:underline"
      >
        How do I become Elite?
      </a>
    </div>
  );
}

function tabFromHash() {
  return typeof window !== "undefined" && window.location.hash.startsWith("#/prompts") ? "prompts" : "guides";
}

export default function LibraryApp() {
  const [state, setState] = useState({ loading: true, signedIn: false, full: false });
  const [tab, setTab] = useState(tabFromHash());

  const refresh = () => getMyAccess().then((a) => setState({ loading: false, ...a })).catch(() => setState({ loading: false, signedIn: false, full: false }));

  useEffect(() => {
    document.title = "Library | NEXTGEN";
    refresh();
    const off = onAuthChange(() => refresh());
    return off;
  }, []);

  return (
    <div className="min-h-screen bg-background text-foreground" style={{ fontFamily: "'Inter',system-ui,sans-serif" }}>
      <TopBar />
      {state.loading ? (
        <p className="py-24 text-center text-sm text-muted-foreground">Loading…</p>
      ) : !state.full ? (
        <LockedState signedIn={state.signedIn} onUnlocked={refresh} />
      ) : (
        <main className="mx-auto max-w-6xl px-6 py-10 sm:py-14">
          <p className="text-[13px] font-medium uppercase tracking-[0.14em] text-muted-foreground">Elite and access-code members</p>
          <h1 className="mt-3 font-heading text-3xl font-semibold tracking-tight sm:text-4xl">NEXTGEN Library</h1>
          <div className="mt-6 flex gap-2" role="tablist" aria-label="Library sections">
            {[
              { id: "guides", label: "Guides and templates" },
              { id: "prompts", label: "Prompts" },
            ].map((t) => (
              <button
                key={t.id}
                type="button"
                role="tab"
                aria-selected={tab === t.id}
                onClick={() => setTab(t.id)}
                className={`min-h-[40px] rounded-full border px-4 text-sm font-medium transition-colors ${
                  tab === t.id ? "border-primary bg-primary/10 text-foreground" : "border-border text-muted-foreground hover:text-foreground"
                }`}
              >
                {t.label}
              </button>
            ))}
          </div>
          <div className="mt-8">{tab === "guides" ? <ResourceBrowser /> : <PromptBrowser />}</div>
        </main>
      )}
    </div>
  );
}
