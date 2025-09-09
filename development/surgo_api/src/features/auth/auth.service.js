// defines auth business logic upon functions from auth.repo

// imports
import * as authRepo from "./auth.repository.js";
import { supabaseAdmin } from "../../app/supabase.js";

// step 2 for repo functions - add business logic (rate limits etc.)

// function to signup a user with email and password
export async function signup(email, password) {
  // add business logic here when required

  return await authRepo.signUpWithEmail(email, password);
}

// function to login a user with email and password
export async function login(email, password) {
  // add business logic here when required

  return await authRepo.signInWithEmail(email, password);
}

// function to delete a user's account using UserID
export async function deleteUser(userID) {
  const { error } = await supabaseAdmin.auth.admin.deleteUser(userID);
  if (error) {
    // bubble up so controller/central error handler can step in
    throw error;
  }
  return { success: true };
}
