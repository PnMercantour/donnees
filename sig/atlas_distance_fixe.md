# Générer un atlas où l'emprise est définie à une distance en mètres (ou autre unité) de l'entité de couverture

## Principe général et cadre d'utilisation

Dans le cadre de la génération d'atlas dans QGIS ile st parfois nécessaire de fixer une distance tampon autour de l'entité de couverture. 


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

Comme on peut déterminer  la marge en % de l'objet, on peut retrouver des unités brutes: 
par exemple si on veut une marge de 400m :
```
100*400/ max(
 (x_max(@geometry ))- (x_min( @geometry)), 
  (y_max(@geometry))-(y_min(@geometry)))
```

