---
hide:
  - path
  - toc
  - navigation
---

<div class="pnm-hero" markdown>

<div class="pnm-hero__brand" markdown>

:material-toolbox:{ .pnm-hero__icon }

</div>

<div class="pnm-hero__text" markdown>

# Tutos autour de QGIS

Ici vous retrouverez l'ensemble des guides pour l'accès et la bonne utilisation des données géographiques du parc ou provenant de sources externes.  

Un [glossaire](./tutos/glossaire.md) des termes de géomatique est disponible pour vous aider, et une [F.A.Q.](./tutos/FAQ.md) a vocation à intégrer vos interrogations !

[:material-magnify: Utilisez la recherche en haut de page](#){ .md-button .md-button--primary onclick="document.querySelector('[data-md-toggle=search]').checked=true; document.querySelector('.md-search__input').focus(); return false;" }

</div>

</div>

!!! info "Nouveau PC" 
    Si vous venez de recevoir votre ordinateur, il est nécessaire de réaliser les premiers paramétrages pour avoir accès à la base de données du parc, et aux fonds de carte au format WMS :octicons-arrow-right-24: Installation. 

!!! question "Une question restée en supsens ?"
    Adressez-vous à `si@mercantour-parcnational.fr`.
    

## :material-cog: Installation
 
Configurer QGIS et accéder aux données du Parc.
 
<div class="grid cards cols-4" markdown>
-   :material-tune: **Paramètres QGIS au PNM**

    ---
 
    Les réglages à faire sur un poste neuf pour travailler dans de bonnes conditions.

    [:octicons-arrow-right-24: Voir le tutoriel](./parametrage_qgis_pnm.md){ .stretched }

-   :material-database-lock: **Accéder aux ressources du PNM**

    ---
 
    Installer les certificats et configurer la connexion **"Service projets"** à la base de données. 

    [:octicons-arrow-right-24: Voir le tutoriel](./installer_certificats_base_de_donnees.md){ .stretched }

-   :material-map: **Fonds de carte**

    ---
 
    Ajouter SCAN 25, orthophotos et autres fonds (WMS, WMTS, WFS).

    [:octicons-arrow-right-24: Voir le tutoriel](./wms_wfs.md){ .stretched }

-   :material-crosshairs-gps: **Systèmes de coordonnées**

    ---
 
    Comprendre les SCR, éviter les décalages et reprojeter une couche.

    [:octicons-arrow-right-24: Voir le tutoriel](./scr.md){ .stretched }

-   :material-puzzle: **Installer un plugin**

    ---
 
    Ajouter une extension à QGIS depuis un dépôt.

    [:octicons-arrow-right-24: Voir le tutoriel](./installation_plugin_via_depot.md){ .stretched }

</div>

## :material-rocket-launch: Prise en main
 
Les gestes de base pour ouvrir, explorer, modifier et entrer vos données.
 
<div class="grid cards cols-4" markdown>

-   :material-cursor-default-click: **Naviguer dans QGIS**

    ---
 
    Interface, souris, zoom et raccourcis clavier.

    [:octicons-arrow-right-24: Voir le tutoriel](./navigation.md){ .stretched }

-   :material-folder-open: **Créer/Modifier un projet**

    ---
 
    Ouvrir ou créer votre propre projet QGIS.

    [:octicons-arrow-right-24: Voir le tutoriel](./creer_modifier_projet.md){ .stretched }

-   :material-layers-plus: **Créer/Modifier une couche**

    ---
 
    Ajouter, créer, modifier une couche de votre projet.

    [:octicons-arrow-right-24: Voir le tutoriel](./creer_modifier_couche.md){ .stretched }

-   :material-palette: **Symbologie & Etiquettes**

    ---
 
    Rendre vos données lisibles d’un coup d’œil.

    [:octicons-arrow-right-24: Voir le tutoriel](./symbologie.md){ .stretched }

</div>

## :material-medal: Pour aller plus loin
 
Des outils supplémentaires pour analyser et donner du sens à vos données.
 
<div class="grid cards cols-4" markdown>

-   :material-share: **Partager un projet**

    ---
 
    Regrouper projet et couches dans un GeoPackage à transmettre.

    [:octicons-arrow-right-24: Voir le tutoriel](./empaqueter_un_projet.md){ .stretched }


-   :material-selection: **Sélection**

    ---
 
    Sélectionner des entités sur la carte, dans la table, par critère ou par position.

    [:octicons-arrow-right-24: Voir le tutoriel](./selection.md){ .stretched }

-   :material-filter: **Filtres**

    ---
 
    N'afficher que les entités qui vous intéressent, et alléger QGIS.

    [:octicons-arrow-right-24: Voir le tutoriel](./filtres.md){ .stretched }

-   :material-calculator-variant-outline: **Calculatrice de champs**

    ---
 
    Remplir ou modifier une colonne par une formule : surfaces, longueurs, textes, classes...


    [:octicons-arrow-right-24: Voir le tutoriel](./calculatrice_champs.md){ .stretched }

-   :material-tools: **Outils de traitement**

    ---
 
    Analyser ou traiter vos données avec la boîte à outils de traitement.


    [:octicons-arrow-right-24: Voir le tutoriel](./outils_traitement.md){ .stretched }

-   :material-image-area: **Raster**

    ---
 
    Charger et afficher un MNT ou une image, travailler avec des pixels.


    [:octicons-arrow-right-24: Voir le tutoriel](./raster.md){ .stretched }

</div>

## :material-map: Cartographie
 
Mettre en page et valoriser vos cartes.
 
<div class="grid cards cols-4" markdown>

-   :material-map-plus: **Créer une carte**

    ---
 
    Produire une carte à partir de votre projet.

    [:octicons-arrow-right-24: Voir le tutoriel](./creer_carte.md){ .stretched }

-   :material-earth: **Génération d'atlas**

    ---
 
    Produire automatiquement une série de cartes à partir d'une couche.

    [:octicons-arrow-right-24: Voir le tutoriel](./generer_un_atlas.md){ .stretched }

-   :material-vector-intersection: **Utiliser un masque**

    ---
 
    Mettre en valeur une zone en estompant le reste de la carte.

    [:octicons-arrow-right-24: Voir le tutoriel](./utiliser_un_masque.md){ .stretched }
    
</div>

## :material-book-open-variant: Ressources
 
Pour comprendre, se former et trouver de l'aide.
 
<div class="grid cards cols-4" markdown>

-   :material-frequently-asked-questions: **FAQ**

    ---
 
    Les réponses aux questions fréquentes.

    [:octicons-arrow-right-24: Consulter la FAQ](./FAQ.md){ .stretched }

-   :material-sort-alphabetical-ascending: **Glossaire**

    ---
 
    Les termes de géomatique expliqués simplement.

    [:octicons-arrow-right-24: Consulter le glossaire](./glossaire.md){ .stretched }

-   :material-checkbox-marked-circle-auto-outline: **Bonnes pratiques**

    ---
 
    Les habitudes à adopter pour travailler proprement et sans risque.

    [:octicons-arrow-right-24: Voir les bonnes pratiques](./bonnes_pratiques.md){ .stretched }

-   :material-school: **Formation**

    ---
 
    En autonomie, avec ses propres données, ou accompagné : mettre en pratique les tutos répertoriés ici !

    [:octicons-arrow-right-24: Voir le résumé](./formation.md){ .stretched }

-   :material-tortoise: **Taxrefmatch > cd_nom**

    ---
 
    L'outil du MNHN qui permet de retrouver le cd_nom à partir d'un nom scientifique de taxon.

    [:octicons-arrow-right-24: Voir le résumé](./taxrefmatch_cdnom.md){ .stretched }   

</div>