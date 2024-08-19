# charte

## Description
 Ce schéma contient toutes les informations nécessaire à la réalisation d'une carte des vocations dans le parc (y compris des couches à la fonction purement esthétique). 
 _NB: Les vocations à Barcelonnette sont absentes de ces données_

<!--
## Utilisation du projet Qgis
_Description du projet Qgis accessible par défaut dans le projet._


### _Exemples_
_Détail de l'utilisation du projet Qgis, de la manipulation des filtres et de la symbologie._

## Tables remarquables

Contient X tables accessibles. 
- _aoa_ contient les vocations pour les zones en aire optimale d'adhésion (coeur exclu)
- _coeur_ contient les vocations pour les zones dans le coeur de parc
- _col_ contient la liste des cols remarquables du parc (10 entités)
- _grands sites_ contient une liste de sites remarquables 
- _hammeaux_aoa/coeur_ contient une liste des hammeaux dans le coeur/l'aire optimale d'adhésion
- _loc_comm_ contient des points (possiblement des villes. Contient plus que les chefs lieux des communes)
- _masse_eau_ contient une liste des masses d'eau avec des caractéristiques détaillées. Probablement issu de la bd topage.mdo
- _mhi_mhc_ Point des monuments historiques classés. Peu de données. (13/24 points sans nom ni propriétés)
- _ombre parc_ : effet graphique d'ombre sur les limites de l'aoa.
- _route_ : tronçons de routes dans l'aoa et le coeur. Probablement extrait de la BD CARTO
- _sommets_: points, liste des sommets du parc.
- _sh_ : zones humides (193 pts, peu d'attributs)

-->

<!-- tables inconnues: 
- esp_nord_pct
- 
-->

<!-- 
## Description des colonnes remarquables

Attention: Ne sont décrites ici que les colonnes remarquables, ou dont le nom pourrait prêter à confusion. 

#### table_1
| Nom de la colonne      | Type | Description     |
| :---        |    :----:   |          :---: |
| n_truc      | (PK) int       | c'est le numéro du truc   |
| nom_truc   | string        | c'est le nom du fameux truc      |

#### table_2
| Nom de la colonne      | Type | Description     |
| :---        |    :----:   |          :---: |
| n_machin      | int       | c'est le numéro du machin   |
| n_truc   | string        | c'est le numéro du truc      |

#### table_3
| Nom de la colonne      | Type | Description     |
| :---        |    :----:   |          :---: |
|...      |...       |...   |
-->

<!-- 
_____
_Documentation pour utilisateurs avancés et maintenance_


## Exemples de Requêtes
_Quelques exemples de requêtes toutes écrites qui permettent de faire des trucs_

```postgreSQL
--Requête pour avoir tous les trucs commençant par "a" ou "A"
SELECT *
FROM table_1
WHERE nom_truc ILIKE 'a%'
```

## Dépendances



## Code de création des tables

[lien](./README.md)
-->
