import React, { useEffect, useState } from "react";
import { createRoot } from "react-dom/client";
import Landing from "./Landing.jsx";
import AcademyApp from "./academy/AcademyApp.jsx";
import AdminApp from "./admin/AdminApp.jsx";
import PromptsApp from "./prompts/PromptsApp.jsx";
// Self-hosted font stack, matching the NEXTGEN Graphics Learning Academy site:
// Playfair Display for display headings, Inter for body/UI copy, Montserrat
// for eyebrows/labels/accents.
import "@fontsource/playfair-display/400.css";
import "@fontsource/playfair-display/500.css";
import "@fontsource/playfair-display/600.css";
import "@fontsource/playfair-display/700.css";
import "@fontsource/inter/300.css";
import "@fontsource/inter/400.css";
import "@fontsource/inter/500.css";
import "@fontsource/inter/600.css";
import "@fontsource/montserrat/600.css";
import "@fontsource/montserrat/700.css";
import "@fontsource/montserrat/800.css";
import "@fontsource/montserrat/900.css";
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
