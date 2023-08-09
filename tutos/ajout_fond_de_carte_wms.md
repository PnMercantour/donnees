# Ajouter une couche WMS

## Avant de commencer

- _Vous souhaitez ajouter un fond de carte à votre projet QGis_
- _Vous avez déjà ajouté le catalogue de ressources wms à l'aide de [ce tuto](./configuration_ressources_wms.md) ou avez un lien vers une autre ressource wms vous intéressant._

## Etapes du paramétrage


- Lancer Qgis
 
- Ouvrir le gestionnaire de sources de données (Onglet "Couche>Gestionnaire de source de données" ou CTRL+L). _[Illustration](#Gestionnaire-de-sources-de-donnees)_

- Cliquer sur l'onglet "WMS" dans la colonne à gauche de la fenêtre.

<img src="./img/gestionnaire_sources.png" alt= “” width="50%" height="50%"> 


## Si vous souhaitez ajouter une ressource se trouvant déjà dans le catalogue

- Dans le menu déroulant des couches, choisir celle qui vous intéresse (ici : "IGN - Licence 7569 - Usages gratuits")
- Cliquer sur connexion
- Les couches proposeées vont apparaître. Choisir celle qui vous intéresse (ici la carte topographique "SCAN25"):
- Prendre soin de bien remplir les champs "taille de la tuile" avec, par exemple 256 comme valeur, ou moins.
_Entrer une valeur dans ce champ évite que Qgis n'essaie de charger des tuiles trop grosses depuis le WMS, et ralentisse._

<img src="./img/ajout_wms_parametres.png" alt= “” width="50%" height="50%"> 

- Appuyer sur ajouter.
 

## Vous souhaitez ajouter une ressource depuis un nouveau lien

- Cliquer sur "Nouveau"

- Entrer un nom clair permettant de comprendre de quelle ressource il s'agit ( "IGN - base de données Hydro" par exemple=

- Coller le lien de la ressource dans le champs "URL"

- Cliquer sur "OK"
