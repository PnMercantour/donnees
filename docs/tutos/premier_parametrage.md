# Premier paramétrage

_Ce tutoriel contient toutes les informations pour paramétrer QGIS lors du premier paramétrage._
_Si vous avez déjà accès à la base de données, la plupart des autres indications sont aussi [trouvables ici](./bonnes_pratiques.md)_


# Contexte


Il est capital de gérer la [projection](./README.md#projection) dans QGIS pour que les cartes produites 
soient lisibles dans le système de coordonnées de référence (SCR) français: Lambert-93. D'autres paramètres
aident aussi à rendre le logiciel lisible et à éviter des plantages.


# Pas à pas
_Ces paramètres sont importants à modifier pour le bon fonctionnement de QGIS, et éviter des plantages et erreurs._

## Projection
- cliquer dans la barre de menus, en haut de la fenêtre de QGIS, sur 

> Préférences > Options 

- Sous l'onglet "SCR et Transformations", cliquer sur l'onglet "Gestion des SCR"

 et sélectionner le SCR "EPSG:2154 - RGF93v1 /Lambert-93" par défaut à la fois
pour les projets, et pour les couches. 

![](./img/config_scr.png)

## Table d'attributs

Dans la même fenêtre se trouve l'onglet "sources de données".




En bas à droite de de la fenêtre de la table d'attributs se trouve une petite icône avec un menu déroulant. 
Choisir l'option "Montrer les entités visibles sur la carte". 

![](./img/params_afficher_visibles.png)

Dorénavant, la table d'attribut ne montrera que les entités visibles sur l'étendue du canevas visible, en zoomant et vous déplaçant sur le canevas vous limiterez le nombre d'entités à charger dans la table d'attribut et donc
le risque de plantage de QGIS. 

---
## Se connecter à la base de données

Suivre la démarche décrite [ici](./installation_certificats_base_de_donnees.md)

## Ajouter le catalogue de fond de cartes (WMS)

Suivre la démarche décrite [ici](./ajout_fond_de_carte_wms.md)

