 # Table des matières des tutos
 
 Le dossier [tutos](./) contient l'ensemble des tutoriels et guides pour l'accès et la bonne utilisation des données géographiques du parc, et provenant de sources externes. Ainsi qu'un glossaire des 
termes utilisés en géomatique ou en lien avec ce dépôt, ainsi qu'une F.A.Q. qui a vocation à intégrer vos interrogations.

 |Nom|Description|
 |:--:|:--:|
 |[ajout_fond_de_carte_wms](./ajout_fond_de_carte_wms.md)| Ajouter un fond de carte standard (SCAN25, Orthophotos) à partir d'un [service wms](#wms)|
 |[bonnes_pratiques](./bonnes_pratiques.md)|Rappel des bonnes pratiques pour le travail informatique et sur Qgis|
 |[edition_de_polygones](./edition_de_polygones.md)| Édition de données vecteurs pour modifier/ajouter des entités ou attributs|
 |[FAQ](./FAQ.md)| Solutions aux questions et problèmes les plus fréquents |
 |[git](./git.md)|Présentation et explication de ce qu'est "git"|
 |[installation_certificats_base_de_donnees](./installation_certificats_base_de_donnees.md)|Paramétrage de l'accès à la base de données depuis Qgis|
 |[liste_ressources_geographiques_wms](./liste_ressources_geographiques_wms.md)|Liste des ressources accessibles au format wms (SCAN25, orthophoto....) |
 |[mon_premier_projet](./mon_premier_projet.md)|Tutoriel complet sur la consultation d'un projet Qgis existant, son enregistrement, sa modification et ses exports|
 |[glossaire](./README.md)|Glossaire des principaux termes de géomatique utilisés sur ce git|



# Glossaire



### Attribut
Les attributs sont les caractéristiques non spatiales des entités. Ils sont stockés dans les colonnes de [la table attributaire](./README.md#table-attributaire).
Ils peuvent avoir différents types: texte (ou chaînes de caractères - "string" en anglais), numériques ou dates.


### Base de données
Au sens large, une base de donnée permet de stocker et de manipuler des données par des moyens informatiques. 

On parle de base de données relationnelles quand ces données sont structurées en tables, gérant de façon explicite les relations entre [entités](./README.md#entite). 
C'est le cas de la base de données du Parc du Mercantour qui est décrite dans ce dépôt. 

Les logiciels permettant de gérer ces bases de données sont appelés des Systèmes de Gestions de Bases de Données Relationnelles (SGBDR). 


### Choroplèthe
Une carte choroplèthe est une carte en aplat de couleurs. Bien qu'elles soient très populaires et utilisées, elles ne sont efficaces que pour communiquer 
des ratios (proportions ou pourcentages).

### Couche
Dans un projet Qgis, une couche est une représentation de données spatialisée. Elle contient le lien vers le fichier contenant la données, ainsi que les informations permettant sa représentation (notamment sa symbologie).
Une couche _n'est pas_ en elle même de la donnée, mais le lien vers une donnée. 

On peut toutefois, depuis Qgis éditer et changer les données vers lesquelles une couche renvoie (par exemple en activant l'outil "Éditer").

### Dépôt (Repository)
Un dépôt git est un entrepôt virtuel, qui permet d'enregistrer et de maintenir facilement du code et de la documentation, 
notamment par la gestion de versions.

### Echelle (Scale)
L'échelle d'une carte est le rapport de taille entre la distance réelle et la distance sur la carte. Quand la carte est sur un support à taille fixe (i.e. papier), 
elle peut être exprimée sous la forme d'un ratio (1/25000 : 1 cm sur la carte = 25 000 cm en réalité). Sur un support à taille variable (numérique),
il est préférable d'utiliser une échelle graphique. C'est-à-dire de représenter graphiquement une longueur en indiquant sa longueur en réalité.
Cela permet d'indiquer l'échelle quelle que soit la taille de la carte.

### Emprise/Etendue (Bounding box)
L'emprise d'un objet géographique correspond au rectangle définit par ses coordonnées minimales et maximales, contenant 
l'intégralité de l'objet géographique

### Entité (Entity)
Une entité dans un format [vecteur](./README.md#vecteur) représente un objet réel avec une géométrie et des attributs. 

### EPSG (European Petroleum Survey Group)
L'EPSG est un registre des systèmes de coordonnées, donnant à chacun un code unique. L'EPSG du système de coordonnées de référence 
utilisé en France est "EPSG:2154".

### Fond de carte (Basemap)
Un fond de carte est la "couche de fond" d'une carte. Elle doit être évidente à lire et sert de support à l'information géographique représentée. 
Elle peut contenir des informations topopgraphiques, administratives, ou 

### GeoPacKage (.gpkg)
Le format geopackage est un format non propriétaire permettant de stocker des informations géographiques et/ou des tables attributaires. 
Il a l'avantage de pouvoir contenir des données au format rasters et/ou vecteur, ainsi 
que le style associé à chaque donnée. 

### MNT - modèle numérique de terrain ("DEM" - Digital elevation model)
Un modèle numérique de terrain est une représentation de l'altitude d'une région géographique. Il prend communément la forme d'un fichier raster
où la valeur de chaque pixel représente une altitude. 

### Numériser (Digitizing)
En SIG, il s'agit de l'opération qui consiste à enregistrer des données au format numérique. Cela peut être fait de manière automatique à l'aide de certains logiciels,
ou manuelle en entrant une à une les géométries et les attributs.

### Orthophotographie (Orthophotography)
Une orthophotographie est une photographie aérienne qui a été corrigé des déformations dues au relief et à la prise de vue dans le but de pouvoir
la représenter dans un système de coordonnées géoréférencé, et de pouvoir y mesurer des distances. 

### Projection
En cartographie, une projection permet de représenter la Terre (objet en 3 dimensions) sur une surface plane. Une projection ne permet pas de conserver 
à la fois les distances et les angles correspondants aux rapports des points sur l'objet d'origine. 


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

### Symboles proportionnels
Une carte en symbole proportionnels permet de représenter des différences de quantité (ou stock) entre les propriétés de plusieurs objets géographiques.

### Symbologie
Dans Qgis, la symbologie est l'ensemble des règles qui permet représenter les entités appartenant à une couche. 
A moins qu'elle ne soit explicitement enregistrée dans un geopackage, elle n'est conservée que dans le projet Qgis. 


### Table attributaire
La table attributaire contient l'ensemble des données, spatiales ou non, liées à une couche vecteur.



### Vecteur
En géomatique, un fichier vecteur est l'un des deux modes principaux de représentation des données spatiales. 
Il est basé sur l'utilisation de coordonnées qui permettent de localiser des points définissant la géométrie de chaque entité.

Dans Qgis un vecteur peut contenir l'un des types de géométrie suivante: 
- des points, 
- des lignes, 
- des polygones. 
Chaque entité est caractérisée par sa géométrie (les coordonnées des points la composant), et des attributs qui peuvent être variables. 


### WMS

Un WMS (_Web Map Service_) permet de consulter des données géoréférencées sur un serveur vers un utilisateur 
par le biais d'une adresse URL.

De cette façon, l'utilisateur n'a pas à charger l'entièreté de la donnée, et peut ne consulter que les zones géographiques d'intérêt. Le WMS ne donne pas accès à la donnée elle
même mais à sa représentation: l'utilisateur n'a donc pas la main sur la symbologie (excepté la transparence), et ne peut pas réaliser d'opérations de transformation sur les données WMS. 


### Zone tampon (Buffer)
Une zone tampon est l'aire définie par une distance par rapport à une entité géographique de référence 
(une zone tampon de 10m pour un point sera un cercle de 10m de rayon centré sur ce point).


