import { supabase } from "./supabase.js";

// Thin wrappers over Supabase Auth. The browser only ever uses the anon key;
// RLS does the authorization once a user is signed in.

export async function signUp(email, password) {
  const { data, error } = await supabase.auth.signUp({ email, password });
  if (error) throw error;
  return data;
}

export async function signIn(email, password) {
  const { data, error } = await supabase.auth.signInWithPassword({ email, password });
  if (error) throw error;
  return data;
}

export async function signOut() {
  const { error } = await supabase.auth.signOut();
  if (error) throw error;
}

export async function getSession() {
  const { data } = await supabase.auth.getSession();
  return data.session;
}

export function onAuthChange(callback) {
  const { data } = supabase.auth.onAuthStateChange((_event, session) => callback(session));
  return () => data.subscription.unsubscribe();
}

// Send a password-recovery email. The link returns to the app root with a
// recovery token in the URL hash; main.jsx routes that arrival into the Academy,
// where a set-new-password screen is shown.
export async function requestPasswordReset(email) {
  const { error } = await supabase.auth.resetPasswordForEmail(email, {
    redirectTo: `${window.location.origin}/`,
  });
  if (error) throw error;
}

// Set a new password for the currently signed-in (recovery) session.
export async function updatePassword(newPassword) {
  const { data, error } = await supabase.auth.updateUser({ password: newPassword });
  if (error) throw error;
  return data;
}

// Fires when the user arrives from a recovery link (after Supabase parses the token).
export function onPasswordRecovery(callback) {
  const { data } = supabase.auth.onAuthStateChange((event) => {
    if (event === "PASSWORD_RECOVERY") callback();
  });
  return () => data.subscription.unsubscribe();
}
