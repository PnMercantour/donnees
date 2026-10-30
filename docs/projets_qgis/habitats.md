# habitats

## Schéma
Sources et structure de la donnée utile à la construction des projets : [habitats](../bd_pnm/habitats.md).

---

## Projet habitats

Projet par défaut du schéma. Il permet de **visualiser la cartographie des habitats** du Parc : quel habitat domine sur chaque polygone, quels habitats composent une mosaïque, quels secteurs ont un enjeu élevé ou relèvent de Natura 2000.

Il n'a vocation qu'à être consulté : les couches sont en lecture seule.

!!! info "Un polygone peut porter plusieurs habitats"
    Chaque polygone est dessiné **une seule fois** et coloré selon son habitat **dominant** (celui qui couvre la plus grande part du polygone). Quand le polygone porte plusieurs habitats, l'étiquette du code est suivie d'un `+`, et la liste complète des habitats avec leurs pourcentages s'affiche dans le formulaire d'identification. Pour voir **tous** les habitats, y compris ceux qui ne sont pas dominants, utilisez la couche « Tous les habitats ».

### Les couches

Le projet est organisé en trois groupes. Le groupe Habitats est mutuellement exclusif, lorsqu'on affiche une couche de ce groupe les autres couches disparaîssent.

|Groupe|Couche|Ce qu'elle montre|Affichée au départ|
|:--|:--|:--|:--:|
|Habitats|**Habitat dominant (par groupe)**|Un polygone, une couleur par grand groupe d'habitats (forêts, fourrés, landes, pelouses, mégaphorbiaies, zones humides, friches, milieux rocheux). Les polygones en mosaïque portent un `+`.|oui|
|Habitats|**Enjeu patrimonial (habitat dominant)**|Les polygones colorés selon l'enjeu de leur habitat dominant, du plus clair (faible) au rouge sombre (très fort). Gris : enjeu non défini.|non|
|Habitats|**Natura 2000**|Seulement les polygones qui portent au moins un habitat d'intérêt communautaire ou prioritaire. Rouge : un habitat **prioritaire** est présent. Bleu foncé : habitats Natura 2000 sur la moitié ou plus du polygone. Bleu clair : moins de la moitié, ou part inconnue.|non|
|Habitats|**Tous les habitats (un par polygone)**|Un habitat sur un polygone = une entité, avec la géométrie du polygone. Les polygones en mosaïque sont donc superposés : cette couche sert à **filtrer** un habitat précis.|non|
|Tables|**Statistiques par habitat**|Nombre de polygones et surface de chaque habitat de la typologie.|—|
|Tables|**Typologie des habitats**|Le dictionnaire des habitats (intitulés, correspondances Corine Biotopes, EUNIS, EUR27).|—|
|Fonds de carte|**Plan IGN**, **Orthophotos**|Fonds de la Géoplateforme de l'IGN. Une connexion internet est nécessaire.|Plan IGN|

!!! note "Les étiquettes n'apparaissent qu'en zoomant"
    Le code de l'habitat dominant est affiché à partir de l'échelle 1:10 000.

!!! note "Le filtre de la couche « Natura 2000 »"
    Cette couche est déjà filtrée sur les polygones qui portent un habitat Natura 2000. Ne retirez pas ce filtre : sans lui, tous les polygones s'afficheraient, et ceux qui n'ont aucun habitat Natura 2000 prendraient le même bleu clair que ceux où la part est faible.

### Identifier un polygone

Avec l'outil **Identifier les entités** sur l'une des trois premières couches, le formulaire s'ouvre en quatre onglets :

- **Habitats** : l'habitat dominant, son groupe et son enjeu, la **composition** du polygone (tous les habitats avec leur pourcentage) et, en dessous, la **liste des habitats du polygone** sous forme de table ;
- **Typologies** : les correspondances de l'habitat dominant (Corine Biotopes, EUNIS, EUR27), la présence d'un habitat Natura 2000 et la part du polygone concernée ;
- **Relevé** : le site, la date, l'observateur, l'organisme, l'identifiant d'origine et la surface ;
- **Métadonnées** : la méthode, la gestion, l'altitude et l'enjeu flore.

En activant les info-bulles de la carte (menu **Vue**), le nom de l'habitat dominant et la composition du polygone s'affichent aussi au survol.

### Exemples

#### Voir où se trouve un habitat

Sélectionnez la couche **Tous les habitats (un par polygone)**, puis ouvrez le **filtre** de la couche (clic droit, **Filtrer...**) et saisissez, par exemple pour le `typo_mer` 98 :
```sql
"typo_mer_id" = 98
```
Tous les polygones qui portent cet habitat s'affichent, **même quand il n'y est pas dominant**. Pour ne garder que ceux où il couvre au moins la moitié du polygone :
```sql
"typo_mer_id" = 98 AND "pour_hab" >= 50
```
Pour afficher plusieurs habitats d'un même groupe, filtrez sur le groupe (les libellés sont écrits sans accents) :
```sql
"groupe_mercantour" = 'Zones humides'
```

#### Chercher un habitat par son nom

Avec la couche **Habitat dominant (par groupe)**, utilisez la [sélection par expression](../tutos/selection.md#selectionner-par-expression) :
```sql
"habitat_dominant" ILIKE '%mugo%'
```
sélectionne les polygones dont l'habitat dominant contient « mugo ».

#### Repérer les polygones à fort enjeu

Dans la couche **Habitat dominant (par groupe)**, une sélection par expression permet de combiner les critères, par exemple les mosaïques dont l'habitat dominant a un enjeu élevé :
```sql
"mosaique" AND "enjeu" IN ('Fort', 'Tres fort')
```

!!! tip "Prendre en main QGIS"
    La page des [tutos](../tutos/README.md) explique comment [filtrer une couche](../tutos/filtres.md), [sélectionner des entités](../tutos/selection.md) ou régler la [symbologie](../tutos/symbologie.md).

### Limites à connaître

- Les surfaces (`surface_ha`) sont calculées sur la carte, en Lambert-93 : elles ne tiennent pas compte du relief.
- La somme des pourcentages d'un polygone n'est pas toujours égale à 100, et certains habitats n'ont pas de pourcentage : leur surface ne peut alors pas être calculée.
- La couche « Enjeu patrimonial » montre l'enjeu de l'habitat **dominant**. Un polygone dont l'habitat dominant est d'enjeu moyen peut contenir un habitat d'enjeu plus élevé sur une plus petite part : la couche « Natura 2000 » ou le formulaire permettent de le repérer.

---

_Documentation pour utilisateurs avancés et maintenance_

### Reconstruire le projet

Le projet est construit par un script PyQGIS : [construire_projet_habitats.py](./scripts/construire_projet_habitats.py). Il crée les couches à partir des [vues du schéma](../bd_pnm/habitats.md#vues), applique les styles, configure les formulaires, la relation « polygone → habitats » et les fonds de carte, puis enregistre le projet.

1. Créer les vues du schéma avec [vues.sql](../bd_pnm/habitats/sql/vues.sql).
2. Dans QGIS, ouvrir un **projet vide** (le script refuse de s'exécuter dans un projet qui contient déjà des couches).
3. Ouvrir le script dans la console Python (ou dans l'éditeur de scripts de Processing) et renseigner la section `CONFIGURATION` : `PG_SERVICE` (un service défini dans `pg_service.conf`), ou `PG_HOST` et `PG_DBNAME`, et au besoin `OUTPUT_PATH`.
4. Exécuter le script. QGIS demande l'identifiant et le mot de passe PostgreSQL : aucun identifiant n'est écrit dans le script.

Les étapes de mise en forme (étiquettes, info-bulles, formulaires) sont isolées : si l'une échoue sur une version de QGIS différente, le projet se construit quand même et le script affiche à la fin la liste de ce qui n'a pas pu être appliqué. Il vise QGIS 3.40 et les versions suivantes.

### Enregistrer le projet dans la base

Comme les autres projets, il est enregistré dans la base de données avec **Projet**, **Enregistrer vers**, **PostgreSQL...**, dans le schéma `habitats`, sous le nom `Habitats du PNM`. Il est ainsi chargé comme les autres projets du Parc ([voir comment charger un projet](../tutos/installer_certificats_base_de_donnees.md#charger-un-projet)).

!!! warning "Droits d'accès"
    Les vues du schéma n'ont aucun droit par défaut. Pour qu'un projet s'ouvre chez les agents, le rôle de lecture concerné doit avoir le droit `SELECT` sur les quatre tables et les trois vues (voir la fin de [vues.sql](../bd_pnm/habitats/sql/vues.sql)).
