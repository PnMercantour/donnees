# Objectifs

Ce document résume les opérations réalisées pendant la formation QGIS. 
Pour chaque opération, vous trouverez un lien vers le tuto concerné. 

## Visualiser des données
- Paramétrer l'accès à la base de données du parc: [premier_parametrage](./premier_parametrage.md)
- Savoir charger et visualiser des couches depuis la base de données
- Paramétrer le catalogue de fonds de carte accessibles au format WMS
- Charger les fonds de carte au format WMS

## Organiser et modifier des données
- Bien comprendre le fonctionnement de QGIS
- Savoir créer et modifier un vecteur : géométrie/attributs
- Transférer des données depuis un relevé OruxMaps vers QGIS et vice-versa
- Réaliser des opérations élémentaires d'analyse spatiale (zone tampon, enveloppe convexe, ...)

## Questions du STRB: 
1. Comment importer des coord. GPX du PC au téléphone portable ? -> Oruxmaps To PC
 - Pour pouvoir importer des données saisies dans Oruxmaps sur Ordinateur, il faut savoir les exporter au format KML ou GPX, et savoir où les retrouver. 
Pour cela, aller dans 
 > Propriétés(le petit engrenage) > Traces/Routes .

Vous devriez voir le nom d'un dossier de type :
> /storage/..../oruxmaps/tracklogs/

En branchant votre appareil à un ordinateur, vous pourrez donc retrouver vos traces dans ce dossier

2. Comment exporter les coord. GPX du téléphone portable au PC ? 
A l'inverse, pour charger des données vecteur depuis QGIS, vers Oruxmaps, il suffit dans un premier temps de convertir la donnée Qgis au format KML
en faisant clic-droit sur la couche puis "Enregistrer sous". Vous pourrez ensuite changer le format de fichier vers kml.

Ensuite, il suffit de copier votre fichier dans votre appareil. Là, vous pourrez l'importer grâce à l'outil "trace/route" qui 
permet de charger un fichier kml ou gpx.

3. Quelle(s) extension(s) pour les coordonnées GPS (GPX et/ou kml) ? 
Les fichiers KML sont possiblement plus simples à lire sur QGIS. Mais les deux font l'affaire. 
Toutefois, pour toute manipulation ultérieure ne dépendant plus d'Oruxmaps, préférer le format geopackage.

4. La NS est-elle exploitable (complète et compréhensible) ? 
Je veux bien regarder
5. Comment consolider plusieurs fichiers gpx en une seule couche kml -> 
Dans l'onglet "vecteur" dans la barre de menus de QGIS, et dans la boite à outils, se frouve l'outil "Fusion de couches vecteurs". Celui-ci permet de regrouper 
en un seul fichier, plusieurs sources de données vectorielles, même dans des formats différents. 

6. Comment positionner un point théorique de relevé terrain (ex crotte de loup) 
ou dessiner un itinéraire pédestre sur QGIS pour en extraire une trace ou un point gpx/kml ou une carte jpg d’illustration.

7. Comment intégrer sur une couche QGIS un tableau de valeurs et coordonnées GPS ? 
En ouvrant le gestionnaire de couche (Ctrl+L) aller dans l'onglet "Comma Separated Values", symbolisé par une grosse virgule.La vous pourrez charger un tableau 
de valeurs à condition qu'il ait été préalablement mis au format csv. 

8. De la possibilité d’avoir des doubles écrans et des ordinateurs avec des "grosses" capacités de réactivité, pour un logiciel qui demande beaucoup d'espace disque.
J'aimerais bien, moi aussi. 


## Exercice de synthèse (pour les débrouillards): 
A partir du projet accessible sur la base de données du parc dans le Schéma "formation_qgis",
réaliser une visualisation des occurences de grenouille rousse (cd_ref=351), dans la vallée de votre choix.

Puis, mettre en évidence les zones à moins de 500m d'une observation de grenouille rousse, ainsi que 
la zone au sein de laquelle les observations ont été faites. 
