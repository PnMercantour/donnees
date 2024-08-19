# admin_express

## Description

Le schéma `admin_express` contient les données relatives les données administratives pour :
 - la région Sud PACA, 
 - les départements de la région, 
 - les EPCI ("Établissement public de coopération intercommunale", structures intercommunale ou intercommunalité) inclus dans les départements des Alpes de Haute Provence et des Alpes Maritimes ainsi que les EPCI contigus, 
 - les communes (multipolygon) et chefs lieu (point) de ces deux départements, 
 - les anciennes communes de Larche et Meyronnes.

Elles proviennent du service admin express COG produit conjointement par l'INSEE et l'IGN: https://geoservices.ign.fr/adminexpress
(Version: ADMIN-EXPRESS-COG-CARTO_3-1\_\_SHP_LAMB93_FXX_2022-04-15)





## Utilisation du projet qgis 

Le projet QGIS `admin_express` permet de parcourir les données administratives régionales (des relations sont établies entre les différentes couches pour faciliter la navigation à partir des outils QGIS d'identification des entités).

_Par ailleurs, les communes du territoire du PNM sont directement accessibles dans le schéma .limites._


## Tables remarquables

Contient 6 tables principales. 

- _.chflieu_commune_  
- _.commune_ 
- _.commune_associee_ou_deleguee_ 
- _.departement_ 
- _.epci_ 
- _.region_ :

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

## Exemples de Requêtes
_Quelques exemples de requêtes toutes écrites qui permettent de faire des trucs_

```postgreSQL
--Requête pour avoir tous les trucs commençant par "a" ou "A"
SELECT *
FROM table_1
WHERE nom_truc ILIKE 'a%'
```
-->
## Dépendances




## Mises à jour

Les données sont régulièrement mises à jour (mise à jour la plus récente: février 2023)

_____________
_Documentation pour utilisateurs avancés et maintenance_



# Modalités de téléchargement (pour les administrateurs)

Télécharger la livraison la plus récente du référentiel administratif, dans sa version COG (Code officiel géographique) CARTO (géométries simplifiées pour améliorer la performance des outils cartographiques).

https://geoservices.ign.fr/adminexpress#telechargementCogCarto

Utiliser QGIS ou OGR/GDAL pour filtrer les données et les pousser en base.

- Remplacer, sans reprojection, le SRS officiel de l'IGN par le SRS 2154. La précision des géométries est de 10cm.

- Filtrer les tables selon l'emprise désirée
  - communes 04 ou 06
  - communes associées/déléguées pertinentes (Meyronnes, Larche)
  - Chef lieu des communes ci-dessus (coordonnées de la mairie des communes)
  - EPCI intégrant ou jouxtant les communes 04 ou 06
  - Départements de la région Sud PACA
  - Région

_Garder la structure des tables IGN pour simplifier l'import ultérieur de mises à jour._

- Charger les tables en base de données dans le schema `admin_express`

  - Convertir les noms de tables et les champs en minuscule
  - créer un index géographique

- Après chargement, ajouter les index et clés étrangères nécessaires.

# Mise à jour du projet

Il est vivement recommandé de mettre à jour le projet git lorsque le schema ou le projet QGIS sont modifiés en base.

Le script [admin_express/bin/dump_schema](bin/dump_schema) lit depuis la base de données la version courante du schema sql et l'enregistre dans [schema.sql](sql/schema.sql).

Le script [admin_express/bin/dump_project](bin/dump_project) télécharge la version courante du projet QGIS depuis la base de données et l'enregistre dans [admin_express.qgs](QGIS/admin_express.qgs.