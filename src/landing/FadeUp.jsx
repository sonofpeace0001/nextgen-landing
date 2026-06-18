import { useState, useEffect, useRef } from "react";
import { prefersReducedMotion } from "./theme.js";

export default function FadeUp({ children, delay = 0, as: Tag = "div", style, className }) {
  const ref = useRef(null);
  const [seen, setSeen] = useState(false);

  useEffect(() => {
    if (prefersReducedMotion || !ref.current) return setSeen(true);
    const o = new IntersectionObserver(
      ([e]) => e.isIntersecting && (setSeen(true), o.disconnect()),
      { threshold: 0.1 }
    );
    o.observe(ref.current);
    return () => o.disconnect();
  }, []);

  const anim = prefersReducedMotion
    ? {}
    : {
        opacity: seen ? 1 : 0,
        transform: seen ? "none" : "translateY(24px)",
        transition: `opacity .7s cubic-bezier(0.25,0.4,0.25,1) ${delay}ms, transform .7s cubic-bezier(0.25,0.4,0.25,1) ${delay}ms`,
      };

  return (
    <Tag ref={ref} style={{ ...style, ...anim }} className={className}>
      {children}
    </Tag>
  );
}
