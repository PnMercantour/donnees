---
title: Page d'accueil
hide:
  - path
  - toc
  - navigation
---
# Docs et tutos concernant les données géographiques du Parc national du Mercantour

Vous trouverez ici la documentation concernant la [base de données*](./tutos/README.md##base-de-données "Au sens large, une base de donnée permet de stocker et de manipuler des données par des moyens informatiques") utilisée par les agents du parc ainsi que des tutoriels et ressources facilitant l'utilisation de la base de données et des données géographiques en général.

> Cette page est exclusivement destinée aux agents du Parc national du Mercantour.

Elle est décomposée en plusieurs sections pour faciliter votre utilisation : 

 - [tutos](./tutos/README.md) contient les tutoriels, supports de formations et ressources pour l'utilisation de QGIS et des bases de données du parc. 
 - [projets_qgis](./projets_qgis/index.md) contient le guide d'utilisation et de développement des projets stockés dans la bdd du parc.
 - [qgis_plugins](./qgis_plugins/plugins_list.md) contient le guide d'utilisation et de développement des plugins QGIS. 
 - [bd_pnm](./bd_pnm/index.md) contient les descriptions des schémas et données de la base de données du parc. 


!!! info "FAQ"
    Si vous cherchez la réponse à une question précise concernant la messagerie, le réseau, le mobile ou autres ressource interne du parc, vous pouvez consulter la [FAQ à ce lien.](https://pnmercantour.github.io/faq/).

??? note "Anciens liens" 
    **Métadonnées**  
    Dans le passé, des métadonnées ont été stockées sur ce site:  [https://catalogue.parcnational.fr/catalogue/pnm/fre/catalog.search#/home](https://catalogue.parcnational.fr/catalogue/pnm/fre/catalog.search#/home)  
    Elles ne sont plus mises à jour, et la plupart ont été copiées ici. 
    
    **Cartothèque**  
    Certaines cartes et données sont accessibles sur la carthotèque à ce lien: [http://192.168.80.85/lm/](http://192.168.80.85/lm/)  
    Elles ne sont plus mises à jour, et la plupart ont été copiées ici. 

## Prise en main de QGIS
 
La page [tutos](./tutos/README.md) contient l'ensemble des guides qui vous permettront l'accès et la bonne utilisation des données géographiques du parc ou provenant de sources externes.  
Un [glossaire](./tutos/glossaire.md) des termes de géomatique est disponible pour vous aider, et une [F.A.Q.](./tutos/FAQ.md) a vocation à intégrer vos interrogations !

!!! info "Nouveau PC" 
    Si vous venez de recevoir votre ordinateur, il est nécessaire de réaliser les premiers paramétrages pour avoir accès à la base de données du parc, et aux fonds de carte au format WMS.  
    Rdv dans la page [tutos](./tutos/README.md).


<!-- 

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

