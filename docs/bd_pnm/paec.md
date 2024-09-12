# PAEC

## Description

Ce schéma contient les tables et vues nécessaires aux calculs des indicateurs nécessaire aux Projets AgroEnvironnementaux et Climatiques.

En l'état, le projet PAEC, principal produit a été "figé" puisqu'il a rempli son objectif. Le projet original contenait à la fois des couches sur la base de donées, des requêtes, et des données dans des fichiers sur les serveurs. Il a donc été exporté en fichier statique afin de pouvoirle consulter dans le futur pour comparaison. Ci-dessous sont listés les principaux critères et méthodes appliqués. 


la plupart des couches du projet ont été filtrées pour ne plus contenir que les données se situant en coeur de parc, ou dans l'aire d'adhésion. 

Le Projet QGIS PAEC est structuré en plusieurs thématiques, chacune divisée en sous thématiques: 

# Enjeux: 

## Zones humides


Les données relatives aux zones humides proviennent essentiellement du schema eau_zh.

La table paec.eau_zh_exclus sert à exclure certains sites zh (et les zh, defens et altérations associés) du projet.

Des vues permettent d'appliquer automatiquement le filtre d'exclusion. Par convention, la vue porte le même nom que la table filtrée avec le suffixe fx (filtre d'exclusion).
```
select * from paec.alteration_fx
```

Les couches UP et prairies présentées dans le contexte zone humide ont les attributs suivants:

    id de l'objet (UP ou prairie),
    nom (pour les UP)
    id_st : identifiant du service territorial
    sites: la liste des sites ZH liés à l'objet (selon le critère d'intersection d'une zh du site avec l'objet),
    surface_zh: la surface de zone humide qui recouvre l'objet,
    surface_defens: la surface de defens qui recouvre l'objet,
    alteration_types: la liste des types d'altérations relevés sur le territoire de l'objet. Bien que l'attribut agrège les types d'altération relevés, il reste possible de filtrer les couches selon les valeurs de cet attribut. Par exemple, on sélectionne ainsi les altérations 10 (reposoir typique) ou 11 (reposoir diffus) : 10 = any("alteration_types") or 11 = any("alteration_types")



## Faune

### Bouquetins
Zones d'hivernage (répertoriées depuis 2017)

Attributs de la couche up_hivernage

    id unité pastorale
    nom unité pastorale
    id_st
    surface d'hivernage sur l'unité pastorale
    proportion de la surface de l'unité pastorale utilisée par les bouquetins

Relevés GPS hivernaux

On retient dans la synthèse les UP qui contiennent au moins 5ha de zone d'hivernage ou qui ont plus de 100 observations hivernales sur le territoire.



## Flore

La table paec.enjeu_flore définit les espèces à enjeu, reproduite dans le projet sous le nom : "Flore - Espèces remarquables". L'attribut booléen super_priorite marque les espèces à enjeu majeur, l'attribut priorite de valeur >= 1 indique la priorité (par convention, 1 est la priorité la plus élevée).

L'attribut enjeu_espece indique une espèce à enjeu.

L'attribut enjeu_habitat indique une espèce indicatrice d'un habitat à enjeu (voir Habitat).

Les observations depuis 1990 sont reliées aux prairies et unités pastorales lorsque la distance entre l'obs et le territoire étudié est inférieure à 200 m. Il est permis de modifier dynamiquement ce paramètre en ajoutant un filtre sur la valeur de l'attribut proximite dans les vues détaillées. Par contre, la requête de synthèse doit être réécrite si l'on veut changer la proximité prise en compte avant l'agrégation des résultats.


Le filtrage est prédéfini sur les vues de synthèse: Enjeu majeur lorsqu'une espèce super-prioritaire est observée, enjeu fort lorsqu'une espèce de priorité 1 est observée, enjeu assez fort dans les autres cas. Ces paramètres de filtrage peuvent être modifiées dans QGIS.

Pour chaque territoire (up ou prairie) et chaque taxon, un objet graphique est créé sur l'emprise du territoire avec les attributs du taxon.

Les couches "Observation ..." donnent le détail des observations d'espèce de flore à enjeu.

# Sous-zones PAEC 2023

Les couches dans sous-zones PAEC 2023 permettent d'observer des zones particulières liées aux enjeux spécifiques suivants : 

- Sous-zone ZH et sites à flore patrimoniale
- Sous-zone Alpages
- Sous-zone Maintien ouverture
- Sous-zone Pres de fauche
- Sous-zone Soutien au collectif

# Zonage

Contient aussi les sites Natura200, le périmètre de la PAEC ainsi que les limites génèrales du parc et des services territoriaux. 




<!--
## Utilisation du projet Qgis
_Description du projet Qgis accessible par défaut dans le projet._

### _Exemples_
_Détail de l'utilisation du projet Qgis, de la manipulation des filtres et de la symbologie._

## Tables remarquables
_Les tables accessibles, le type de données_ </br>
Contient X tables accessibles. 
- La première table qui fait des trucs
- la deuxième qui est aussi très intéressante
- sans parler de la troisième

# Description des colonnes remarquables

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

table_3 mise à jour à partir de **schema1.table_46** et **schema3.table_18**



## Code de création des tables

[lien](./README.md)
-->
