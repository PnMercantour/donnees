 # _Cadastre_
 ## Description
Ce schéma contient les données du cadastre librement accessibles mises en forme pour faciliter leur consultation. Les parcelles sont issues de https://cadastre.data.gouv.fr/data/etalab-cadastre/2024-01-01/geojson/departements/
et le fichier des personnes morales de https://www.data.gouv.fr/fr/datasets/fichiers-des-locaux-et-des-parcelles-des-personnes-morales/ .
Les données utilisées sont issues de l'édition 2023.

<!--
# Description des colonnes remarquables

Attention: Ne sont décrites ici que les colonnes remarquables, ou dont le nom pourrait prêter à confusion. 

#### Autorisations_travaux_test
Table temporaire qui contient 
| Nom de la colonne      | Type | Description     |
| :---        |    :----:   |          :---: |
| n_truc      | (PK) int       | c'est le numéro du truc   |
| nom_truc   | string        | c'est le nom du fameux truc      |

--> 

 ## Utilisation des projets Qgis

### Projet Cadastre
Ce projet permet de consulter les tracés des parcelles, de vérifier si elles appartiennent à une personne privée ou morale et le cas échéant, de visualiser son propriétaire.
Il n'a vocation qu'à être consulté.

Ce projet s'affiche différemment selon le niveau de zoom. De loin ce sont les communes qui s'affichent en couleurs nettement différentes. 
- A niveau moyen on peut voir les sections cadastrales sans pour autant qu'elles soient nommées. 
- En continuant le zoom, les couleurs distinguant les communes sont remplacées par la catégorisation des parcelles selon qu'elles appartiennent à une personne morale ou privée. Les sections cadastrales sont alors étiquetées selon leur lettre. 
- A haut niveau de zoom ( min 1:15 000) les identifiants de parcelles s'affichent.
- A très haut niveau de zoom (min 1:4000) les propriétaires de chaque parcelle s'affichent là où ces parcelles appartiennent à des personnes morales. 

Il est aussi possible de chercher directement une parcelle par id en réalisant une [Sélection par expression](/tutos/editeur_expression.md)

### Projet Autorisations Travaux
Ce projet permet de consulter les identifiants des travaux autorisés pour chaque parcelle. Il n'a pas vocation à être modifié directement pour l'instant. 
Les données concernant les autorisations de travaux qu'il contient ne sont pas exhaustives pour l'instant.

Il fonctionne sur le même mode que le projet avec des informations différentes affichées selon le niveau de zoom:
- les communes 
- les sections cadastrales et les parcelles pour lesquelles des autorisations de travaux ont été délivrées (sans précision)
- l'ensemble des parcelles, où on peut encore vérifier qu'elles appartiennent à une personne privée ou morale et le cas échéant, de visualiser son propriétaire.
- Les numéros des autorisations de travaux. Il peut être nécessaire de zoomer jusqu'à des échelles jusqu'à 1:500, puisque certaines parcelles très petites (<1ha)  ont reçu de nombreuses autorisations.



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


--> 
_Documentation pour utilisateurs avancés et maintenance_
## Jointure 

[Jointure du fichier des personnes morales avec les identifiants des parcelles.](./bin/jointure_majic_parcelle.sql)
