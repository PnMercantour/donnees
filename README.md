# Données

Bienvenue sur le git du Parc national du Mercantour. 

_[Première fois sur git ? Cliquez ici](./tutos/git.md)_

Vous trouverez ici un [_dépôt_ (qu'est-ce que c'est ?)](./tutos/README.md##dépôt-repository  "Un projet Qgis contient un ensemble de couches, les informations permettant de les représenter, ainsi que l'ensemble des paramètres conditionnant la réalisation de géotraitements.") 
contenant la documentation et les codes concernant la [_base de données_ (qu'est-ce que c'est ?)](./tutos/README.md##base-de-données "Au sens large, une base de donnée permet de stocker et de manipuler des données par des moyens informatiques") 
utilisée par les agents du parc. Ainsi que des tutoriels et ressources facilitant l'utilisation de la base de données, et des ressources géographiques en général.


# Ce dépôt


Ce dépôt est composé de deux parties principales qui vous seront utiles.

 ## [bd_pnm](./bd_pnm)
  
Dans ce dossier, se trouve la documentation permettant de comprendre le contenu de chaque [_schéma_ (qu'est-ce que c'est ?](./tutos/README.md#schéma "Un schéma est un sous-ensemble organisé d'une base de données")) de la base de données, 
ainsi que les _projets qgis_ associés et les requêtes sql d'intérêt.

Le dossier [bn_pnm](./bd_pnm) contient un dossier par [schéma](./tutos/README.md#schema). Chaque dossier-schéma contient:
 - un fichier README.md détaillant le contenu et l'utilité du schéma
 - un dossier "projets_qgis" contenant les projets_qgis validés en format texte (téléchargeables et utilisables par les agents). _NB: Les projets ne sont pas directement visionnables depuis git, il est nécessaire de les télécharger pour ensuite les ouvrir avec Qgis._
 - un dossier "sql" contenant les requêtes sql utiles à ce schéma
 - un dossier "bin" à l'usage des gestionnaires de la base de données

 Le dossier "_modele" contient le modèle de la documentation appliquée à chaque schéma. 
 

_les noms des schémas ci-dessous sont des liens cliquables_

 |Schéma|Description des données|
 |:--:|:--:|
 |[ag_pasto](./bd_pnm/ag_pasto)|Agropastoralisme <!-- à compléter -->|
 |[charte](./bd_pnm/charte)|Données nécessaires à la réalisation de la carte des vocations<!-- à compléter -->|
 |[geonature_synthese](./bd_pnm/geonature_synthese)|Observations géonature, détaillées <br > et agrégées selon différents critères|
 |[geotrek](./bd_pnm/geotrek)| Sentiers du parc|
 |[inpn](./bd_pnm/inpn)| Limites de parcs nationaux, régionaux, et réserves naturelles|
 |[limites](./bd_pnm/limites)| Limites du parc et administratives|
 |[survol](./bd_pnm/survol)| Zones sensibles en lien avec les autorisations de survol|


 ## [tutos](./tutos)
 
 Le dossier [tutos](./tutos) contient l'ensemble des tutoriels et guides pour l'accès et la bonne utilisation des données géographiques du aprc, et provenant de sources externes. Ainsi qu'un glossaire des 
termes de géomatique ou en lien avec ce dépôt, et une F.A.Q. qui a vocation à intégrer vos interrogations !

Si vous venez de recevoir votre ordinateur, il est nécessaire de réaliser les premiers paramétrages pour avoir accès à la base de données du parc, et aux fonds 
de carte au format wms. 
[ajout_fond_de_carte_wms](./tutos/ajout_fond_de_carte_wms.md)


 |Nom|Description|
 |:--:|:--:|
 |[ajout_fond_de_carte_wms](./tutos/ajout_fond_de_carte_wms.md)| Ajouter un fond de carte standard (SCAN25, Orthophotos) à partir d'un [service wms]()|
 |[bonnes_pratiques](./tutos/bonnes_pratiques.md)|Rappel des bonnes pratiques pour le travail informatique et sur Qgis|
 |[configuration_ressources_wms](./tutos/configuration_ressources_wms.md)|Mise en place des fichiers xml pour paramétrer l'accès aux données WMS/WFS depuis Qgis|
 |[edition_de_polygones](./tutos/edition_de_polygones.md)|
 |[FAQ](./tutos/FAQ.md)| Questions les plus fréquentes et leurs solutions |
 |[git](./tutos/git.md)|Présentation et explication de ce qu'est "git"|
 |[installation_certificats_base_de_donnees](./tutos/installation_certificats_base_de_donnees.md)|Mise en place des fichiers xml pour paramétrer l'accès à la base de données depuis Qgis|
 |[liste_ressources_geographiques_wms](./tutos/liste_ressources_geographiques_wms.md)|Liste des ressources accessibles au format wms |
 |[mon_premier_projet](./tutos/mon_premier_projet.md)|Tutoriel complet sur la consultation d'un projet Qgis existant, son enregistrement, sa modification et ses exports|
 |[glossaire](./tutos/README.md)|Glossaire des principaux termes de géomatique utilisés sur ce git|



 
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
