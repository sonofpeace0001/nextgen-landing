import { motion, useReducedMotion } from "motion/react";
import { cn } from "@/lib/utils";

// Brand-skinned geometric background. Original used five hardcoded colors
// (indigo/rose/violet/amber/cyan), #030303, and heavy glows; this version is
// tokens-only, a single accent, hairline borders, and respects reduced motion.
function ElegantShape({ className, delay = 0, width = 400, height = 100, rotate = 0 }) {
  const reduce = useReducedMotion();
  return (
    <motion.div
      initial={reduce ? false : { opacity: 0, y: -150, rotate: rotate - 15 }}
      animate={{ opacity: 1, y: 0, rotate }}
      transition={
        reduce
          ? { duration: 0 }
          : { duration: 2.4, delay, ease: [0.23, 0.86, 0.39, 0.96], opacity: { duration: 1.2 } }
      }
      className={cn("absolute", className)}
    >
      <motion.div
        animate={reduce ? {} : { y: [0, 15, 0] }}
        transition={reduce ? {} : { duration: 12, repeat: Number.POSITIVE_INFINITY, ease: "easeInOut" }}
        style={{ width, height }}
        className="relative"
      >
        {/* faint accent fill + hairline border, no heavy shadow */}
        <div
          className="absolute inset-0 rounded-full border border-border backdrop-blur-[2px]"
          style={{ background: "color-mix(in srgb, var(--primary) 10%, transparent)" }}
        />
      </motion.div>
    </motion.div>
  );
}

// Full-page backdrop: a fixed, full-viewport layer so the ambient shapes stay
// behind the whole page while it scrolls. Content renders above it.
export default function GeometricBackground({ children, className }) {
  return (
    <div className={cn("relative w-full", className)}>
      <div aria-hidden="true" className="fixed inset-0 overflow-hidden bg-background">
        {/* single subtle accent wash */}
        <div
          className="absolute inset-0"
          style={{
            background:
              "radial-gradient(55% 45% at 50% 25%, color-mix(in srgb, var(--primary) 6%, transparent), transparent 70%)",
          }}
        />
        <ElegantShape delay={0.3} width={600} height={140} rotate={12} className="left-[-10%] top-[12%] md:left-[-5%] md:top-[16%]" />
        <ElegantShape delay={0.5} width={500} height={120} rotate={-15} className="right-[-5%] top-[58%] md:right-[0%] md:top-[62%]" />
        <ElegantShape delay={0.4} width={300} height={80} rotate={-8} className="bottom-[8%] left-[4%] md:left-[10%]" />
        <ElegantShape delay={0.6} width={200} height={60} rotate={20} className="right-[14%] top-[8%] md:right-[20%]" />
        <ElegantShape delay={0.7} width={150} height={40} rotate={-25} className="left-[22%] bottom-[18%] md:left-[28%]" />
      </div>

      <div className="relative z-10">{children}</div>
    </div>
  );
}
