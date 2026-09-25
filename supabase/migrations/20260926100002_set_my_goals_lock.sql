-- set_my_goals() is for signed-in members only. Supabase grants EXECUTE on new
-- public functions to anon by default, which `revoke ... from public` does not
-- remove, so revoke it explicitly. (The function also rejects anonymous callers
-- itself; this closes the door at the permission layer too.)
revoke execute on function public.set_my_goals(text[]) from anon;
grant execute on function public.set_my_goals(text[]) to authenticated;
