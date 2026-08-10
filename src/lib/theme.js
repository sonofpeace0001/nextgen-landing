const KEY = "ng-theme";

function getInitialTheme() {
  if (typeof window === "undefined") return "dark";
  const saved = localStorage.getItem(KEY);
  if (saved === "light" || saved === "dark") return saved;
  return window.matchMedia("(prefers-color-scheme: light)").matches ? "light" : "dark";
}

function applyTheme(theme) {
  if (theme === "light") document.documentElement.setAttribute("data-theme", "light");
  else document.documentElement.removeAttribute("data-theme");
  localStorage.setItem(KEY, theme);
}

// Single source of truth, shared by every ThemeToggle instance (there can be more
// than one mounted at once — e.g. desktop nav + mobile nav — via useSyncExternalStore
// so they never drift out of sync with each other.
let theme = getInitialTheme();
const listeners = new Set();

if (typeof document !== "undefined") applyTheme(theme);

export function getTheme() {
  return theme;
}

export function setTheme(next) {
  theme = next;
  applyTheme(theme);
  listeners.forEach((l) => l());
}

export function toggleTheme() {
  setTheme(theme === "light" ? "dark" : "light");
}

export function subscribeTheme(callback) {
  listeners.add(callback);
  return () => listeners.delete(callback);
}
