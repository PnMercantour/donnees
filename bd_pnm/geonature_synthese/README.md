# geonature_synthese 

## Description

_Description générale du schéma: quel type d'information, pour quelles utilisations, de quelles sources_

Ce schéma contient les observations de la base de données geonature. 
A chaque taxon sont associés les attributs tels que définis par taxref ainsi que les informations géographiques 
correspondant au maillage et aux différentes zones remarquables du parc national du Mercantour. 
Les données sont accessibles soient de en détail,soit agrégées selon la maille géographique, l'année, ou les classements en groupes inpn 1-2. 


## Tables remarquables

L'ensemble du schéma est constitué de 3 tables :

 - .detail (vue)
Contient l'ensemble des observations, complété par les données issues de taxref, et des propriétés de la maille contenant le lieu d'observation. 
Il a été décidé que chaque observation serait assignée à une et une seule maille de la grille 1km, en cas 
de superposition parfaite du lieu d'observation avec la limite entre deux mailles, la mailles au n° le plus grand est conservée. 

Dans les vues aggrégées, la patrimonialité et la protection ne sont vraies que si toutes les espèces aggrégées sont protégées ou patrimoniales. 

 - .aggregation_maille_an
aggrégation des observation par année de début d'observation et pour chaque maille de limites.grid
Ne sont conservées que les observations ayant eu lieu sur une seule année
 
 - .aggregation_maille_groupe*_inpn
aggrégation des observations selon le groupe inpn 1-2 



## Description des colonnes remarquables
*Attention: Ne sont décrites ici que les colonnes remarquables, ou dont le nom pourrait prêter à confusion. *

#### .detail

| Nom de la colonne      | Type | Description     |
| :---        |    :----:   |          :---: |
| id_synthese      | int       | numéro d'observation   |
| id_grid   | int        | identifiant du numéro de maille |
| cd_nom   | int        | identifiant de nom unique dans taxref      |
| cd_ref   | int        | identifiant du taxon de référence      |
| patrimoniale/protegee| boolean| Valeurs True/False quand connue, sinon null. |
|...|...|...|


#### .aggregation_maille_an
_Mêmes colonnes que observation  - aggregation par année et par maille_


#### aggregation_maille_groupe1_inpn
_Mêmes colonnes que observation  - aggregation par groupe inpn_

## Exemples de Requêtes
_Quelques exemples de requêtes toutes écrites qui permettent de faire des trucs_

```sql
--Requête pour avoir tous les trucs commençant par "a" ou "A"
SELECT *
FROM table_1
WHERE nom_truc ILIKE 'a%'
```

## Dépendances

Les 3 vues aggrégées sont construites sur la vue matérialisée _gn_observation.observation_. 

Celle ci dépend directement des tables: 
 - [limites.grid](https://github.com/PnMercantour/limites/README.md#tables_remarquables) : données géographiques liées aux mailles - jointure géographique
 - [limites.grid](https://github.com/PnMercantour/limites/limites/README.md#limites.communes) : données géographiques liées aux mailles - jointure géographique

 - gn_synthese.synthese_avec_partenaires : observations de la base géonature
 - taxonomie.taxref : classification - jointure par cd_nom
 - taxonomie.v_taxref_pp : patrimonialité/protection - jointure par cd_nom
 - ref_nomenclatures.* : détails sur l'observation - jointure par fonction et id_nomenclature_*


## Mises à jour

Tous les ans, ou quand les couches de références changent. 

## Code de création des tables

[table_1](https://github.com/EcMerc/DemoDBDoc/blob/decd1fccd363a4239451b1d69fdefd363db3b442/sql/table_1.sql)

[table_2](https://github.com/EcMerc/DemoDBDoc/blob/decd1fccd363a4239451b1d69fdefd363db3b442/sql/table_2.sql)

[table_3]()



