# Comparaison méthodes de calcul d'aire

```sql
SELECT nom, st_area(geom) as area_geom2154 , 
st_area(st_transform(geom, 4326)) as area_geom4326, 
st_area(st_transform(geom, 4326)::geography) as area_geogr4326, 
(st_area(geom) -  st_area(st_transform(geom, 4326)::geography))/10000 as dif_ha from admin_express.commune
```

En comparant avec les aires données par l'insee et selon les différentes sources ign (admin express vs cog carto)

```sql
SELECT  CASE WHEN cp.nom = 'La Bollène-Vésubie' THEN 'Bollene Vésubie' ELSE cp.nom END as nom, 
-- st_area(cp.geom)/1000000 as superficie_commune, 
st_area(ST_intersection(st_transform(cp.geom, 4326)::geography, st_transform(li.geom, 4326)::geography))/1000000 as superficie_coeur, 

st_area(st_transform(cp.geom, 4326)::geography)/1000000 as superficie_adminexpress24,
st_area(st_transform(ae20.geom, 4326)::geography)/1000000 as superficie_adminexpress20, 
st_area(st_transform(cog24.geom, 4326)::geography)/1000000 as superficie_cog24, 

st_area(st_transform(cp.geom, 4326)::geography)/10000  - st_area(st_transform(ae20.geom, 4326)::geography)/10000 as difae,

ci.p20_pop,
ci.superf as superficie_insee,
ST_intersection(st_transform(cp.geom, 4326)::geography, st_transform(li.geom, 4326)::geography)
from 
public.limites_inpn li, admin_express.communes_parc cp
join public.commune_insee ci on cp.insee_com= ci.codgeo 
join admin_express.adminexpress_2020 ae20 on cp.insee_com = ae20.insee_com
join admin_express.cogcarto_2024_paca cog24 on cp.insee_com = cog24.insee_com
WHERE li.id_local='coeur_PNM'
AND st_area(ST_intersection(st_transform(cp.geom, 4326)::geography, st_transform(li.geom, 4326)::geography))/1000000>0
OR cp.nom in ('Barcelonnette', 'Fontan', 'Jausiers', 'Saint-Dalmas-le-Selvage', 'Saint-Étienne-de-Tinée')
ORDER by cp.nom
```




# Verification cohérence nom_cite/cd_nom

```sql
with pre as (SELECT id_synthese, cd_nom, nom_cite, id_source
from gn_synthese.synthese)
SELECT pre.*, tr.nom_vern, tr.nom_valide 
from pre
JOIN taxonomie.taxref tr using(cd_nom)
WHERE LEFT(lower(pre.nom_cite), 3) NOT LIKE LEFT(lower(tr.nom_valide), 3) 
AND LEFT(lower(pre.nom_cite), 3) NOT LIKE LEFT(lower(tr.nom_vern), 3) 
AND position (split_part(lower(pre.nom_cite),' ',1) in lower(tr.nom_vern)) = 0
AND position (split_part(lower(pre.nom_cite),' ',2) in lower(tr.nom_vern)) = 0
AND position (split_part(lower(pre.nom_cite),' ',1) in lower(tr.nom_valide)) = 0
AND position (split_part(lower(pre.nom_cite),' ',2) in lower(tr.nom_valide)) = 0
```

Au moment de l'utilisation de cette commande (2024-08), on obtient 11099 entrées où les 3 premières lettres ne collent pas avec nom valide NI nom vern
Et le premier mot ni le deuxième mot de nom cite ne sont ni dans nom vern, ni dans nom valide.

Par ailleurs, commande intéressante pour récupérer l'ensemble des noms: 

```sql
SELECT string_agg(nom_complet ||','|| lb_nom||','|| nom_vern, ', ')
from taxonomie.taxref 
where cd_ref = 92
```

# Conversion shp -> gpkg avec une colonne au format datetime
```python

path_shp = ""
col_date = ""

import geopandas as gpd
import pandas as pd
import os

temp = gpd.read_file(path_shp)
temp["datetime"] = pd.to_datetime(temp[col_date])
    
out_path = os.path.dirname(path_shp)
out_path = os.path.join(out_path, 
                        os.path.basename(path_shp.split('.')[0])) + '_dt.gpkg'
temp.to_file(out_path)
    
    return
```
