-- Publish the Expert and Grandmaster tiers (days 61-90) of the nine goal tracks,
-- now that each lesson has a worked example and a common mistake.
update public.day d
   set is_published = true
  from public.track t
 where t.id = d.track_id
   and t.slug in ('graphics','content','apps','agents','film','motion','audio','research','business')
   and d.day_number between 61 and 90;
