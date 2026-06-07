import React, { useEffect, useState } from "react";
import { createRoot } from "react-dom/client";
import NextgenLanding from "./NextgenLanding.jsx";
import AcademyApp from "./academy/AcademyApp.jsx";
import "./index.css";

// Lightweight hash routing (no router dep, matching the site's existing hash-anchor
// approach): #/learn -> the Academy app; everything else -> the marketing page.
function Root() {
  const [hash, setHash] = useState(typeof window !== "undefined" ? window.location.hash : "");
  useEffect(() => {
    const onHash = () => setHash(window.location.hash);
    window.addEventListener("hashchange", onHash);
    return () => window.removeEventListener("hashchange", onHash);
  }, []);
  return hash.startsWith("#/learn") ? <AcademyApp /> : <NextgenLanding />;
}

createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <Root />
  </React.StrictMode>
);
