-- ============================================================================
-- Vues de visualisation des habitats du Mercantour (pour le projet QGIS)
-- ============================================================================
-- Sources : habitats.t_releve_habitat, habitats.t_releve_metadonnee,
--           habitats.t_habitat_occurrence, habitats.dico_typo_mer,
--           eau_zh.zh, eau_zh.habitat, eau_zh.ref_habitat, eau_zh.site.
--
-- Trois vues, toutes en lecture seule :
--   v_releve_dominant   (spatiale)     1 ligne par polygone : habitat dominant,
--                                      composition, part Natura 2000, metadonnees
--   v_occurrence_carto  (spatiale)     1 ligne par (polygone, habitat), toutes
--                                      sources confondues
--   v_stats_habitat     (non spatiale) surface et nombre de polygones par typo_mer
--
-- Les habitats de eau_zh ne sont integres que s'ils correspondent a une entree de
-- dico_typo_mer via dico_typo_mer.cor_typo_zh. Leurs identifiants de vue sont des
-- UUID deterministes derives de leurs identifiants source.
--
-- Conventions :
--   * "dominant" = habitat au plus fort pour_hab ; a egalite, le plus petit
--     code typo_mer (choix arbitraire mais deterministe).
--   * surface_ha = surface PLANIMETRIQUE (Lambert-93) du polygone x pour_hab / 100.
--     En montagne, la surface reelle du terrain est superieure.
--   * "Natura 2000" = statut_eur27 IN ('IC', 'PR') (IC = interet communautaire,
--     PR = prioritaire).
--
-- Controle utile : les occurrences sans pourcentage ont une surface NULL.
--   SELECT count(*) FROM habitats.t_habitat_occurrence WHERE pour_hab IS NULL;
-- ============================================================================

BEGIN;

-- PostgreSQL ne permet pas de modifier l'ordre des colonnes d'une vue existante
-- avec CREATE OR REPLACE ; on repart donc de zero.
DROP VIEW IF EXISTS habitats.v_stats_habitat;
DROP VIEW IF EXISTS habitats.v_occurrence_carto;
DROP VIEW IF EXISTS habitats.v_releve_dominant;

-- ----------------------------------------------------------------------------
-- 1. Un polygone = une ligne, avec son habitat dominant
-- ----------------------------------------------------------------------------
CREATE VIEW habitats.v_releve_dominant AS
WITH poly AS (
    SELECT r.id, r.id_origine, r.geometry, r.site, r.date_obs, r.observateur, r.organisme,
        'habitats'::text AS source_donnee, NULL::text AS ec_exp_zh
    FROM habitats.t_releve_habitat r
    UNION ALL
    SELECT md5('zh:' || z.id)::uuid, z.id::bigint, z.geom::geometry(MultiPolygon, 2154),
        s.nom_site::text,
        CASE WHEN z.annee_inventaire IS NOT NULL
            THEN make_timestamp(z.annee_inventaire, 1, 1, 0, 0, 0) END,
        NULL::text, z.source::text,
        'eau_zh'::text,
        CASE z.etat_zh
            WHEN 'bon' THEN 'Bon Etat'
            WHEN 'moyen' THEN 'Etat Altere'
            WHEN 'mauvais' THEN 'Etat Degrade'
            ELSE 'Non Evalue'
        END
    FROM eau_zh.zh z
    LEFT JOIN eau_zh.site s ON s.id = z.id_site
), occ AS (
    SELECT o.releve_id, o.typo_mer_id, o.pour_hab
    FROM habitats.t_habitat_occurrence o
    UNION ALL
    SELECT md5('zh:' || h.id_zh)::uuid, d.code_typo_mer, h.proportion::numeric(5,2)
    FROM eau_zh.habitat h
    JOIN eau_zh.ref_habitat rh ON rh.id = h.id_type
    JOIN habitats.dico_typo_mer d ON d.cor_typo_zh = rh.id
)
SELECT r.id, r.id_origine, r.geometry, r.site, r.date_obs, r.observateur, r.organisme,
    dom.typo_mer_id AS typo_mer_dominant, dom.pour_hab AS pour_hab_dominant,
    d.intitule AS habitat_dominant,
    d.groupe_mercantour, d.groupe_mer_pelouses, d.sous_groupe, d.enjeu,
    d.code_cb, d.lib_cb, d.code_eunis, d.lib_eunis, d.code_eur27, d.lib_eur27, d.statut_eur27,
    comp.nb_habitats, (comp.nb_habitats > 1) AS mosaique, comp.total_pour_hab, comp.composition,
    comp.natura2000, comp.pour_hab_n2000, comp.prioritaire,
    round((st_area(r.geometry) / 10000.0::double precision)::numeric, 4) AS surface_ha,
    m.natu_obs, m.unit_vege, m.echelle, m.grand_type, m.legende,
    COALESCE(m.ec_exp, r.ec_exp_zh) AS ec_exp,
    m.comm_exp, m.gestion, m.gestion_b, m.grille_ec, m.note_ec, m.alt_obs, m.alt_grille, m.enjeu_flore,
    r.source_donnee
FROM poly r
LEFT JOIN habitats.t_releve_metadonnee m ON m.releve_id = r.id
LEFT JOIN LATERAL (
    SELECT o.typo_mer_id, o.pour_hab
    FROM occ o
    WHERE o.releve_id = r.id
    ORDER BY o.pour_hab DESC NULLS LAST, o.typo_mer_id
    LIMIT 1
) dom ON true
LEFT JOIN habitats.dico_typo_mer d ON d.code_typo_mer = dom.typo_mer_id
LEFT JOIN LATERAL (
    SELECT count(*) AS nb_habitats,
        sum(o.pour_hab) AS total_pour_hab,
        COALESCE(bool_or(dd.statut_eur27 = ANY (ARRAY['IC'::text, 'PR'::text])), false) AS natura2000,
        COALESCE(sum(o.pour_hab) FILTER (
            WHERE dd.statut_eur27 = ANY (ARRAY['IC'::text, 'PR'::text])
        ), 0::numeric) AS pour_hab_n2000,
        COALESCE(bool_or(dd.statut_eur27 = 'PR'::text), false) AS prioritaire,
        string_agg(
            o.typo_mer_id || ' - ' || COALESCE(dd.intitule, '?') || ' ('
            || COALESCE(
                regexp_replace(o.pour_hab::text, '(\.[0-9]*[1-9])0+$|\.0+$', '\1'),
                '?'
            ) || ' %)',
            E'\n' ORDER BY o.pour_hab DESC NULLS LAST, o.typo_mer_id
        ) AS composition
    FROM occ o
    JOIN habitats.dico_typo_mer dd ON dd.code_typo_mer = o.typo_mer_id
    WHERE o.releve_id = r.id
) comp ON true;

COMMENT ON VIEW habitats.v_releve_dominant IS
    'Un polygone par ligne, toutes sources confondues, avec son habitat dominant, la composition, '
    'la part Natura 2000 et les metadonnees. Couche principale du projet QGIS.';

-- ----------------------------------------------------------------------------
-- 2. Un habitat sur un polygone = une ligne (geometrie du polygone repetee)
-- ----------------------------------------------------------------------------
CREATE VIEW habitats.v_occurrence_carto AS
WITH poly AS (
    SELECT r.id, r.geometry, r.site, r.date_obs, 'habitats'::text AS source_donnee
    FROM habitats.t_releve_habitat r
    UNION ALL
    SELECT md5('zh:' || z.id)::uuid, z.geom::geometry(MultiPolygon, 2154), s.nom_site::text,
        CASE WHEN z.annee_inventaire IS NOT NULL
            THEN make_timestamp(z.annee_inventaire, 1, 1, 0, 0, 0) END,
        'eau_zh'::text
    FROM eau_zh.zh z
    LEFT JOIN eau_zh.site s ON s.id = z.id_site
), occ AS (
    SELECT o.id, o.releve_id, o.typo_mer_id, o.pour_hab, o.enjeu_pnm
    FROM habitats.t_habitat_occurrence o
    UNION ALL
    SELECT md5('zhhab:' || h.id)::uuid, md5('zh:' || h.id_zh)::uuid,
        d.code_typo_mer, h.proportion::numeric(5,2), NULL::text
    FROM eau_zh.habitat h
    JOIN eau_zh.ref_habitat rh ON rh.id = h.id_type
    JOIN habitats.dico_typo_mer d ON d.cor_typo_zh = rh.id
)
SELECT o.id, o.releve_id, r.geometry, o.typo_mer_id, d.intitule AS habitat, o.pour_hab,
    round((
        st_area(r.geometry) * o.pour_hab::double precision
        / 100.0::double precision / 10000.0::double precision
    )::numeric, 4) AS surface_ha,
    d.groupe_mercantour, d.groupe_mer_pelouses, d.sous_groupe, d.enjeu, o.enjeu_pnm,
    d.code_cb, d.lib_cb, d.code_eunis, d.lib_eunis, d.code_eur27, d.lib_eur27, d.statut_eur27,
    COALESCE(d.statut_eur27 = ANY (ARRAY['IC'::text, 'PR'::text]), false) AS natura2000,
    r.site, r.date_obs, r.source_donnee
FROM occ o
JOIN poly r ON r.id = o.releve_id
JOIN habitats.dico_typo_mer d ON d.code_typo_mer = o.typo_mer_id;

COMMENT ON VIEW habitats.v_occurrence_carto IS
    'Une ligne par habitat present sur un polygone, toutes sources confondues, avec geometrie, '
    'surface ponderee par pour_hab et source_donnee.';

-- ----------------------------------------------------------------------------
-- 3. Statistiques par habitat (sans geometrie)
-- ----------------------------------------------------------------------------
CREATE VIEW habitats.v_stats_habitat AS
WITH poly AS (
    SELECT r.id, r.geometry FROM habitats.t_releve_habitat r
    UNION ALL
    SELECT md5('zh:' || z.id)::uuid, z.geom::geometry(MultiPolygon, 2154)
    FROM eau_zh.zh z
), occ AS (
    SELECT o.id, o.releve_id, o.typo_mer_id, o.pour_hab
    FROM habitats.t_habitat_occurrence o
    UNION ALL
    SELECT md5('zhhab:' || h.id)::uuid, md5('zh:' || h.id_zh)::uuid,
        d.code_typo_mer, h.proportion::numeric(5,2)
    FROM eau_zh.habitat h
    JOIN eau_zh.ref_habitat rh ON rh.id = h.id_type
    JOIN habitats.dico_typo_mer d ON d.cor_typo_zh = rh.id
)
SELECT d.code_typo_mer, d.intitule, d.groupe_mercantour, d.groupe_mer_pelouses,
    d.sous_groupe, d.enjeu, d.code_eur27, d.statut_eur27,
    count(o.id) AS nb_polygones,
    round(sum(
        st_area(r.geometry) * o.pour_hab::double precision
        / 100.0::double precision / 10000.0::double precision
    )::numeric, 2) AS surface_ha,
    count(o.id) FILTER (WHERE o.pour_hab IS NULL) AS nb_sans_pourcentage
FROM habitats.dico_typo_mer d
LEFT JOIN occ o ON o.typo_mer_id = d.code_typo_mer
LEFT JOIN poly r ON r.id = o.releve_id
GROUP BY d.code_typo_mer, d.intitule, d.groupe_mercantour, d.groupe_mer_pelouses,
    d.sous_groupe, d.enjeu, d.code_eur27, d.statut_eur27;

COMMENT ON VIEW habitats.v_stats_habitat IS
    'Nombre de polygones et surface (ha, ponderee par pour_hab) par typo_mer, toutes sources '
    'confondues, y compris les typo_mer jamais observes (0).';

-- ----------------------------------------------------------------------------
-- Droits : rien n'est accordé par défaut. Exemple, à adapter au rôle de lecture :
-- ----------------------------------------------------------------------------
-- GRANT SELECT ON habitats.v_releve_dominant, habitats.v_occurrence_carto, habitats.v_stats_habitat
--     TO <role_lecture>;

COMMIT;
