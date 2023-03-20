# geonature_synthese 


## Description

Ce schéma contient les observations de la base de données geonature. 
A chaque taxon sont associés les attributs définis par taxref ainsi que les informations géographiques 
correspondant au maillage et aux différentes zones remarquables du parc national du Mercantour. 
Les données sont accessibles soit en détail, soit agrégées selon la maille géographique, l'année, ou les classements en groupes inpn 1-2. 
Une liste rappelant les espèces patrimoniales/protégées est aussi disponible.



## Utilisation du projet qgis 

Les principales couches sont chargées, et représentées de façon simple.
Par défaut, des filtres sont appliqués afin d'accélérer le chargement du projet et de permettre la représentation d'entitées superposées.
Ces filtres sont appliqués à la fois par l'outil de filtrage, et au niveau de la symbologie ([Voir Bonnes Pratiques](../../tutos/BonnesPratiques.md#filtres)).

Pour utiliser le projet, ces filtres doivent être remplacés pour ne conserver que les données pertinentes.

### _Exemples_

#### Couche "détail"
	
>  Si l'on s'intéresse à toutes les observations d'Arthropodes dans la couche "détail"
	Après avoir cliqué sur l'icône de filtre à côté de la couche, on peut remplacer:

```sql
date_part('year', "date_max") = 2023
```
> par:
```sql
"phylum" = 'Arthropoda'
```
> Cette manipulation change le filtre: au lien de ne garder que les observations où l'année est 2023, on ne garde que celles où la colonne 
"phylum" contient exactement le mot "Arthropoda". 

#### Couche "Agrégation par maille, cd_ref et par an"
> en l'état la couche est filtrée par année d'observation (annee)
```sql
annee = 2023
```
> Elle est aussi filtrée au niveau de la symbologie

_Valeur_ : `sum("n_obs",group_by:="maille")`
> qui permet de regrouper les valeurs des mailles superposées. Au moment du chargement est donc représenté le nombre d'observation par maille en 2023.
> Les autres couches agrégées sont construites sur le même modèle. 



## Tables remarquables

Le schéma est constitué de 5 tables :

 - _.detail_ 

Contient l'ensemble des observations, complété par les données issues de taxref, et des propriétés de la maille contenant le lieu d'observation. 
Il a été décidé que chaque observation serait assignée à une et une seule maille de la grille 1km, en cas 
de superposition parfaite du lieu d'observation avec la limite entre deux mailles, la mailles au n° le plus grand est conservée. 

Dans les vues agrégées, la patrimonialité et la protection ne sont vraies que si toutes les espèces agrégées sont protégées ou patrimoniales. 

 - _.agregation_maille_an_

agrégation des observation par année de début d'observation et pour chaque maille de limites.grid. 
Ne sont conservées que les observations ayant eu lieu sur une seule année
 
 - _.agregation_groupe*\_inpn_maille_

agrégation des observations selon le groupe inpn 1-2 

 - _.taxon_patrimonial_protege_

liste des taxons (cd_ref) patrimoniaux ou protégés

## Description des colonnes remarquables
*Attention: Ne sont décrites ici que les colonnes remarquables, ou dont le nom pourrait prêter à confusion.*

#### _.detail_

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


 


_____
_Documentation pour utilisateurs avancés et maintenance_

## Exemples de Requêtes

<!--
_Requêtes pour récupérer toutes les observations d'une espèce dont le nom valide commence par "ar"_

```sql
--Requête pour avoir tous les trucs commençant par "a" ou "A"
SELECT *
FROM table_1
WHERE nom_truc ILIKE 'a%'
```
-->
## Dépendances

Les 3 vues agrégées sont construites sur la vue matérialisée _geonature_synthese.observation_taxonomie_grille_ qui permet de faire le lien
entre 4 schémas: 

|Schéma| Table/Vue/Vue Matérialisée| Description| clef |
|:--:|:--:|:--:|:--:|
|gn_synthese|synthese_avec_partenaires |observations de la base géonature| - |
|limites|grid|données géographiques liées aux mailles | spatiale|
|taxonomie|taxref|données taxonomiques| _cd_nom_|
|taxonomie|v_taxref_pp |patrimonialité/protection|_cd_nom_|
|ref_nomenclatures|*|détails sur l'observation|_id_nomenclature\_\*_|
 
 
 <!-- -
 - [limites.grid](https://github.com/PnMercantour/limites/README.md#tables_remarquables) : données géographiques liées aux mailles - jointure géographique
  [limites.grid](https://github.com/PnMercantour/limites/limites/README.md#limites.communes) : données géographiques liées aux mailles - jointure géographique 

 - gn_synthese.synthese_avec_partenaires : observations de la base géonature
 - taxonomie.taxref : classification - jointure sur _cd_nom_
 - taxonomie.v_taxref_pp : patrimonialité/protection - jointure sur _cd_nom_
 - ref_nomenclatures.* : détails sur l'observation - jointure sur _id_nomenclature\_\*_


## Mises à jour

Tous les ans, ou quand les couches de références changent. -->

## Code de création des tables

[Ici](./sql/creation.sql)




