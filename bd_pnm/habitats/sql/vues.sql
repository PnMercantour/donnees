-- ============================================================================
-- Vues de visualisation des habitats du Mercantour (pour le projet QGIS)
-- ============================================================================
-- Tables sources : habitats.t_releve_habitat, habitats.t_releve_metadonnee,
--                  habitats.t_habitat_occurrence, habitats.dico_typo_mer
--
-- Trois vues, toutes en lecture seule :
--   v_releve_dominant   (spatiale)     1 ligne par polygone : habitat dominant,
--                                      composition complete, part Natura 2000,
--                                      metadonnees -> couche principale
--   v_occurrence_carto  (spatiale)     1 ligne par (polygone, habitat) : permet de
--                                      cartographier UN habitat precis, y compris
--                                      quand il n'est pas dominant
--   v_stats_habitat     (non spatiale) surface et nombre de polygones par typo_mer
--
-- Conventions :
--   * "dominant" = habitat au plus fort pour_hab ; a egalite, le plus petit
--     code typo_mer (choix arbitraire mais deterministe).
--   * surface_ha = surface PLANIMETRIQUE (Lambert-93) du polygone x pour_hab / 100.
--     En montagne, la surface reelle du terrain est superieure.
--   * "Natura 2000" = statut_eur27 IN ('IC', 'PR')  (IC = interet communautaire,
--     PR = prioritaire, NC = non concerne). A CONFIRMER avec la signification
--     des codes dans votre typologie.
--
-- Controle a lancer avant usage : des pour_hab NULL donnent une surface NULL.
--   SELECT count(*) FROM habitats.t_habitat_occurrence WHERE pour_hab IS NULL;
-- ============================================================================

BEGIN;

-- Script relancable : PostgreSQL refuse de modifier l'ordre des colonnes d'une
-- vue existante avec CREATE OR REPLACE, on repart donc de zero.
DROP VIEW IF EXISTS habitats.v_stats_habitat;
DROP VIEW IF EXISTS habitats.v_occurrence_carto;
DROP VIEW IF EXISTS habitats.v_releve_dominant;

-- ----------------------------------------------------------------------------
-- 1. Un polygone = une ligne, avec son habitat dominant
-- ----------------------------------------------------------------------------
CREATE VIEW habitats.v_releve_dominant AS
SELECT
    r.id,
    r.id_origine,
    r.geometry,
    r.site,
    r.date_obs,
    r.observateur,
    r.organisme,

    -- habitat dominant et sa description typologique
    dom.typo_mer_id                      AS typo_mer_dominant,
    dom.pour_hab                         AS pour_hab_dominant,
    d.intitule                           AS habitat_dominant,
    d.groupe_mercantour,
    d.groupe_mer_pelouses,
    d.sous_groupe,
    d.enjeu,
    d.code_cb,
    d.lib_cb,
    d.code_eunis,
    d.lib_eunis,
    d.code_eur27,
    d.lib_eur27,
    d.statut_eur27,

    -- composition du polygone
    comp.nb_habitats,
    (comp.nb_habitats > 1)               AS mosaique,
    comp.total_pour_hab,
    comp.composition,

    -- Natura 2000 : presence (independante du pourcentage), part du polygone, prioritaire
    comp.natura2000,
    comp.pour_hab_n2000,
    comp.prioritaire,

    round((ST_Area(r.geometry) / 10000.0)::numeric, 4) AS surface_ha,

    -- metadonnees du releve
    m.natu_obs,
    m.unit_vege,
    m.echelle,
    m.grand_type,
    m.legende,
    m.ec_exp,
    m.comm_exp,
    m.gestion,
    m.gestion_b,
    m.grille_ec,
    m.note_ec,
    m.alt_obs,
    m.alt_grille,
    m.enjeu_flore
FROM habitats.t_releve_habitat r
LEFT JOIN habitats.t_releve_metadonnee m
       ON m.releve_id = r.id
LEFT JOIN LATERAL (
    SELECT o.typo_mer_id, o.pour_hab
    FROM habitats.t_habitat_occurrence o
    WHERE o.releve_id = r.id
    ORDER BY o.pour_hab DESC NULLS LAST, o.typo_mer_id
    LIMIT 1
) dom ON true
LEFT JOIN habitats.dico_typo_mer d
       ON d.code_typo_mer = dom.typo_mer_id
LEFT JOIN LATERAL (
    SELECT
        count(*)                                                        AS nb_habitats,
        sum(o.pour_hab)                                                 AS total_pour_hab,
        coalesce(bool_or(dd.statut_eur27 IN ('IC', 'PR')), false)       AS natura2000,
        coalesce(sum(o.pour_hab) FILTER (WHERE dd.statut_eur27 IN ('IC', 'PR')), 0)
                                                                        AS pour_hab_n2000,
        coalesce(bool_or(dd.statut_eur27 = 'PR'), false)                AS prioritaire,
        string_agg(
            o.typo_mer_id || ' - ' || coalesce(dd.intitule, '?') || ' ('
            || coalesce(
                   regexp_replace(o.pour_hab::text, '(\.[0-9]*[1-9])0+$|\.0+$', '\1'),
                   '?'
               )
            || ' %)',
            E'\n'
            ORDER BY o.pour_hab DESC NULLS LAST, o.typo_mer_id
        )                                                               AS composition
    FROM habitats.t_habitat_occurrence o
    JOIN habitats.dico_typo_mer dd ON dd.code_typo_mer = o.typo_mer_id
    WHERE o.releve_id = r.id
) comp ON true;

COMMENT ON VIEW habitats.v_releve_dominant IS
    'Un polygone par ligne avec son habitat dominant (plus fort pour_hab), la composition '
    'complete (texte), la part Natura 2000 et les metadonnees. Couche principale du projet QGIS.';

-- ----------------------------------------------------------------------------
-- 2. Un habitat sur un polygone = une ligne (geometrie du polygone repetee)
-- ----------------------------------------------------------------------------
CREATE VIEW habitats.v_occurrence_carto AS
SELECT
    o.id,
    o.releve_id,
    r.geometry,
    o.typo_mer_id,
    d.intitule                           AS habitat,
    o.pour_hab,
    round((ST_Area(r.geometry) * o.pour_hab / 100.0 / 10000.0)::numeric, 4) AS surface_ha,
    d.groupe_mercantour,
    d.groupe_mer_pelouses,
    d.sous_groupe,
    d.enjeu,
    o.enjeu_pnm,
    d.code_cb,
    d.lib_cb,
    d.code_eunis,
    d.lib_eunis,
    d.code_eur27,
    d.lib_eur27,
    d.statut_eur27,
    coalesce(d.statut_eur27 IN ('IC', 'PR'), false) AS natura2000,
    r.site,
    r.date_obs
FROM habitats.t_habitat_occurrence o
JOIN habitats.t_releve_habitat r ON r.id = o.releve_id
JOIN habitats.dico_typo_mer d    ON d.code_typo_mer = o.typo_mer_id;

COMMENT ON VIEW habitats.v_occurrence_carto IS
    'Une ligne par habitat present sur un polygone, avec geometrie et surface ponderee par pour_hab. '
    'Sert a cartographier un habitat precis meme quand il n''est pas dominant, et de table liee dans le formulaire.';

-- ----------------------------------------------------------------------------
-- 3. Statistiques par habitat (sans geometrie)
-- ----------------------------------------------------------------------------
CREATE VIEW habitats.v_stats_habitat AS
SELECT
    d.code_typo_mer,
    d.intitule,
    d.groupe_mercantour,
    d.groupe_mer_pelouses,
    d.sous_groupe,
    d.enjeu,
    d.code_eur27,
    d.statut_eur27,
    count(o.id)                                                         AS nb_polygones,
    round(sum(ST_Area(r.geometry) * o.pour_hab / 100.0 / 10000.0)::numeric, 2)
                                                                        AS surface_ha,
    count(o.id) FILTER (WHERE o.pour_hab IS NULL)                       AS nb_sans_pourcentage
FROM habitats.dico_typo_mer d
LEFT JOIN habitats.t_habitat_occurrence o ON o.typo_mer_id = d.code_typo_mer
LEFT JOIN habitats.t_releve_habitat r     ON r.id = o.releve_id
GROUP BY d.code_typo_mer, d.intitule, d.groupe_mercantour, d.groupe_mer_pelouses,
         d.sous_groupe, d.enjeu, d.code_eur27, d.statut_eur27;

COMMENT ON VIEW habitats.v_stats_habitat IS
    'Nombre de polygones et surface (ha, ponderee par pour_hab) par typo_mer, y compris les typo_mer jamais observes (0).';

-- ----------------------------------------------------------------------------
-- Droits : rien n'est accordé par défaut. Exemple, à adapter au rôle de lecture :
-- ----------------------------------------------------------------------------
-- GRANT SELECT ON habitats.v_releve_dominant, habitats.v_occurrence_carto, habitats.v_stats_habitat
--     TO <role_lecture>;

COMMIT;
