# Installation des certificats d'accès la base de données



## Explications:
Dans ce tuto, vous allez permettre à QGIS de se connecter à la base de données. Pour cela, il faut déposer certains fichiers
qui vous auront été envoyés par le SI  - ce sont les certificats.
Pour cela, il faudra dézipper ce fichier, copier-coller son contenu dans un dossier spécifique. 
Ce répertoire peut être masqué par défaut, on utilisera donc une méthode particulière pour y accéder. 

Cette opération doit être renouvelée tous les ans, les certifiats vous identifiant à la base de données ayant une durée
limitée pour des raisons de sécurité. 


## Pas à pas

 _Vous avez reçu un fichier zip permettant le paramétrage de la connexion de la part du service informatique_
 
 _Vous êtes bien connecté sur votre session._


- Télécharger le fichier zip 
- Dézipper le fichier reçu dans un dossier. 
- Aller dans le dossier AppData. Deux façons de faire sont possibles:
	- 1- _Recommandé_ :Appuyer sur  _touche windows + R_ (la touche windows se trouve entre Ctrl et Alt) puis entrer la commande "%AppData%"
	- 2- Naviguer manuellement dans l'explorateur de fichiers jusqu'à
```
C:\Users\ *[nomdelasession]* \AppData\Roaming
```

- Vérifier si un dossier "postgresql" existe dans ..\AppData\Roaming  
- Sinon, le créer.

- Copier dans ce dossier tous les fichiers du zip à votre nom, y compris - et surtout - le fichier masqué .pg_service.conf. S'ils existent déjà, les remplacer.


- Lancer Qgis

- Ouvrir le gestionnaire de sources de données (Onglet "Couche>Gestionnaire de source de données" ou Ctrl+L) 

- Cliquer sur PostgreSQL dans la barre de gauche
![](./img/gestionnaire_sources_pg.png)

## _Si vous voyez "service projets" dans le menu déroulant en haut_

- Sélectionner "service projets" dans le menu déroulant en haut

- cliquer sur "Connecter"

- Vous avez maintenant accès à l'ensemble des schémas et projets de la base des données pour lesquels vos droits ont été définis

## _Si vous ne voyez pas "service projets" dans le menu déroulant en haut_

- Télécharger le fichier de paramétrage en faisant clic droit "Enregistrer la cible du lien sous" sur le lien suivant:  [services postgresql.xml en cliquant sur ce lien](https://raw.githubusercontent.com/PnMercantour/donnees/main/docs/tutos/ressources/services_postgresql.xml)

- Cliquer sur "Charger" à droite de la fenêtre

- Sélectionner le fichier "services postgresql" que vous avez téléchargé plus haut. 

_La liste des tables et schémas accessibles devrait apparaître._





_Vous pourrez aussi directement charger des projets directement depuis:_
> Projet > Ouvrir depuis... > PostgreSQL

_Puis en choisissant la connexion "Service projets" et le schéma concerné._




