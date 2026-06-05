import { useState, useEffect, useRef } from "react";
import { Check, ChevronDown, Menu, X, ArrowUpRight } from "lucide-react";

const prefersReducedMotion =
  typeof window !== "undefined"
    ? window.matchMedia("(prefers-reduced-motion: reduce)").matches
    : false;

function useScrolled(threshold = 40) {
  const [scrolled, setScrolled] = useState(false);
  useEffect(() => {
    const handler = () => setScrolled(window.scrollY > threshold);
    window.addEventListener("scroll", handler, { passive: true });
    return () => window.removeEventListener("scroll", handler);
  }, [threshold]);
  return scrolled;
}

function useInView(ref) {
  const [inView, setInView] = useState(false);
  useEffect(() => {
    if (!ref.current) return;
    const obs = new IntersectionObserver(
      ([e]) => {
        if (e.isIntersecting) {
          setInView(true);
          obs.disconnect();
        }
      },
      { threshold: 0.15 }
    );
    obs.observe(ref.current);
    return () => obs.disconnect();
  }, [ref]);
  return inView;
}

function FadeUp({ children, delay = 0, className = "" }) {
  const ref = useRef(null);
  const inView = useInView(ref);
  const style = prefersReducedMotion
    ? {}
    : {
        opacity: inView ? 1 : 0,
        transform: inView ? "translateY(0)" : "translateY(14px)",
        transition: `opacity 0.55s ease ${delay}ms, transform 0.55s ease ${delay}ms`,
      };
  return (
    <div ref={ref} style={style} className={className}>
      {children}
    </div>
  );
}

function LogoMark({ size = 28 }) {
  return (
    <svg width={size} height={size} viewBox="0 0 32 32" fill="none">
      <defs>
        <linearGradient id="xgrad" x1="0" y1="0" x2="1" y2="1">
          <stop offset="0%" stopColor="#E27FE0" />
          <stop offset="50%" stopColor="#A855F7" />
          <stop offset="100%" stopColor="#7C3AED" />
        </linearGradient>
      </defs>
      <line x1="4" y1="4" x2="28" y2="28" stroke="url(#xgrad)" strokeWidth="4.5" strokeLinecap="round" />
      <line x1="28" y1="4" x2="4" y2="28" stroke="url(#xgrad)" strokeWidth="4.5" strokeLinecap="round" />
      <line x1="16" y1="15" x2="16" y2="28" stroke="url(#xgrad)" strokeWidth="4.5" strokeLinecap="round" />
    </svg>
  );
}

const ACCENT_GRADIENT = "linear-gradient(135deg, #E27FE0 0%, #A855F7 50%, #7C3AED 100%)";

function AccentText({ children }) {
  return (
    <span
      style={{
        background: ACCENT_GRADIENT,
        WebkitBackgroundClip: "text",
        WebkitTextFillColor: "transparent",
        backgroundClip: "text",
      }}
    >
      {children}
    </span>
  );
}

// Official community links.
const X_URL = "https://x.com/G_NEXTGEN";
const DISCORD_URL = "https://discord.gg/HDgMdVECwF";
const FOUNDER_X_URL = "https://x.com/sonofpeace0001";

function XIcon({ size = 16 }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="currentColor" aria-hidden="true">
      <path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z" />
    </svg>
  );
}

function DiscordIcon({ size = 17 }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="currentColor" aria-hidden="true">
      <path d="M20.317 4.3698a19.7913 19.7913 0 00-4.8851-1.5152.0741.0741 0 00-.0785.0371c-.211.3753-.4447.8648-.6083 1.2495-1.8447-.2762-3.68-.2762-5.4868 0-.1636-.3933-.4058-.8742-.6177-1.2495a.077.077 0 00-.0785-.037 19.7363 19.7363 0 00-4.8852 1.515.0699.0699 0 00-.0321.0277C.5334 9.0458-.319 13.5799.0992 18.0578a.0824.0824 0 00.0312.0561c2.0528 1.5076 4.0413 2.4228 5.9929 3.0294a.0777.0777 0 00.0842-.0276c.4616-.6304.8731-1.2952 1.226-1.9942a.076.076 0 00-.0416-.1057c-.6528-.2476-1.2743-.5495-1.8722-.8923a.077.077 0 01-.0076-.1277c.1258-.0943.2517-.1923.3718-.2914a.0743.0743 0 01.0776-.0105c3.9278 1.7933 8.18 1.7933 12.0614 0a.0739.0739 0 01.0785.0095c.1202.099.246.1981.3728.2924a.077.077 0 01-.0066.1276 12.2986 12.2986 0 01-1.873.8914.0766.0766 0 00-.0407.1067c.3604.698.7719 1.3628 1.225 1.9932a.076.076 0 00.0842.0286c1.961-.6067 3.9495-1.5219 6.0023-3.0294a.077.077 0 00.0313-.0552c.5004-5.177-.8382-9.6739-3.5485-13.6604a.061.061 0 00-.0312-.0286zM8.02 15.3312c-1.1825 0-2.1569-1.0857-2.1569-2.419 0-1.3332.9555-2.4189 2.157-2.4189 1.2108 0 2.1757 1.0952 2.1568 2.419 0 1.3332-.9555 2.4189-2.1569 2.4189zm7.9748 0c-1.1825 0-2.1569-1.0857-2.1569-2.419 0-1.3332.9554-2.4189 2.1569-2.4189 1.2108 0 2.1757 1.0952 2.1568 2.419 0 1.3332-.946 2.4189-2.1568 2.4189Z" />
    </svg>
  );
}

// Bordered icon button for X / Discord — lifts via border, no shadow.
function SocialIconLink({ href, label, children }) {
  const [hov, setHov] = useState(false);
  return (
    <a
      href={href}
      target="_blank"
      rel="noopener noreferrer"
      aria-label={label}
      onMouseEnter={() => setHov(true)}
      onMouseLeave={() => setHov(false)}
      style={{
        display: "inline-flex",
        alignItems: "center",
        justifyContent: "center",
        width: 38,
        height: 38,
        borderRadius: 8,
        border: hov ? "1px solid rgba(255,255,255,0.2)" : "1px solid rgba(255,255,255,0.08)",
        background: hov ? "rgba(255,255,255,0.04)" : "transparent",
        color: hov ? "#F5F5F7" : "#9CA3AF",
        transition: "border 0.15s ease, background 0.15s ease, color 0.15s ease",
      }}
    >
      {children}
    </a>
  );
}

// Inline icon + text link that brightens on hover.
function IconTextLink({ href, label, children }) {
  const [hov, setHov] = useState(false);
  return (
    <a
      href={href}
      target="_blank"
      rel="noopener noreferrer"
      onMouseEnter={() => setHov(true)}
      onMouseLeave={() => setHov(false)}
      style={{
        display: "inline-flex",
        alignItems: "center",
        gap: 8,
        fontSize: 14,
        color: hov ? "#F5F5F7" : "#9CA3AF",
        transition: "color 0.15s ease",
      }}
      aria-label={label}
    >
      {children}
    </a>
  );
}

function PrimaryButton({ children, onClick }) {
  const [hov, setHov] = useState(false);
  return (
    <button
      onClick={onClick}
      onMouseEnter={() => setHov(true)}
      onMouseLeave={() => setHov(false)}
      style={{
        background: ACCENT_GRADIENT,
        border: hov ? "1px solid rgba(255,255,255,0.22)" : "1px solid rgba(255,255,255,0.08)",
        filter: hov ? "brightness(1.12)" : "brightness(1)",
        transition: "border 0.15s ease, filter 0.15s ease",
        padding: "12px 24px",
        borderRadius: 8,
        color: "#fff",
        fontSize: 14,
        fontWeight: 500,
        letterSpacing: "-0.01em",
        cursor: "pointer",
        fontFamily: "inherit",
      }}
    >
      {children}
    </button>
  );
}

function GhostButton({ children, onClick, small }) {
  const [hov, setHov] = useState(false);
  return (
    <button
      onClick={onClick}
      onMouseEnter={() => setHov(true)}
      onMouseLeave={() => setHov(false)}
      style={{
        border: hov ? "1px solid rgba(255,255,255,0.2)" : "1px solid rgba(255,255,255,0.08)",
        background: hov ? "rgba(255,255,255,0.04)" : "transparent",
        transition: "border 0.15s ease, background 0.15s ease",
        padding: small ? "8px 16px" : "12px 24px",
        borderRadius: 8,
        color: "#F5F5F7",
        fontSize: small ? 13 : 14,
        fontWeight: 500,
        letterSpacing: "-0.01em",
        cursor: "pointer",
        fontFamily: "inherit",
      }}
    >
      {children}
    </button>
  );
}

function NavLink({ children, href }) {
  const [hov, setHov] = useState(false);
  return (
    <a
      href={href || "#"}
      onMouseEnter={() => setHov(true)}
      onMouseLeave={() => setHov(false)}
      style={{ textDecoration: "none", position: "relative", fontSize: 14, color: "#9CA3AF" }}
    >
      {children}
      <span
        style={{
          position: "absolute",
          bottom: -2,
          left: 0,
          height: 1,
          width: hov ? "100%" : 0,
          background: ACCENT_GRADIENT,
          transition: "width 0.15s ease",
          display: "block",
        }}
      />
    </a>
  );
}

const FAQ_DATA = [
  {
    q: "Do I need tech experience to join?",
    a: "No. NEXTGEN is built to be beginner-friendly. We go from zero to skilled in a structured way, so you can start wherever you are.",
  },
  {
    q: "Is NEXTGEN free?",
    a: "Yes. There's a full free tier where you can learn, connect, and explore opportunities without paying anything.",
  },
  {
    q: "What is NEXTGEN Elite?",
    a: "Elite is the premium tier designed for faster growth, deeper access, and real execution. It's earned through contribution, not just purchased.",
  },
  {
    q: "Can I start free and upgrade later?",
    a: "Yes. Explore the community first, build a feel for it, and when you're ready to go deeper, Elite will be there.",
  },
  {
    q: "Can Elite members earn from NEXTGEN?",
    a: "Yes. Elite members are first in line for paid opportunities, partnerships, and referrals inside and outside the community.",
  },
  {
    q: "Can Elite status be lost?",
    a: "Yes. It's performance-based. Inactivity or misconduct can result in removal. That's by design — it keeps the tier meaningful.",
  },
  {
    q: "How do I get started?",
    a: "Join the community, explore the resources and learning paths, start engaging, and upgrade to Elite when you're ready to accelerate.",
  },
];

function FAQAccordion() {
  const [open, setOpen] = useState(null);
  return (
    <div style={{ borderTop: "1px solid rgba(255,255,255,0.08)" }}>
      {FAQ_DATA.map((item, i) => (
        <div key={i} style={{ borderBottom: "1px solid rgba(255,255,255,0.08)" }}>
          <button
            onClick={() => setOpen(open === i ? null : i)}
            style={{
              width: "100%",
              display: "flex",
              alignItems: "center",
              justifyContent: "space-between",
              padding: "20px 0",
              textAlign: "left",
              background: "none",
              border: "none",
              cursor: "pointer",
              fontFamily: "inherit",
            }}
          >
            <span style={{ fontSize: 15, fontWeight: 500, color: "#F5F5F7", paddingRight: 32 }}>
              {item.q}
            </span>
            <ChevronDown
              size={15}
              style={{
                color: "#6B7280",
                flexShrink: 0,
                transform: open === i ? "rotate(180deg)" : "rotate(0deg)",
                transition: "transform 0.2s ease",
              }}
            />
          </button>
          <div
            style={{
              maxHeight: open === i ? 200 : 0,
              overflow: "hidden",
              transition: "max-height 0.25s ease",
            }}
          >
            <p style={{ fontSize: 14, lineHeight: 1.7, color: "#9CA3AF", paddingBottom: 20 }}>
              {item.a}
            </p>
          </div>
        </div>
      ))}
    </div>
  );
}

function HeroVisual() {
  return (
    <div
      style={{
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        minHeight: 340,
        position: "relative",
      }}
    >
      <svg viewBox="0 0 440 380" fill="none" style={{ width: "100%", maxWidth: 420, opacity: 0.65 }}>
        <defs>
          <linearGradient id="vg1" x1="0" y1="0" x2="1" y2="1">
            <stop offset="0%" stopColor="#E27FE0" stopOpacity="0.55" />
            <stop offset="50%" stopColor="#A855F7" stopOpacity="0.45" />
            <stop offset="100%" stopColor="#7C3AED" stopOpacity="0.3" />
          </linearGradient>
          <linearGradient id="vg2" x1="1" y1="0" x2="0" y2="1">
            <stop offset="0%" stopColor="#7C3AED" stopOpacity="0.3" />
            <stop offset="100%" stopColor="#E27FE0" stopOpacity="0.15" />
          </linearGradient>
        </defs>
        {/* Outer hex */}
        <polygon
          points="220,28 388,118 388,248 220,338 52,248 52,118"
          stroke="url(#vg1)"
          strokeWidth="0.8"
          fill="none"
        />
        {/* Mid hex */}
        <polygon
          points="220,76 346,144 346,218 220,288 94,218 94,144"
          stroke="url(#vg1)"
          strokeWidth="0.8"
          fill="none"
          strokeOpacity="0.55"
        />
        {/* Inner hex */}
        <polygon
          points="220,122 304,168 304,216 220,252 136,216 136,168"
          stroke="url(#vg1)"
          strokeWidth="0.8"
          fill="none"
          strokeOpacity="0.35"
        />
        {/* Spokes */}
        {[0, 60, 120, 180, 240, 300].map((deg, i) => {
          const r = (deg * Math.PI) / 180;
          return (
            <line
              key={i}
              x1="220"
              y1="187"
              x2={220 + 168 * Math.cos(r)}
              y2={187 + 130 * Math.sin(r)}
              stroke="url(#vg2)"
              strokeWidth="0.7"
              strokeOpacity="0.45"
            />
          );
        })}
        {/* Center X mark — the brand mark */}
        <line x1="197" y1="164" x2="243" y2="210" stroke="url(#vg1)" strokeWidth="3.5" strokeLinecap="round" />
        <line x1="243" y1="164" x2="197" y2="210" stroke="url(#vg1)" strokeWidth="3.5" strokeLinecap="round" />
        <line x1="220" y1="183" x2="220" y2="210" stroke="url(#vg1)" strokeWidth="3.5" strokeLinecap="round" />
        {/* Vertex dots */}
        {[[220,28],[388,118],[388,248],[220,338],[52,248],[52,118]].map(([cx,cy],i) => (
          <circle key={i} cx={cx} cy={cy} r="3.5" fill="url(#vg1)" fillOpacity="0.7" />
        ))}
        {[[220,76],[346,144],[346,218],[220,288],[94,218],[94,144]].map(([cx,cy],i) => (
          <circle key={i} cx={cx} cy={cy} r="2" fill="url(#vg1)" fillOpacity="0.4" />
        ))}
        {[[220,122],[304,168],[304,216],[220,252],[136,216],[136,168]].map(([cx,cy],i) => (
          <circle key={i} cx={cx} cy={cy} r="1.5" fill="url(#vg1)" fillOpacity="0.3" />
        ))}
      </svg>
    </div>
  );
}

const COMPARISON_ROWS = [
  { label: "Learning paths for in-demand skills", free: true, elite: true },
  { label: "Community of builders", free: true, elite: true },
  { label: "Access to opportunities (jobs, gigs)", free: true, elite: true },
  { label: "Start from zero, no experience required", free: true, elite: true },
  { label: "Advanced structured roadmaps", free: false, elite: true },
  { label: "Exclusive and early-access opportunities", free: false, elite: true },
  { label: "Direct mentorship and guidance", free: false, elite: true },
  { label: "Priority access to tools and resources", free: false, elite: true },
  { label: "Elite-only channels and strategy calls", free: false, elite: true },
  { label: "Higher-level builder network", free: false, elite: true },
  { label: "Priority for paid roles and ambassador slots", free: false, elite: true },
  { label: "Increased visibility for your personal brand", free: false, elite: true },
];

const S = {
  base: { background: "#0A0A0C", color: "#F5F5F7" },
  alt: { background: "#0E0E12" },
  border: { borderTop: "1px solid rgba(255,255,255,0.08)" },
  borderB: { borderBottom: "1px solid rgba(255,255,255,0.08)" },
  eyebrow: {
    fontSize: 12,
    fontWeight: 500,
    letterSpacing: "0.13em",
    textTransform: "uppercase",
    color: "#6B7280",
    display: "block",
    marginBottom: 16,
  },
  h2: {
    fontFamily: "'Space Grotesk', 'Inter', sans-serif",
    fontWeight: 600,
    letterSpacing: "-0.022em",
    color: "#F5F5F7",
    lineHeight: 1.15,
  },
  body: { fontSize: 16, lineHeight: 1.7, color: "#9CA3AF" },
  container: { maxWidth: 1120, margin: "0 auto", padding: "0 24px" },
  sectionPad: { padding: "96px 0" },
};

/* ──────────────────────────────────────────────────────────
   NEXTGEN ACADEMY
   ────────────────────────────────────────────────────────── */

// CREAO sign-up — activated on click, never rendered as visible text.
const CREAO_SIGNUP_URL = "https://agent.creao.ai/@Sonofpeace";

const QUIZ_OK = "#34D399";
const QUIZ_NO = "#F87171";

const ACADEMY_TRACKS = {
  ai: {
    label: "AI",
    blurb: "Every practical AI skill — from your first prompt to shipping agents and selling the work.",
    modules: [
      {
        title: "AI foundations & prompting",
        levels: {
          novice: "We begin at zero — what each model is, how to talk to it, and the CCSF formula you'll reuse forever.",
          pro: "Skip the tour. Straight into frameworks, system prompts, and structured output for production work.",
        },
        lessons: [
          "The AI landscape — ChatGPT, Claude, Gemini, Grok, and when to use which",
          "Prompting basics — the CCSF formula (Context, Constraints, Specifics, Format)",
          "Advanced prompting — roles, few-shot examples, chain-of-thought",
          "Prompt frameworks — RTF, RACE, CRISPE, TAG",
          "System prompts and custom instructions",
          "Prompting for code, analysis, and structured output",
          "Practice day — workshop your prompts",
        ],
        quiz: [
          { q: "You need to reason carefully through a long, detailed document. As a general starting point, which is the best fit?", options: ["Whichever tab opens first", "A model known for long-context reasoning like Claude", "Any image generator", "A model picked at random"], answer: 1, explain: "Match the model to the job. For long, careful reasoning, a strong long-context model is a sensible default — but always test, since strengths shift over time." },
          { q: "In the CCSF prompt formula, what does the first C stand for?", options: ["Code", "Context", "Cost", "Caption"], answer: 1, explain: "CCSF = Context, Constraints, Specifics, Format. Context first grounds the model before you ask for anything." },
          { q: "Chain-of-thought prompting means…", options: ["Sending many prompts at once", "Asking the model to reason step by step before answering", "Using only one-word prompts", "Hiding your instructions"], answer: 1, explain: "Asking for explicit step-by-step reasoning often improves accuracy on multi-step problems." },
        ],
      },
      {
        title: "Content creation with AI",
        levels: {
          novice: "Learn each tool one at a time, with templates you can copy straight into your own work.",
          pro: "Build a repeatable content engine and automate the parts that slow you down.",
        },
        lessons: [
          "Writing blogs, articles, and newsletters",
          "Short-form content — hooks, captions, threads, posts",
          "AI image generation — Midjourney, DALL·E, Ideogram",
          "AI video — Runway, Pika, HeyGen, Sora",
          "AI audio — ElevenLabs voices, Suno music, podcast workflows",
          "Content repurposing — turn one idea into 10+ pieces",
          "Build your personal content engine",
        ],
        quiz: [
          { q: "Which tool is best known for generating music from a prompt?", options: ["Suno", "Ideogram", "Runway", "ElevenLabs"], answer: 0, explain: "Suno generates music; ElevenLabs does voices, Runway does video, Ideogram does images." },
          { q: "\"Content repurposing\" means…", options: ["Deleting old posts", "Turning one core idea into many formats and pieces", "Copying competitors", "Posting the same link twice"], answer: 1, explain: "One strong idea becomes a blog, a thread, a short video, a carousel, a newsletter, and more." },
          { q: "Ideogram is most associated with…", options: ["Spreadsheets", "AI image generation, including legible text in images", "Cold email", "Smart contracts"], answer: 1, explain: "Ideogram is an image generator known for handling text inside images well." },
        ],
      },
      {
        title: "AI for business & marketing",
        levels: {
          novice: "Plain-language intros to research, outreach, SEO, and analysis — no jargon.",
          pro: "Wire AI into real business workflows and ship measurable results.",
        },
        lessons: [
          "Market and competitor research with AI",
          "Cold email and sales outreach",
          "AI customer support and chatbots",
          "Marketing strategy, positioning, and copywriting",
          "SEO with AI — keywords, briefs, on-page optimization",
          "Data analysis — turn raw numbers into insights",
          "Real case studies of small businesses scaling with AI",
        ],
        quiz: [
          { q: "A practical first use of AI in SEO is…", options: ["Buying backlinks", "Generating keyword clusters and content briefs", "Hiding text on the page", "Ignoring search intent"], answer: 1, explain: "AI is great for clustering keywords and drafting briefs; you still edit for quality and intent." },
          { q: "Before automating cold outreach, the most important thing is…", options: ["Sending as many emails as possible", "Clear targeting and a relevant offer", "The longest subject line", "Removing all personalization"], answer: 1, explain: "Automation amplifies whatever you point it at. Bad targeting just fails faster." },
        ],
      },
      {
        title: "Automation & AI agents",
        levels: {
          novice: "A gentle intro to automation and what an agent actually is — and isn't.",
          pro: "Design multi-step agents, connectors, and team workflows with CREAO.",
        },
        lessons: [
          "Automation intro — Zapier, Make, n8n",
          "Connecting AI into workflows (webhooks, APIs)",
          "AI agents — what they are, when to use them, what they replace",
          "CREAO deep dive — building your first super agent",
          "CREAO advanced — scheduling, connectors, memory, team agents",
          "Custom GPTs, Claude Projects, and reusable assistants",
        ],
        quiz: [
          { q: "What is CREAO?", options: ["A no-code website builder", "A super agent that executes complex tasks end-to-end", "A crypto wallet", "A stock-photo library"], answer: 1, explain: "CREAO is a super agent — it searches the web, writes code, generates files, calls integrations, and delivers results, which you can save as a reusable agent." },
          { q: "Zapier, Make, and n8n are mainly used to…", options: ["Edit videos", "Connect apps and automate workflows", "Mint NFTs", "Write essays"], answer: 1, explain: "They're automation platforms that link tools together so steps run without you." },
          { q: "When does an AI agent beat a single prompt?", options: ["Never", "When a task needs multiple steps, tools, or actions to finish", "Only for images", "Only for short questions"], answer: 1, explain: "Agents shine on multi-step tasks that require tools, browsing, or several actions in sequence." },
        ],
      },
      {
        title: "Earning & launch",
        levels: {
          novice: "Package one simple service and make your first offer this month.",
          pro: "Stack services, raise prices, and run it like an agency.",
        },
        lessons: [
          "Freelance services you can sell starting tomorrow",
          "AI agency model, productized services, and niche deep dives",
          "Capstone — launch your first offer, post your first piece, set your price",
          "Graduation, Q&A, and next steps",
        ],
        quiz: [
          { q: "A productized service is…", options: ["A one-off custom project", "A fixed-scope offer sold at a set price, repeatedly", "A free sample", "An hourly contract with no scope"], answer: 1, explain: "Productizing means a clear, repeatable offer at a set price — easier to sell and scale." },
          { q: "The capstone asks you to…", options: ["Watch more videos", "Launch your first offer, post your first piece, and set your price", "Wait a year", "Only read case studies"], answer: 1, explain: "The point is to ship: a real offer, a real post, and a real price." },
        ],
      },
    ],
  },

  web3: {
    label: "Web3",
    blurb: "From wallets and self-custody to building and earning on-chain.",
    modules: [
      {
        title: "Web3 foundations",
        levels: {
          novice: "No crypto background needed — wallets, gas, and safety, explained simply.",
          pro: "Move fast through the fundamentals and focus on self-custody and security.",
        },
        lessons: [
          "How blockchains actually work — blocks, nodes, consensus",
          "Wallets and self-custody — keys, seed phrases, safety",
          "Gas, networks, and EVM vs non-EVM chains",
          "Reading a block explorer",
          "Stablecoins and on/off ramps",
          "Spotting scams, drainers, and rug pulls",
        ],
        quiz: [
          { q: "\"Self-custody\" means…", options: ["A bank holds your crypto", "You control your own private keys", "An exchange controls your funds", "Your keys are public"], answer: 1, explain: "Self-custody means you hold the keys — and the responsibility to keep them safe." },
          { q: "Gas fees are…", options: ["A monthly subscription", "The cost to process a transaction on the network", "Free on all chains", "A token you mint"], answer: 1, explain: "Gas is what you pay the network to include and process your transaction." },
        ],
      },
      {
        title: "DeFi & on-chain",
        levels: {
          novice: "Understand DeFi before you touch it.",
          pro: "Manage liquidity, yield, and risk like a power user.",
        },
        lessons: [
          "DEXs and swaps — how AMMs work",
          "Liquidity, lending, and borrowing",
          "Yield, staking, and risk",
          "Bridging assets across chains",
          "Tracking your on-chain portfolio",
        ],
        quiz: [
          { q: "A DEX lets you…", options: ["Swap tokens without a centralized intermediary", "Print stablecoins", "Reverse any transaction", "Mint NFTs for free"], answer: 0, explain: "A decentralized exchange swaps tokens peer-to-contract, with no central middleman." },
          { q: "Higher yield usually comes with…", options: ["Lower risk", "Higher risk", "No risk", "Guaranteed returns"], answer: 1, explain: "Yield and risk move together. Outsized APYs deserve extra scrutiny." },
        ],
      },
      {
        title: "Tokens, NFTs & communities",
        levels: {
          novice: "What tokens, NFTs, and DAOs really are — minus the hype.",
          pro: "Evaluate token standards and govern communities on-chain.",
        },
        lessons: [
          "Token standards — ERC-20, ERC-721, ERC-1155",
          "Minting and trading NFTs",
          "DAOs and on-chain governance",
          "Finding and vetting communities",
        ],
        quiz: [
          { q: "A DAO is…", options: ["A centralized company", "A community that governs decisions on-chain", "A type of wallet", "A stablecoin"], answer: 1, explain: "A DAO coordinates and votes on decisions transparently on-chain." },
          { q: "ERC-721 is the standard for…", options: ["Fungible tokens", "Non-fungible tokens (NFTs)", "Gas fees", "Bridges"], answer: 1, explain: "ERC-721 defines unique, non-fungible tokens; ERC-20 covers fungible tokens." },
        ],
      },
      {
        title: "Building on-chain",
        levels: {
          novice: "Write your first smart contract with step-by-step guidance.",
          pro: "Ship and audit contracts, with AI assisting the heavy lifting.",
        },
        lessons: [
          "Solidity basics — your first smart contract",
          "Testnets and deploying a token",
          "Common security pitfalls",
          "Using AI to write and audit contracts",
        ],
        quiz: [
          { q: "Before deploying a contract to mainnet, you should…", options: ["Skip testing to save time", "Test thoroughly on a testnet", "Delete the source code", "Share your seed phrase"], answer: 1, explain: "Testnets let you catch bugs with fake funds before real money is at stake." },
          { q: "AI helps with smart contracts by…", options: ["Guaranteeing zero bugs", "Drafting and reviewing code you still audit", "Replacing audits entirely", "Holding your keys"], answer: 1, explain: "AI speeds drafting and review, but human and professional audits still matter." },
        ],
      },
      {
        title: "Earning in Web3",
        levels: {
          novice: "Find your first legitimate on-chain opportunities.",
          pro: "Turn on-chain reputation into paid roles and gigs.",
        },
        lessons: [
          "Airdrops, quests, and on-chain reputation",
          "Community, mod, and ambassador roles",
          "Freelance Web3 gigs and where to find them",
          "Capstone — ship something on-chain",
        ],
        quiz: [
          { q: "Airdrops typically reward…", options: ["Random strangers only", "Early users and genuine on-chain activity", "People who never used the protocol", "Centralized banks"], answer: 1, explain: "Airdrops often reward genuine early usage and contribution." },
          { q: "A reliable way to earn early in Web3 is…", options: ["Buying every token you see", "Contributing real value to communities and projects", "Sharing your private key", "Ignoring security"], answer: 1, explain: "Contribution — mod work, content, building — builds a reputation that pays." },
        ],
      },
    ],
  },

  freelancing: {
    label: "Freelancing",
    blurb: "Turn a skill into paid client work, then scale it into a business.",
    modules: [
      {
        title: "Foundations",
        levels: {
          novice: "Choose what to sell and to whom, step by step.",
          pro: "Sharpen positioning and pricing to command premium rates.",
        },
        lessons: [
          "Pick a service and a niche",
          "Position yourself so clients choose you",
          "Define your offer and deliverables",
          "Pricing models — hourly, fixed, retainer, value",
        ],
        quiz: [
          { q: "Niching down helps you…", options: ["Appeal to literally everyone", "Stand out and charge more for specialized work", "Lower your rates", "Avoid all clients"], answer: 1, explain: "A clear niche makes you the obvious choice for the right clients." },
          { q: "A retainer is…", options: ["A one-time fee", "Recurring pay for ongoing work", "A free trial", "A refund"], answer: 1, explain: "Retainers give predictable recurring income for ongoing scope." },
        ],
      },
      {
        title: "Profile & presence",
        levels: {
          novice: "Set up profiles and a portfolio from scratch.",
          pro: "Turn proof and presence into inbound demand.",
        },
        lessons: [
          "Build a portfolio that sells outcomes",
          "Set up Upwork, Fiverr, and Contra profiles",
          "Grow a personal brand on X and LinkedIn",
          "Case studies and social proof",
        ],
        quiz: [
          { q: "A strong portfolio prioritizes…", options: ["A long list of tools", "Outcomes and results for clients", "Your hobbies", "Stock images"], answer: 1, explain: "Clients buy outcomes. Lead with results, not a tool checklist." },
          { q: "Social proof means…", options: ["Follower count only", "Testimonials, case studies, and results others can see", "Paid ads", "Your logo"], answer: 1, explain: "Proof others vouch for reduces the client's risk in hiring you." },
        ],
      },
      {
        title: "Getting clients",
        levels: {
          novice: "Send your first outreach message and your first proposal.",
          pro: "Build a repeatable pipeline across outbound and inbound.",
        },
        lessons: [
          "Cold outreach that gets replies",
          "Proposals that win the project",
          "Inbound — let content bring leads to you",
          "Referrals and repeat work",
        ],
        quiz: [
          { q: "The goal of a cold outreach message is to…", options: ["Close the deal in one message", "Start a relevant conversation", "Send your whole life story", "Get blocked"], answer: 1, explain: "Outreach opens a door — be relevant and specific, not pushy." },
          { q: "A winning proposal focuses on…", options: ["Your needs", "The client's problem and the outcome you'll deliver", "A wall of jargon", "The lowest possible price"], answer: 1, explain: "Speak to their problem and the result, not just your process." },
        ],
      },
      {
        title: "Delivery & operations",
        levels: {
          novice: "Deliver cleanly and get paid without the stress.",
          pro: "Tighten ops so delivery scales without chaos.",
        },
        lessons: [
          "Scoping projects and avoiding scope creep",
          "Contracts, invoices, and getting paid",
          "Client communication and updates",
          "Your tool stack and workflow",
        ],
        quiz: [
          { q: "A clear scope of work mainly prevents…", options: ["Getting paid", "Scope creep and disputes", "Talking to clients", "Doing good work"], answer: 1, explain: "Defined scope protects both sides and keeps projects profitable." },
          { q: "Best practice for getting paid is…", options: ["Invoice whenever you remember", "Agree terms up front and invoice on a schedule", "Never discuss money", "Work fully unpaid first"], answer: 1, explain: "Clear terms and milestones or deposits keep cash flow healthy." },
        ],
      },
      {
        title: "Scaling",
        levels: {
          novice: "Land and deliver your first paid project.",
          pro: "Productize and delegate to grow beyond your own hours.",
        },
        lessons: [
          "Raise your rates with confidence",
          "Productize your service",
          "The agency model — delegate and grow",
          "Capstone — land and deliver your first paid project",
        ],
        quiz: [
          { q: "Raising your rates is easiest when you…", options: ["Have no clients", "Have proof of results and steady demand", "Lower your quality", "Stop marketing"], answer: 1, explain: "Demand and results give you the leverage to charge more." },
          { q: "The agency model lets you…", options: ["Work more hours yourself forever", "Delegate delivery and grow beyond your own time", "Avoid all clients", "Stop delivering quality"], answer: 1, explain: "Bringing in others lets revenue scale past your personal hours." },
        ],
      },
    ],
  },
};

function Quiz({ questions }) {
  const [idx, setIdx] = useState(0);
  const [picked, setPicked] = useState(null);
  const [finished, setFinished] = useState(false);
  const [score, setScore] = useState(0);

  if (!questions || questions.length === 0) return null;
  const q = questions[idx];
  const answered = picked !== null;

  const pick = (i) => {
    if (answered) return;
    setPicked(i);
    if (i === q.answer) setScore((s) => s + 1);
  };
  const next = () => {
    if (idx < questions.length - 1) {
      setIdx(idx + 1);
      setPicked(null);
    } else setFinished(true);
  };
  const reset = () => {
    setIdx(0);
    setPicked(null);
    setFinished(false);
    setScore(0);
  };

  return (
    <div style={{ border: "1px solid rgba(255,255,255,0.08)", borderRadius: 12, padding: 20, background: "#0A0A0C" }}>
      <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", marginBottom: 14 }}>
        <span style={{ fontSize: 11, fontWeight: 600, letterSpacing: "0.12em", textTransform: "uppercase", color: "#6B7280" }}>
          Module check
        </span>
        {!finished && (
          <span style={{ fontSize: 12, color: "#6B7280", fontVariantNumeric: "tabular-nums" }}>
            {idx + 1} / {questions.length}
          </span>
        )}
      </div>

      {finished ? (
        <div>
          <p style={{ fontSize: 15, fontWeight: 600, color: "#F5F5F7", marginBottom: 6 }}>Module check complete</p>
          <p style={{ fontSize: 14, lineHeight: 1.6, color: "#9CA3AF", marginBottom: 18 }}>
            You scored {score} of {questions.length}.{" "}
            {score === questions.length
              ? "Clean run — move on to the next module."
              : "Review the lessons above, then retake to lock it in."}
          </p>
          <GhostButton small onClick={reset}>Retake</GhostButton>
        </div>
      ) : (
        <div>
          <p style={{ fontSize: 15, fontWeight: 500, color: "#F5F5F7", lineHeight: 1.5, marginBottom: 16 }}>{q.q}</p>
          <div style={{ display: "flex", flexDirection: "column", gap: 8 }}>
            {q.options.map((opt, i) => {
              const isAnswer = i === q.answer;
              const isPicked = i === picked;
              let border = "1px solid rgba(255,255,255,0.08)";
              let color = "#D1D5DB";
              let icon = null;
              if (answered && isAnswer) {
                border = `1px solid ${QUIZ_OK}55`;
                color = QUIZ_OK;
                icon = <Check size={14} style={{ color: QUIZ_OK, flexShrink: 0 }} />;
              } else if (answered && isPicked && !isAnswer) {
                border = `1px solid ${QUIZ_NO}55`;
                color = QUIZ_NO;
                icon = <X size={14} style={{ color: QUIZ_NO, flexShrink: 0 }} />;
              }
              return (
                <button
                  key={i}
                  onClick={() => pick(i)}
                  disabled={answered}
                  style={{
                    display: "flex",
                    alignItems: "center",
                    justifyContent: "space-between",
                    gap: 12,
                    padding: "12px 14px",
                    borderRadius: 8,
                    border,
                    background: answered && (isAnswer || isPicked) ? "rgba(255,255,255,0.02)" : "transparent",
                    color,
                    fontSize: 14,
                    fontFamily: "inherit",
                    cursor: answered ? "default" : "pointer",
                    textAlign: "left",
                    transition: "border 0.15s ease, color 0.15s ease",
                    width: "100%",
                  }}
                >
                  <span>{opt}</span>
                  {icon}
                </button>
              );
            })}
          </div>
          {answered && (
            <div style={{ display: "flex", alignItems: "flex-start", justifyContent: "space-between", gap: 16, marginTop: 16 }}>
              <p style={{ fontSize: 13, lineHeight: 1.6, color: "#9CA3AF", flex: 1 }}>{q.explain}</p>
              <GhostButton small onClick={next}>{idx < questions.length - 1 ? "Next" : "Finish"}</GhostButton>
            </div>
          )}
        </div>
      )}
    </div>
  );
}

function AcademySection() {
  const TRACK_KEYS = ["ai", "web3", "freelancing"];
  const [track, setTrack] = useState("ai");
  const [level, setLevel] = useState("Novice");
  const [openMod, setOpenMod] = useState(0);
  const [completed, setCompleted] = useState({});

  const data = ACADEMY_TRACKS[track];
  const lvl = level === "Novice" ? "novice" : "pro";

  const keyOf = (m, l) => `${track}-${m}-${l}`;
  const toggleLesson = (m, l) =>
    setCompleted((p) => ({ ...p, [keyOf(m, l)]: !p[keyOf(m, l)] }));
  const moduleDone = (mi, lessons) =>
    lessons.reduce((n, _, li) => n + (completed[keyOf(mi, li)] ? 1 : 0), 0);

  const selectTrack = (t) => {
    setTrack(t);
    setOpenMod(0);
  };

  const signup = () => {
    if (typeof window !== "undefined") window.open(CREAO_SIGNUP_URL, "_blank", "noopener,noreferrer");
  };

  return (
    <section id="academy" style={S.sectionPad}>
      <div style={S.container}>
        <FadeUp>
          <span style={S.eyebrow}>NEXTGEN Academy</span>
          <h2 style={{ ...S.h2, fontSize: "clamp(26px,3vw,40px)", marginBottom: 16, maxWidth: 640 }}>
            Learn it step by step. Become genuinely good.
          </h2>
          <p style={{ ...S.body, marginBottom: 40, maxWidth: 560 }}>
            {level === "Novice"
              ? "Brand new? Start as a Novice. Each track opens one module at a time, so you're never staring at everything at once — learn, check yourself with a quick quiz, then move on."
              : "Already dangerous? Switch to Pro. Same tracks, faster pace, less hand-holding — straight to the frameworks and execution that make you genuinely good."}
          </p>
        </FadeUp>

        <FadeUp delay={60}>
          {/* Level + track controls */}
          <div style={{ display: "flex", flexWrap: "wrap", alignItems: "center", justifyContent: "space-between", gap: 20, marginBottom: 8 }}>
            <div style={{ display: "flex", alignItems: "center", gap: 14 }}>
              <span style={{ fontSize: 12, color: "#6B7280", letterSpacing: "0.04em" }}>I'm a</span>
              <div style={{ display: "inline-flex", border: "1px solid rgba(255,255,255,0.08)", borderRadius: 8, padding: 3, gap: 3 }}>
                {["Novice", "Pro"].map((L) => {
                  const active = level === L;
                  return (
                    <button
                      key={L}
                      onClick={() => setLevel(L)}
                      style={{
                        padding: "7px 20px",
                        borderRadius: 6,
                        fontSize: 13,
                        fontWeight: 500,
                        cursor: "pointer",
                        fontFamily: "inherit",
                        border: "none",
                        background: active ? "rgba(255,255,255,0.08)" : "transparent",
                        color: active ? "#F5F5F7" : "#9CA3AF",
                        transition: "background 0.15s ease, color 0.15s ease",
                      }}
                    >
                      {L}
                    </button>
                  );
                })}
              </div>
            </div>
          </div>

          {/* Track tabs */}
          <div style={{ display: "flex", gap: 28, flexWrap: "wrap", borderBottom: "1px solid rgba(255,255,255,0.08)", marginTop: 28 }}>
            {TRACK_KEYS.map((t) => {
              const active = t === track;
              return (
                <button
                  key={t}
                  onClick={() => selectTrack(t)}
                  style={{
                    position: "relative",
                    padding: "0 0 14px",
                    background: "none",
                    border: "none",
                    cursor: "pointer",
                    fontFamily: "inherit",
                    fontSize: 15,
                    fontWeight: 500,
                    letterSpacing: "-0.01em",
                    color: active ? "#F5F5F7" : "#6B7280",
                    transition: "color 0.15s ease",
                  }}
                >
                  {ACADEMY_TRACKS[t].label}
                  <span
                    style={{
                      position: "absolute",
                      bottom: -1,
                      left: 0,
                      height: 2,
                      width: active ? "100%" : 0,
                      background: ACCENT_GRADIENT,
                      transition: "width 0.2s ease",
                    }}
                  />
                </button>
              );
            })}
          </div>

          <p style={{ fontSize: 14, color: "#9CA3AF", margin: "20px 0 32px", maxWidth: 540 }}>{data.blurb}</p>
        </FadeUp>

        {/* Modules */}
        <FadeUp delay={100}>
          <div>
            {data.modules.map((mod, mi) => {
              const open = openMod === mi;
              const doneCount = moduleDone(mi, mod.lessons);
              return (
                <div
                  key={`${track}-${mi}`}
                  style={{
                    border: "1px solid rgba(255,255,255,0.08)",
                    borderRadius: 12,
                    marginBottom: 12,
                    overflow: "hidden",
                    background: open ? "#0C0C10" : "transparent",
                    transition: "background 0.2s ease",
                  }}
                >
                  <button
                    onClick={() => setOpenMod(open ? -1 : mi)}
                    style={{
                      width: "100%",
                      display: "flex",
                      alignItems: "center",
                      justifyContent: "space-between",
                      gap: 16,
                      padding: "20px 22px",
                      background: "none",
                      border: "none",
                      cursor: "pointer",
                      textAlign: "left",
                      fontFamily: "inherit",
                    }}
                  >
                    <span style={{ display: "flex", alignItems: "center", gap: 16, minWidth: 0 }}>
                      <span style={{ fontSize: 12, fontWeight: 600, color: "#4B5563", letterSpacing: "0.08em" }}>
                        {String(mi + 1).padStart(2, "0")}
                      </span>
                      <span style={{ fontSize: 16, fontWeight: 600, color: "#F5F5F7", letterSpacing: "-0.01em" }}>
                        {mod.title}
                      </span>
                    </span>
                    <span style={{ display: "flex", alignItems: "center", gap: 16, flexShrink: 0 }}>
                      <span style={{ fontSize: 12, color: doneCount > 0 ? "#A855F7" : "#6B7280", fontVariantNumeric: "tabular-nums" }}>
                        {doneCount}/{mod.lessons.length}
                      </span>
                      <ChevronDown size={16} style={{ color: "#6B7280", transform: open ? "rotate(180deg)" : "none", transition: "transform 0.2s ease" }} />
                    </span>
                  </button>

                  {open && (
                    <div style={{ padding: "0 22px 22px" }}>
                      <p
                        style={{
                          fontSize: 13.5,
                          lineHeight: 1.6,
                          color: "#9CA3AF",
                          borderTop: "1px solid rgba(255,255,255,0.06)",
                          paddingTop: 16,
                          marginBottom: 14,
                        }}
                      >
                        <span style={{ color: "#A855F7", fontWeight: 600 }}>{level} path — </span>
                        {mod.levels[lvl]}
                      </p>

                      <div style={{ display: "flex", flexDirection: "column", marginBottom: 22 }}>
                        {mod.lessons.map((lesson, li) => {
                          const isDone = !!completed[keyOf(mi, li)];
                          return (
                            <button
                              key={li}
                              onClick={() => toggleLesson(mi, li)}
                              style={{
                                display: "flex",
                                alignItems: "flex-start",
                                gap: 14,
                                padding: "11px 0",
                                background: "none",
                                border: "none",
                                borderBottom: "1px solid rgba(255,255,255,0.05)",
                                cursor: "pointer",
                                textAlign: "left",
                                fontFamily: "inherit",
                                width: "100%",
                              }}
                            >
                              <span
                                style={{
                                  width: 18,
                                  height: 18,
                                  borderRadius: "50%",
                                  border: isDone ? "1px solid #A855F7" : "1px solid rgba(255,255,255,0.18)",
                                  background: isDone ? "rgba(168,85,247,0.15)" : "transparent",
                                  display: "flex",
                                  alignItems: "center",
                                  justifyContent: "center",
                                  flexShrink: 0,
                                  marginTop: 1,
                                  transition: "border 0.15s ease, background 0.15s ease",
                                }}
                              >
                                {isDone && <Check size={11} style={{ color: "#A855F7" }} />}
                              </span>
                              <span style={{ fontSize: 14, lineHeight: 1.5, color: isDone ? "#6B7280" : "#D1D5DB", textDecoration: isDone ? "line-through" : "none" }}>
                                <span style={{ color: "#4B5563", marginRight: 10, fontVariantNumeric: "tabular-nums" }}>
                                  {String(li + 1).padStart(2, "0")}
                                </span>
                                {lesson}
                              </span>
                            </button>
                          );
                        })}
                      </div>

                      <Quiz questions={mod.quiz} />
                    </div>
                  )}
                </div>
              );
            })}
          </div>
        </FadeUp>

        {/* CREAO */}
        <FadeUp delay={120}>
          <div style={{ marginTop: 64, border: "1px solid rgba(255,255,255,0.08)", borderRadius: 12, overflow: "hidden" }}>
            <div style={{ display: "grid", gridTemplateColumns: "1.4fr 1fr" }} className="two-col">
              <div style={{ padding: 40 }}>
                <span style={{ ...S.eyebrow, marginBottom: 14 }}>Your AI super agent</span>
                <h3 style={{ ...S.h2, fontSize: "clamp(24px,2.6vw,32px)", marginBottom: 16 }}>
                  Build with <AccentText>CREAO</AccentText>
                </h3>
                <p style={{ ...S.body, fontSize: 15, marginBottom: 14 }}>
                  CREAO is a super agent that executes complex tasks end-to-end — searching the web, writing code, generating files, calling integrations, and delivering real results.
                </p>
                <p style={{ ...S.body, fontSize: 15 }}>
                  When a session works well, save it as a reusable agent so your team never re-prompts the same task twice. Two full lessons in the AI track take you from your first agent to scheduling, connectors, memory, and team agents.
                </p>
              </div>
              <div
                className="creao-side"
                style={{
                  padding: 40,
                  borderLeft: "1px solid rgba(255,255,255,0.08)",
                  background: "#0E0E12",
                  display: "flex",
                  flexDirection: "column",
                  justifyContent: "center",
                }}
              >
                <span style={{ ...S.eyebrow, marginBottom: 14 }}>Sign up</span>
                <p style={{ fontSize: 14, lineHeight: 1.6, color: "#9CA3AF", marginBottom: 22 }}>
                  Create your CREAO account and spin up your first super agent in minutes. No setup, no boilerplate.
                </p>
                <div>
                  <PrimaryButton onClick={signup}>
                    <span style={{ display: "inline-flex", alignItems: "center", gap: 8 }}>
                      Sign up
                      <ArrowUpRight size={15} />
                    </span>
                  </PrimaryButton>
                </div>
              </div>
            </div>
          </div>
        </FadeUp>
      </div>
    </section>
  );
}

export default function NextgenLanding() {
  const [mobileOpen, setMobileOpen] = useState(false);
  const scrolled = useScrolled(40);
  const [heroVisible, setHeroVisible] = useState(false);

  useEffect(() => {
    if (prefersReducedMotion) { setHeroVisible(true); return; }
    const t = setTimeout(() => setHeroVisible(true), 80);
    return () => clearTimeout(t);
  }, []);

  const hi = (delay) =>
    prefersReducedMotion
      ? {}
      : {
          opacity: heroVisible ? 1 : 0,
          transform: heroVisible ? "translateY(0)" : "translateY(12px)",
          transition: `opacity 0.5s ease ${delay}ms, transform 0.5s ease ${delay}ms`,
        };

  const NAV_LINKS = [
    { label: "What is NEXTGEN", href: "#what" },
    { label: "For Whom", href: "#for-whom" },
    { label: "Academy", href: "#academy" },
    { label: "Elite", href: "#elite" },
    { label: "FAQ", href: "#faq" },
  ];

  return (
    <div style={{ ...S.base, fontFamily: "'Inter','Geist',system-ui,-apple-system,sans-serif", overflowX: "hidden" }}>
      <style>{`
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Space+Grotesk:wght@600&display=swap');
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        html { scroll-behavior: smooth; }
        a { color: inherit; text-decoration: none; }
        @keyframes bgDrift {
          0%,100% { opacity:.07; transform:scale(1) translate(0,0); }
          50%      { opacity:.1;  transform:scale(1.05) translate(14px,-10px); }
        }
        @keyframes bgPulse {
          0%,100% { opacity:.05; }
          50%      { opacity:.09; }
        }
        @media (prefers-reduced-motion: reduce) {
          *, *::before, *::after { animation: none !important; transition: none !important; }
        }
      `}</style>

      {/* ── NAV ── */}
      <nav
        style={{
          position: "fixed", top: 0, left: 0, right: 0, zIndex: 100,
          background: scrolled ? "#0A0A0C" : "transparent",
          borderBottom: scrolled ? "1px solid rgba(255,255,255,0.08)" : "1px solid transparent",
          transition: "background 0.22s ease, border-color 0.22s ease",
        }}
      >
        <div style={{ ...S.container, display: "flex", alignItems: "center", justifyContent: "space-between", height: 64 }}>
          <a href="#" style={{ display: "flex", alignItems: "center", gap: 10 }}>
            <LogoMark size={24} />
            <span style={{ fontFamily: "'Space Grotesk','Inter',sans-serif", fontWeight: 600, fontSize: 16, letterSpacing: "-0.02em", color: "#F5F5F7" }}>
              NEXTGEN
            </span>
          </a>

          <div style={{ display: "flex", alignItems: "center", gap: 36 }} className="hidden-mobile">
            {NAV_LINKS.map((l) => <NavLink key={l.label} href={l.href}>{l.label}</NavLink>)}
          </div>

          <div style={{ display: "flex", alignItems: "center", gap: 10 }} className="hidden-mobile">
            <GhostButton small>Log in</GhostButton>
            <PrimaryButton>Join NEXTGEN</PrimaryButton>
          </div>

          <button
            onClick={() => setMobileOpen(!mobileOpen)}
            style={{ background: "none", border: "none", color: "#9CA3AF", cursor: "pointer", padding: 4, display: "none" }}
            className="mobile-menu-btn"
          >
            {mobileOpen ? <X size={20} /> : <Menu size={20} />}
          </button>
        </div>

        {mobileOpen && (
          <div style={{ ...S.alt, ...S.borderB, padding: "16px 24px 28px", display: "flex", flexDirection: "column", gap: 16 }}>
            {NAV_LINKS.map((l) => (
              <a key={l.label} href={l.href} style={{ fontSize: 15, color: "#9CA3AF" }} onClick={() => setMobileOpen(false)}>
                {l.label}
              </a>
            ))}
            <div style={{ display: "flex", flexDirection: "column", gap: 8, paddingTop: 8 }}>
              <GhostButton>Log in</GhostButton>
              <PrimaryButton>Join NEXTGEN</PrimaryButton>
            </div>
          </div>
        )}
      </nav>

      {/* ── HERO ── */}
      <section style={{ paddingTop: 152, paddingBottom: 112, position: "relative", overflow: "hidden" }}>
        {/* Ambient glow — barely perceptible */}
        <div style={{
          position: "absolute", top: "5%", left: "28%",
          width: 720, height: 520, borderRadius: "50%",
          background: "radial-gradient(ellipse, #7C3AED 0%, transparent 68%)",
          animation: prefersReducedMotion ? "none" : "bgDrift 18s ease-in-out infinite",
          pointerEvents: "none", zIndex: 0,
        }} />
        <div style={{ ...S.container, position: "relative", zIndex: 1 }}>
          <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: 64, alignItems: "center" }} className="hero-grid">
            <div>
              <div style={hi(0)}>
                <span style={{ ...S.eyebrow, marginBottom: 28 }}>The future-skills community</span>
              </div>
              <div style={hi(70)}>
                <h1 style={{
                  fontFamily: "'Space Grotesk','Inter',sans-serif",
                  fontSize: "clamp(40px,5.6vw,68px)",
                  fontWeight: 600,
                  lineHeight: 1.07,
                  letterSpacing: "-0.026em",
                  color: "#F5F5F7",
                  marginBottom: 24,
                }}>
                  Learn the skills the next{" "}
                  <AccentText>economy</AccentText>{" "}
                  is actually paying for.
                </h1>
              </div>
              <div style={hi(140)}>
                <p style={{ ...S.body, fontSize: 18, marginBottom: 40, maxWidth: 460 }}>
                  AI, Web3, content, freelancing — practical skills with a community that's doing the work alongside you.
                </p>
              </div>
              <div style={{ ...hi(200), display: "flex", gap: 12, flexWrap: "wrap" }}>
                <PrimaryButton>Join free</PrimaryButton>
                <GhostButton>Explore Elite</GhostButton>
              </div>
            </div>
            <div style={{ ...hi(110) }} className="hero-visual">
              <HeroVisual />
            </div>
          </div>
        </div>
      </section>

      {/* ── WHAT IS NEXTGEN ── */}
      <section id="what" style={{ ...S.alt, ...S.border, ...S.borderB, ...S.sectionPad }}>
        <div style={S.container}>
          <FadeUp>
            <span style={S.eyebrow}>What is NEXTGEN</span>
          </FadeUp>
          <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: 80, alignItems: "start" }} className="two-col">
            <FadeUp delay={60}>
              <h2 style={{ ...S.h2, fontSize: "clamp(28px,3.2vw,40px)" }}>
                Built for people who want to act, not just watch.
              </h2>
            </FadeUp>
            <FadeUp delay={120}>
              <p style={{ ...S.body, marginBottom: 20 }}>
                NEXTGEN is a community for people who want to build, earn, and grow in the new tech economy — AI, Web3, content, freelancing — instead of just consuming it.
              </p>
              <p style={S.body}>
                Most communities are about watching someone else do things. NEXTGEN is about doing them. Every resource, every connection, every opportunity here points at one outcome: turning you from a consumer into a builder.
              </p>
            </FadeUp>
          </div>
        </div>
      </section>

      {/* ── WHO IT'S FOR ── */}
      <section id="for-whom" style={S.sectionPad}>
        <div style={S.container}>
          <FadeUp>
            <span style={S.eyebrow}>For whom</span>
            <h2 style={{ ...S.h2, fontSize: "clamp(26px,3vw,36px)", marginBottom: 56 }}>
              No experience required. Seriousness is.
            </h2>
          </FadeUp>
          <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr" }} className="two-col">
            {[
              { label: "Beginners", desc: "You don't know where to start and every tutorial assumes you already know things. We fix that." },
              { label: "Students", desc: "You want skills that translate to income and relevance, not just a certificate." },
              { label: "Creators and freelancers", desc: "You're already building an audience or client base and want to layer in AI, Web3, or new revenue streams." },
              { label: "People serious about earning online", desc: "You've decided the traditional path isn't your only option and you want a community that gets that." },
            ].map((item, i) => (
              <FadeUp key={i} delay={i * 55}>
                <div style={{
                  ...S.border,
                  borderRight: i % 2 === 0 ? "1px solid rgba(255,255,255,0.08)" : "none",
                  padding: "32px 0",
                  paddingRight: i % 2 === 0 ? 48 : 0,
                  paddingLeft: i % 2 === 1 ? 48 : 0,
                }}>
                  <p style={{ fontSize: 15, fontWeight: 600, color: "#F5F5F7", marginBottom: 8, letterSpacing: "-0.01em" }}>
                    {item.label}
                  </p>
                  <p style={{ fontSize: 14, lineHeight: 1.65, color: "#9CA3AF" }}>{item.desc}</p>
                </div>
              </FadeUp>
            ))}
            <div style={{ ...S.border, gridColumn: "1 / -1" }} />
          </div>
        </div>
      </section>

      {/* ── FREE TIER ── */}
      <section style={{ ...S.alt, ...S.border, ...S.borderB, ...S.sectionPad }}>
        <div style={S.container}>
          <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: 80, alignItems: "start" }} className="two-col">
            <FadeUp>
              <span style={S.eyebrow}>Free tier</span>
              <h2 style={{ ...S.h2, fontSize: "clamp(26px,3vw,36px)" }}>
                Everything you need to get moving.
              </h2>
            </FadeUp>
            <FadeUp delay={80}>
              {[
                { title: "Clear learning paths", desc: "Structured paths for AI, Web3, content creation, and freelancing — in an order that actually makes sense." },
                { title: "Real opportunities", desc: "Jobs, gigs, and collaborations posted inside the community. Not curated lists from LinkedIn." },
                { title: "A community of builders", desc: "People who are doing the work, not talking about it. Ask questions, get real answers." },
                { title: "Guidance on growth and earning", desc: "Honest direction on positioning, pricing your work, and starting to see income." },
              ].map((item, i) => (
                <div key={i} style={{ ...S.borderB, padding: "22px 0" }}>
                  <p style={{ fontSize: 15, fontWeight: 600, color: "#F5F5F7", marginBottom: 6, letterSpacing: "-0.01em" }}>{item.title}</p>
                  <p style={{ fontSize: 14, lineHeight: 1.65, color: "#9CA3AF" }}>{item.desc}</p>
                </div>
              ))}
            </FadeUp>
          </div>
        </div>
      </section>

      {/* ── NEXTGEN ACADEMY ── */}
      <AcademySection />

      {/* ── FREE VS ELITE ── */}
      <section id="elite" style={S.sectionPad}>
        <div style={S.container}>
          <FadeUp>
            <span style={S.eyebrow}>Compare tiers</span>
            <h2 style={{ ...S.h2, fontSize: "clamp(26px,3vw,36px)", marginBottom: 12 }}>
              Free is the foundation. Elite is the accelerator.
            </h2>
            <p style={{ ...S.body, marginBottom: 56, maxWidth: 520 }}>
              Both tiers are real. Free gets you started. Elite is for when you want to go faster, deeper, and with more support behind you.
            </p>
          </FadeUp>

          <FadeUp delay={80}>
            <div style={{ border: "1px solid rgba(255,255,255,0.08)", borderRadius: 12, overflow: "hidden" }}>
              {/* Header */}
              <div style={{
                display: "grid", gridTemplateColumns: "1fr 100px 100px",
                ...S.alt, ...S.borderB,
                padding: "16px 24px", gap: 16,
              }}>
                <div />
                <div style={{ textAlign: "center", fontSize: 13, fontWeight: 600, color: "#F5F5F7", letterSpacing: "-0.01em" }}>
                  NEXTGEN
                </div>
                <div style={{ textAlign: "center", fontSize: 13, fontWeight: 600, letterSpacing: "-0.01em" }}>
                  <span style={{ background: ACCENT_GRADIENT, WebkitBackgroundClip: "text", WebkitTextFillColor: "transparent", backgroundClip: "text" }}>
                    Elite
                  </span>
                </div>
              </div>
              {/* Rows */}
              {COMPARISON_ROWS.map((row, i) => (
                <div
                  key={i}
                  style={{
                    display: "grid", gridTemplateColumns: "1fr 100px 100px",
                    borderBottom: i < COMPARISON_ROWS.length - 1 ? "1px solid rgba(255,255,255,0.055)" : "none",
                    padding: "13px 24px", gap: 16, alignItems: "center",
                    background: i % 2 === 1 ? "rgba(255,255,255,0.018)" : "transparent",
                  }}
                >
                  <span style={{ fontSize: 14, color: "#9CA3AF", lineHeight: 1.4 }}>{row.label}</span>
                  <div style={{ display: "flex", justifyContent: "center" }}>
                    {row.free
                      ? <Check size={14} style={{ color: "#A855F7" }} />
                      : <span style={{ color: "#374151", fontSize: 16 }}>—</span>}
                  </div>
                  <div style={{ display: "flex", justifyContent: "center" }}>
                    {row.elite
                      ? <Check size={14} style={{ color: "#A855F7" }} />
                      : <span style={{ color: "#374151", fontSize: 16 }}>—</span>}
                  </div>
                </div>
              ))}
            </div>
          </FadeUp>

          <FadeUp delay={120}>
            <div style={{ marginTop: 36, display: "flex", gap: 12, flexWrap: "wrap" }}>
              <PrimaryButton>Apply for Elite</PrimaryButton>
              <GhostButton>Join free</GhostButton>
            </div>
          </FadeUp>
        </div>
      </section>

      {/* ── HOW ELITE WORKS ── */}
      <section style={{ ...S.alt, ...S.border, ...S.borderB, ...S.sectionPad }}>
        <div style={S.container}>
          <FadeUp>
            <span style={S.eyebrow}>How Elite works</span>
            <h2 style={{ ...S.h2, fontSize: "clamp(26px,3vw,36px)", marginBottom: 12 }}>Earned, not bought.</h2>
            <p style={{ ...S.body, marginBottom: 64, maxWidth: 480 }}>
              Elite is merit-based. You get it by showing up and contributing consistently — not by putting in a card number.
            </p>
          </FadeUp>

          <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr 1fr", gap: 0 }} className="three-col">
            {[
              {
                num: "01",
                title: "How you qualify",
                points: [
                  "Contribute to community growth",
                  "Help other members make progress",
                  "Bring in and onboard new members",
                  "Promote NEXTGEN on X",
                  "Host or support X Spaces",
                ],
              },
              {
                num: "02",
                title: "How you're selected",
                points: [
                  "Periodic merit reviews of active contributors",
                  "Standout contributors are invited directly",
                  "Applications open when slots become available",
                  "Consistency counts more than one big moment",
                ],
              },
              {
                num: "03",
                title: "What's expected",
                points: [
                  "Uphold community values",
                  "Support other members genuinely",
                  "Promote NEXTGEN authentically",
                  "Contribute ideas and feedback",
                  "Inactivity or misconduct removes Elite status",
                ],
              },
            ].map((block, i) => (
              <FadeUp key={i} delay={i * 80}>
                <div style={{
                  borderLeft: i > 0 ? "1px solid rgba(255,255,255,0.08)" : "none",
                  padding: i === 0 ? "0 40px 0 0" : i === 2 ? "0 0 0 40px" : "0 40px",
                }}>
                  <span style={{ fontSize: 11, fontWeight: 600, color: "#4B5563", letterSpacing: "0.1em", display: "block", marginBottom: 18 }}>
                    {block.num}
                  </span>
                  <p style={{ fontSize: 15, fontWeight: 600, color: "#F5F5F7", marginBottom: 20, letterSpacing: "-0.01em" }}>
                    {block.title}
                  </p>
                  <ul style={{ listStyle: "none", display: "flex", flexDirection: "column", gap: 10 }}>
                    {block.points.map((p, j) => (
                      <li key={j} style={{ display: "flex", gap: 10, alignItems: "flex-start" }}>
                        <span style={{ width: 3, height: 3, borderRadius: "50%", background: "#4B5563", flexShrink: 0, marginTop: 9 }} />
                        <span style={{ fontSize: 14, lineHeight: 1.65, color: "#9CA3AF" }}>{p}</span>
                      </li>
                    ))}
                  </ul>
                </div>
              </FadeUp>
            ))}
          </div>
        </div>
      </section>

      {/* ── FAQ ── */}
      <section id="faq" style={S.sectionPad}>
        <div style={{ maxWidth: 720, margin: "0 auto", padding: "0 24px" }}>
          <FadeUp>
            <span style={S.eyebrow}>FAQ</span>
            <h2 style={{ ...S.h2, fontSize: "clamp(24px,2.8vw,34px)", marginBottom: 48 }}>
              Questions people actually ask.
            </h2>
          </FadeUp>
          <FadeUp delay={60}>
            <FAQAccordion />
          </FadeUp>
        </div>
      </section>

      {/* ── FINAL CTA ── */}
      <section style={{ ...S.alt, ...S.border, padding: "120px 0", position: "relative", overflow: "hidden" }}>
        <div style={{
          position: "absolute", bottom: "-25%", left: "50%", transform: "translateX(-50%)",
          width: 640, height: 320, borderRadius: "50%",
          background: "radial-gradient(ellipse, #7C3AED 0%, transparent 70%)",
          animation: prefersReducedMotion ? "none" : "bgPulse 15s ease-in-out infinite",
          pointerEvents: "none",
        }} />
        <div style={{ ...S.container, position: "relative", zIndex: 1 }}>
          <FadeUp>
            <h2 style={{ ...S.h2, fontSize: "clamp(30px,4.5vw,58px)", marginBottom: 16, maxWidth: 560 }}>
              NEXTGEN isn't just about learning.{" "}
              <span style={{ color: "#6B7280" }}>It's about becoming.</span>
            </h2>
          </FadeUp>
          <FadeUp delay={80}>
            <p style={{ ...S.body, marginBottom: 40, maxWidth: 400 }}>
              The skills, the community, and the opportunity are here. The only thing missing is you.
            </p>
          </FadeUp>
          <FadeUp delay={140}>
            <div style={{ display: "flex", gap: 12, flexWrap: "wrap" }}>
              <PrimaryButton>Join NEXTGEN</PrimaryButton>
              <GhostButton>Apply for Elite</GhostButton>
            </div>
          </FadeUp>
          <FadeUp delay={200}>
            <div style={{ display: "flex", alignItems: "center", gap: 16, marginTop: 36 }}>
              <span style={{ fontSize: 13, color: "#6B7280" }}>Or come hang out</span>
              <span style={{ display: "flex", gap: 10 }}>
                <SocialIconLink href={X_URL} label="NEXTGEN on X">
                  <XIcon size={15} />
                </SocialIconLink>
                <SocialIconLink href={DISCORD_URL} label="NEXTGEN on Discord">
                  <DiscordIcon size={17} />
                </SocialIconLink>
              </span>
            </div>
          </FadeUp>
        </div>
      </section>

      {/* ── FOUNDER ── */}
      <section style={{ ...S.border, ...S.sectionPad }}>
        <div style={S.container}>
          <div
            style={{ display: "grid", gridTemplateColumns: "300px 1fr", gap: 56, alignItems: "center" }}
            className="two-col"
          >
            <FadeUp>
              <div
                style={{
                  width: "100%",
                  maxWidth: 300,
                  border: "1px solid rgba(255,255,255,0.08)",
                  borderRadius: 12,
                  overflow: "hidden",
                  background: "#000",
                }}
              >
                <img
                  src="/founder.jpg"
                  alt="SON OF PEACE, founder of NEXTGEN"
                  width="720"
                  height="720"
                  loading="lazy"
                  style={{ width: "100%", height: "auto", display: "block" }}
                />
              </div>
            </FadeUp>

            <FadeUp delay={80}>
              <span style={S.eyebrow}>The founder</span>
              <h2 style={{ ...S.h2, fontSize: "clamp(26px,3vw,40px)", marginBottom: 18 }}>SON OF PEACE</h2>
              <p style={{ ...S.body, marginBottom: 26, maxWidth: 460 }}>
                SON OF PEACE started NEXTGEN to give people a real path into the new tech economy — not more theory, but skills, a community, and opportunities you can actually act on.
              </p>
              <IconTextLink href={FOUNDER_X_URL} label="SON OF PEACE on X">
                <XIcon size={14} />
                @sonofpeace0001
              </IconTextLink>
            </FadeUp>
          </div>
        </div>
      </section>

      {/* ── FOOTER ── */}
      <footer style={{ ...S.border, padding: "44px 0", background: "#0A0A0C" }}>
        <div style={{
          ...S.container,
          display: "flex",
          flexWrap: "wrap",
          alignItems: "flex-start",
          justifyContent: "space-between",
          gap: 32,
        }}>
          <div>
            <a href="#" style={{ display: "flex", alignItems: "center", gap: 9, marginBottom: 10 }}>
              <LogoMark size={20} />
              <span style={{ fontFamily: "'Space Grotesk','Inter',sans-serif", fontWeight: 600, fontSize: 14, letterSpacing: "-0.02em", color: "#F5F5F7" }}>
                NEXTGEN
              </span>
            </a>
            <p style={{ fontSize: 13, color: "#6B7280", lineHeight: 1.5, marginBottom: 18 }}>
              The future-skills community.<br />Build, earn, and grow.
            </p>
            <div style={{ display: "flex", gap: 10 }}>
              <SocialIconLink href={X_URL} label="NEXTGEN on X">
                <XIcon size={15} />
              </SocialIconLink>
              <SocialIconLink href={DISCORD_URL} label="NEXTGEN on Discord">
                <DiscordIcon size={17} />
              </SocialIconLink>
            </div>
          </div>

          <div style={{ display: "flex", gap: 28, flexWrap: "wrap", alignItems: "center" }}>
            {NAV_LINKS.map((l) => (
              <a key={l.label} href={l.href} style={{ fontSize: 13, color: "#6B7280" }}>{l.label}</a>
            ))}
          </div>

          <p style={{ fontSize: 12, color: "#374151", alignSelf: "flex-end" }}>
            &copy; {new Date().getFullYear()} NEXTGEN
          </p>
        </div>
      </footer>

      {/* Responsive overrides */}
      <style>{`
        @media (max-width: 768px) {
          .hidden-mobile { display: none !important; }
          .mobile-menu-btn { display: block !important; }
          .hero-grid { grid-template-columns: 1fr !important; gap: 48px !important; }
          .hero-visual { display: none; }
          .two-col { grid-template-columns: 1fr !important; gap: 40px !important; }
          .three-col { grid-template-columns: 1fr !important; gap: 0 !important; }
          .three-col > div > div {
            border-left: none !important;
            padding: 0 0 40px !important;
            border-bottom: 1px solid rgba(255,255,255,0.08);
            margin-bottom: 40px;
          }
          .creao-side {
            border-left: none !important;
            border-top: 1px solid rgba(255,255,255,0.08);
          }
        }
        @media (min-width: 769px) {
          .hidden-mobile { display: flex !important; }
          .mobile-menu-btn { display: none !important; }
        }
      `}</style>
    </div>
  );
}
