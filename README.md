# Donnees

Ce dépôt est destiné à stocker la documentation, les requêtes sql ainsi que les projets qgis liés aux 
principaux schémas des bases de données en utilisation. En cas de besoin, de nouveaux schémas pourront être
ajoutés. 

## Structure du dépôt

```bash
donnees
│   README.md
│
└───bd_pnm
    ├───gn_observation
    │   │   README.md
    │   │
    │   ├───projets_qgis
    │   └───sql
    ├───limites
    │   │   README.md
    │   │
    │   ├───projets_qgis
    │   └───sql
    ├───_modele
    │   README.md
	│   │
    │   ├───projets_qgis
    │   └───sql
	│
    ....
	
```

Le dossier "_modele" contient le modèle de la documentation appliquée à chaque schéma. 

## Description

Le dossier "bn_pnm" contient un dossier par schéma. Chaque dossier-schéma contient:
 - un fichier README.md qui en fait la documentation
 - un dossier "sql" contenant les requêtes sql utiles à ce schéma
 - un dossier "projets_qgis" contenant les projets_qgis validés en format texte 

