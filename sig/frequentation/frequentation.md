


Fréquentation par tranche de 12h
```sql
SELECT id_compteur, heure,aller, 
-- 			 count(*) OVER w AS n_mesure,
			 sum(sum(aller)) OVER w AS trans_total
FROM   tourisme.mesure_compteur t
WHERE id_compteur = 3
GROUP  BY id_compteur, heure, aller  -- is PK!
WINDOW w AS (ORDER BY heure
             RANGE BETWEEN CURRENT ROW AND '12 hours' FOLLOWING)
ORDER  BY heure, id_compteur
;
```


# Récupération des chemins pour les photos flickr

```
concat(
	concat('https://live.staticflickr.com/', "server", '/', "id" ),
	concat('_',  "secret" , '_w.jpg')
	)
```
 