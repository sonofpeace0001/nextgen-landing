import { parseBlocks, parseInline } from "../lib/markdown.js";

function Inline({ text }) {
  return parseInline(text).map((n, i) => {
    if (n.t === "bold") return <strong key={i} style={{ color: "inherit", fontWeight: 700 }}>{n.v}</strong>;
    if (n.t === "italic") return <em key={i}>{n.v}</em>;
    if (n.t === "code") return <code key={i} style={{ background: "rgba(255,255,255,0.08)", borderRadius: 4, padding: "1px 5px", fontSize: "0.92em" }}>{n.v}</code>;
    if (n.t === "link") {
      const external = /^https?:/i.test(n.href);
      return (
        <a key={i} href={n.href} {...(external ? { target: "_blank", rel: "noopener noreferrer" } : {})} style={{ color: "var(--primary, #A855F7)", textDecoration: "underline" }}>
          {n.v}
        </a>
      );
    }
    return <span key={i}>{n.v}</span>;
  });
}

// Renders lesson/assignment/resource markdown as real elements. Inherits colour and font size.
export function Markdown({ text, style }) {
  const blocks = parseBlocks(text);
  const gap = { margin: "0 0 12px" };
  return (
    <div style={{ lineHeight: 1.65, wordBreak: "break-word", ...style }}>
      {blocks.map((b, i) => {
        if (b.t === "h") {
          const size = b.level <= 2 ? "1.15em" : "1.05em";
          return <h3 key={i} style={{ margin: "18px 0 8px", fontSize: size, fontWeight: 700, color: "inherit" }}><Inline text={b.v} /></h3>;
        }
        if (b.t === "ul" || b.t === "ol") {
          const Tag = b.t;
          return (
            <Tag key={i} style={{ ...gap, paddingLeft: 22, listStyle: b.t === "ul" ? "disc" : "decimal" }}>
              {b.items.map((it, j) => <li key={j} style={{ marginBottom: 4 }}><Inline text={it} /></li>)}
            </Tag>
          );
        }
        if (b.t === "quote") {
          return <blockquote key={i} style={{ ...gap, borderLeft: "3px solid rgba(168,85,247,0.6)", paddingLeft: 12, opacity: 0.95 }}><Inline text={b.v} /></blockquote>;
        }
        return <p key={i} style={gap}><Inline text={b.v} /></p>;
      })}
    </div>
  );
}
