# inpn


## Description

Le schéma `inpn` contient les données relatives aux espaces protégés de la région Sud PACA. 
Elles proviennent du Service du Patrimoine Naturel du Muséum national d'Histoire naturelle (MNHN-SPN - [description détaillée ici](https://inpn.mnhn.fr/docs/transfertSIG.pdf)), et 
sont automatiquement mises à jour à partir du serveur inpn.

Ces données sont également accessibles via des flux [WMS](QGIS/inpn_wms.xml) et [WFS](QGIS/inpn_wfs.xml), en [télécharchement]( https://inpn.mnhn.fr/telechargement/cartes-et-information-geographique/ep/pn
) ou sur le [géoportail](geoportail.gouv.fr) ( Cartes > Données thématiques > Développement durable, énergie > Espaces protégés).



## Utilisation du projet qgis 

Le projet QGIS `inpn` dans ce schéma permet de visualiser les:

    - Parcs nationaux de métropole,
    - Parcs naturels régionaux de la région Sud PACA,
    - Réserves naturelles régionales de la région Sud PACA.


## Tables remarquables

Contient 3 tables principales. 
- pn
- pnr
- rnr : réserves naturelles régionales
<!--
## Description des colonnes remarquables

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

## Exemples de Requêtes
_Quelques exemples de requêtes toutes écrites qui permettent de faire des trucs_

```postgreSQL
--Requête pour avoir tous les trucs commençant par "a" ou "A"
SELECT *
FROM table_1
WHERE nom_truc ILIKE 'a%'
```
-->
## Dépendances




## Mises à jour

Les données sont régulièrement mises à jour (mise à jour la plus récente: février 2023)
