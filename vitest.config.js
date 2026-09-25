import { defineConfig } from "vitest/config";

export default defineConfig({
  test: {
    environment: "node",
    setupFiles: ["./tests/setup.js"],
    exclude: ["**/node_modules/**", "supabase/functions/**"], // edge-function tests run with node --test
    testTimeout: 30000,
    hookTimeout: 30000,
  },
});
