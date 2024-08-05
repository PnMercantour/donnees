 # _survol_
 ## Description
 Ce schéma regroupe les données nécessaire à l'établissement de plan de vol du Parc National du Mercantour. 
 Les données relatives à la localisation d'espèces sensibles sont regroupées selon les périodes de l'années, 
 avec des zones tampon quand nécessaire pour déterminer les zones dont le survol sera interdit. 


 ## Utilisation du projet Qgis
Pas encore de projet Qgis dédié.

### _Exemples_
_Détail de l'utilisation du projet Qgis, de la manipulation des filtres et de la symbologie._

## Tables remarquables
 - _.zones_sensibles_ </br>
 Cette vue regroupe l'ensemble des zones sensibles pour toutes les espèces, elle est donc particulièrement importante pour l'établissement d'un plan 
 de vol. Elle contient pour chaque mois (de 01 à 12) une géométrie (MultiPolygon) représentant l'ensemble des zones sensibles. 

 Le tableau suivant résume les critères choisis pour chaque espèce, ainsi que les schémas et tables où les informations relatives sont stockées. 

 > NB: `"survol.t_calendrier_interdiction_survol_cis"  est abrégé en "cis"`

|Espèce|Zone Tampon|Critère|Schéma|table|
| :--:|:--: |:--:|:--:|:--:|
|aigle|500 | t_suivi.annee > 2012 - enjeu > 0 , </br>cis.activité != Emancipation| bd_aigle_royal|t_suivi_repro - </br >tr_codes_repro - c_aires|
|vautour| 500 | cis.activité=estive|faune|c_vautour_fauve_dortoir_vfd|
| gypaète| | c_zsm_gypaete_barbu_zgb.active=True|faune|c_zsm_gypaete_barbu_zgb|
|lagopède| | cis.activite in ('Manifestations territoriales', </br>'Ponte - Couvaison', 'Elevage jeune')|faune|c_lago_zone_repro_lzr|
|bouquetin| | cis.activite=hivernage </br> c_...\_bzh.annee_donnee>=2017 |faune|c_bouquetin_zone_hivernage_bzh |
|//||cis.activite= 'Mise bas' </br> c_..._com.enjeux like '%bouquetin%'|faune| c_ongules_misebas_com|
|chamois| | cis.activite = 'Mise bas'</br>c_..._com.enjeux like '%chamois%'|faune|c_ongules_misebas_com|
|tétralyre|100|cis.activite = 'Hivernage'|faune|c_tly_zone_quietude_tzq|
|//|100|cis.activite = 'Manifestations territoriales'|faune|c_tly_quartier_comptage_chant_tqc|



#	# Description des colonnes remarquables
<!--
Attention: Ne sont décrites ici que les colonnes remarquables, ou dont le nom pourrait prêter à confusion. 

#### table_1
| Nom de la colonne      | Type | Description     |
| :---        |    :----:   |          :---: |
| n_truc      | (PK) int       | c'est le numéro du truc   |
| nom_truc   | string        | c'est le nom du fameux truc      |

#### table_2
| Nom de la colonne      | Type | Description     |
| :---        |    :----:   |          :---: |
| n_machin      | int       | c'est le numéro du machin   |
| n_truc   | string        | c'est le numéro du truc      |

#### table_3
| Nom de la colonne      | Type | Description     |
| :---        |    :----:   |          :---: |
|...      |...       |...   |

-->


_____
_Documentation pour utilisateurs avancés et maintenance_

<!--
## Exemples de Requêtes
_Quelques exemples de requêtes toutes écrites qui permettent de faire des trucs_

```postgreSQL
--Requête pour avoir tous les trucs commençant par "a" ou "A"
SELECT *
FROM table_1
WHERE nom_truc ILIKE 'a%'
```

## Dépendances

table_3 mise à jour à partir de **schema1.table_46** et **schema3.table_18**



## Code de création des tables

[lien](./README.md)
-->