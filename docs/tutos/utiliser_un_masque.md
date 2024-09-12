# Utiliser un masque


## Explications

On désire parfois mettre en avant une couche, ou une entité, en "floutant" tout ce qu'il y a autour. 
Cette opération peut être réalisée avec certains plugs-ins ou extensions QGIS, elle est toutefois très simple à réaliser à la main, et savoir la réaliser peut éviter les soucis de mise à jour en cas de problème ou bug. 
  

Appliquer un masque de ce genre peut être fait de deux façons: 
- en appliquant le style "polygone inversé" à une entité ou une couche, ce qui "vide" l'intérieur du polygone, et permet d'appliquer un "grisage" autour
- en créant une couche "masque" qui est gris transparent, puis en y faisant un trou qui laisse apparaitre le polygone d'intérêt


Dans tous les cas, il est possible de mettre en lien le masque avec un [atlas](./generer_un_atlas.md) pour que seule l'entité apparaissant dans l'[atlas](./generer_un_atlas.md) soit visible.
 
# Pas à pas

## Style polygone inversé

Cette solution marche pour une carte simple: on ne souhaite voir que les zones couvertes par une couche (par exemple: représentant une commune).

- faire clic droit sur la couche de la zone désirée, et cliquer sur dupliquer la couche

- faire double clic sur la couche, ou bien clic droit > Propriétés, puis dans l'onglet "Symbologie"

- Tout en bas à gauche de la fenêtre se trouve le bouton "Style", cliquer dessus puis "Charger"

- En cliquant sur les "..." naviguer jusqu'à ce fichier   : "W:\symbologie\masque.qml"

- Cliquer sur "Appliquer"


## Représenter la zone de l'entité courante d'un atlas
 
### générer l'atlas

- En partant d'une carte existante, dans la barre de menu cliquer sur "Projet" puis "Gestionnaire de mise en page"

- Créer une nouvelle mise en page, ou utiliser une mise en page existante. 

Dans la fenêtre de mise en page, il faut d'abord activer les paramètres d'atlas. Pour ça: 


- dans la barre de menu, cliquer sur "Atlas" puis "Paramètres de l'atlas"

- Dans la barre de droite, apparait un onglet "Atlas" à côté de "Mise en page", "Propriétés de l'objet", et "Guides". Cocher la case "Générer un atlas"

- Dans le menu déroulant "couche de couverture", sélectionner la couche contenant les entités sur lesquelles devra être centré l'atlas. 

- Facultatif: Filtrer ou ordonner par un des champs de la couche de couverture. 


### Créer la couche de masque

Ces opérations ont pour but de créer un fond uni et grisé, dont la géométrie sera ensuite générée pour ne pas cacher la partie correspondant à l'entité actuellement représentée par l'atlas. 

- Créer une couche en cliquant sur l'onglet couche de la barre de menu puis "Créer une couche" 
- Sélectionner nouvelle couche shapefile de polygone
- Naviguer en cliquant sur les "..."  et enregistrer avec un nom clair ("masque_xxx") dans le dossier de travail courant.
- Créer une seule entité (suivre [ce tuto](./editer_des_polygones.md) si nécessaire)  englobant toute la zone à représenter, avec une bonne marge. 
- Enregistrer les modifications 

- Dans la couche masque ainsi crée, aller dans propriétés (double clic ou clic droit>propriétés)
- Dans l'onglet symbologie choisir "Générateur de géométrie"
- remplacer la formule existante par la suivante :

> difference( $geometry,  @atlas_geometry )

Appliquer les modifications.

Dorénavant, quand vous générez l'atlas, un "trou" se formera automatiquement à l'emplacement de l'unité d'intérêt de l'atlas. 



