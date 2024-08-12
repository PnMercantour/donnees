 # bd_lacs

 ## Description
 Ce schéma contient les données relatives aux lacs du mercantour. Il est en cours de documentation.



## Tables

- Data_PNM_ref_pat
- data_PNM
- Lac_PNM
- Lacs_remarquables
- T_Lac_alevinage
- T_Lac_caract_statut
- T_Lac_enjeux
- T_Lac_etudes
- T_Lac_etudes_liaison
- T_Lac_photo
- T_Lac_poisson
- T_Lac_poisson_statutpop
- T_Lac_releves_phys_chim
- T_Lac_vie_aquatique


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

#	# Description des colonnes remarquables

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
