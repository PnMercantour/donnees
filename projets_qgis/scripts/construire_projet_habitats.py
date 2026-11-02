# -*- coding: utf-8 -*-
"""
Construit le projet QGIS « Habitats du Parc national du Mercantour ».

Mode d'emploi
-------------
1. Creer les vues dans PostgreSQL : vues_habitats_qgis.sql
2. QGIS : Projet > Nouveau (le script refuse de tourner dans un projet qui
   contient deja des couches, pour ne rien ecraser).
3. Extensions > Console Python > « Afficher l'editeur » > ouvrir ce fichier,
   renseigner la section CONFIGURATION ci-dessous, puis Executer.
4. QGIS demande l'identifiant et le mot de passe PostgreSQL (aucun identifiant
   n'est ecrit dans le script).

Ce que le script produit
------------------------
* Groupe « Habitats » : habitat dominant par groupe (visible), enjeu
  patrimonial, Natura 2000, tous les habitats par polygone (masque).
* Groupe « Tables » : statistiques par habitat, typologie complete.
* Groupe « Fonds de carte » : Plan IGN et orthophotos (Geoplateforme).
* Une relation polygone -> habitats presents, affichee dans le formulaire
  d'identification, avec la composition de la mosaique et les metadonnees.
* Le projet est enregistre dans OUTPUT_PATH.

Ecrit pour QGIS >= 3.28 (compatible QGIS 4 : les enumerations sont appelees
par leur nom complet quand c'est possible).
"""
import os
from urllib.parse import quote

from qgis.core import (
    Qgis,
    QgsAttributeEditorContainer,
    QgsAttributeEditorField,
    QgsAttributeEditorRelation,
    QgsCoordinateReferenceSystem,
    QgsDataSourceUri,
    QgsEditFormConfig,
    QgsEditorWidgetSetup,
    QgsExpression,
    QgsFillSymbol,
    QgsPalLayerSettings,
    QgsProject,
    QgsRasterLayer,
    QgsRectangle,
    QgsReferencedRectangle,
    QgsRelation,
    QgsRuleBasedRenderer,
    QgsTextBufferSettings,
    QgsTextFormat,
    QgsVectorLayer,
    QgsVectorLayerSimpleLabeling,
)
from qgis.PyQt.QtGui import QColor

# ============================================================================
# CONFIGURATION : a adapter
# ============================================================================
# Soit un service defini dans pg_service.conf (recommande pour un projet partage
# entre collegues : aucune adresse de serveur dans le fichier .qgz) ...
PG_SERVICE = "projets"
# ... soit l'adresse du serveur (utilisee uniquement si PG_SERVICE est vide).
PG_HOST = "A_REMPLIR"
PG_PORT = "5432"
PG_DBNAME = "A_REMPLIR"
PG_USER = ""  # facultatif ; sinon QGIS le demandera
PG_SCHEMA = "habitats"

PROJECT_TITLE = "Habitats du Parc national du Mercantour"

# Emprise initiale (Lambert-93) : le massif du Mercantour
EXTENT_2154 = (985885, 6300980, 1077744, 6383693)

# ============================================================================
# PALETTES : les valeurs sont celles du dictionnaire (sans accents)
# ============================================================================
GROUPES = [
    # (valeur dans dico_typo_mer.groupe_mercantour, libelle, couleur)
    ("Forets", "Forêts", "#2b6e44"),
    ("Fourres", "Fourrés", "#7fa83e"),
    ("Landes", "Landes", "#a8577e"),
    ("Pelouses", "Pelouses", "#cdd96b"),
    ("Megaphorbiaies", "Mégaphorbiaies", "#e3a33b"),
    ("Zones humides", "Zones humides", "#3b82c4"),
    ("Friches", "Friches", "#b5835a"),
    ("Milieux rocheux", "Milieux rocheux", "#8c8c8c"),
]
ENJEUX = [
    ("Tres fort", "Très fort", "#7f0000"),
    ("Fort", "Fort", "#d7301f"),
    ("Moyen", "Moyen", "#fc8d59"),
    ("Faible", "Faible", "#fdd49e"),
    ("Non defini", "Non défini", "#d9d9d9"),
]
COULEUR_AUTRE = "#f2f2f2"

# Libelles lisibles pour les formulaires et les tables attributaires
ALIAS = {
    "id": "Identifiant",
    "id_origine": "Identifiant d'origine",
    "site": "Site",
    "date_obs": "Date d'observation",
    "observateur": "Observateur",
    "organisme": "Organisme",
    "typo_mer_dominant": "Code typo_mer dominant",
    "pour_hab_dominant": "% de l'habitat dominant",
    "habitat_dominant": "Habitat dominant",
    "groupe_mercantour": "Groupe",
    "groupe_mer_pelouses": "Groupe (pelouses détaillées)",
    "sous_groupe": "Sous-groupe",
    "enjeu": "Enjeu patrimonial",
    "code_cb": "Code Corine Biotopes",
    "lib_cb": "Corine Biotopes",
    "code_eunis": "Code EUNIS",
    "lib_eunis": "EUNIS",
    "code_eur27": "Code EUR27",
    "lib_eur27": "EUR27",
    "statut_eur27": "Statut EUR27",
    "nb_habitats": "Nombre d'habitats",
    "mosaique": "Mosaïque",
    "total_pour_hab": "Total des %",
    "composition": "Composition du polygone",
    "natura2000": "Habitat Natura 2000 présent",
    "pour_hab_n2000": "% Natura 2000",
    "prioritaire": "Habitat prioritaire présent",
    "surface_ha": "Surface (ha)",
    "natu_obs": "Nature de l'observation",
    "unit_vege": "Unité de végétation",
    "echelle": "Échelle",
    "grand_type": "Grand type",
    "legende": "Légende",
    "ec_exp": "EC_EXP",
    "comm_exp": "Commentaire expert",
    "gestion": "Gestion",
    "gestion_b": "Gestion (b)",
    "grille_ec": "Grille EC",
    "note_ec": "Note EC",
    "alt_obs": "Altitude (observée)",
    "alt_grille": "Altitude (grille)",
    "enjeu_flore": "Enjeu flore",
    "releve_id": "Polygone",
    "typo_mer_id": "Code typo_mer",
    "habitat": "Habitat",
    "pour_hab": "% du polygone",
    "enjeu_pnm": "Enjeu PNM",
    "code_typo_mer": "Code typo_mer",
    "intitule": "Intitulé",
    "nb_polygones": "Nombre de polygones",
    "nb_sans_pourcentage": "Occurrences sans %",
}

WARNINGS = []


# ============================================================================
# Utilitaires
# ============================================================================
def essayer(libelle, fonction, *args, **kwargs):
    """Etape cosmetique : un echec (API differente selon la version de QGIS)
    est signale a la fin mais ne bloque pas la construction du projet."""
    try:
        return fonction(*args, **kwargs)
    except Exception as exc:  # noqa: BLE001
        WARNINGS.append("%s : %s" % (libelle, exc))
        return None


def _type_multipolygone():
    try:
        return Qgis.WkbType.MultiPolygon
    except AttributeError:  # QGIS < 3.30
        from qgis.core import QgsWkbTypes

        return QgsWkbTypes.MultiPolygon


def _mise_en_forme_glisser_deposer():
    try:
        return Qgis.AttributeFormLayout.DragAndDrop
    except AttributeError:  # QGIS < 3.32
        return QgsEditFormConfig.TabLayout


def couche_pg(nom, table, cle, avec_geometrie=True):
    """Couche PostgreSQL. Les vues n'ont pas de cle primaire : on declare la
    colonne unique et on desactive le controle d'unicite (couteux sur une vue)."""
    if PG_SERVICE:
        connexion = "service='%s'" % PG_SERVICE
    else:
        connexion = "host=%s port=%s dbname='%s'" % (PG_HOST, PG_PORT, PG_DBNAME)
    uri = QgsDataSourceUri(connexion)
    if PG_USER:
        uri.setUsername(PG_USER)
    uri.setDataSource(PG_SCHEMA, table, "geometry" if avec_geometrie else "", "", cle)
    uri.setParam("checkPrimaryKeyUnicity", "0")
    uri.setUseEstimatedMetadata(True)
    if avec_geometrie:
        uri.setSrid("2154")
        uri.setWkbType(_type_multipolygone())
    couche = QgsVectorLayer(uri.uri(False), nom, "postgres")
    if not couche.isValid():
        raise RuntimeError(
            "Impossible de charger %s.%s. Verifiez la connexion, les droits SELECT "
            "sur la vue et que vues_habitats_qgis.sql a bien ete execute." % (PG_SCHEMA, table)
        )
    return couche


def symbole(couleur, opacite=0.85):
    s = QgsFillSymbol.createSimple(
        {
            "color": couleur,
            "outline_color": "35,35,35,90",
            "outline_width": "0.12",
            "outline_style": "solid",
        }
    )
    s.setOpacity(opacite)
    return s


def rendu_par_regles(regles, autre=None):
    """regles : liste de (libelle, expression, couleur).
    autre : (libelle, couleur) pour tout ce qui ne correspond a aucune regle
    (y compris les valeurs NULL), ou None pour ne rien dessiner."""
    racine = QgsRuleBasedRenderer.Rule(None)
    for libelle, expression, couleur in regles:
        racine.appendChild(QgsRuleBasedRenderer.Rule(symbole(couleur), 0, 0, expression, libelle))
    if autre:
        racine.appendChild(QgsRuleBasedRenderer.Rule(symbole(autre[1]), 0, 0, "ELSE", autre[0]))
    return QgsRuleBasedRenderer(racine)


def regles_valeurs(champ, valeurs):
    col = QgsExpression.quotedColumnRef(champ)
    return [
        (libelle, "%s = %s" % (col, QgsExpression.quotedString(valeur)), couleur)
        for valeur, libelle, couleur in valeurs
    ]


def etiquettes(couche, expression, echelle_max=10000):
    reglage = QgsPalLayerSettings()
    reglage.fieldName = expression
    reglage.isExpression = True
    fmt = QgsTextFormat()
    fmt.setSize(8)
    contour = QgsTextBufferSettings()
    contour.setEnabled(True)
    contour.setSize(0.8)
    contour.setColor(QColor("white"))
    fmt.setBuffer(contour)
    reglage.setFormat(fmt)
    reglage.scaleVisibility = True
    reglage.minimumScale = echelle_max  # visible quand on zoome plus pres que 1:echelle_max
    reglage.maximumScale = 0
    couche.setLabeling(QgsVectorLayerSimpleLabeling(reglage))
    couche.setLabelsEnabled(True)


def alias(couche):
    for i, champ in enumerate(couche.fields()):
        if champ.name() in ALIAS:
            couche.setFieldAlias(i, ALIAS[champ.name()])


def colonnes_table(couche, visibles):
    """Ne garde que `visibles` (dans cet ordre) dans la table attributaire."""
    cfg = couche.attributeTableConfig()
    cfg.update(couche.fields())
    par_nom = {c.name: c for c in cfg.columns()}
    ordre = []
    for nom in visibles:
        col = par_nom.pop(nom)
        col.hidden = False
        ordre.append(col)
    for nom, col in par_nom.items():
        col.hidden = nom != ""  # '' = colonne des boutons d'action
        ordre.append(col)
    cfg.setColumns(ordre)
    couche.setAttributeTableConfig(cfg)


def formulaire_polygone(couche, relation):
    """Formulaire a onglets : habitats / typologies / releve / metadonnees."""
    cfg = couche.editFormConfig()
    cfg.setLayout(_mise_en_forme_glisser_deposer())
    racine = cfg.invisibleRootContainer()
    racine.clear()

    def onglet(titre, champs, relation_liee=None):
        cont = QgsAttributeEditorContainer(titre, racine)
        cont.setColumnCount(1)
        for nom in champs:
            idx = couche.fields().indexOf(nom)
            if idx >= 0:
                cont.addChildElement(QgsAttributeEditorField(nom, idx, cont))
        if relation_liee is not None:
            try:
                el = QgsAttributeEditorRelation(relation_liee, cont)
            except TypeError:
                el = QgsAttributeEditorRelation(relation_liee.id(), cont)
            cont.addChildElement(el)
        racine.addChildElement(cont)

    onglet(
        "Habitats",
        [
            "habitat_dominant", "typo_mer_dominant", "pour_hab_dominant", "groupe_mercantour",
            "sous_groupe", "enjeu", "mosaique", "composition",
        ],
        relation,
    )
    onglet(
        "Typologies",
        [
            "code_cb", "lib_cb", "code_eunis", "lib_eunis", "code_eur27", "lib_eur27",
            "statut_eur27", "natura2000", "pour_hab_n2000", "prioritaire",
        ],
    )
    onglet("Relevé", ["site", "date_obs", "observateur", "organisme", "id_origine", "surface_ha"])
    onglet(
        "Métadonnées",
        [
            "natu_obs", "unit_vege", "echelle", "grand_type", "legende", "ec_exp", "comm_exp",
            "gestion", "gestion_b", "grille_ec", "note_ec", "alt_obs", "alt_grille", "enjeu_flore",
        ],
    )
    couche.setEditFormConfig(cfg)

    idx = couche.fields().indexOf("composition")
    if idx >= 0:
        couche.setEditorWidgetSetup(idx, QgsEditorWidgetSetup("TextEdit", {"IsMultiline": True}))


def fond_ign(titre, identifiant, format_image):
    brut = (
        "https://data.geopf.fr/wmts?SERVICE=WMTS&REQUEST=GetTile&VERSION=1.0.0"
        "&LAYER=%s&STYLE=normal&FORMAT=%s&TILEMATRIXSET=PM"
        "&TILEMATRIX={z}&TILEROW={y}&TILECOL={x}" % (identifiant, format_image)
    )
    source = "type=xyz&url=%s&zmax=19&zmin=0" % quote(brut, safe=":/?")
    couche = QgsRasterLayer(source, titre, "wms")
    if not couche.isValid():
        WARNINGS.append("Fond de carte « %s » non valide (acces internet ?)" % titre)
    return couche


# ============================================================================
# Construction
# ============================================================================
def main():
    if not PG_SERVICE and "A_REMPLIR" in (PG_HOST, PG_DBNAME):
        raise RuntimeError("Renseignez PG_SERVICE, ou PG_HOST et PG_DBNAME, dans la section CONFIGURATION.")

    projet = QgsProject.instance()
    if projet.mapLayers():
        raise RuntimeError(
            "Le projet courant contient deja des couches. Faites Projet > Nouveau, puis relancez le script."
        )

    projet.setTitle(PROJECT_TITLE)
    crs = QgsCoordinateReferenceSystem("EPSG:2154")
    projet.setCrs(crs)

    # --- couches --------------------------------------------------------------
    dominant = couche_pg("Habitat dominant (par groupe)", "v_releve_dominant", "id")
    enjeu = couche_pg("Enjeu patrimonial (habitat dominant)", "v_releve_dominant", "id")
    natura = couche_pg("Natura 2000", "v_releve_dominant", "id")
    occurrences = couche_pg("Tous les habitats (un par polygone)", "v_occurrence_carto", "id")
    stats = couche_pg("Statistiques par habitat", "v_stats_habitat", "code_typo_mer", avec_geometrie=False)
    typologie = couche_pg("Typologie des habitats", "dico_typo_mer", "code_typo_mer", avec_geometrie=False)

    # --- styles ---------------------------------------------------------------
    dominant.setRenderer(
        rendu_par_regles(
            regles_valeurs("groupe_mercantour", GROUPES), ("Autre / non renseigné", COULEUR_AUTRE)
        )
    )
    essayer(
        "Etiquettes (habitat dominant)",
        etiquettes,
        dominant,
        "\"typo_mer_dominant\" || CASE WHEN \"mosaique\" THEN ' +' ELSE '' END",
    )

    enjeu.setRenderer(
        rendu_par_regles(regles_valeurs("enjeu", ENJEUX), ("Non renseigné", COULEUR_AUTRE))
    )

    natura.setSubsetString('"natura2000" = true')
    natura.setRenderer(
        rendu_par_regles(
            [
                ("Habitat prioritaire présent", '"prioritaire"', "#b2182b"),
                ("Habitat d'intérêt communautaire ≥ 50 % du polygone", '"pour_hab_n2000" >= 50', "#2166ac"),
            ],
            ("Habitat d'intérêt communautaire < 50 % ou % inconnu", "#92c5de"),
        )
    )

    occurrences.setRenderer(
        rendu_par_regles(
            regles_valeurs("groupe_mercantour", GROUPES), ("Autre / non renseigné", COULEUR_AUTRE)
        )
    )

    # --- libelles, lecture seule, infobulles -----------------------------------
    for couche in (dominant, enjeu, natura, occurrences, stats, typologie):
        alias(couche)
    for couche in (dominant, enjeu, natura, occurrences, stats):
        couche.setReadOnly(True)

    for couche in (dominant, enjeu, natura):
        essayer("Expression d'affichage", couche.setDisplayExpression, '"habitat_dominant"')
        essayer(
            "Infobulle",
            couche.setMapTipTemplate,
            "<b>[% \"habitat_dominant\" %]</b><br>[% replace(\"composition\", '\\n', '<br>') %]",
        )
    essayer("Expression d'affichage", occurrences.setDisplayExpression, '"typo_mer_id" || \' - \' || "habitat"')
    essayer(
        "Table des habitats du polygone",
        colonnes_table,
        occurrences,
        ["typo_mer_id", "habitat", "pour_hab", "surface_ha", "enjeu", "statut_eur27"],
    )

    # --- arbre des couches ------------------------------------------------------
    for couche in (dominant, enjeu, natura, occurrences, stats, typologie):
        projet.addMapLayer(couche, False)
    racine = projet.layerTreeRoot()

    g_hab = racine.addGroup("Habitats")
    for couche, visible in ((dominant, True), (enjeu, False), (natura, False), (occurrences, False)):
        noeud = g_hab.addLayer(couche)
        noeud.setItemVisibilityChecked(visible)
        noeud.setExpanded(visible)

    g_tab = racine.addGroup("Tables")
    for couche in (stats, typologie):
        g_tab.addLayer(couche).setExpanded(False)
    g_tab.setExpanded(False)

    g_fond = racine.addGroup("Fonds de carte")
    fonds = (
        (fond_ign("Plan IGN (© IGN)", "GEOGRAPHICALGRIDSYSTEMS.PLANIGNV2", "image/png"), True),
        (fond_ign("Orthophotos (© IGN)", "ORTHOIMAGERY.ORTHOPHOTOS", "image/jpeg"), False),
    )
    for fond, visible in fonds:
        projet.addMapLayer(fond, False)
        noeud = g_fond.addLayer(fond)
        noeud.setItemVisibilityChecked(visible)
        noeud.setExpanded(False)

    # --- relation polygone -> habitats presents ---------------------------------
    # Une relation par couche polygone : une relation ne peut etre affichee que
    # dans le formulaire de sa propre couche « referencee ».
    for couche, suffixe in ((dominant, "dominant"), (enjeu, "enjeu"), (natura, "natura2000")):
        rel = QgsRelation()
        rel.setId("rel_polygone_habitats_%s" % suffixe)
        rel.setName("Habitats du polygone")
        rel.setReferencedLayer(couche.id())
        rel.setReferencingLayer(occurrences.id())
        rel.addFieldPair("releve_id", "id")
        if rel.isValid():
            projet.relationManager().addRelation(rel)
        else:
            WARNINGS.append("Relation polygone -> habitats invalide (%s) : %s" % (suffixe, rel.validationError()))
            rel = None
        essayer("Formulaire (%s)" % suffixe, formulaire_polygone, couche, rel)

    # --- emprise ------------------------------------------------------------------
    emprise = QgsRectangle(*EXTENT_2154)
    essayer("Emprise initiale", projet.viewSettings().setDefaultViewExtent, QgsReferencedRectangle(emprise, crs))
    try:
        iface.mapCanvas().setExtent(emprise)  # noqa: F821  (defini dans la console QGIS)
        iface.mapCanvas().refresh()  # noqa: F821
    except NameError:
        pass

    if WARNINGS:
        print("\nAvertissements (le projet est utilisable, ces points sont a verifier) :")
        for w in WARNINGS:
            print(" - %s" % w)


main()
