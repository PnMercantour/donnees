# Accès au catalogue de données WMS/WFS.

<!--Ce tutorial détaille les étapes permettant de configurer l'accès au catalogue de données WMS/WFS du Parc national du Mercantour.
Il exige d'avoir reçu au préalable un fichier zip du service informatique du Parc. --> 

## Avant de commencer

 - _Vous avez reçu un fichier zip ou .xml permettant le paramétrage de la connexion de la part du service informatique_
 - _Vous êtes bien sur une session windows qui n'est pas partagée._

## Etapes du paramétrage


- Enregistrer et décompresser si nécessaire le fichier zip contenant le fichier "service WMS.xml".

- Déplacer ce fichier dans un dossier où il sera facile à retrouver.
 
> Exemple: C:\Users\VotreNom\Documents\QgisXML

- Lancer Qgis
 
- Ouvrir le gestionnaire de sources de données (Onglet "Couche>Gestionnaire de source de données" ou CTRL+L). _[Illustration](#Gestionnaire-de-sources-de-donnees)_

- clic droit sur WMS/WMTS dans l'explorateur, sélectionner "charger des connexions" 

 - Sélectionner le fichier "service WMS.xml" précédemment enregistré. 
Une fenêtre s'ouvre, clic sur 'Tout Sélectionner' puis 'Importer'

_Cette opération a enrichi l'annuaire des couches WMS avec les catalogues IGN les plus souvent utilisés._



____

## Illustrations

### Gestionnaire de sources de données
<img src="./img/gestionnaire_sources.png" alt= “” width="50%" height="50%"> 
