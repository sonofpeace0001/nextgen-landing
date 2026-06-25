-- Switch the drip default to immediate completion-gating (no calendar-day
-- cooldown) so members can proceed to the next day as soon as they complete the
-- current one. Previously 'completion_capped' held the next day until the
-- following calendar day, which read as "can't proceed to day 2 after day 1".
alter table public.enrollment alter column unlock_mode set default 'completion';

-- Unblock existing members who were created on the capped mode.
update public.enrollment set unlock_mode = 'completion' where unlock_mode = 'completion_capped';
