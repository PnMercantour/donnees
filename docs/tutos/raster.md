# Raster

Un **raster** est une donnée géographique faite d'une **grille de pixels**, chacun portant une valeur : une altitude, une couleur, une température... C'est le deuxième grand type de données de QGIS, à côté du [vecteur](./glossaire.md#vecteur).

---

## Qu'est-ce qu'un raster ?

On peut se représenter un raster comme un **tableau de cases** posé sur le territoire. Chaque case, le **pixel**, a une valeur unique. Plus les cases sont petites, plus l'image est fine.

| Notion | Ce que c'est | Exemple |
|--------|--------------|---------|
| **Pixel** (ou cellule) | Une case de la grille, qui porte **une valeur** | 2 345 (altitude en mètres) |
| **Résolution** | La **taille d'un pixel** sur le terrain | 5 m : chaque pixel couvre 5 m × 5 m |
| **Bande** | Une « couche » de valeurs dans le fichier | 1 bande pour un MNT, 3 bandes (rouge, vert, bleu) pour une photo |
| **Emprise** | Le rectangle couvert par le raster | Un massif, un département |
| **Valeur sans données** | Pixel volontairement vide, hors de la zone d'intérêt | Au-delà des limites du Parc |

!!! info "Quelques rasters courants"
    - **MNT** (modèle numérique de terrain) : une bande, l'altitude du sol.
    - **Orthophotographie** : une photo aérienne redressée, en 3 bandes (couleurs).
    - **Fond de carte** (WMS) : une image fournie par un service, [:octicons-arrow-right-24: Fonds de carte](./wms_wfs.md).
    - **Carte de pente, d'exposition, d'ombrage** : calculées à partir d'un MNT.

---

## Différence avec un vecteur

| | **Vecteur** | **Raster** |
|---|-------------|------------|
| **Principe** | Des **objets** : points, lignes, polygones | Une **grille de pixels** |
| **Contenu** | Une géométrie **et** une table d'attributs | Une valeur par pixel |
| **Exemples** | Sentiers, secteurs, observations | Altitude, photo aérienne, pente |
| **Précision** | Exacte, au sommet près | Limitée par la **résolution** |
| **Quand l'utiliser** | Pour des **objets distincts** avec leurs informations | Pour une information **continue** sur tout le territoire |
| **Dans QGIS** | On interroge la **table attributaire** | On regarde les **valeurs des pixels** |

!!! tip "Comment choisir ?"
    - Une chose qu'on peut **compter, nommer, délimiter** (une observation, un secteur) : un **vecteur**.
    - Une grandeur qui **varie partout** (altitude, température, couverture végétale) : un **raster**.

!!! info "On peut passer de l'un à l'autre"
    Un raster peut être **converti en polygones** (« vectoriser »), et un vecteur **en raster** (« rastériser ») depuis les **outils de traitement**. Ces conversions perdent de la précision : on les utilise quand l'analyse l'exige.

---

## Où trouver le MNT du Parc ?

| Source | Où la trouver | Résolution |
|--------|---------------|------------|
| **MNT du Parc** | [MNT_04_06_25m.tif](http://configuration.mercantour.local/MNT/) | 25 m |
| **RGE ALTI** (IGN) | [RGE_ALTI_5m_Mercantour.tif](http://configuration.mercantour.local/MNT/) | 5 m |
| **Fond de carte** (WMS) | Catalogue de fonds : [Fonds de carte](./wms_wfs.md#charger-un-fond-de-carte-dans-un-projet-qgis) | Selon le service |

!!! note "Données en ligne et données locales"
    Un fond WMS **affiche** une image, mais vous ne pouvez pas **calculer** dessus. Pour une pente ou une altitude, il faut le **fichier** du MNT (en général un GeoTIFF, `.tif`).

---

## Charger un raster

1. Dans la barre de menu, cliquez sur ++"Couche"++ > ++"Ajouter une couche"++ > ++"Ajouter une couche raster..."++, ou utilisez ++ctrl+shift+r++.
2. Cliquez sur les ++"..."+++ et sélectionnez votre fichier (par exemple `mnt.tif`).
3. Cliquez sur **Ajouter**, puis **Fermer**.

Vous pouvez aussi **glisser-déposer** le fichier depuis l'explorateur Windows dans QGIS.

### Vérifier ce qu'on a chargé

Faites un ++"clic droit"++ sur la couche > **Propriétés** > onglet **Information**. Vous y trouvez :

| Information | À regarder |
|-------------|------------|
| **SCR** | Le même que le projet, sinon voir [Système de coordonnées](./scr.md#quel-est-le-scr-de-ma-couche) |
| **Taille d'un pixel** | La résolution : 5 m, 25 m... |
| **Nombre de bandes** | 1 pour un MNT |
| **Emprise** | Couvre-t-elle bien votre zone d'étude ? |
| **Valeur sans données** | Celle utilisée hors de la zone |



### Le mettre en forme

Les réglages se font dans les **Propriétés** de la couche > onglet **Symbologie**. Les items ci-dessous sont propres aux raster :

| Type de rendu | Pour | Exemple |
|---------------|------|---------|
| **Bande grise unique** | Voir un MNT en niveaux de gris | Relief en noir et blanc |
| **Pseudo-couleur à bande unique** | Afficher les valeurs avec une **rampe de couleurs** | Altitude, du vert au brun |
| **Couleur multibande** | Les rasters de photo (rouge, vert, bleu) | Orthophotographie |
| **Ombrage** | Donner du **relief** à une carte | MNT en ombrage, sous une couche semi-transparente |

!!! tip "Un relief lisible"
    Placez un **ombrage** du MNT sous la couche d'altitude en pseudo-couleur, puis réglez la **transparence** de celle-ci (onglet **Transparence**) autour de 50 %. Le relief ressort immédiatement.



### Lire la valeur d'un pixel
Avec l'outil **Identifier les entités** ++ctrl+shift+i++, cliquez sur le raster : QGIS affiche la valeur du pixel, par exemple l'altitude.

---

## Les calculs les plus courants
 
Ces outils se trouvent dans le menu ++"Raster"++, ou dans la **Boîte à outils de traitements** (++ctrl+alt+t++) : voir [Outils de traitement](./outils_traitement.md).
 
| Je veux... | Outil | Résultat |
|------------|-------|----------|
| **Mesurer la pente** | **Pente** | Un raster de pentes, en degrés |
| **Connaître l'orientation d'un versant** | **Exposition** | Un raster d'orientations, de 0° à 360° |
| **Donner du relief à une carte** | **Ombrage** | Un raster d'ombrage |
| **Garder le raster sur ma zone** | **Découper un raster selon une couche de masque** | Un raster réduit au contour d'un polygone |
| **Combiner ou filtrer des pixels** | **Calculatrice raster** | Un nouveau raster filtré |
| **Vectoriser un raster** | **Polygoniser** | Un nouveau vecteur contentant des polygones |
 

### La calculatrice raster
 
Les outils précédents font une opération précise. Pour une opération **sur mesure**, la **calculatrice raster** applique une formule **pixel par pixel**, sur un ou plusieurs rasters : ++"Raster"++ > ++"Calculatrice raster..."++.

Cet outil est particulièrement utile pour filtrer un MNT et convertir ensuite en surface de travail : exemple zone dont l'altitude est supérieure à 2000m d'altitude.

C'est l'équivalent de la [calculatrice de champs](./calculatrice_champs.md), mais pour des pixels au lieu de lignes d'une table.
 
| Je veux... | Formule | Résultat |
|------------|---------|----------|
| Isoler une **tranche d'altitude** | `"mnt@1" >= 1500 AND "mnt@1" <= 2500` | `1` dans la tranche, `0` ailleurs |
| Passer de **mètres en pieds** (ou changer d'unité) | `"mnt@1" * 3.28084` | Un raster dans la nouvelle unité |
| **Croiser** deux rasters | `("mnt@1" > 2000) * ("pente@1" < 30)` | `1` là où les **deux** conditions sont vraies |
 
Le nom d'une couche s'écrit sous la forme **`"nom_de_la_couche@numéro_de_bande"`** : `"mnt@1"` désigne la bande 1 du raster `mnt`. Double-cliquez sur la couche dans la liste de gauche pour l'insérer sans faute de frappe.
 
!!! example "Le principe"
    Une condition renvoie **1** quand elle est vraie et **0** quand elle est fausse. On obtient ainsi un raster « oui / non » : par exemple, les zones entre 1 500 et 2 500 m, à croiser avec des observations ou à mettre en valeur sur la carte.
 
!!! warning "Rasters de même grille"
    Pour combiner plusieurs rasters, leur **SCR** et leur **résolution** doivent être cohérents. Sinon, rééchantillonnez-les avant le calcul.
 
Une fois la nouvelle couche raster filtrée créée vous pouvez la transformer en polygones si besoin, avec l'outil **Polygoniser**.


---

## En cas de problème

| Symptôme | Cause probable | Solution |
|----------|----------------|----------|
| Le raster ne s'affiche pas | Mauvais SCR, ou emprise hors de la zone de travail | Vérifiez le SCR dans les **Propriétés** et zoomez sur la couche (**Zoom sur la couche**) |
| Il s'affiche tout gris ou tout noir | Rendu en **bande grise** avec des valeurs mal étirées | Dans la **Symbologie**, ajustez min et max, ou choisissez une **pseudo-couleur** |
| Le raster est décalé par rapport aux vecteurs | SCR différents sans reprojection correcte | Vérifiez le SCR de la couche et celui du projet |
| L'outil est très lent | Raster très grand | **Découpez** d'abord sur votre zone |
| Les points ont une valeur vide après l'échantillonnage | Points hors de l'emprise, ou sur un pixel sans données | Vérifiez l'**emprise** du raster et la **valeur sans données** |
| Impossible de calculer sur un fond de carte | C'est un service **WMS**, pas un fichier | Utilisez le **fichier** du MNT |
| Le résultat est vide ou décalé | Rasters de résolutions ou d'emprises très différentes | Reprojetez ou rééchantillonnez-les avant le calcul |


