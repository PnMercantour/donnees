
#  Fonction de correction de zone
```sql
create function ref_geo.fct_fix_cor_area_synthese(area_in int)
returns VOID
language plpgsql
as
$$
begin
	delete from gn_synthese.cor_area_synthese cas
	where cas.id_area =area_in;
	INSERT INTO gn_synthese.cor_area_synthese (id_synthese, id_area)
	SELECT
	  s.id_synthese,
	  la.id_area
	FROM
	  gn_synthese.synthese s,
	  ref_geo.l_areas la
	WHERE
	  la.id_area = area_in
	  AND st_intersects (s.the_geom_local, la.geom)
	  AND NOT st_touches (s.the_geom_local, la.geom)
	ON CONFLICT
	  DO nothing;
end;
$$;
```

# requête boucle qui appelle la fonction
```sql
do 
$do$
declare
 tempid record;
begin
	for tempid in (select id_area from ref_geo.l_areas where id_type=25) 
	loop
		PERFORM fct_fix_cor_area_synthese( tempid.id_area);
		raise notice 'Processed %', tempid.id_area;
	end loop;
end
$do$;
```