# Données



Ce dépôt sert à construire la documentation qui est affichée sur le site: https://pnmercantour.github.io/donnees


La documentation est composé de deux parties principales. [bd_pnm](#bd_pnm) contient les descriptions des schémas et données de la base de données du parc, [tutos](#tutos) contient les tutoriels, supports de formations et ressources pour l'utilisation de QGIS et des bases de données du parc. 

 ## [bd_pnm](./bd_pnm)
  
Dans ce dossier, se trouve la documentation permettant de comprendre le contenu de chaque [_schéma_ (qu'est-ce que c'est ?](./tutos/README.md#schéma "Un schéma est un sous-ensemble organisé d'une base de données")) de la base de données, 
ainsi que les [_projets qgis_]((./tutos/README.md#projet ) associés et les requêtes sql d'intérêt.

Le dossier [bn_pnm](./bd_pnm) contient un dossier par [schéma](./tutos/README.md#schema). Chaque dossier-schéma contient:
 - un fichier README.md détaillant le contenu et l'utilité du schéma
 - un dossier "projets_qgis" contenant les projets_qgis validés en format texte (téléchargeables et utilisables par les agents). _NB: Les projets ne sont pas directement visionnables depuis git, il est nécessaire de les télécharger pour ensuite les ouvrir avec Qgis._
 - un dossier "sql" contenant les requêtes sql utiles à ce schéma
 - un dossier "bin" à l'usage des gestionnaires de la base de données

 Le dossier "_modele" contient le modèle de la documentation appliquée à chaque schéma. 
 

_les noms des schémas ci-dessous sont des liens cliquables_

|Schéma|Description des données|
|:--:|:--:|
|[admin_express](./bd_pnm/admin_express)|Données concernant les limites administratives (produites par l'IGN)<!-- à compléter -->|
|[ag_pasto](./bd_pnm/ag_pasto)|Agropastoralisme <!-- à compléter -->|
|[bd_lacs](./bd_pnm/bd_lacs)|Données concernant les lacs<!-- à compléter -->|
|[cadastre](./bd_pnm/cadastre)|Données publiques issues cadastre<!-- à compléter -->|
|[charte](./bd_pnm/charte)|Données nécessaires à la réalisation de la carte des vocations<!-- à compléter -->|
|[foret](./bd_pnm/foret)|Données publiques issues cadastre<!-- à compléter -->|
|[geonature_synthese](./bd_pnm/geonature_synthese)|Observations géonature, détaillées et agrégées selon différents critères|
|[geotrek](./bd_pnm/geotrek)| Sentiers du parc|
|[inpn](./bd_pnm/inpn)| Limites de parcs nationaux, régionaux, et réserves naturelles|
|[limites](./bd_pnm/limites)| Limites du parc et administratives|
|[rice](./bd_pnm/rice)| Réserve Internationale de Ciel Etoilé|
|[survol](./bd_pnm/survol)| Zones sensibles en lien avec les autorisations de survol|
|[tourisme](./bd_pnm/tourisme)| Tourisme et fréquentation du parc (compteurs..)|


 ## [tutos](./tutos)
 
 Le dossier [tutos](./tutos) contient l'ensemble des tutoriels et guides pour l'accès et la bonne utilisation des données géographiques du aprc, et provenant de sources externes. Ainsi qu'un glossaire des 
termes de géomatique ou en lien avec ce dépôt, et une F.A.Q. qui a vocation à intégrer vos interrogations !

Si vous venez de recevoir votre ordinateur, il est nécessaire de réaliser les premiers paramétrages pour avoir accès à la base de données du parc, et aux fonds 
de carte au format wms. 
[ajout_fond_de_carte_wms](./tutos/ajout_fond_de_carte_wms.md)


 |Nom|Description|
 |:--:|:--:|
 |[ajout_fond_de_carte_wms](./tutos/ajout_fond_de_carte_wms.md)| Ajouter un fond de carte standard (SCAN25, Orthophotos) à partir d'un [service wms](#wms)|
 |[ajout_fond_SCAN25](./tutos/ajout_fond_SCAN25.md)| Ajouter le fond SCAN25 à partir d'un [service wms](#wms)|
 |[bonnes_pratiques](./tutos/bonnes_pratiques.md)|Rappel des bonnes pratiques pour le travail informatique et sur QGIS|
 |[editer_des_polygones](./tutos/editer_des_polygones.md)| Édition de données vecteurs pour modifier/ajouter des entités ou attributs|
 |[empaqueter_un_projet](./tutos/empaqueter_un_projet.md)| Enregistrer la symbologie d'un projet et l'ensemble des couches associées dans un seul fichier|
 |[FAQ](./tutos/FAQ.md)| Solutions aux questions et problèmes les plus fréquents |
 |[filtres](./tutos/filtres.md)| Comprendre l'utilisation des filtres pour ne charger qu'une partie des entités d'une couche|
 |[generer_un_atlas](./tutos/generer_un_atlas.md)| Générer un ensemble de cartes à partir d'une couche|
 |[git](./tutos/git.md)|Présentation et explication de ce qu'est "git"|
 |[glossaire](./tutos/README.md#glossaire)|Glossaire des principaux termes de géomatique utilisés sur ce git|
 |[installation_certificats_base_de_donnees](./tutos/installer_certificats_base_de_donnees.md)|Paramétrage de l'accès à la base de données depuis QGIS|
 |[mon_premier_projet](./tutos/mon_premier_projet.md)|Tutoriel complet sur la consultation d'un projet QGIS existant, son enregistrement, sa modification et ses exports|
 |[premier_paramétrage](./tutos/premier_parametrage.md)|Configuration de base de QGIS permettant d'en assurer le bon fonctionnement|
 |[ressources_geographiques_wms](./tutos/ressources_geographiques_wms.md)|Liste et description des ressources disponibles au format wms.|
 



 
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
