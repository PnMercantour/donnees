# Résumé

Ce document vise à définir les pratiques et conventions de nommage pour les fichiers, projets  et couches qgis dans la bd_pnm.
Ses recommandations sont sujettes à exception dans certains cas, mais leur respect dans la pratique quotidienne permettra de 
faciliter la lecture et le travail dans la base de données.

## Préconisations de nommage
 - Eviter les accents, espaces et caractères spéciaux dans les noms de fichiers (*, #, !, é, ê, ....)
 - Rester cohérent ( éviter de changer une nomenclature en cours de route)
 - Privilégier le français (a minima rester cohérent)
 - Eviter les abbréviations qui rendent les noms cryptiques (ex: "liste_patrimoine_protection" plutôt que "lst_pp")

## Projets QGis
 - Importer les couches et projets depuis le Gestionnaire de sources de données ("Couches>Gestionnaire de source de données" ou CTRL+L)
 et pas depuis l'explorateur.
 - Au chargement d'un projet, la plupart des couches sont filtrées, à la fois par l'outil filtre et par la symbologie. Ces filtres doivent être modifiés pour accéder aux données pertinentes
 - Éviter tout particulièrement les accents, espaces et caractères spéciaux
 - Utiliser des alias pour les couches pour en faciliter la lecture
 - Penser à utiliser des groupes pour organiser les couches de travail
 
### Pour le travail en local
 - Penser à supprimer les produits intermédiaires
 - Toujours conserver une copie intacte des données de travail
 - Privilégier les exports en dur aux couches temporaires pour les résultats de géotraitements (voir exemple)
 
### En cas de problème
 - Vérifier la projection (CRS: EPSG:2154)
 - Vérifier qu'on travaille bien sur les bons fichiers ('couche'> Propriétés)
 - Vérifier la nature des données sur lesquelles on travaille (vecteur/raster, type de données dans les colonnes...)
 - Parfois....redémarrer Qgis...





 ## Illustrations

 ### Exports

  <img src="./img/exports_endurs.png" alt= “” width="75%" height="75%">

_Privilégier l'export vers un fichier des résultats de traitements (ici "Centroïdes") à la production de couches temporaires._

 ### Filtres

 <img src="./img/filtre_couche.png" alt= “” width="75%" height="75%">

_L'application d'un filtre est signalée par l'icône de filtre. En cliquant dessus on accède au constructeur de requête qui 
permet de modifier les paramètres du filtrage._

 <img src="./img/filtre_symbologie.png" alt= “” width="75%" height="75%">

_L'utilisation d'une expression dans la symbologie ("Couche>Propriétés>Symbologie" ou double clic sur la couche - onglet symbologie)*
permet de filtrer ou regrouper l'information. Ici on obtient la somme de n_obs par maille. L'expression est modifiable directement ou 
en cliquant sur le ε pour accéder à l'éditeur d'expressions._

