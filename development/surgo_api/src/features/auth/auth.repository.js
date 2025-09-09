// defines auth database/supabase calls

// imports
import { supabase } from "../../app/supabase.js";

// functions
export async function signUpWithEmail(email, password) {
  // use supabase.auth.signUp
  const { data, error } = await supabase.auth.signUp({ email, password });
  if (error) {
    throw error;
  }
  return data; // include return data - user and session - depends on supabase configurations
}

export async function signInWithEmail(email, password) {
  // use supabase.auth.signIn
  const { data, error } = await supabase.auth.signInWithPassword({
    email,
    password,
  });
  if (error) {
    throw error;
  }
  return data; // contains session and user on success
}
