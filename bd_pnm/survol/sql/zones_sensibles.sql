 WITH periodes_aigle AS (
         WITH aigle AS (
                 SELECT st_buffer(c_aires.geom, 500::double precision) AS geom
                   FROM bd_aigle_royal.c_aires
                     LEFT JOIN bd_aigle_royal.t_suivi_repro suivi USING (id_aire)
                     JOIN bd_aigle_royal.tr_codes_repro tcr USING (id_code_repro)
                  WHERE suivi.annee > 2012 AND tcr.enjeu_repro > 0
                  GROUP BY c_aires.id_aire
                ), periode AS (
                 SELECT DISTINCT unnest(string_to_array(cis.aigle, ','::text)) AS mois
                   FROM survol.t_calendrier_interdiction_survol_cis cis
                )
         SELECT aigle.geom,
            periode.mois
           FROM aigle,
            periode
        ), periodes_vautour AS (
         WITH vautour AS (
                 SELECT st_buffer(c_vautour_fauve_dortoir_vfd.geom, 500::double precision) AS geom
                   FROM faune.c_vautour_fauve_dortoir_vfd
                ), periode AS (
                 SELECT DISTINCT unnest(string_to_array(cis.vautour, ','::text)) AS mois
                   FROM survol.t_calendrier_interdiction_survol_cis cis
                  WHERE cis.activite = 'Estive'::text
                )
         SELECT vautour.geom,
            periode.mois
           FROM vautour,
            periode
        ), periodes_gypaete AS (
         WITH gypaete AS (
                 SELECT c_gypaete_barbu_zone_vigilance_gbz.geom
                   FROM faune.c_gypaete_barbu_zone_vigilance_gbz
                ), periode AS (
                 SELECT DISTINCT unnest(string_to_array(cis.gypaete, ','::text)) AS mois
                   FROM survol.t_calendrier_interdiction_survol_cis cis
                  WHERE cis.activite = 'Prospection territoriale'::text
                )
         SELECT gypaete.geom,
            periode.mois
           FROM gypaete,
            periode
        ), periodes_lagopede AS (
         WITH lagopede AS (
                 SELECT c_lago_zone_repro_lzr.geom
                   FROM faune.c_lago_zone_repro_lzr
                ), periode AS (
                 SELECT DISTINCT unnest(string_to_array(cis.lagopede, ','::text)) AS mois
                   FROM survol.t_calendrier_interdiction_survol_cis cis
                  WHERE cis.activite = ANY (ARRAY['Manifestations territoriales'::text, 'Ponte - Couvaison'::text])
                )
         SELECT lagopede.geom,
            periode.mois
           FROM lagopede,
            periode
        ), periodes_bouquetin_hivernage AS (
         WITH bouquetin AS (
                 SELECT c_bouquetin_zone_hivernage_bzh.geom
                   FROM faune.c_bouquetin_zone_hivernage_bzh
                  WHERE c_bouquetin_zone_hivernage_bzh.annee_donnee >= 2017
                ), periode AS (
                 SELECT DISTINCT unnest(string_to_array(cis.bouquetin, ','::text)) AS mois
                   FROM survol.t_calendrier_interdiction_survol_cis cis
                  WHERE cis.activite = 'Hivernage'::text
                )
         SELECT bouquetin.geom,
            periode.mois
           FROM bouquetin,
            periode
        ), periodes_bouquetin_misebas AS (
         WITH bouquetin AS (
                 SELECT c_ongules_misebas_com.geom
                   FROM faune.c_ongules_misebas_com
                  WHERE c_ongules_misebas_com.enjeux::text ~~ '%bouquetin%'::text
                ), periode AS (
                 SELECT DISTINCT unnest(string_to_array(cis.bouquetin, ','::text)) AS mois
                   FROM survol.t_calendrier_interdiction_survol_cis cis
                  WHERE cis.activite = 'Mise bas'::text
                )
         SELECT bouquetin.geom,
            periode.mois
           FROM bouquetin,
            periode
        ), periodes_chamois_misebas AS (
         WITH chamois AS (
                 SELECT c_ongules_misebas_com.geom
                   FROM faune.c_ongules_misebas_com
                  WHERE c_ongules_misebas_com.enjeux::text ~~ '%chamois%'::text
                ), periode AS (
                 SELECT DISTINCT unnest(string_to_array(cis.chamois, ','::text)) AS mois
                   FROM survol.t_calendrier_interdiction_survol_cis cis
                  WHERE cis.activite = 'Mise bas'::text
                )
         SELECT chamois.geom,
            periode.mois
           FROM chamois,
            periode
        ), periodes_tetralyre_hivernage AS (
         WITH tetralyre AS (
                 SELECT st_buffer(c_tly_zone_quietude_tzq.geom, 100::double precision) AS geom
                   FROM faune.c_tly_zone_quietude_tzq
                ), periode AS (
                 SELECT DISTINCT unnest(string_to_array(cis.tetralyre, ','::text)) AS mois
                   FROM survol.t_calendrier_interdiction_survol_cis cis
                  WHERE cis.activite = 'Hivernage'::text
                )
         SELECT tetralyre.geom,
            periode.mois
           FROM tetralyre,
            periode
        ), periodes_tetralyre_repro AS (
         WITH tetralyre AS (
                 SELECT st_buffer(c_tly_quartier_comptage_chant_tqc.geom, 100::double precision) AS geom
                   FROM faune.c_tly_quartier_comptage_chant_tqc
                ), periode AS (
                 SELECT DISTINCT unnest(string_to_array(cis.tetralyre, ','::text)) AS mois
                   FROM survol.t_calendrier_interdiction_survol_cis cis
                  WHERE cis.activite = 'Manifestations territoriales'::text
                )
         SELECT tetralyre.geom,
            periode.mois
           FROM tetralyre,
            periode
        ), toutes_especes AS (
         SELECT periodes_aigle.geom,
            periodes_aigle.mois
           FROM periodes_aigle
        UNION
         SELECT periodes_vautour.geom,
            periodes_vautour.mois
           FROM periodes_vautour
        UNION
         SELECT periodes_gypaete.geom,
            periodes_gypaete.mois
           FROM periodes_gypaete
        UNION
         SELECT periodes_lagopede.geom,
            periodes_lagopede.mois
           FROM periodes_lagopede
        UNION
         SELECT periodes_bouquetin_hivernage.geom,
            periodes_bouquetin_hivernage.mois
           FROM periodes_bouquetin_hivernage
        UNION
         SELECT periodes_bouquetin_misebas.geom,
            periodes_bouquetin_misebas.mois
           FROM periodes_bouquetin_misebas
        UNION
         SELECT periodes_chamois_misebas.geom,
            periodes_chamois_misebas.mois
           FROM periodes_chamois_misebas
        UNION
         SELECT periodes_tetralyre_hivernage.geom,
            periodes_tetralyre_hivernage.mois
           FROM periodes_tetralyre_hivernage
        UNION
         SELECT periodes_tetralyre_repro.geom,
            periodes_tetralyre_repro.mois
           FROM periodes_tetralyre_repro
        )
 SELECT toutes_especes.mois,
    st_union(toutes_especes.geom) AS geom
   FROM toutes_especes
  GROUP BY toutes_especes.mois
  ORDER BY toutes_especes.mois;