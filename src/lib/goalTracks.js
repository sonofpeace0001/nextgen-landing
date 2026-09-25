// Single source of truth for the goal-based paths: what members can say they
// joined for, which track that maps to, and the tool stack shown to them.
// Mirrors the `track` rows seeded in 20260926100001_goal_tracks_foundation.sql
// (slug = goal id). Change copy here; publish tracks from the admin panel.

export const CREAO_URL = "https://agent.creao.ai/@Sonofpeace";

// wave 1 opens first, then 2, 3, 4 (see the rollout plan). `unsure` has no track.
export const GOALS = [
  {
    id: "graphics",
    label: "Graphics and design",
    wave: 1,
    creao: "Generate images, make on-brand variants from one brief, and publish a one-page portfolio. Its memory keeps your brand rules.",
  },
  {
    id: "content",
    label: "Content and writing",
    wave: 1,
    creao: "Save your voice and audience in its memory, then have an agent draft, turn one idea into every format, and run on a schedule.",
  },
  {
    id: "apps",
    label: "Apps and tools",
    wave: 2,
    creao: "Build custom apps by chat, each with a built-in copilot, connect them to your tools, and iterate in the same conversation.",
  },
  {
    id: "agents",
    label: "AI agents and automation",
    wave: 2,
    creao: "Turn a chat into a reusable agent, connect Gmail, Sheets or Slack, schedule it, and add approval steps before it acts.",
  },
  {
    id: "film",
    label: "AI film and video",
    wave: 3,
    creao: "Generate video, images and narration in one workspace for storyboards, shots and voiceover.",
  },
  {
    id: "motion",
    label: "Motion graphics",
    wave: 3,
    creao: "Concept, storyboard, generated assets and voiceover, plus batch variants of one motion template.",
  },
  {
    id: "audio",
    label: "Audio, music and voice",
    wave: 3,
    creao: "Narrate in 20+ voices and run recurring audio jobs such as a weekly script plus voiceover.",
  },
  {
    id: "research",
    label: "Research and data",
    wave: 4,
    creao: "Browse live sites, extract data, connect to Sheets, and run a scheduled research digest that remembers your sources.",
  },
  {
    id: "business",
    label: "Earning with AI skills",
    wave: 4,
    creao: "Run lead lists, outreach drafts, proposals and follow-ups as agents, so you review and send instead of typing everything.",
  },
  {
    id: "unsure",
    label: "Not sure yet",
    wave: 0,
    creao: "Write, generate images, video and voice, and build agents in one place, which makes it a good first tool while you explore.",
  },
];

export const GOAL_BY_ID = Object.fromEntries(GOALS.map((g) => [g.id, g]));

const WAVE_NOTE = {
  1: "This path opens first, in the first wave.",
  2: "This path opens in the second wave.",
  3: "This path opens in a later wave.",
  4: "This path opens in a later wave.",
};

// Honest status line: only the general AI path is live today.
export function goalStatus(goalId) {
  const g = GOAL_BY_ID[goalId];
  if (!g || g.wave === 0) return "";
  return `${WAVE_NOTE[g.wave]} Until then, the Novice path teaches the AI skills every track builds on.`;
}

// Goal ids in localStorage, so the Academy can pre-select a track and save them
// to the member's profile once they are signed in.
const KEY = "ng-goals";

export function rememberGoal(goalId) {
  try {
    localStorage.setItem(KEY, JSON.stringify(goalId ? [goalId] : []));
  } catch {
    /* storage may be blocked; the page works without it */
  }
}

export function recalledGoals() {
  try {
    const raw = JSON.parse(localStorage.getItem(KEY) || "[]");
    return Array.isArray(raw) ? raw.filter((id) => GOAL_BY_ID[id]) : [];
  } catch {
    return [];
  }
}

// Saves goals via the secure set_my_goals() function. Never throws: a missing
// function or a signed-out user must not break enrolment.
export async function saveMyGoals(supabase, goals) {
  try {
    if (!goals?.length) return null;
    const { data } = await supabase.rpc("set_my_goals", { p_goals: goals });
    return data ?? null;
  } catch {
    return null;
  }
}
