import { useEffect } from "react";
import { Markdown } from "../components/Markdown.jsx";

// Plain-language Privacy and Terms pages. DRAFT prepared from what the app actually does; the owner
// should have a qualified professional review them and add a contact address before relying on them.
const DISCORD_URL = "https://discord.gg/HDgMdVECwF";
const UPDATED = "26 September 2026";

const PRIVACY = `
NEXTGEN is a learning community and academy. This page explains what we collect, why, who processes it, and the choices you have. Last updated ${UPDATED}.

## What we collect

- **Account:** your email address and a password (stored securely by our sign-in provider, never in plain text), and an optional display name.
- **Your goals and progress:** the goals you choose, your enrolments, which days you have finished, scores and streaks.
- **Your submissions:** the text and links you submit for assignments, and the scores and feedback you receive.
- **Scoring records:** for AI-scored days, a log of when a submission was scored, which model scored it and the outcome, used to prevent abuse and limit cost.
- **On your device:** your theme choice and, if you pick a goal before signing in, that goal, saved in your browser.

We do not run advertising trackers on this site.

## How we use it

- To run your account and show your progress.
- To score and give feedback on your work, and to let a person review it when needed.
- To keep the service safe and working, and to fix problems.
- To share your work in the community, but only when you press the share button yourself.

## AI scoring

Some assignments are scored by an AI model. When you submit one of those, the text and image links in your submission are sent to our AI provider, together with the lesson title, objective, assignment and scoring rubric. We do **not** send your email address or password. AI scores can be wrong: you can ask a person to re-check any score. Do not include passwords, ID numbers, bank details or other private information about yourself or anyone else in a submission.

## Who processes your data

- **Supabase:** database and sign-in.
- **Vercel:** website hosting.
- **Anthropic:** AI scoring of submissions (only on AI-scored days).
- **Discord:** only if you choose to share a result. The post shows your display name, your score, one point of feedback and, if you included one, your image link.

## Links to other sites

Some links, including links to CREAO, are referral links: if you sign up we may receive a benefit. Other sites have their own privacy policies.

## Your choices

- You can ask us to see, correct or delete your data, or to delete your account, by messaging us on [Discord](${DISCORD_URL}).
- You can stop AI scoring of a day by not submitting it, or ask a person to review a result.
- Sharing to Discord is always your choice. Ask us to remove a post you shared.

## Keeping data

We keep your account and submissions while your account is open and delete them when you ask us to delete your account, except where we must keep a record for a legitimate reason such as preventing abuse.

## Children

NEXTGEN is not aimed at children under 13. If you believe a child has given us information, tell us and we will remove it.

## Changes

If we change this page in a way that matters, we will update the date at the top.
`;

const TERMS = `
These terms cover your use of the NEXTGEN website, Academy, Resource Library and community. By creating an account or using the Academy you agree to them. Last updated ${UPDATED}.

## What NEXTGEN is

A place to learn practical AI skills through lessons, assignments, feedback and community. It is education, not professional advice. Nothing here is legal, tax, financial, medical or investment advice. Some lessons mention laws and contracts to help you ask good questions; talk to a qualified professional for your situation.

## Your account

Give accurate details, keep your password private and tell us if you think your account was used by someone else. You are responsible for what you do with it.

## Your work

You own the work you submit. You give us permission to store it, have it scored by AI and reviewed by people, and, only when you press share, post it to our Discord. You confirm that you have the right to submit it, that it does not include other people's private information, and that any real person's face, voice or work in it is used with their permission.

## AI feedback

Scores and feedback may be produced by AI and can be wrong or incomplete. They are a learning aid, not a grade from a school or a certification. You can ask a person to re-check a score. Some lessons need a person to approve your work before the next lesson opens.

## Fair use of the service

Do not submit unlawful, harmful, deceptive or infringing material; do not try to break, overload or misuse the service or its scoring; do not use it to harass others; and do not share someone else's account. We may remove content or suspend accounts that break these rules.

## Referral links and tools

Some links, including CREAO links, are referral links and we may receive a benefit if you sign up. Third-party tools have their own terms, prices and licences, which change; check them before you rely on a tool or sell work made with it.

## Paid features

Where we offer paid features such as Elite, the price and what is included are shown where they are offered. Read them before you pay.

## Availability and changes

We work to keep the service running but do not promise it will always be available or error-free. Content, lessons and features can change. We may update these terms and will change the date above when we do.

## Liability

To the extent the law allows, NEXTGEN is provided as is, and we are not responsible for losses that come from relying on lessons, AI feedback, templates or tool suggestions, or from third-party tools. Nothing here limits rights you have by law that cannot be limited.

## Contact

Questions about these terms or your data: message us on [Discord](${DISCORD_URL}).
`;

export default function LegalApp({ page }) {
  const isPrivacy = page === "privacy";
  useEffect(() => {
    document.title = `${isPrivacy ? "Privacy" : "Terms"} | NEXTGEN`;
    window.scrollTo(0, 0);
  }, [isPrivacy]);
  return (
    <div className="min-h-screen bg-background text-foreground" style={{ fontFamily: "'Inter',system-ui,sans-serif" }}>
      <header className="border-b border-border">
        <div className="mx-auto flex h-16 max-w-6xl items-center justify-between px-6">
          <a href="#top" className="flex items-center gap-2.5" aria-label="NEXTGEN home">
            <img src="/logo.png" alt="" aria-hidden="true" className="h-7 w-auto" />
            <span className="font-heading text-[17px] font-semibold tracking-tight text-foreground">NEXTGEN</span>
          </a>
          <nav className="flex items-center gap-5 text-sm text-muted-foreground">
            <a href="#/privacy" className={isPrivacy ? "text-foreground" : "hover:text-foreground"}>Privacy</a>
            <a href="#/terms" className={!isPrivacy ? "text-foreground" : "hover:text-foreground"}>Terms</a>
            <a href="#top" className="hover:text-foreground">Home</a>
          </nav>
        </div>
      </header>
      <main className="mx-auto max-w-3xl px-6 py-12">
        <h1 className="font-heading text-4xl font-semibold tracking-tight">{isPrivacy ? "Privacy" : "Terms of use"}</h1>
        <Markdown text={isPrivacy ? PRIVACY : TERMS} style={{ marginTop: 24, fontSize: 16 }} />
      </main>
    </div>
  );
}
