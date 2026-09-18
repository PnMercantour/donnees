# geonature_synthese 


## Schéma
Sources et structure de la donnée utile à la construction des projets : [geonature_synthese](../bd_pnm/geonature_synthese.md).



## Projet geonature_synthese

Projet par défaut. 
Il charge les principales couches du schéma afin de présenter un exemple des réalisations possibles.

Les observations sont représentées par des points, tandis que le nombre d'observations pour une maille et selon un groupe inpn donné sont affichées. 
Ces filtres sont appliqués à la fois par l'outil de filtrage, et au niveau de la symbologie ([Voir Bonnes Pratiques](../tutos/BonnesPratiques.md#filtres)).

Pour utiliser le projet, ces filtres peuvent être remplacés pour ne conserver que les données pertinentes.

### Couche "détail"
	
Si l'on s'intéresse à toutes les observations d'Arthropodes dans la couche "détail". Après avoir cliqué sur l'icône de filtre à côté de la couche, on peut remplacer:
```sql
date_part('year', "date_max") = 2023
```
par:
```sql
"phylum" = 'Arthropoda'
```
Cette manipulation change le filtre: au lien de ne garder que les observations où l'année est 2023, on ne garde que celles où la colonne 
"phylum" contient exactement le mot "Arthropoda". 

### Couche "Agrégation par maille, cd_ref et par an"
En l'état la couche est filtrée par année d'observation (annee)
```sql
annee = 2023
```
Elle est aussi filtrée au niveau de la symbologie  
> _Valeur_ : `sum("n_obs",group_by:="maille")` 
 
qui permet de regrouper les valeurs des mailles superposées. Au moment du chargement est donc représenté le nombre d'observation par maille en 2023.
Les autres couches agrégées sont construites sur le même modèle. 
