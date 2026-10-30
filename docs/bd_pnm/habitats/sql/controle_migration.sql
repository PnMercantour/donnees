-- ============================================================================
-- Schéma habitats : contrôles après la migration (creation.sql)
-- ============================================================================
-- Lecture seule. À lancer requête par requête ; les requêtes 3 à 6 ne doivent
-- rien retourner (ou seulement des cas compris et acceptés).
-- ============================================================================

-- 1. Nombre de polygones : source et cible doivent être égaux
SELECT
    (SELECT count(*) FROM habitats.t_fusion_habitats_vegetation) AS polygones_source,
    (SELECT count(*) FROM habitats.t_releve_habitat)            AS polygones_cible;

-- 2. Nombre d'habitats : avant et après regroupement des doublons
--    habitats_source = valeurs TYPO_MER_i non nulles ; occurrences_cible = lignes créées.
--    L'écart doit être égal aux doublons (requête 5) et aux typo_mer hors dictionnaire (requête 3).
SELECT
    (SELECT count(*)
       FROM habitats.t_fusion_habitats_vegetation f,
            LATERAL (VALUES (f."TYPO_MER_1"), (f."TYPO_MER_2"), (f."TYPO_MER_3"), (f."TYPO_MER_4")) AS t(v)
      WHERE v IS NOT NULL)                                       AS habitats_source,
    (SELECT count(*) FROM habitats.t_habitat_occurrence)         AS occurrences_cible;

-- 3. typo_mer utilisés dans la table source mais absents du dictionnaire
--    (ces occurrences n'ont pas été migrées)
SELECT v AS typo_mer_absent_du_dico, count(*) AS nb_occurrences_perdues
FROM habitats.t_fusion_habitats_vegetation f,
     LATERAL (VALUES (f."TYPO_MER_1"), (f."TYPO_MER_2"), (f."TYPO_MER_3"), (f."TYPO_MER_4")) AS t(v)
WHERE v IS NOT NULL
  AND v NOT IN (SELECT code_typo_mer FROM habitats.dico_typo_mer)
GROUP BY v
ORDER BY v;

-- 4. Comparaison détaillée, par id_origine et par typo_mer : source recalculée
--    avec la logique de la migration contre cible. Aucune ligne = migration cohérente.
--    pour_hab_source vide : occurrence seulement côté cible ;
--    pour_hab_cible vide  : occurrence perdue ; deux valeurs : écart de somme.
--    Limite : la comparaison regroupe par id_origine ; si deux polygones distincts
--    partagent le même id_origine, leur groupe est validé, pas chacun d'eux.
WITH source_agrege AS (
    SELECT id AS id_origine, "TYPO_MER_1" AS typo_mer_id, "POUR_HAB_1" AS pour_hab
    FROM habitats.t_fusion_habitats_vegetation
    WHERE "TYPO_MER_1" IN (SELECT code_typo_mer FROM habitats.dico_typo_mer)
    UNION ALL
    SELECT id, "TYPO_MER_2", "POUR_HAB_2" FROM habitats.t_fusion_habitats_vegetation
    WHERE "TYPO_MER_2" IN (SELECT code_typo_mer FROM habitats.dico_typo_mer)
    UNION ALL
    SELECT id, "TYPO_MER_3", "POUR_HAB_3" FROM habitats.t_fusion_habitats_vegetation
    WHERE "TYPO_MER_3" IN (SELECT code_typo_mer FROM habitats.dico_typo_mer)
    UNION ALL
    SELECT id, "TYPO_MER_4", "POUR_HAB_4" FROM habitats.t_fusion_habitats_vegetation
    WHERE "TYPO_MER_4" IN (SELECT code_typo_mer FROM habitats.dico_typo_mer)
),
source_par_id AS (
    SELECT id_origine, typo_mer_id, SUM(pour_hab) AS pour_hab_source
    FROM source_agrege
    GROUP BY id_origine, typo_mer_id
),
cible_par_id AS (
    SELECT r.id_origine, o.typo_mer_id, SUM(o.pour_hab) AS pour_hab_cible
    FROM habitats.t_habitat_occurrence o
    JOIN habitats.t_releve_habitat r ON r.id = o.releve_id
    GROUP BY r.id_origine, o.typo_mer_id
)
SELECT
    coalesce(s.id_origine, c.id_origine) AS id_origine,
    coalesce(s.typo_mer_id, c.typo_mer_id) AS typo_mer_id,
    s.pour_hab_source,
    c.pour_hab_cible
FROM source_par_id s
FULL OUTER JOIN cible_par_id c
    ON c.id_origine = s.id_origine AND c.typo_mer_id = s.typo_mer_id
WHERE s.pour_hab_source IS DISTINCT FROM c.pour_hab_cible
ORDER BY id_origine, typo_mer_id;

-- 5. Polygones de la table source où le même typo_mer figure sur plusieurs rangs
--    (leurs pourcentages ont été additionnés à la migration)
SELECT f.id AS id_origine, v AS typo_mer, count(*) AS nb_rangs
FROM habitats.t_fusion_habitats_vegetation f,
     LATERAL (VALUES (f."TYPO_MER_1"), (f."TYPO_MER_2"), (f."TYPO_MER_3"), (f."TYPO_MER_4")) AS t(v)
WHERE v IS NOT NULL
GROUP BY f.ctid, f.id, v
HAVING count(*) > 1
ORDER BY f.id, v;

-- 6. Polygones dont la somme des pourcentages s'écarte de 100 de plus de 5 points
--    (tolérance à ajuster) ; ne signale pas les polygones sans aucun pourcentage.
SELECT releve_id, sum(pour_hab) AS total_pour_hab, count(*) AS nb_habitats
FROM habitats.t_habitat_occurrence
GROUP BY releve_id
HAVING abs(sum(pour_hab) - 100) > 5
ORDER BY total_pour_hab;

-- 7. Occurrences sans pourcentage (leur surface ne peut pas être calculée)
SELECT count(*) AS occurrences_sans_pour_hab
FROM habitats.t_habitat_occurrence
WHERE pour_hab IS NULL;
