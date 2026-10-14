# Formation QGIS

La formation consiste à **dérouler les tutos de ce site, dans l'ordre du menu**, en s'entraînant sur un projet commun : **`Formation QGIS`**.

!!! tip "À refaire en toute autonomie" 
    Ce déroulé n'est pas réservé à la séance : vous pouvez le refaire seul·e, à votre rythme, autant de fois que nécessaire.  
    Rouvrez le projet `Formation QGIS`, travaillez sur votre copie, parcourez les tutos, et réimportez le CSV d'exemple ou vos propres données ! 

## Le projet `Formation QGIS`

Le projet d'exemple se trouve dans la base de données du Parc, dans le schéma `formation_qgis`. Pour l'ouvrir : [Accéder aux ressources du PNM](./installer_certificats_base_de_donnees.md#charger-une-couche).


| Groupe | Couche | Rôle |
|--------|--------|---------|
| **Mailles à prospecter** | `Presence_a_completer` | Les mailles (polygones) dont il faut renseigner la présence |
| | `couchetest_a_remplir` | Une couche de points pour accueillir les relevés de terrain |
| **Limites** | `Vallees` | Les 7 vallées du Parc (couche **filtrée**) |
| | `parc_coeur` | Le cœur du Parc et les communes de l'aire d'adhésion |
| | Carte topographique (IGN Scan 25) | Fond de carte (WMS) |
| | `departement` | Limites de départements |


## Les données de terrain

Un exemple de données est fourni dans le **tableur** ci-dessous :octicons-arrow-down-24:    
Ces relevés sont **inventés** pour la formation, et leur position est approximative : ils ne correspondent à aucune observation réelle.  

Vous pouvez également vous servir de vos **propres relevés**, sous format Excel, LibreOffice ou déjà en `.csv`.
 
| Fichier | Contenu |
|:---------:|---------|
| [`prospection_exemple.csv`](./ressources/prospection_exemple.csv) | 93 relevés fictifs de grenouille rousse, avec leurs coordonnées en latitude/longitude (`EPSG:4326`)  |
 
!!! tip "Enregistrer un Excel/LibreOffice en .csv"
    Ouvrez votre tableur, cliquez sur ++"Enregistrer sous"++.  
    Choisissez le format **Texte CSV** ou **CSV UTF-8 (délimité par des virgules)** selon le logiciel utilisé.   
    De préférence, utilisez le **point-virgule** comme séparateur de champ et **UTF-8** comme jeu de caractères.

    ![](./img/calc_pointvirgule.png)
	/// caption
	Sous **LibreOffice**
	///

	![](./img/enregistrer_sous_csv.png)
	/// caption
	Sous **Excel**
	///


## Le déroulé


| Étape | Tuto | Sur le projet `formation_qgis` |
|-------|------|--------------------------------|
| **Installation** | [Paramètres QGIS au PNM](./parametrage_qgis_pnm.md) · [Accéder aux ressources du PNM](./installer_certificats_base_de_donnees.md) | Se connecter à la base et ouvrir le projet |
| | [Fonds de carte](./wms_wfs.md) | Repérer le Scan 25, ajouter un autre fond (orthophoto) |
| | [Système de coordonnées](./scr.md) | Vérifier le SCR du projet et celui des couches |
| **Prise en main** | [Naviguer dans QGIS](./navigation.md) | Explorer le panneau Couches, zoomer sur une vallée |
| | [Créer ou modifier un projet](./creer_modifier_projet.md) | Enregistrer sa propre copie du projet |
| | [Créer ou modifier une couche](./creer_modifier_couche.md) | Copie locale de `couchetest_a_remplir` et `presence_a_completer`, puis **ajout du CSV de terrain** : importer `prospection_exemple.csv`, vérifier qu'il se superpose aux vallées |
| | [Symbologie](./symbologie.md) | Changer la symbologie des vallées, afficher leurs noms en étiquettes, symbologie des relevés |
| **Pour aller plus loin** | [Sélection](./selection.md) · [Filtres](./filtres.md) | Sélectionner une vallée, observer le filtre de `Vallees` & appliquer des filtres sur la `prospection` |
| | [Calculatrice de champs](./calculatrice_champs.md) | Calculer la surface de chaque vallée |
| | [Outils de traitement](./outils_traitement.md) | Obtenir les relevés uniquement sur la zone désirée |
| | [Partager un projet](./empaqueter_un_projet.md) | Empaqueter son projet |
| **Cartographie** | [Créer une carte](./creer_carte.md) | Une carte des vallées avec légende, échelle et source |

## Bonnes pratiques

À garder tout du long, voir [Bonnes pratiques](./bonnes_pratiques.md) :

1. **Enregistrer** souvent ++ctrl+s++.
2. **Travailler sur une copie**, jamais sur le projet partagé.
3. **Vérifier le SCR** quand on ajoute des données.

!!! tip "Besoin d'aide ?"
    [Glossaire](./glossaire.md) · [FAQ](./FAQ.md) · `si@mercantour-parcnational.fr`