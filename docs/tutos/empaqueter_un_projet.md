# Empaqueter un projet

Il est parfois nécessaire de partager un projet initialement construit sur une machine, avec des ressources se situant à différents endroits. 
Pour le partager simplement, le plus simple est d'enregistrer à la fois le projet, et les couches qu'il contient dans un geopackage. 
_Le format gpkg fonctionne sur le modèle de la base de données, un onglet lui est spécialement dédié dans le Gestionnaire de sources de données._


## Empaquetage des couches

Dans un premier temps, il faut enregistrer toutes les données desquelles dépend le projet dans un geopackage. 
Pour cela, on peut utiliser l'outil "Empaquetage de couche".
Pour y avoir accès, le plus simple est de faire un clic clic droit sur la batte des menus, puis de cliquer dans "Panneaux > Panneau Boîte à outils de traitements"


![](./img/panneaux_barretoutils.png)


Dans le panneau qui s'affiche, il est possible de chercher automatiquement parmis tous les outils disponibles dans QGIS celui qui s'appelle "Empaquetage de couche". 

Là, il suffit de choisir toutes les couches du projet et de les enregistrer dans un geopackage avec leurs styles et symbologies associées. 

_NB: Certaines couches ne peuvent pas être enregistrées dans un geopackage, d'autres solutions seront à envisager dans ces cas_

Vous pourrez vérifier ensuite que les couches du projet sont bien maintenant situées dans le geopackage. Sinon, vous pourrez les charger à nouveau dans le projet.


## Empaquetage du projet 


1. Sauvegarder un projet au format geopackage

Afin de pouvoir enregistrer le projet et l'ensemble des couches le composant dans un geopackage, il faut d'abord créer un geopackage vierge. 
On pourra le faire à l'onglet Couche:
> Couche > Créer une couche > Nouvelle couche Geopackage ...


![](./img/creer_gpkg.png)


QGIS n'est pas par défaut "conscient" du geopackage nouvellement créé. Il faut définir la connexion à ce fichier. 
Pour cela on peut passer par le gestionnaire de sources de données (Ctrl + l) 
> Base de données > Gestionnaire de source de données

et cliquer droit sur "Geopackage>Nouvelle connexion..." dans le menu de gauche.
On pourra alors naviguer jusqu'au fichier geopackage nouvellement créé. 


Enfin, on pourra simplement enregistrer le projet et lui donner un nom.
> Projet > Enregistrer le projet sous.... > Geopackage



### Ouvrir un projet dans un geopackage

Pour ouvrir le projet ainsi enregistré, il suffit d'aller à 

> Projet > Ouvrir depuis .. > Geopackage


_Si le geopackage n'est pas affiché dans les connexions par défaut, il suffit de cliquer sur l'icone "..." puis de naviguer jusqu'au geopackage_

