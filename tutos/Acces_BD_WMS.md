# Accès au catalogue de données WMS/WFS et à la base de données.


_Avant de commencer: se trouver sur une session windows qui n'est pas partagée._



- Enregistrer et décompresser le fichier zip contenant les deux fichiers "service projets.xml" et "service WMS.xml".


- naviguer jusqu'au dossier AppData.

Il se trouve typiquement dans un chemin du type:
> C:\Users\ *[nomdelasession]* \AppData\Roaming

Le façon la plus simple de l'atteindre consiste à appuyer sur  _touche windows + R_, 
puis à entrer la commande "%AppData%" dans l'invité de commande (la touche windows se trouve entre ctrl et alt). [Voir Exemple](#Acces-au-dossier-AppData)

(Ce répertoire est masqué par défaut, il est aussi possible de naviguer jusqu'à lui, en autorisant
l'affichage des fichiers cachés dans les options)


- Créer un dossier "postgresql" dans le dossier AppData\Roaming s'il n'existe pas
- Copier dans ce dossier tous les fichiers du zip, y compris le fichier masqué .pg_service.conf
(les remplacer s'ils existent déjà)

- lancer Qgis

- clic droit sur WMS/WMTS dans l'explorateur, sélectionner "charger des connexions" 

 - Sélectionner le fichier "service WMS.xml" précédemment enregistré sur le disque. 
Une fenêtre s'ouvre, clic sur 'Sélectionner tout'. 
Cette opération a enrichi l'annuaire des couches WMS avec les catalogues IGN les plus souvent utilisés.

- clic droit sur Postgis dans l'explorateur. Même manip que précédemment avec le fichier "service projets.xml" qui ajoute la connexion vers notre base de données au catalogue.




## Illustrations

### Acces au dossier AppData

<img src="./img/appdata.png" alt= “” width="50%" height="50%">
