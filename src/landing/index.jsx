/* ══════════════════════════════════════════════════════════
   NEXTGEN Landing Page — Component Architecture
   
   Each section is a self-contained component.
   Shared tokens live in theme.js, content in data.js,
   animations in animations.css.
   ══════════════════════════════════════════════════════════ */

import { TEXT, BG } from "./theme.js";
import "./animations.css";

import Nav from "./Nav.jsx";
import Hero from "./Hero.jsx";
import Tracks from "./Tracks.jsx";
import HowItWorks from "./HowItWorks.jsx";
import Community from "./Community.jsx";
import Plans from "./Plans.jsx";
import Footer from "./Footer.jsx";

export default function Landing() {
  return (
    <div
      id="top"
      style={{
        background: BG,
        minHeight: "100vh",
        color: TEXT,
        fontFamily: "'Inter',system-ui,-apple-system,sans-serif",
        overflowX: "hidden",
      }}
    >
      <style>{`
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
        html{scroll-behavior:smooth}
        a:hover{color:${TEXT}}
      `}</style>
      <Nav />
      <Hero />
      <Tracks />
      <HowItWorks />
      <Community />
      <Plans />
      <Footer />
    </div>
  );
}
