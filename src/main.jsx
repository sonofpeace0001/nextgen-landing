import React from "react";
import { createRoot } from "react-dom/client";
import NextgenLanding from "./NextgenLanding.jsx";
import "./index.css";

createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <NextgenLanding />
  </React.StrictMode>
);
