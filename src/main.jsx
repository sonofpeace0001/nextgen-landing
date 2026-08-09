import React, { useEffect, useState } from "react";
import { createRoot } from "react-dom/client";
import Landing from "./Landing.jsx";
import AcademyApp from "./academy/AcademyApp.jsx";
import AdminApp from "./admin/AdminApp.jsx";
import PromptsApp from "./prompts/PromptsApp.jsx";
// Self-hosted font: Geist Sans, used for both body/UI and headings (free/open,
// SIL licensed — one clean typeface throughout, the look most modern SaaS
// sites — Stripe included — reach for instead of a paid display font).
import "@fontsource/geist-sans/400.css";
import "@fontsource/geist-sans/500.css";
import "@fontsource/geist-sans/600.css";
import "@fontsource/geist-sans/700.css";
import "./index.css";

// Password-recovery links from Supabase land on the site root with a token in
// the URL hash. Captured synchronously at load, before the auth client consumes
// and cleans the hash, so we can route the arrival into the Academy.
const arrivedFromRecovery =
  typeof window !== "undefined" && window.location.hash.includes("type=recovery");

// Lightweight hash routing (no router dep, matching the site's hash-anchor style):
// #/learn -> the Academy learning app; #/prompts -> the Elite Prompt Library;
// everything else -> the marketing page.
function Root() {
  const [hash, setHash] = useState(typeof window !== "undefined" ? window.location.hash : "");
  useEffect(() => {
    const onHash = () => setHash(window.location.hash);
    window.addEventListener("hashchange", onHash);
    return () => window.removeEventListener("hashchange", onHash);
  }, []);
  if (hash.startsWith("#/admin")) return <AdminApp />;
  if (arrivedFromRecovery) return <AcademyApp />;
  if (hash.startsWith("#/prompts")) return <PromptsApp />;
  return hash.startsWith("#/learn") ? <AcademyApp /> : <Landing />;
}

createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <Root />
  </React.StrictMode>
);
