# Griser le fond d'un atlas

## Principe général et cadre d'utilisation

Dans le cadre de la génération d'atlas dans QGIS il est parfois utile de griser tout ce qui apparait derrière une entité d'intérêt.


<!--
## Exemples
Dans le cadre d'un projet de validation des observations, on ne souhaite visualiser qu'une partie des observations pour pouvoir les valider. 
Les observations validées doivent alors être remplacées par d'autres observations à valider. 

Dans ce cas, on peut mettre en place 
- une table "validation_observation", contenant toutes les observations à valider
- une vue "taxon_a_valider" où ne sont affichés que quelques taxons pour ne pas surcharger visuellement la carte
 
La table validation_observation est filtrée selon les taxons présents dans la vue "taxon_a_valider".

La vue taxons à valider peut être définie comme les 3 premiers taxons 
--> 

## Code / paramétrage

Créer une couche contenant un polygone qui recouvre toute l'emprise de ce qui va être vu par l'atlas. Lui donner une symbologie blanc/gris semi-transparente.

Lui donner une géométrie par expresion:

```
difference( $geometry,  @atlas_geometry )
```
