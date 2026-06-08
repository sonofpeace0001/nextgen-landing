import React from "react";
import { createRoot } from "react-dom/client";
import Landing from "./Landing.jsx";
import "./index.css";

createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <Landing />
  </React.StrictMode>
);
