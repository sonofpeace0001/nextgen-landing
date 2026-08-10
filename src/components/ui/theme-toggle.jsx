import { useSyncExternalStore } from "react";
import { Sun, Moon } from "lucide-react";
import { cn } from "@/lib/utils";
import { getTheme, subscribeTheme, toggleTheme } from "@/lib/theme";

export function useTheme() {
  const theme = useSyncExternalStore(subscribeTheme, getTheme, () => "dark");
  return { theme, toggle: toggleTheme };
}

export function ThemeToggle({ className }) {
  const { theme, toggle } = useTheme();
  return (
    <button
      type="button"
      onClick={toggle}
      aria-label={theme === "light" ? "Switch to dark mode" : "Switch to light mode"}
      className={cn(
        "inline-flex h-9 w-9 shrink-0 items-center justify-center rounded-lg border border-border text-muted-foreground transition-colors hover:text-foreground motion-reduce:transition-none",
        className,
      )}
    >
      {theme === "light" ? <Moon size={16} /> : <Sun size={16} />}
    </button>
  );
}
