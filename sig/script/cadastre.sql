## CODE CREATION TABLE CADASTRE LISIBLE
```sql
-- View: cadastre.cadastre_parcelle_proprietaire

-- DROP MATERIALIZED VIEW IF EXISTS cadastre.cadastre_parcelle_proprietaire;

CREATE MATERIALIZED VIEW IF NOT EXISTS cadastre.cadastre_parcelle_proprietaire
TABLESPACE pg_default
AS
 SELECT sub.id_parcelle,
    lpad(max(sub.departement::text)::character varying::text, 2, '0'::text) AS departement,
    lpad(max(sub.code_commune::text)::character varying::text, 3, '0'::text) AS code_commune,
    max(sub.nom_commune::text) AS nom_commune,
    string_agg(DISTINCT sub.denomination_proprietaire_parcelle::text, ' - '::text) FILTER (WHERE sub.code_droit_proprietaire::text = 'P'::text) AS proprietaire,
    string_agg(DISTINCT sub.denomination_proprietaire_parcelle::text, ' - '::text) FILTER (WHERE sub.code_droit_proprietaire::text = 'Z'::text) AS gestionnaire_bien_de_l_etat,
    string_agg(DISTINCT sub.denomination_proprietaire_parcelle::text, ' - '::text) FILTER (WHERE sub.code_droit_proprietaire::text = 'G'::text) AS gerant_mandataire_gestionnaire,
    string_agg(DISTINCT sub.denomination_proprietaire_parcelle::text, ' - '::text) FILTER (WHERE sub.code_droit_proprietaire::text = 'B'::text) AS bailleur_a_construction,
    string_agg(DISTINCT sub.denomination_proprietaire_parcelle::text, ' - '::text) FILTER (WHERE sub.code_droit_proprietaire::text = 'R'::text) AS preneur_a_construction,
    string_agg(DISTINCT sub.denomination_proprietaire_parcelle::text, ' - '::text) FILTER (WHERE sub.code_droit_proprietaire::text = 'E'::text) AS emphytheote,
    string_agg(DISTINCT sub.denomination_proprietaire_parcelle::text, ' - '::text) FILTER (WHERE sub.code_droit_proprietaire::text = 'S'::text) AS syndic_de_copropriete,
    string_agg(DISTINCT sub.denomination_proprietaire_parcelle::text, ' - '::text) FILTER (WHERE sub.code_droit_proprietaire::text = 'N'::text) AS nu_proprietaire,
    string_agg(DISTINCT sub.denomination_proprietaire_parcelle::text, ' - '::text) FILTER (WHERE sub.code_droit_proprietaire::text = 'U'::text) AS usufruitier,
    sub.geom::geometry(MultiPolygon,2154) AS geom
   FROM ( SELECT cpm.id,
            cpm.departement,
            cpm.code_direction,
            cpm.code_commune,
            cpm.nom_commune,
            cpm.prefixe,
            cpm.section,
            cpm.plan,
            cpm.numero_voirie,
            cpm.indice_repetition,
            cpm.code_voie_majic,
            cpm.code_voie_rivoli,
            cpm.nature_voie,
            cpm.nom_voie,
            cpm.contenance_parcelle,
            cpm.evaluation_suf,
            cpm.nature_culture_suf,
            cpm.contenance_suf,
            cpm.code_droit_proprietaire,
            cpm.numero_majic,
            cpm.numero_siren,
            cpm.groupe_personne_proprietaire,
            cpm.forme_juridique,
            cpm.forme_juridique_abregee,
            cpm.denomination_proprietaire_parcelle,
            cpm.id_parcelle,
            cp.geom
           FROM cadastre.cadastre_personne_morale cpm
             JOIN cadastre.cadastre_parc cp ON cp.id::text = cpm.id_parcelle::text) sub
  GROUP BY sub.id_parcelle, sub.geom
WITH DATA;

ALTER TABLE IF EXISTS cadastre.cadastre_parcelle_proprietaire
    OWNER TO admin;


CREATE INDEX sidx_cadastre_proprietaire
    ON cadastre.cadastre_parcelle_proprietaire USING gist
    (geom)
    TABLESPACE pg_default;
```