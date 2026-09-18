# cadastre

## Description
Ce schéma contient les données du cadastre librement accessibles et mises en forme pour faciliter leur consultation. Les données concernant les parcelles [(source)](https://cadastre.data.gouv.fr/data/etalab-cadastre/2024-01-01/geojson/departements/)
et les personnes morales [(source)](https://www.data.gouv.fr/fr/datasets/fichiers-des-locaux-et-des-parcelles-des-personnes-morales/) sont issues de l'édition 2023.

## Projets Qgis associés
Vous trouverez la documentation des projets [ici](../projets_qgis/cadastre.md).


## Tables et vues remarquables
- ```cadastre_parc``` : limites du cadastre sur la superficie du Parc national du Mercantour (données datant de 04-2024)
- ```cadastre_personne_morale``` : liste des personnes morales 
- ```code_droit``` : table qui permet de comprendre les différents codes associés aux différents types de lien entre une personne et une parcelle.
- ```cadastre_parcelle_proprietaire``` : vue qui fait le lien entre les limites cadastrales et les données de propriété disponibles. 

> autorisation_travaux

- ```autorisations_travaux_test``` : table en cours de préparation. Vise à lister le nombre d'autorisations de travaux délivrées par parcelle.

> autorisation_travaux_v2

- ```autorisation_travaux_details``` : liste l'ensemble des autorisations de travaux délivrées avec leurs informations associées.
- ```correspondance_autorisation_parcelles``` : associe chaque numéro d'autorisation aux parcelles concernées, et inversement. Chaque combinaison 'autorisation-parcelle' est unique.
- ```liste_autorisations_parcelle``` : vue qui vise à lister l'ensemble des autorisations délivrées par parcelle.

<!--
### _Exemples_
_Détail de l'utilisation du projet Qgis, de la manipulation des filtres et de la symbologie._



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


--> 

