# Données

Bienvenue sur le git du Parc national du Mercantour. 

_[Première fois sur git ? Cliquez ici](./tutos/premierefois.md)_

Vous trouverez ici un _dépôt_ ([qu'est-ce que c'est ?](./tutos/README.md#depot)) contenant la documentation et 
les codes concernant la _base de données_ ([qu'est-ce que c'est ?](./tutos/README.md#base-de-donnees)) utilisée par les agents du parc.


# Le dépôt Données


Il est composé de deux parties principales.

 - "[bd_pnm](./bd_pnm)"
 
 Documentation, requêtes sql et _projets qgis_ liés à chaque schéma.


 - "[tutos](./tutos)"
 
 Guides et tutoriels pour accéder et traiter les données du parc du mercantour en utilisant les outils appropriés.



## Description

### [bn_pnm](./bd_pnm)

Le dossier [bn_pnm](./bd_pnm) contient un dossier par schéma ([qu'est-ce que c'est ?](./tutos/README.md#schema)). Chaque dossier-schéma contient:
 - un fichier README.md qui en fait la documentation
 - un dossier "sql" contenant les requêtes sql utiles à ce schéma
 - un dossier "projets_qgis" contenant les projets_qgis validés en format texte 
 - un dossier "bin" à l'usage des gestionnaires de la base de données
 Le dossier "_modele" contient le modèle de la documentation appliquée à chaque schéma. 
 
 ### [tutos](./tutos)

 Le dossier [tutos](./tutos) contient l'ensemble des tutoriels et guides pour la bonne utilisation des données géographiques.


 ## liens directs
 _les noms des schémas sont des liens cliquables, emmenant vers leur documentation_

 ### [bn_pnm](./bd_pnm)

 |Schéma|Description des données|
 |:--:|:--:|
 |[ag_pasto](./bd_pnm/ag_pasto)|Agropastoralisme <!-- à compléter -->|
 |[geonature_synthese](./bd_pnm/geonature_synthese)|Observations géonature, détaillées <br > et agrégées selon différents critères|
 |[limites](./bd_pnm/limites)| Limites du parc et administratives|

 ### [tutos](./tutos)

 |Nom|Description|
 |:--:|:--:|
 |[Acces_BD](./tutos/Acces_BD.md)| Mise en place des fichiers xml pour paramétrer l'accès à la base de données depuis Qgis|
 |[Acces_WMS](./tutos/Acces_WMS.md)|Mise en place des fichiers xml pour paramétrer l'accès aux données WMS/WFS depuis Qgis|

 ## Structure du dépôt

```bash
donnees
├───bd_pnm
│   │
│   ├───ag_pasto
│   │   ├───projets_qgis
│   │   ├───sql
│   │   └───bin
│   │
│   ├───geonature_synthese
│   │   ├───projets_qgis
│   │   ├───sql
│   │   └───bin
│   ├───limites
│   │   ├───projets_qgis
│   │   ├───sql
│   │   └───bin
│   │
│   ├─── ....
│   │   │
│   │   ├───projets_qgis
│   │   ├───sql
│   │   └───bin
│   │
│   │
│   └───_modele
│       ├───projets_qgis
│       ├───sql
│       └───bin
│ 
│ 
└───tutos
    ....
```


____
## Maintenance et utilisateurs avancés

### Mise à jour
Dans chaque dossier-schéma se trouve un dossier bin contenant notamment deux scripts:
 - `dump_schema` lit depuis la base de données la version courante du schema sql et l'enregistre dans `schema.sql`.  
 - `dump_project` télécharge la version courante du projet QGIS depuis la base de données et l'enregistre dans `nom_du_schema.qgs`
