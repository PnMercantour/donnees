# Ajout de couches WMS

## Explications

Les fonds de carte qu'on utilise souvent (ex: SCAN 25, orthophotos) sont le plus souvent utilisés au format WMS.
Ce format présente des caractéristiques particulières. Il ne s'agit pas de fichiers stockés dans votre machine, 
mais plutôt d'un moyen d'accéder à des fichiers qui se trouvent sur un serveur distant, au moyen d'un url et de paramètres de connexion.
A chaque déplacement de la carte dans le projet QGIS, une requête est envoyée au serveur, qui va répondre en donnant accès aux données dans la région concernée.
Cette méthode d'accés à la donnée a l'avantage de ne pas surcharger les machines -  puisque ce sont souvent des données volumineuses -  en chargeant seulement la portion du territoire qui est concernée par le projet. 

Dans ce tuto, nous allons enregistrer des listes d'adresses de serveurs pour pouvoir y avoir accès facilement par la suite. Pour cela, on va utiliser un fichier .xml contenant une liste d'adresse de serveurs, ainsi que les options permettant de s'y connecter. On verra aussi comment ajouter manuellement des WMS issus d'autres sources. 


## Pas à pas

### Ajout du catalogue de WMS

- Télécharger le catalogue en faisant clic droit "Enregistrer la cible du lien sous" sur le lien suivant:  [service WMS.xml en cliquant sur ce lien](https://raw.githubusercontent.com//PnMercantour/donnees/main/tutos/ressources/service%20WMS.xml)

- Déplacer ce fichier dans un dossier où il sera facile à retrouver.
 
> Exemple: C:\Users\"VotreNom"\Documents\QgisXML
_Remplacer "VotreNom" par le nom d'utilisateur sur votre machine._
- Lancer QGIS
 
- Ouvrir le gestionnaire de sources de données (Onglet "Couche>Gestionnaire de source de données" ou CTRL+L). 
![](./img/gestionnaire_sources.png)

- Cliquer sur WMS/WMTS dans l'explorateur, sélectionner "charger des connexions" 

 - Sélectionner le fichier "service WMS.xml" précédemment enregistré. 
Une fenêtre s'ouvre, clic sur 'Tout Sélectionner' puis 'Importer'

_Cette opération a enrichi l'annuaire des couches WMS avec les catalogues IGN les plus souvent utilisés._ 
_Vous pouvez maintenant ajouter des fonds de carte au format wms en suivant la démarche décrite plus bas_

### Ajouter un WMS depuis un nouveau lien
_Vous avez trouvé le lien vers une ressource WMS qui n'est pas dans le catalogue mentionné plus haut._

- Ouvrir le gestionnaire de sources de données (Onglet "Couche>Gestionnaire de source de données" ou CTRL+L). 
![](./img/gestionnaire_sources.png)

- Aller dans l'onglet "WMS/WMTS" dans le ruban de gauche.
 
- Cliquer sur "Nouveau"

- Entrer un nom clair permettant d'identifier la ressource ( i.e."IGN - base de données Hydro" )

- Coller le lien de la ressource dans le champs "URL"

- Cliquer sur "OK"



### Charger un fond de carte dans un projet QGIS

- Lancer QGIS
 
- Ouvrir le gestionnaire de sources de données (Onglet "Couche>Gestionnaire de source de données" ou CTRL+L). 

- Cliquer sur l'onglet "WMS" dans la colonne à gauche de la fenêtre.

![](./img/gestionnaire_sources.png)


## Si vous souhaitez ajouter une ressource se trouvant déjà dans le catalogue

- Dans le menu déroulant des couches, choisir la source de données qui vous intéresse (par exemple: "IGN - Licence 7569 - Usages gratuits")
- Cliquer sur connexion
- Les couches liées à la couche choisie vont apparaître. Choisir celle qui vous intéresse (ici la carte topographique "SCAN25"):
- Prendre soin de bien remplir les champs "taille de la tuile" avec, par exemple 512 comme valeur.

_Entrer une valeur dans ce champ évite que QGIS n'essaie de charger des tuiles trop grosses depuis le WMS, ce qui peut ralentir voire complètement bloquer l'affichage de votre projet._

![](./img/ajout_wms_parametres.png)

- Appuyer sur ajouter.
 

