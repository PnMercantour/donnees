 # _Cadastre_
 ## Description
Ce schéma contient les données issues du cadastre librement accessibles - mises en forme pour faciliter leur consultation. Les parcelles sont issues de https://cadastre.data.gouv.fr/data/etalab-cadastre/2024-01-01/geojson/departements/
et le fichier des personnes morales de https://www.data.gouv.fr/fr/datasets/fichiers-des-locaux-et-des-parcelles-des-personnes-morales/ .
Les données utilisées sont issues de l'édition 2023.



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


--> 
_Documentation pour utilisateurs avancés et maintenance_
## Jointure 

[Jointure du fichier des personnes morales avec les identifiants des parcelles.](./bin/jointure_majic_parcelle.sql)
