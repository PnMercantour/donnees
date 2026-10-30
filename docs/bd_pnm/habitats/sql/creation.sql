-- ============================================================================
-- Schéma habitats : création des tables et migration depuis la table fusion
-- ============================================================================
-- Documentation : docs/bd_pnm/habitats.md
--
-- Ce script :
--   1. crée le dictionnaire des habitats (dico_typo_mer) et le charge depuis le
--      fichier CSV de la typologie du Parc ;
--   2. crée les trois tables du relevé (t_releve_habitat, t_releve_metadonnee,
--      t_habitat_occurrence) ;
--   3. migre les données de habitats.t_fusion_habitats_vegetation (format
--      « large » : TYPO_MER_1..4 / POUR_HAB_1..4) vers ces tables.
--
-- Prérequis :
--   * le schéma habitats existe, ainsi que la table source
--     habitats.t_fusion_habitats_vegetation ;
--   * l'extension PostGIS est installée ;
--   * le CSV du dictionnaire (dico_typo_mer.csv, UTF-8, séparateur virgule,
--     valeurs vides = NULL) se trouve dans le dossier d'où psql est lancé.
--
-- Lancement :  psql -d <base> -f creation.sql
-- (\copy est une commande psql : elle ne fonctionne pas depuis DBeaver ou
--  pgAdmin, il faudrait alors charger le CSV avec leur outil d'import.)
-- ============================================================================

BEGIN;

CREATE EXTENSION IF NOT EXISTS pgcrypto;   -- gen_random_uuid()

-- ----------------------------------------------------------------------------
-- 1. Dictionnaire des habitats
-- ----------------------------------------------------------------------------
CREATE TABLE habitats.dico_typo_mer (
    code_typo_mer               int8 PRIMARY KEY,
    intitule                    text,
    groupe_mercantour           text,
    groupe_mer_pelouses         text,
    groupe                      text,
    sous_groupe                 text,
    sous_sous_groupe            text,
    rata_ordre                  text,
    rata_allia                  text,
    rata_assoc                  text,
    code_cb                     text,
    lib_cb                      text,
    code_eunis                  text,
    lib_eunis                   text,
    code_eur27                  text,
    lib_eur27                   text,
    statut_eur27                text,
    enjeu                       text,
    fiche_merc                  text,
    code_guide_habitats_alpes   text
);

COMMENT ON TABLE habitats.dico_typo_mer IS
    'Typologie des habitats du Parc national du Mercantour (une ligne par typo_mer), avec les correspondances Corine Biotopes, EUNIS et EUR27.';

\copy habitats.dico_typo_mer FROM 'dico_typo_mer.csv' WITH (FORMAT csv, HEADER true, NULL '', ENCODING 'UTF8')

-- ----------------------------------------------------------------------------
-- 2. Relevé : un polygone observé
-- ----------------------------------------------------------------------------
CREATE TABLE habitats.t_releve_habitat (
    id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    id_origine    int8,                 -- ancien "id" de la table fusion. NON UNIQUE dans la source :
                                        -- sert à la traçabilité, jamais de clé de jointure.
    geometry      public.geometry(multipolygon, 2154) NOT NULL,
    site          text,
    date_obs      timestamp,
    observateur   text,
    organisme     text
);

CREATE INDEX idx_t_releve_habitat_geometry
    ON habitats.t_releve_habitat USING gist (geometry);
CREATE INDEX idx_t_releve_habitat_id_origine
    ON habitats.t_releve_habitat (id_origine);

COMMENT ON TABLE habitats.t_releve_habitat IS
    'Un polygone cartographié : géométrie, site, date, observateur, organisme. Les habitats présents sont dans t_habitat_occurrence, les autres informations dans t_releve_metadonnee.';

-- ----------------------------------------------------------------------------
-- 3. Métadonnées du relevé (relation 1-1)
-- ----------------------------------------------------------------------------
CREATE TABLE habitats.t_releve_metadonnee (
    releve_id     uuid PRIMARY KEY REFERENCES habitats.t_releve_habitat(id) ON DELETE CASCADE,
    natu_obs      text,
    unit_vege     text,
    echelle       text,
    grand_type    text,
    legende       text,
    ec_exp        text,
    comm_exp      text,
    gestion       text,
    gestion_b     text,
    grille_ec     text,
    note_ec       text,
    alt_obs       text,
    alt_grille    text,
    enjeu_flore   text
);

COMMENT ON TABLE habitats.t_releve_metadonnee IS
    'Informations complémentaires sur un polygone (méthode, gestion, altitude, enjeu flore...). Une ligne au plus par polygone.';

-- ----------------------------------------------------------------------------
-- 4. Occurrences : un habitat présent sur un polygone
-- ----------------------------------------------------------------------------
CREATE TABLE habitats.t_habitat_occurrence (
    id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    releve_id     uuid NOT NULL REFERENCES habitats.t_releve_habitat(id) ON DELETE CASCADE,
    typo_mer_id   int8 NOT NULL REFERENCES habitats.dico_typo_mer(code_typo_mer),
    pour_hab      numeric(5,2) CHECK (pour_hab IS NULL OR (pour_hab >= 0 AND pour_hab <= 100)),
    enjeu_pnm     text,

    UNIQUE (releve_id, typo_mer_id)
);

CREATE INDEX idx_t_habitat_occurrence_releve_id
    ON habitats.t_habitat_occurrence (releve_id);
CREATE INDEX idx_t_habitat_occurrence_typo_mer_id
    ON habitats.t_habitat_occurrence (typo_mer_id);

COMMENT ON TABLE habitats.t_habitat_occurrence IS
    'Un habitat (typo_mer) présent sur un polygone, avec le pourcentage du polygone qu''il couvre (pour_hab). Les attributs de l''habitat (Corine Biotopes, EUNIS, EUR27...) sont dans dico_typo_mer.';
COMMENT ON COLUMN habitats.t_habitat_occurrence.pour_hab IS
    'Pourcentage du polygone couvert par cet habitat (0 à 100). La somme par polygone devrait être proche de 100, sans que ce soit imposé : voir controle_migration.sql.';

-- ----------------------------------------------------------------------------
-- 5. Migration depuis habitats.t_fusion_habitats_vegetation
-- ----------------------------------------------------------------------------
-- La colonne "id" de la table source n'est PAS unique : on ne peut donc pas
-- s'en servir pour rattacher une ligne source au polygone créé (une jointure
-- sur id multiplierait les lignes de chaque groupe de doublons). On passe par
-- le ctid, identifiant physique de ligne, unique par construction, via une
-- table temporaire de correspondance.

CREATE TEMP TABLE _map_releve AS
SELECT ctid AS src_ctid, gen_random_uuid() AS releve_id
FROM habitats.t_fusion_habitats_vegetation;

INSERT INTO habitats.t_releve_habitat
    (id, id_origine, geometry, site, date_obs, observateur, organisme)
SELECT
    m.releve_id, f.id, f.geometry, f."Site", f."DATE", f."OBSERVAT", f."ORGANISM"
FROM habitats.t_fusion_habitats_vegetation f
JOIN _map_releve m ON m.src_ctid = f.ctid;

INSERT INTO habitats.t_releve_metadonnee
    (releve_id, natu_obs, unit_vege, echelle, grand_type, legende, ec_exp, comm_exp,
     gestion, gestion_b, grille_ec, note_ec, alt_obs, alt_grille, enjeu_flore)
SELECT
    m.releve_id, f."NATU_OBS", f."UNIT_VEGE", f."ECHELLE", f."GRAND_TYPE", f."LEGENDE", f."EC_EXP", f."COMM_EXP",
    f."GESTION", f."GESTION_B", f."GRILLE_EC", f."NOTE_EC", f."ALT_OBS", f."ALT_GRILLE", f."ENJEU_FLORE"
FROM habitats.t_fusion_habitats_vegetation f
JOIN _map_releve m ON m.src_ctid = f.ctid;

-- Occurrences : les quatre blocs TYPO_MER_i / POUR_HAB_i deviennent des lignes.
-- * Les typo_mer absents du dictionnaire mettent renvoient une erreur lors de l'insertion dans la table t_habitat_occurrence
--   un script est disponible pour checker leur présence dans controle_migration.sql.
-- * Quand un même typo_mer figure sur deux rangs d'un même polygone, les
--   pourcentages sont additionnés ; enjeu_pnm prend la première valeur non nulle.
WITH occurrences_brutes AS (
    SELECT m.releve_id, f."TYPO_MER_1" AS typo_mer_id, f."POUR_HAB_1" AS pour_hab, f."ENJEU_PNM_1" AS enjeu_pnm
    FROM habitats.t_fusion_habitats_vegetation f
    JOIN _map_releve m ON m.src_ctid = f.ctid
    WHERE f."TYPO_MER_1" IS NOT NULL  --IN (SELECT code_typo_mer FROM habitats.dico_typo_mer)

    UNION ALL

    SELECT m.releve_id, f."TYPO_MER_2", f."POUR_HAB_2", f."ENJEU_PNM_2"
    FROM habitats.t_fusion_habitats_vegetation f
    JOIN _map_releve m ON m.src_ctid = f.ctid
    WHERE f."TYPO_MER_2" IS NOT NULL  --IN (SELECT code_typo_mer FROM habitats.dico_typo_mer)

    UNION ALL

    SELECT m.releve_id, f."TYPO_MER_3", f."POUR_HAB_3", f."ENJEU_PNM_3"
    FROM habitats.t_fusion_habitats_vegetation f
    JOIN _map_releve m ON m.src_ctid = f.ctid
    WHERE f."TYPO_MER_3" IS NOT NULL  --IN (SELECT code_typo_mer FROM habitats.dico_typo_mer)

    UNION ALL

    SELECT m.releve_id, f."TYPO_MER_4", f."POUR_HAB_4", NULL
    FROM habitats.t_fusion_habitats_vegetation f
    JOIN _map_releve m ON m.src_ctid = f.ctid
    WHERE f."TYPO_MER_4" IS NOT NULL  --IN (SELECT code_typo_mer FROM habitats.dico_typo_mer)
)
INSERT INTO habitats.t_habitat_occurrence (releve_id, typo_mer_id, pour_hab, enjeu_pnm)
SELECT
    releve_id,
    typo_mer_id,
    SUM(pour_hab),
    (array_agg(enjeu_pnm) FILTER (WHERE enjeu_pnm IS NOT NULL))[1]
FROM occurrences_brutes
GROUP BY releve_id, typo_mer_id;

DROP TABLE _map_releve;

COMMIT;

-- Ensuite : lancer controle_migration.sql, puis vues.sql.
