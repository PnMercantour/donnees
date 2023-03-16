# _Exemple de format pour la documentation_
_Les phrases en italiques comme celle ci seront à considérer comme des commentaires._ 

------------
 # schema_test _(Nom du Schéma)_
 ## Description
 _Description générale du schéma: quel type d'information, pour quelles utilisations, de quelles sources_
 C'est un schéma qui contient des informations vides.  Il est supposé servir à aucun utilisateur pour faire des trucs.
 Les données sont issues de https://www.sourcededonnees.com, et sont mises à jour manuellement quand elles changent, c'est-à-dire jamais. 

## Tables remarquables
_Les tables accessibles, le type de données_
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


## Projets Qgis

## Mises à jour

Tous les ans, ou quand les couches de références changent. 