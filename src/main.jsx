import React, { useEffect, useState } from "react";
import { createRoot } from "react-dom/client";
import Landing from "./Landing.jsx";
import AcademyApp from "./academy/AcademyApp.jsx";
import AdminApp from "./admin/AdminApp.jsx";
import "./index.css";

// Lightweight hash routing (no router dep, matching the site's hash-anchor style):
// #/learn -> the Academy learning app; everything else -> the marketing page.
function Root() {
  const [hash, setHash] = useState(typeof window !== "undefined" ? window.location.hash : "");
  useEffect(() => {
    const onHash = () => setHash(window.location.hash);
    window.addEventListener("hashchange", onHash);
    return () => window.removeEventListener("hashchange", onHash);
  }, []);
  if (hash.startsWith("#/admin")) return <AdminApp />;
  return hash.startsWith("#/learn") ? <AcademyApp /> : <Landing />;
}

createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <Root />
  </React.StrictMode>
);
