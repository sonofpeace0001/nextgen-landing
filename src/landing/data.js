/* ══════════════════════════════════════════════════════════
   NEXTGEN Content Data
   ══════════════════════════════════════════════════════════ */

import { VIOLET, INDIGO, ROSE } from "./theme.js";

export const X_URL = "https://x.com/G_NEXTGEN";
export const DISCORD_URL = "https://discord.gg/HDgMdVECwF";
export const LEARN = "#/learn";
export const FOUNDER_X_URL = "https://x.com/sonofpeace0001";

export const NAV_LINKS = [
  { label: "Tracks", href: "#tracks" },
  { label: "How it works", href: "#how" },
  { label: "Community", href: "#community" },
  { label: "Plans", href: "#plans" },
];

export const TRACKS = [
  {
    name: "Freelancing",
    blurb: "Turn a skill into paid client work, then scale it into a business.",
    icon: "💼",
    color: VIOLET,
  },
  {
    name: "Web3",
    blurb: "From wallets and self-custody to building and earning on-chain.",
    icon: "⛓️",
    color: ROSE,
  },
  {
    name: "AI",
    blurb: "Every practical AI skill — from your first prompt to shipping agents and selling the work.",
    icon: "🤖",
    color: INDIGO,
  },
];

export const TIERS = ["Basic", "Pro", "Expert", "Grandmaster"];

export const LEVELS = [
  { name: "Novice", days: 90 },
  { name: "Intermediate", days: 60 },
  { name: "Advanced", days: 30 },
];

export const LOOP_STEPS = [
  { n: "01", title: "Learn", desc: "Each day opens with one clear objective and a focused lesson — what to learn today, no filler." },
  { n: "02", title: "Improve", desc: "A specific skill focus pushes you to get better at one thing that compounds over the path." },
  { n: "03", title: "Assignment", desc: "Apply it the same day. Every day ends with real work, not passive watching." },
  { n: "04", title: "Score", desc: "Your work is scored against a clear rubric, with an auto-graded check to confirm you have it." },
];

export const COMPARISON_ROWS = [
  { label: "Learning paths for in-demand skills", free: true },
  { label: "A community of builders", free: true },
  { label: "Access to opportunities (jobs, gigs)", free: true },
  { label: "Start from zero, no experience needed", free: true },
  { label: "Advanced structured roadmaps", free: false },
  { label: "Exclusive and early-access opportunities", free: false },
  { label: "Direct mentorship and guidance", free: false },
  { label: "Priority access to tools and resources", free: false },
  { label: "Elite-only channels and strategy calls", free: false },
  { label: "Priority for paid roles and ambassador slots", free: false },
  { label: "Increased visibility for your personal brand", free: false },
];

export const DISPLAY_CARDS_DATA = [
  { icon: "🎯", title: "Daily Lessons", desc: "Real skills, one day at a time", color: "#818CF8" },
  { icon: "⚡", title: "Live Community", desc: "400+ builders doing the work", color: "#FB7185" },
  { icon: "🏆", title: "Scored Work", desc: "Auto-graded, real feedback", color: "#A78BFA" },
];
