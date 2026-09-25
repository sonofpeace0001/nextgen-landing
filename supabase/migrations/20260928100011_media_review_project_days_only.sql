-- Media tracks: only module projects and the capstone need a person's approval.
-- Other days are practice and complete on submission, so the admin queue stays small.
update public.day d
   set requires_review = false
  from public.track t
 where t.id = d.track_id
   and t.slug in ('film', 'motion', 'audio')
   and d.day_number not in (6, 12, 18, 24, 30);
