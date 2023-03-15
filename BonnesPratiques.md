# Résumé

Ce document vise à définir les pratiques et conventions de nommage pour les fichiers, projets  et couches qgis dans la bd_pnm.
Ses recommandations sont sujettes à exception dans certains cas, mais leur respect dans la pratique quotidienne permettra de 
faciliter la lecture et le travail dans la base de données.

## Préconnisations de nommage
 - Eviter les accents, espaces et caractères spéciaux dans les noms de fichiers (*, #, !, é, ê, ....)
 - Rester cohérent dans la façon de nommer les fichiers
 - Privilégier le français dans le nommage (a minima rester cohérent)
 - Eviter les abbréviations qui rendent les noms cryptiques (ex: "liste_patrimoine_protection" plutôt que "lst_pp")

## Projets QGis
 - Importer les couches et projets depuis le Gestionnaire de sources de données ("Couches>Gestionnaire de source de données" ou CTRL+L)
 et pas depuis l'explorateur.
 - Éviter tout particulièrement les accents, espaces et caractères spéciaux
 - Utiliser des alias pour les couches pour en faciliter la lecture
 - Penser à utiliser des groupes pour organiser les couches de travail
 
### Pour le travail en local
 - Penser à supprimer les produits intermédiaires
 - Toujours conserver une copie intacte des données de travail
 - Privilégier les exports en dur aux couches temporaires
 
### En cas de problème
 - Vérifier la projection (CRS: EPSG:2154)
 - Vérifier qu'on travaille bien sur les bons fichiers (couche > Propriétés)
 - Vérifier la nature des données sur lesquelles on travaille (vecteur/raster, type de données dans les colonnes...)
 - Parfois....redémarrer Qgis...



