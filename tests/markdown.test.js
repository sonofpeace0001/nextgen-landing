import { describe, it, expect } from "vitest";
import { parseBlocks, parseInline, isSafeLink } from "../src/lib/markdown.js";

describe("markdown", () => {
  it("parses headings, paragraphs and lists", () => {
    const b = parseBlocks("## Title\n\nHello **world**.\nSecond line.\n\n- one\n- two\n\n1. first\n2. second");
    expect(b.map((x) => x.t)).toEqual(["h", "p", "ul", "ol"]);
    expect(b[1].v).toBe("Hello **world**. Second line.");
    expect(b[2].items).toEqual(["one", "two"]);
    expect(b[3].items).toEqual(["first", "second"]);
  });

  it("parses inline bold, italic, code and safe links", () => {
    const n = parseInline("a **b** *c* `d` [e](https://x.com) [f](javascript:alert(1))");
    expect(n.filter((x) => x.t === "bold")[0].v).toBe("b");
    expect(n.filter((x) => x.t === "italic")[0].v).toBe("c");
    expect(n.filter((x) => x.t === "code")[0].v).toBe("d");
    expect(n.filter((x) => x.t === "link")).toHaveLength(1);
    expect(n.some((x) => x.t === "text" && x.v === "f")).toBe(true); // unsafe link degrades to text
  });

  it("only allows http(s), mailto and in-app links", () => {
    expect(isSafeLink("https://a.com")).toBe(true);
    expect(isSafeLink("#/start")).toBe(true);
    expect(isSafeLink("javascript:alert(1)")).toBe(false);
    expect(isSafeLink("data:text/html,x")).toBe(false);
  });

  it("does not produce HTML strings", () => {
    const n = parseInline("<img src=x onerror=alert(1)> **ok**");
    expect(n[0].v).toContain("<img"); // kept as literal text, rendered escaped by React
  });
});
