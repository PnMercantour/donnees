# F.A.Q.

_Vous trouverez dans ce fichier une liste de problèmes et questions fréquentes avec des solutions simples._

_En cliquant en haut à gauche de cette fenêtre vous avez accès à la table des matières pour chercher directement la question qui vous intéresse_




## Recherche de données

### Je souhaite importer des courbes de niveau dans mon projet Qgis. 



## Dans QGIS

### Ma table ne montre pas toutes les entités. 

Vous pouvez vérifier le nombre d'entités contenu dans une couche en passant par:
> clic droit sur la couche > Propriétés > Information : Décompte d'entités
Si ce nombre ne correspond pas au nombre d'entités dans la table d'attribut vous pouvez appliquer la solution ci-dessous. 

_Solution_

En bas à droite de de la fenêtre de la table d'attributs se trouve une petite icône avec un menu déroulant "Ne montrer que les entités visibles sur la carte", 
vous pouvez choisir à la place l'option "Montrer toutes les entités" si vous savez que la taille de la table d'attributs n'est pas trop grande pour la mémoire de votre machine. 


### Message d'erreur " L'entité ...  a une géométrie non valide" pendant un géotraitement
Même si elles ne sont pas formulées, les géométries dans Qgis répondent à des règles. Une entité invalide peut tout de même être affichée, mais
toute tentative de traitement, ou de jointure avec une autre couche renverra cette erreur. 

_Solution_

- > "Réparer les géométries": dans la boîte à outil de Qgis se trouve un outil "Réparer les géométries" qui peut tenter de réparer les erreurs de géométries.

- > Modification manuelle: Si le message d'erreur donne les identifiants des entités aux géométries incorrectes, il est possible de les examiner et 
modifier manuellement pour corriger les éventuelles erreurs. 

### Impossible de charger un projet depuis la base de données PostgreSQL
Il existe plusieurs cas de figures:

- 1. Vous ne disposez pas d'un accès à la base de données

_Solution_

> Si vous êtes bien sur votre poste de travail, et que c'est la première fois que vous vous connectez à la base de données contacter le SI.


- 2. Vous pouvez charger des couches depuis la base de données en passant par le gestionnaire de sources de données

_Solution_

> Dans le Gestionnaire des sources de données (Onglet "Couche > Gestionnaire des sources de données" ou CTRL + L), sélectionner l'onglet "PostgreSQL". Puis sélectionner la connexion "Service projets". Enfin, cliquer sur "Editer". 
Une nouvelle fenêtre s'affiche en bas de laquelle se trouve la case à cocher "Permettre l'enregistrement et le chargement de projets QGIS dans la base de données. "

### Je ne vois pas les projets, mais seulement les tables de la base de données

 Faire un clic droit sur Postgis/Service Projets dans l'explorateur, cliquer "Editer la connexion" et cocher "Permettre le chargement et l'enregistrement de projets QGIS" puis "OK".
 [Illustration](#Autoriser-le-chargement-des-projets)




## Illustration

#### Autoriser le chargement des projets

<img src="./img/editerconnexion_chargerprojets.png" alt= “” width="50%" height="50%"> 