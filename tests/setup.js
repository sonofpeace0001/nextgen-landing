// Load .env.local for node-side integration tests (service_role lives here,
// never with a VITE_ prefix, never committed).
import { config } from "dotenv";

config({ path: ".env.local" });
