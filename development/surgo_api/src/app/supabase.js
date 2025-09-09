// basic imports
import { createClient } from "@supabase/supabase-js";
import { config } from "./config.js";

if (!config.supabaseUrl) {
  throw new Error("Invalid SUPABASE URL");
}

// using anonymous key - no privileges
export const supabase = createClient(
  config.supabaseUrl,
  config.supabaseAnonKey
);

// privileged operations - use only on server side
export const supabaseAdmin = createClient(
  config.supabaseUrl,
  config.supabaseServiceKey
);
