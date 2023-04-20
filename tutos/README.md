

# Glossaire

### Base de données
Au sens large, une base de donnée permet de stocker des données. 

On parle de base de données relationnelles quand ces données sont structurées en tables, gérant de façon explicite les relations entre entités. C'est le cas de la base de données du Parc du Mercantour qui est décrite dans ce dépôt. 

Les logiciels permettant de gérer ces bases de données sont appelés des Systèmes de Gestions de Bases de Données Relationnelles (SGBDR). 

### Couche
Dans un projet Qgis, une couche est une représentation de données spatialisée. Elle contient le lien vers le fichier contenant la données, ainsi que les informations permettant sa représentation (notamment sa symbologie).
Une couche _n'est pas_ en elle même de la donnée, mais le lien vers une donnée. 

On peut toutefois, depuis Qgis éditer et changer les données vers lesquelles une couche renvoie (notamment en activant l'outil "Éditer").

### Dépôt
Un dépôt git est un entrepôt virtuel, qui permet d'enregistrer et de maintenir facilement du code et de la documentation, notamment par la gestion de versions.

### Projet
Un projet Qgis contient un ensemble de couches, les informations permettant de les représenter, ainsi que l'ensemble des paramètres conditionnant la réalisation de géotraitements. 
En tant que tel, un projet Qgis ne contient **pas** de données, mais des liens (ou chemins) vers des données, représentées sous formes de couches. 


### Raster
En géomatique, un raster est l'un des deux modes principaux de représentation des données spatiales. A la façon d'une photographie, il stocke l'information spatiale dans une matrice régulière de pixels, contenant chacun une information chiffrée.

Une matrice dans un raster est appelée "bande". Un raster peut être multi-bandes, c'est-à-dire contenir plusieurs matrices superposées - à la façon d'une photographie qui contient tois matrices: rouge-vert-bleu. 

Un raster est caractérisé par sa "résolution spatiale" qui est définie par la taille de ses pixels. 


### Schéma
Dans une base de données relationnelle, un schéma regroupe différents objets dont des tables, vues et fonctions. 
Il permet d'organiser le contenu d'une base de données en thématique, de manière similaire à un dossier dans un répertoire de fichier - on ne peut pas cependant imbriquer un schéma dans un autre. 

Dans la base de données du parc, un schéma spécifique est dédié à chaque principale thématique (i.e. : ag_pasto, flore, limites). Ce dépôt contient pour les principaux schémas la documentation permettant d'en comprendre le contenu. 

### Vecteur
En géomatique, un vecteur est l'un des deux modes principaux de représentation des données spatiales. 
Il est basé sur l'utilisation de coordonnées qui permettent de localiser des points définissant la géométrie de chaque entité.

Dans Qgis un vecteur peut contenir soit: 
- des points, 
- des lignes, 
 - des polygones. 
Chaque entité est caractérisée par sa géométrie (les coordonnées des points la composant), et des attributs qui peuvent être variables. 


