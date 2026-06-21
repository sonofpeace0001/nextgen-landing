-- NEXTGEN refocused on AI only. Remove the (unpublished) Web3 and Freelancing
-- tracks. The on-delete cascades on tier/day/day_check clean up everything
-- beneath them. Idempotent: deletes nothing if they are already gone.
--
-- Note: the curriculum scaffold migration (20260609100001) still *creates* these
-- two tracks; this migration runs after it, so a fresh database ends up AI-only.
delete from public.track where slug in ('web3', 'freelancing');
