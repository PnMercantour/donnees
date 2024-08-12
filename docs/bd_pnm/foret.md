# foret

## Description
_Description générale du schéma: quel type d'information, pour quelles utilisations, de quelles sources_ </br>
Informations concernant les forêts du Parc national du Mercantour. Documentation en cours


## Utilisation des projets Qgis

### gestion 
Composition de couches du schéma foret représentant les régimes forestiers, et les zones en libre évolution. 

### foret 
Projet par défaut du schéma. Montre le parcellaire forestier, les peuplements remarquables et les forêts anciennes. 

<!--
### _Exemples_
_Détail de l'utilisation du projet Qgis, de la manipulation des filtres et de la symbologie._
-->

## Tables remarquables


### Historique_coupe_2020
Date de la dernière exploitation forestière sur les forêts gérées par l'ONF sur le territoire du Parc national du Mercantour.

### c_aptitude_libre_evolution_ale
Carte renseignant l'aptitude des surfaces boisées du Parc national du Mercantour à figurer dans le réseau de peuplements forestiers en libre évolution. 

### c_forets_anciennes_foa
Carte des surfaces boisées qualifiées "d'anciennes" sur le territoire du PNM, traduisant une continuité de l'état boisé durant les derniers siècles (env. 1750).

### c_peuplements_remarquables_per
Carte localisant les zones forestières à fort intérêt patrimonial (très gros bois, vieux arbres, zones riches en bois morts ou dépérissant ou peuplements rares) dans le Parc national du Mercantour (zone cœur et zone d'adhésion).

### c_sapiniere_ligure_sal
Carte des sapinières "prioritaires" de la charte du parc, "sapinières supra-méditerranéennes ou montagnardes sous influence climatique méditerranéenne et notamment ligure"

### c_statut_libre_evolution_sle
Carte des différents statuts de libre évolution sur le territoire du PNM 

### cr_foret_soumise_fs
Carte des terrains bénéficiant du régime forestier : terrains communaux ou domaniaux (source ONF)

### cr_ign_foretv2_2016_ifv
Carte des types de formation végétale qualifiant la couverture boisée du sol (source IGN)

### cr_parcellaire_forestier_pf
Cartes des parcelles forestières (source ONF)

<!--
### desserte
Desserte (source ONF)-->

### revision_amf_soumis
Carte des terrains bénéficiant du régime forestier : terrains communaux ou domaniaux (source ONF) précisant les dates de l’aménagement forestier en cours



<!--
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

[lien](./README.md)-->
