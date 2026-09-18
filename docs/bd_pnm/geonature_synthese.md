# geonature_synthese 


## Description

Ce schéma contient les observations de la base de données geonature.   
A chaque taxon sont associés les attributs définis par TaxRef ainsi que les informations géographiques.   
correspondant au maillage et aux différentes zones remarquables du parc national du Mercantour.   
Les données sont accessibles soit en détail, soit agrégées selon la maille géographique, l'année, ou les classements en groupes inpn 1-2.   
Une liste rappelant les espèces patrimoniales/protégées est aussi disponible.  
 


## Projets Qgis associés
Vous trouverez la documentation des projets [ici](../projets_qgis/geonature_synthese.md).


## Tables remarquables

Le schéma est constitué de 5 tables :

### detail 

Contient l'ensemble des observations, complété par les données issues de taxref, et des propriétés de la maille contenant le lieu d'observation.  
Il a été décidé que chaque observation serait assignée à une et une seule maille de la grille 1km, en cas.   
de superposition parfaite du lieu d'observation avec la limite entre deux mailles, la mailles au n° le plus grand est conservée.  

Dans les vues agrégées, la patrimonialité et la protection ne sont vraies que si toutes les espèces agrégées sont protégées ou patrimoniales. 


### agregation_maille_an

Agrégation des observation par année de début d'observation et pour chaque maille de limites.grid.  
Ne sont conservées que les observations ayant eu lieu sur une seule année.  
 
### agregation_groupe\inpn_maille

Agrégation des observations selon le groupe inpn 1-2 

### taxon_patrimonial_protege

Liste des taxons (cd_ref) patrimoniaux ou protégés


## Description des colonnes remarquables
!!! Warning "Ne sont décrites ici que les colonnes remarquables, ou dont le nom pourrait prêter à confusion."

#### .detail

| Nom de la colonne      | Type | Description     |
| :---        |    :----:   |          :--- |
| id_synthese      | int       | numéro d'observation   |
| id_grid   | int        | identifiant du numéro de maille |
| cd_nom   | int        | identifiant de nom unique dans taxref      |
| cd_ref   | int        | identifiant du taxon de référence      |
|maille | int |n° de la maille d'1km de côté dans laquelle se situe l'observation|
| patrimoniale/protegee| boolean| Valeurs True/False quand connue, sinon null. |
|count_min| int| nombre d'individus observés pour un taxon donné|
|...|...|...|


 
## Dépendances

??? Note "Documentation pour utilisateurs avancés et maintenance"
    Les 3 vues agrégées sont construites sur la vue matérialisée _geonature_synthese.observation_taxonomie_grille_ qui permet de faire le lien entre 4 schémas : 

    |Schéma| Table/Vue/Vue Matérialisée| Description| clef |
    |:--:|:--:|:--:|:--:|
    |gn_synthese|synthese_avec_partenaires |observations de la base géonature| - |
    |limites|grid|données géographiques liées aux mailles | spatiale|
    |taxonomie|taxref|données taxonomiques| _cd_nom_|
    |taxonomie|v_taxref_pp |patrimonialité/protection|_cd_nom_|
    |ref_nomenclatures|*|détails sur l'observation|_id_nomenclature\_\*_|
 

## Exemple de requêtes 

 
 <!-- -
 - [limites.grid](https://github.com/PnMercantour/limites/README.md#tables_remarquables) : données géographiques liées aux mailles - jointure géographique
  [limites.grid](https://github.com/PnMercantour/limites/limites/README.md#limites.communes) : données géographiques liées aux mailles - jointure géographique 

 - gn_synthese.synthese_avec_partenaires : observations de la base géonature
 - taxonomie.taxref : classification - jointure sur _cd_nom_
 - taxonomie.v_taxref_pp : patrimonialité/protection - jointure sur _cd_nom_
 - ref_nomenclatures.* : détails sur l'observation - jointure sur _id_nomenclature\_\*_


## Mises à jour

Tous les ans, ou quand les couches de références changent.

## Code de création des tables

[Ici](./sql/creation.sql)



 -->
