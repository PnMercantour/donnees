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

Par ailleurs, commande intéressante pour récupérer l'ensemble des noms d'un taxon donné: 

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

# Conversion de WKB en WKT 
```python
from shapely.wkb import loads
df['geometry'] = df.WKT.apply(loads)
df = df.drop(columns=['WKT', 'geom'])
gdf = gpd.GeoDataFrame(df, geometry='geometry')
```

# Fusions de données à partir de requêtes sur Geonature V1 et V2
```
"""
Combinaison des opérations pour changer les géométries de WKB vers objets shapely gérés par geopandas
et combinaison des requêtes à partir des uuid (dans ce cas aucune valeur d'uuid n'est nulle, sinon cas à gérer).
"""
import pandas as pd
old_lepido = "C:/Users/echraibi/Documents/projets/2025/synthese_lepido_clementine/requete_gnv1.csv"
new_lepido = "C:/Users/echraibi/Documents/projets/2025/synthese_lepido_clementine/requete_gnv2.csv"


lepidol = pd.read_csv(old_lepido)
lepidnew = pd.read_csv(new_lepido)

toadd = lepidol.loc[~lepidol['unique_id_sinp'].isin(lepidnew['unique_id_sinp'])]

res = pd.concat((lepidnew,toadd))

import geopandas as gpd
import shapely.wkb
res['geom'] = res['geom'].map(shapely.wkb.loads)
res = gpd.GeoDataFrame(res, crs="EPSG:2154", geometry=res['geom'])
res = res.drop('geom', axis=1)
res['geometry'] = res['geometry'].centroid
res.to_csv("C:/Users/echraibi/Documents/projets/2025/synthese_lepido_clementine/sub_cdref_lepido_res.csv")
res.to_file("C:/Users/echraibi/Documents/projets/2025/synthese_lepido_clementine/sub_cdref_lepido_res.gpkg")
```


# Expérimentation MBtiles
Script supposé générer un MBTiles qui se sert du scan25 pour les hauts niveaux de zoom, et du scan100 pour les bas niveaux de zoom.
```bash
gdal_translate -of mbtiles -co "TILE_FORMAT=PNG8" -co "ZLEVEL=9" "scan100_exp.tif" "mapbase.mbtiles"
gdal_translate -of mbtiles -co "TILE_FORMAT=PNG8" -co "ZLEVEL=9" "scan25_exp.tif" "mapbase_low.mbtiles"
gdaladdo -r nearest -oo "TILE_FORMAT=PNG8" -oo "ZLEVEL=9" "mapbase_low.mbtiles" 2 4 8 16
echo ATTACH "mapbase_low.mbtiles" AS low; INSERT or REPLACE INTO tiles SELECT * FROM low.tiles; | sqlite3 "mapbase.mbtiles"

> sqlite3 mapbase.mbtiles
> update metadata set value=10 where name='minzoom';

sqlite3 mapbase_tomodif.mbtiles
 update tiles set zoom_level=23-zoom_level;
```