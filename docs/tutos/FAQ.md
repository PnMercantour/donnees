# F.A.Q.

_Vous trouverez dans ce fichier une liste de problèmes et questions fréquentes avec des solutions simples._

_En cliquant en haut à droite de cette fenêtre vous avez accès à la table des matières pour chercher directement la question qui vous intéresse_
<img src="./img/table_des_matieres_git_page.png" alt= “” width="50%" height="50%"> 




<!-- ## Recherche de données -->

<!-- ### Je souhaite importer des courbes de niveau dans mon projet QGIS. --> 
## Concernant le parc

### J'ai un souci avec les limites du parc
Du fait de la méthode de leur tracé, les limites du parc sont compliquées à estimées avec une très grande précision.
Pour la plupart, elles s'appuient réglementairement sur le cadastre qui peut manquer de précision, mais il arrive aussi qu'elles traversent des parcelles.
Les cartes sur lesquelles les limites s'appuient sont tracées au 1/100 000.

Pour ces raisons, la délimitation à très grande échelle des limites du parc est un travail en cours. 

Pour ce qui concerne les calculs de superficie de pourcentage de zone coeur/d'aire d'adhésion, se référer au document 
> X:\6.7 SYSTEME INFORMATION\6_OUTILS_MEMO\STATS-CHIFFRES CLES\Données par communes.xlsx

N'hésitez pas à signaler les erreurs importantes/à conséquence 

<!--
### Je souhaite réaliser une carte à l'aide de données qui ne me sont pas accessibles

Contacter le chargé de mission référent sur le sujet, et s'assurer qu'il ne s'agit pas de données sensibles dont la diffusion est limitée. 
-->

## Dans QGIS

### J'AI UN PROBLEME ET JE SAIS PAS QUOI FAIRE
- Vérifier l'emplacement des données (est-ce qu'il s'agit de données qui sont sur la base de données, en local sur la machine, sur une tablette connectée en USB....)
- Vérifier la projection des données (2154)
- Vérifier le format des données 
	- ça peut être le type de géométrie point/ligne/polygone, 
	- le type d'attribut  (on ne peut pas faire de calculs sur des attributs au format texte)
	- 

### QGIS plante quand j'essaie d'ouvrir la table d'attribut d'une couche
_Il est probable que la table que vous essayer d'ouvrir est trop grande pour être gérée par QGIS._
_Solution: Limiter le nombre d'entités affiché par défaut dans la table d'attributs_
Dans la barre d'outils cliquer sur :
> Préférences > Options...
Dans les onglets de gauche, cliquer sur "Sources de données", puis dans "Comportement des tables" choisir "Montré les entités visibles sur la carte".

Dorénavant, la table d'attribut ne montrera que les entités visibles sur l'étendue du canevas visible, en zoomant vous limiterez le nombre d'entités à charger dans la table d'attribut et donc
le risque de plantage de QGIS. 

___________________________________
### La table d'attribut d'une couche ne montre pas toutes les entités. 

_Si vous êtes sûr que votre couche contient un grand nombre d'entités, mais seules quelques unes, voire aucunes
ne sont visibles dans la table d'attribut._
_Solution: Autoriser une couche à afficher toutes ses entités dans la table d'attributs._
En bas à droite de de la fenêtre de la table d'attributs se trouve une petite icône avec un menu déroulant "Ne montrer que les entités visibles sur la carte", 
vous pouvez choisir à la place l'option "Montrer toutes les entités" si vous savez que la taille de la table d'attributs n'est pas trop grande pour la mémoire de votre machine. 


_Vous pouvez aussi vérifier le nombre d'entités contenu dans une couche en passant par:_
> clic droit sur la couche > Propriétés > Information : Décompte d'entités_
_Si ce nombre ne correspond pas au nombre d'entités dans la table d'attribut vous pouvez appliquer la solution ci-dessous._ 



#### Explication
QGIS est paramétré par défaut pour ne montrer que les entités de la table d'attribut qui sont visibles sur la carte. 
Cela évite de faire planter instantanément QGIS en essayant de charger une table d'attribut contenant des milliers d'entités,
comme il en existe sur le serveur. 

___________________________________

### "Traiter les couches inutilisables" à l'ouverture d'un projet: certaines couches ne s'affichent pas

Un projet QGIS ne stocke pas les données en dur, mais uniquement les chemins vers celles-ci. 
Par conséquent, si des données ont été supprimées ou déplacées, QGIS ne les "trouve plus", et renvoie 
un message d'erreur  à l'ouverture d'un projet utilisant ces données.

<img src="./img/couche_introuvable_explication.png" alt= “” width="50%" height="50%"> 

- S'il s'agissait de données enregistrées localement sur la machine:
il suffit de sélectionner la couche manquante dans cette fenêtre,
puis de cliquer sur "Parcourir" et de montrer à QGIS où se situent les données. Une fois le projet enregistré, l'erreur ne devrait plus apparaitre. 


 - S'il s'agissait de données enregistrées sur le serveur:
le plus simple est de cliquer sur "Conserver les couches inutilisables", puis de cliquer droit sur la couche introuvable et de choisir "Réparer la source des données".

<img src="./img/reparer_la_source_des_donnees.png" alt= “” width="50%" height="50%"> 



Une toute petite fenêtre s'affiche, vous pouvez l'aggrandir. En bas vous trouverez PostgreSQL, puis "Service projets" et les schémas et tables contenant les données du parc. 

<img src="./img/reparer_source_donnees_postgreSQL.png" alt= “” width="50%" height="50%"> 



En cas de doute, vous pouvez toujours double cliquer sur la couche manquante, et regarder dans ses propriétés sa source afin de retrouver le nom du schéma et de la table correspondant. 

<img src="./img/nom_schema_table.png" alt= “” width="50%" height="50%"> 



___________________________________

### Message d'erreur " L'entité ...  a une géométrie non valide" pendant un géotraitement
Même si elles ne sont pas formulées, les géométries dans QGIS répondent à des règles. Une entité invalide peut tout de même être affichée, mais
toute tentative de traitement, ou de jointure avec une autre couche renverra cette erreur. 

_Solution_

- > "Réparer les géométries": dans la boîte à outil de QGIS se trouve un outil "Réparer les géométries" qui peut tenter de réparer les erreurs de géométries.

- > Modification manuelle: Si le message d'erreur donne les identifiants des entités aux géométries incorrectes, il est possible de les examiner et 
modifier manuellement pour corriger les éventuelles erreurs. 
___________________________________

### Impossible de charger un projet depuis la base de données PostgreSQL
Il existe plusieurs cas de figures:

- 1. Vous ne disposez pas d'un accès à la base de données

_Solution_

> Si vous êtes bien sur votre poste de travail, et c'est la première fois que vous vous connectez à la base de données contacter le SI.


- 2. Vous pouvez charger des couches depuis la base de données en passant par le gestionnaire de sources de données

_Solution_

> Dans le Gestionnaire des sources de données (Onglet "Couche > Gestionnaire des sources de données" ou CTRL + L), sélectionner l'onglet "PostgreSQL". Puis sélectionner la connexion "Service projets". Enfin, cliquer sur "Editer". 
Une nouvelle fenêtre s'affiche en bas de laquelle se trouve la case à cocher "Permettre l'enregistrement et le chargement de projets QGIS dans la base de données. "

___________________________________

### Je ne vois plus le panneau couches/explorateur/...
Le plus probable est qu'un panneau ait été déplacé/fermé dans une mauvaise manipulation. 
Pour le faire réapparaître, il suffit de cliquer sur 
> Vue>Panneaux
Puis de cocher les cases d'intérêt (généralement: Couches/Boîtes à Outils de traitements/Style de couche)


___________________________________

### Je ne vois pas les projets, mais seulement les tables de la base de données

 Faire un clic droit sur Postgis/Service Projets dans l'explorateur, cliquer "Editer la connexion" et cocher "Permettre le chargement et l'enregistrement de projets QGIS" puis "OK".
<img src="./img/editerconnexion_chargerprojets.png" alt= “” width="50%" height="50%"> 
	
___________________________________

### Je souhaite enregistrer une couche avec sa symbologie

Les formats traditionnels d'enregistrement ne permettaient pas d'associer les données et leur mode de représentation, mais 
le format GeoPackage si.
Pour cela, il faut passer par l'outil "Empaquetage de couche" de la boite à outils (accessible à l'aide de CTRL+ALT+T) ou dans 
l'onglet "Traitement" de la barre de menu.


___________________________________

## Oruxmaps

### charger une couche dans Oruxmaps

Pour rendre une couche accessible dans Oruxmaps, il est nécessaire de produire un fichier au format kml de cette couche, puis de la charger dans le téléphone. 

- Dans QGIS, charger la couche d'intérêt. 
- Cliquer droit sur la couche "Exporter> Sauvergarder les entités sous....."
- Choisir le format Keyhole Markup Language (KML)
- Parcourir les dossiers en cliquant sur l'icône suivant, et enregistrer le fichier là où il sera facile à retrouver.
<img src="./img/parcourir_dossiers_enregistrer.png" alt= “” width="20%" height="20%"> 
- Brancher le portable ou la tablette à l'ordinateur. 
- Copier le fichier KML dans le dossier 
> ...> oruxmaps > overlay
- Ouvrir Oruxmaps, ouvrir les options de cartes, 
<img src="./img/oruxmaps_optiondecouches.png" alt= “” width="20%" height="20%"> 
- Ouvrir "Options des couches" puis "Charger une couche KML"
Vous devriez trouver le fichier kml, et pouvoir le sélectionner pour le charger. 


### Charger le scan 25 dans Orux Maps


> https://data.geopf.fr/private/wmts?SERVICE=WMTS&VERSION=1.0.0&REQUEST=GetCapabilities&apikey=ign_scan_ws


