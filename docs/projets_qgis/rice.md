# rice

## Schéma
Sources et structure de la donnée utile à la construction des projets : [rice](../bd_pnm/rice.md).


## Projet Extension

Le projet "Extension zoom_2024" est la dernière version à jour contenant les informations sur l'extension de la Rice.  
!!! warning "Pas sûre que la doc soit à jour, il existe des projets plus récents"  

Les couches de ce projet sont le résultat de liaisons à partir de la table "rice.extension" et "limites.communes". 
Pour le mettre à jour ce sont donc ces tables là qu'il faut modifier. 


<!--
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
