---
title: Page d'Accueil
hide:
  - path
  - toc
  - navigation
---
# Docs et tutos concernant les données géographiques du Parc national du Mercantour

Vous trouverez ici la documentation concernant la [_base de données_ (qu'est-ce que c'est ?)](./tutos/README.md##base-de-données "Au sens large, une base de donnée permet de stocker et de manipuler des données par des moyens informatiques") utilisée par les agents du parc ainsi que des tutoriels et ressources facilitant l'utilisation de la base de données, et des données géographiques en général.

Cette page est exclusivement destinée aux agents du Parc national du Mercantour.

Elle composé de deux parties principales: 

 - [bd_pnm](./bd_pnm/README.md) contient les descriptions des schémas et données de la base de données du parc, 
 - [tutos](./tutos/README.md) contient les tutoriels, supports de formations et ressources pour l'utilisation de QGIS et des bases de données du parc. 

## Documentation de la base de données: [bd_pnm](./docs/bd_pnm/README.md)
  
Dans ce dossier, se trouve la documentation permettant de comprendre le contenu de chaque [_schéma_ (qu'est-ce que c'est ?](./tutos/README.md#schéma "Un schéma est un sous-ensemble organisé d'une base de données")) de la base de données, 
ainsi que les [_projets qgis_](./tutos/README.md#projet ) associés et les requêtes sql d'intérêt.
 

_les noms des schémas ci-dessous sont des liens cliquables_

 |Schéma|Description des données|
 |:--:|:--:|
 |[admin_express](./bd_pnm/admin_express.md)|Données concernant les limites administratives (produites par l'IGN)<!-- à compléter -->|
 |[ag_pasto](./bd_pnm/ag_pasto.md)|Agropastoralisme <!-- à compléter -->|
 |[bd_lacs](./bd_pnm/bd_lacs.md)|Données concernant les lacs<!-- à compléter -->|
 |[bd_source](./bd_pnm/bd_lacs.md)|Données concernant les lacs<!-- à compléter -->|
 |[cadastre](./bd_pnm/cadastre.md)|Données publiques issues cadastre<!-- à compléter -->|
 |[charte](./bd_pnm/charte.md)|Données nécessaires à la réalisation de la carte des vocations<!-- à compléter -->|
 |[foret](./bd_pnm/foret.md)|Données publiques issues cadastre<!-- à compléter -->|
 |[geonature_synthese](./bd_pnm/geonature_synthese.md)|Observations géonature, détaillées <br > et agrégées selon différents critères|
 |[geotrek](./bd_pnm/geotrek.md)| Sentiers du parc|
 |[inpn](./bd_pnm/inpn.md)| Limites de parcs nationaux, régionaux, et réserves naturelles|
 |[limites](./bd_pnm/limites.md)| Limites du parc et administratives|
 |[rice](./bd_pnm/rice.md)| Réserve Internationale de Ciel Etoilé|
 |[survol](./bd_pnm/survol.md)| Zones sensibles en lien avec les autorisations de survol|
 |[tourisme](./bd_pnm/tourisme.md)| Tourisme et fréquentation du parc (compteurs..)|


 ## Tutos Qgis [tutos](./tutos/README.md)
 
 Le dossier [tutos](./tutos/README.md) contient l'ensemble des tutoriels et guides pour l'accès et la bonne utilisation des données géographiques du aprc, et provenant de sources externes. Ainsi qu'un glossaire des 
termes de géomatique ou en lien avec ce dépôt, et une F.A.Q. qui a vocation à intégrer vos interrogations !

Si vous venez de recevoir votre ordinateur, il est nécessaire de réaliser les premiers paramétrages pour avoir accès à la base de données du parc, et aux fonds 
de carte au format wms. 


|Nom|Description|
|:--:|:--:|
|[Ajout de couches wms](./tutos/ajout_fond_de_carte_wms.md)| Ajouter un fond de carte standard (SCAN25, Orthophotos) à partir d'un [service wms](#wms)|
|[Ajout du fond SCAN25](./tutos/ajout_fond_SCAN25.md)| Ajouter le fond SCAN25 à partir d'un [service wms](#wms)|
|[Bonnes pratiques](./tutos/bonnes_pratiques.md)|Rappel des bonnes pratiques pour le travail informatique et sur QGIS|
|[Edition de polygones](./tutos/editer_des_polygones.md)| Édition de données vecteurs pour modifier/ajouter des entités ou attributs|
|[Editeur d'expressions](./tutos/editeur_expression.md)| Utiliser le expressions QGIS pour filtrer une couche, ou réaliser une sélection fine|
|[Empaquetage de projet QGIS en Geopackage](./tutos/empaqueter_un_projet.md)| Enregistrer la symbologie d'un projet et l'ensemble des couches associées dans un seul fichier|
|[F.A.Q.](./tutos/FAQ.md)| Solutions aux questions et problèmes les plus fréquents |
|[Les Filtres dans QGIS](./tutos/filtres.md)| Comprendre l'utilisation des filtres pour ne charger qu'une partie des entités d'une couche|
|[Generation d'atlas](./tutos/generer_un_atlas.md)| Générer un ensemble de cartes à partir d'une couche|
|[glossaire](./tutos/glossaire.md)|Glossaire des principaux termes de géomatique utilisés sur ce git|
|[Accès à la base de données](./tutos/installer_certificats_base_de_donnees.md)|Paramétrage de l'accès à la base de données depuis QGIS|
|[Mon premier projet](./tutos/mon_premier_projet.md)|Tutoriel complet sur la consultation d'un projet QGIS existant, son enregistrement, sa modification et ses exports|
|[Premier paramétrage](./tutos/premier_parametrage.md)|Configuration de base de QGIS permettant d'en assurer le bon fonctionnement|
|[Ressources WMS](./tutos/ressources_geographiques_wms.md)|Liste et description des ressources disponibles au format wms.|



 
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

 <!--
# Welcome to MkDocs

For full documentation visit [mkdocs.org](https://www.mkdocs.org).

## Commands

* `mkdocs new [dir-name]` - Create a new project.
* `mkdocs serve` - Start the live-reloading docs server.
* `mkdocs build` - Build the documentation site.
* `mkdocs -h` - Print help message and exit.

## Project layout

    mkdocs.yml    # The configuration file.
    docs/
        index.md  # The documentation homepage.
        ...       # Other markdown pages, images and other files.
        -->