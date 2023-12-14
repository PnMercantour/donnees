
Dans le cadre de la bascule des ressources de l'IGN, le SCAN 25 est temporairement accessible selon la démarche décrite à ce lien (cette même démarche est décrite plus en détail dans ce document).

> https://geoservices.ign.fr/documentation/services/utilisation-sig/tutoriel-qgis/gpf-wms-wmts-donneesnonlibres

Cette solution est temporaire, et cessera de fonctionner dès la fin de la bascule des ressources de l'ign sur la géoplateforme. Quand cela arrivera, le nouveau mode d'accès au SAN25 vous sera communiqué.


# Ajouter le SCAN 25 au catalogue WMS


## Pas à pas

### Ajout de la ressource catalogue de WMS

 
- Ouvrir le gestionnaire de sources de données (Onglet "Couche>Gestionnaire de source de données" ou CTRL+L). 
<img src="./img/gestionnaire_sources.png" alt= “” width="50%" height="50%"> 

- Cliquer sur WMS/WMTS dans l'explorateur, sélectionner "Nouveau" 

- Dans nom entrer "Scan 25"
- Dans URL copier le lien suivant
> https://data.geopf.fr/private/wms-r?SERVICE=WMS&VERSION=1.3.0&REQUEST=GetCapabilities 

- Il faut ensuite cliquer sur la petite croix verte dans l'encadré "Athentification"

<img src="./img/croix_verte_nouveau_wms.png" alt= “” width="50%" height="50%"> 

- Puis entrer les données comme dans l'image ci dessous après avoir cliqué à nouveau sur la petite croix verte: 
	- Nom: Scan25
	- clé d'en-tête: apikey
	- Valeur d'en-tête: ign_scan_ws
<img src="./img/detail_params_scan25.png" alt= “” width="50%" height="50%"> 

- Et enfin cliquer sur OK. 

- Cette couche est maintenant disponible pour être chargée dans un projet comme décrit dans les instructions ci-dessous.




### Charger un fond de carte dans un projet Qgis

- Lancer Qgis
 
- Ouvrir le gestionnaire de sources de données (Onglet "Couche>Gestionnaire de source de données" ou CTRL+L). 

- Cliquer sur l'onglet "WMS" dans la colonne à gauche de la fenêtre.

<img src="./img/gestionnaire_sources.png" alt= “” width="50%" height="50%"> 

- Cliquer sur la ressource d'intérêt dans le menu déroulant (ici "SCAN 25") puis sur "Charger"
- Cliquer sur la couche qui s'affiche dans le menu central
- Entrer des tailles de tuile (recommandé: "256" et "256".) Le système de coordonnées n'est pas toujours modifiable.

<img src="./img/ajout_wms_parametres.png" alt= “” width="50%" height="50%"> 

- puis sur "Ajouter"


