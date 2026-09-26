// Tiny, safe markdown parser for lesson and resource text. Produces plain data (no HTML strings), so
// React renders it without dangerouslySetInnerHTML. Supports: #### headings, paragraphs, bullet and
// numbered lists, blockquotes, **bold**, *italic*, `code` and [text](url) links (http, https, mailto
// and in-app #/ links only).

const SAFE_LINK = /^(https?:\/\/|mailto:|#\/)/i;

export function isSafeLink(url) {
  return SAFE_LINK.test(String(url || "").trim());
}

export function parseInline(text) {
  const out = [];
  const re = /(\*\*([^*]+)\*\*|\*([^*\s][^*]*)\*|`([^`]+)`|\[([^\]]+)\]\(([^)\s]+)\))/g;
  let last = 0;
  let m;
  while ((m = re.exec(text)) !== null) {
    if (m.index > last) out.push({ t: "text", v: text.slice(last, m.index) });
    if (m[2] !== undefined) out.push({ t: "bold", v: m[2] });
    else if (m[3] !== undefined) out.push({ t: "italic", v: m[3] });
    else if (m[4] !== undefined) out.push({ t: "code", v: m[4] });
    else if (isSafeLink(m[6])) out.push({ t: "link", v: m[5], href: m[6].trim() });
    else out.push({ t: "text", v: m[5] });
    last = m.index + m[0].length;
  }
  if (last < text.length) out.push({ t: "text", v: text.slice(last) });
  return out;
}

export function parseBlocks(src) {
  const lines = String(src || "").replace(/\r\n?/g, "\n").split("\n");
  const blocks = [];
  let para = [];
  let list = null;
  let quote = [];
  const flushPara = () => { if (para.length) { blocks.push({ t: "p", v: para.join(" ") }); para = []; } };
  const flushList = () => { if (list) { blocks.push(list); list = null; } };
  const flushQuote = () => { if (quote.length) { blocks.push({ t: "quote", v: quote.join(" ") }); quote = []; } };
  const flushAll = () => { flushPara(); flushList(); flushQuote(); };
  for (const line of lines) {
    if (!line.trim()) { flushAll(); continue; }
    let m;
    if ((m = line.match(/^(#{1,4})\s+(.*)$/))) { flushAll(); blocks.push({ t: "h", level: m[1].length, v: m[2].trim() }); continue; }
    if ((m = line.match(/^\s*[-*]\s+(.*)$/))) {
      flushPara(); flushQuote();
      if (!list || list.t !== "ul") { flushList(); list = { t: "ul", items: [] }; }
      list.items.push(m[1]); continue;
    }
    if ((m = line.match(/^\s*\d+[.)]\s+(.*)$/))) {
      flushPara(); flushQuote();
      if (!list || list.t !== "ol") { flushList(); list = { t: "ol", items: [] }; }
      list.items.push(m[1]); continue;
    }
    if ((m = line.match(/^>\s?(.*)$/))) { flushPara(); flushList(); quote.push(m[1]); continue; }
    flushList(); flushQuote();
    para.push(line.trim());
  }
  flushAll();
  return blocks;
}
