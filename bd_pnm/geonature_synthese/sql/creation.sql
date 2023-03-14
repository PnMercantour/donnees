
-- Vue materialisee observation_taxonomie_grille
-- lien entre les tables qui seront ensuite accessibles par des vues
CREATE MATERIALIZED VIEW gn_observation.observation_taxonomie_grille as (
 SELECT s_1.id_synthese,
    taxref.cd_ref,
    grid.id AS maille,
    st_centroid(s_1.the_geom_local) AS geom
   FROM limites.grid,
    gn_synthese.synthese s_1
     LEFT JOIN taxonomie.taxref USING (cd_nom)
  WHERE s_1.id_nomenclature_info_geo_type = 
			ref_nomenclatures.get_id_nomenclature(
				'TYP_INF_GEO'::character varying, '1'::character varying) 
  AND st_centroid(s_1.the_geom_local) && grid.geom 
  AND st_x(st_centroid(s_1.the_geom_local)) < st_xmin(st_centroid(grid.geom)::box3d) 
  AND st_y(st_centroid(s_1.the_geom_local)) < st_ymin(st_centroid(grid.geom)::box3d) 
  AND st_area(s_1.the_geom_local) < 600000::double precision 
  AND st_length(s_1.the_geom_local) < 600::double precision) ;

-- ----------------------------------------------------------------------------------------------------
-- Vue detail
-- ensemble des informations en detail
CREATE VIEW geonature_synthese.detail as (SELECT id_synthese,
    sap.cd_nom,
    taxref.cd_ref,
    taxref.regne,
    taxref.phylum,
    taxref.classe,
    COALESCE(patrimoniale IS NOT NULL, FALSE) AS patrimoniale,
	COALESCE(protegee IS NOT NULL, FALSE) AS protegee,
	id_grid,
	surface_coeur,
    surface_aire_adhesion,
    surface_aoa,
    surface_vallee,
    nom_vallee,
    date_min,
    date_max,
    count_min,
    count_max,
    ref_nomenclatures.get_nomenclature_label (id_nomenclature_geo_object_nature) AS nat_obj_geo,
    ref_nomenclatures.get_nomenclature_label (id_nomenclature_grp_typ) AS typ_grp,
    ref_nomenclatures.get_nomenclature_label (id_nomenclature_obs_technique) AS meth_obs,
    ref_nomenclatures.get_nomenclature_label (id_nomenclature_bio_status) AS statut_bio,
    ref_nomenclatures.get_nomenclature_label (id_nomenclature_bio_condition) AS eta_bio,
    ref_nomenclatures.get_nomenclature_label (id_nomenclature_naturalness) AS naturalite,
    ref_nomenclatures.get_nomenclature_label (id_nomenclature_exist_proof) AS preuve_exist,
    ref_nomenclatures.get_nomenclature_label (id_nomenclature_valid_status) AS statut_valid,
    ref_nomenclatures.get_nomenclature_label (id_nomenclature_diffusion_level) AS niv_precis,
    ref_nomenclatures.get_nomenclature_label (id_nomenclature_life_stage) AS stade_vie,
    ref_nomenclatures.get_nomenclature_label (id_nomenclature_sex) AS sexe,
    ref_nomenclatures.get_nomenclature_label (id_nomenclature_obj_count) AS obj_denbr,
    ref_nomenclatures.get_nomenclature_label (id_nomenclature_type_count) AS typ_denbr,
    ref_nomenclatures.get_nomenclature_label (id_nomenclature_sensitivity) AS sensibilite,
    ref_nomenclatures.get_nomenclature_label (id_nomenclature_observation_status) AS statut_obs,
    ref_nomenclatures.get_nomenclature_label (id_nomenclature_blurring) AS dee_flou,
    ref_nomenclatures.get_nomenclature_label (id_nomenclature_source_status) AS statut_source,
    ref_nomenclatures.get_nomenclature_label (id_nomenclature_info_geo_type) AS type_inf_geo,
    ref_nomenclatures.get_nomenclature_label (id_nomenclature_determination_method) AS meth_determin,
    ref_nomenclatures.get_nomenclature_label (id_nomenclature_behaviour) AS occ_comportement,
    ref_nomenclatures.get_nomenclature_label (id_nomenclature_biogeo_status) AS stat_biogeo


FROM geonature_synthese.observation_grille_taxonomie
	LEFT JOIN gn_synthese.synthese_avec_partenaires AS sap USING (id_synthese)
    LEFT JOIN taxonomie.taxref USING (cd_nom)
    LEFT JOIN taxonomie.v_taxref_pp USING (cd_nom)
	LEFT JOIN limites.grid on observation_grille_taxonomie.id_grid = grid.id
	);

-- ----------------------------------------------------------------------------------------------------
-- Deux vues aggregation_groupe*_inpn_maille
-- aggregation des donnee pour chaque groupe inpn et par maille
CREATE geonature_synthese.aggregation_groupe1_inpn_maille AS ( SELECT detail.group1_inpn,
    detail.maille,
    count(*) AS n_obs,
    max(grid.geom::text) AS geom
   FROM geonature_synthese.detail
     LEFT JOIN limites.grid ON grid.id = detail.maille
  GROUP BY detail.group1_inpn, detail.maille);

-- ----------------------------------------------------------------------------------------------------
-- Vue aggregation_maille_an
-- aggregation des cd_ref par maille et par an
CREATE VIEW geonature_synthese.aggregation_maille_an
 SELECT detail.maille,
    detail.cd_ref,
    date_part('year'::text, detail.date_min) AS year_min,
    count(detail.id_synthese) AS n_obs,
    sum(detail.count_min) AS sum_min,
    sum(detail.count_max) AS sum_max,
    min(detail.patrimoniale::integer)::boolean AS patrimoniale,
    min(detail.protegee::integer)::boolean AS protegee,
    max(detail.surface_coeur) AS surface_coeur,
    max(detail.surface_aire_adhesion) AS surface_aire_adhesion,
    max(detail.surface_aoa) AS surface_aoa,
    max(detail.nom_vallee::text) AS nom_vallee,
    max(grid.geom::text) AS geom
   FROM geonature_synthese.detail
     LEFT JOIN limites.grid ON grid.id = detail.maille
  WHERE date_part('year'::text, detail.date_min) = date_part('year'::text, detail.date_max)
  GROUP BY detail.maille, detail.cd_ref, (date_part('year'::text, detail.date_min));

-- ----------------------------------------------------------------------------------------------------
-- Vue taxon_patrimonial_protege
CREATE geonature.taxon_patrimonial_protege AS (
    WITH patrimoniale AS (
             SELECT cor_taxon_attribut.cd_ref
               FROM taxonomie.cor_taxon_attribut
                 JOIN taxonomie.bib_attributs ba USING (id_attribut)
              WHERE ba.nom_attribut::text = 'patrimonial'::text AND cor_taxon_attribut.valeur_attribut = 'oui'::text
            ), 
         protegee AS (
             SELECT cor_taxon_attribut.cd_ref
               FROM taxonomie.cor_taxon_attribut
                 JOIN taxonomie.bib_attributs ba USING (id_attribut)
              WHERE ba.nom_attribut::text = 'protection_stricte'::text AND cor_taxon_attribut.valeur_attribut = 'oui'::text
            )
     SELECT DISTINCT ON (cd_ref) cd_ref,
        taxref.nom_valide,
        COALESCE(patrimoniale.cd_ref IS NOT NULL, false) AS patrimoniale,
        COALESCE(protegee.cd_ref IS NOT NULL, false) AS protegee
       FROM patrimoniale
         FULL JOIN protegee USING (cd_ref)
         LEFT JOIN taxonomie.taxref USING (cd_ref)
      ORDER BY cd_ref;