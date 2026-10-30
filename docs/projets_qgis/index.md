---
hide:
  - path
  - toc
  - navigation
---

<div class="pnm-hero" markdown>

<div class="pnm-hero__brand" markdown>

![Parc national du Mercantour](../tutos/img/Qgis-icon-3.0.png){ .pnm-hero__logo }

</div>

<div class="pnm-hero__text" markdown>

# Les projets QGIS du Parc

Bienvenue dans la documentation des projets QGIS disponibles dans la [base de données du Parc](../bd_pnm/index.md).

Vous y trouverez toutes les informations utiles pour **utiliser** et **développer** les projets listés.   
La documentation est structurée par [schéma](../tutos/glossaire.md#schema "Un schéma est un sous-ensemble organisé d'une base de données") : chaque projet est documenté dans le schéma qui le contient.

[:material-magnify: Utilisez la recherche en haut de page](#){ .md-button .md-button--primary onclick="document.querySelector('[data-md-toggle=search]').checked=true; document.querySelector('.md-search__input').focus(); return false;" }

</div>

</div>

!!! tip "Comment ouvrir un projet ?"
    Les projets sont stockés dans la base de données du Parc [:octicons-arrow-right-24: Charger un projet depuis la base de données](../tutos/installer_certificats_base_de_donnees.md#charger-un-projet).


## :material-map-outline: Limites et territoire
 
<div class="grid cards cols-4" markdown>

-   :material-city-variant-outline: **admin_express**

    ---
 
    Limites administratives (produites par l'IGN).

    
    - [admin_express](./admin_express.md#projet-admin_express)

    [:octicons-arrow-right-24: Voir le schéma](../bd_pnm/admin_express.md)

-   :material-home-map-marker: **cadastre**

    ---
 
    Données publiques issues du cadastre.

    - [cadastre](./cadastre.md#projet-cadastre)
    - [autorisation_travaux(_v2)](./cadastre.md#projet-autorisations-de-travaux)

    [:octicons-arrow-right-24: Voir le schéma](../bd_pnm/cadastre.md)

-   :material-leaf-circle: **inpn**

    ---
 
    Limites des parcs nationaux, des parcs régionaux et des réserves naturelles.

    - [inpn](./inpn.md#projet-inpn)

    [:octicons-arrow-right-24: Voir le schéma](../bd_pnm/inpn.md)


</div>

## :material-binoculars: Biodiversité et milieux naturels
 
<div class="grid cards cols-4" markdown>

-   :material-binoculars: **geonature_synthese**

    ---
 
    Observations GeoNature, détaillées et agrégées selon différents critères.

    - [geonature_synthese](./geonature_synthese.md#projet-geonature_synthese)

    [:octicons-arrow-right-24: Voir le schéma](../bd_pnm/geonature_synthese.md)

-   :material-pine-tree: **foret**

    ---
 
    Données concernant les forêts.

    - [foret](./foret.md#projet-foret)
    - [gestion](./foret.md#projet-gestion)

    [:octicons-arrow-right-24: Voir le schéma](../bd_pnm/foret.md)

-   :material-leaf: **habitats**

    ---

    Cartographie des habitats naturels du Parc.

    - [Habitats du PNM](./habitats.md#projet-habitats)

    [:octicons-arrow-right-24: Voir le schéma](../bd_pnm/habitats.md)

</div>

## :material-sign-direction: Gestion et fréquentation
 
<div class="grid cards cols-4" markdown>

-   :material-sign-direction: **geotrek**

    ---
 
    Sentiers du Parc.

    - [travaux_sentiers_faune/flore](./geotrek.md#projets-travaux-sentiers-florefaune)

    [:octicons-arrow-right-24: Voir le schéma](../bd_pnm/geotrek.md)

</div>

## :material-shield-check-outline: Réglementation et zonages
 
<div class="grid cards cols-4" markdown>

-   :material-weather-night: **rice**

    ---
 
    Réserve Internationale de Ciel Étoilé.
    
    - [Extension](./rice.md#projet-extension)

    [:octicons-arrow-right-24: Voir le schéma](../bd_pnm/rice.md)

</div>

!!! note "Tous les projets ne sont pas accessibles à tous les agents"
    Certains contiennent des données sensibles, si un projet n'apparaît pas dans QGIS, contactez le SI : `si@mercantour-parcnational.fr`.

!!! info "Documentation en cours"
    Si vous avez besoin de plus d'informations sur un projet QGIS stocké dans la bdd, contactez le SI `si@mercantour-parcnational.fr`.   
    Certains schémas de la base de données n'ont pas encore de projet QGIS associé. Voir la [liste des schémas](../bd_pnm/index.md).
 
