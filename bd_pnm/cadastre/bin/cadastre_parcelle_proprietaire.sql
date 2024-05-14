/*
Deux vues ont été créées. 
La première est une étape du processus permet de n'avoir qu'une ligne par parcelle, les colonnes donnent les informations de propriétés.
La deuxième a vocation a être consultée directement. Elle fait la jointure avec la première vue, et associe à chaque parcelle une géométrie et un code commune.
Le "LEFT JOIN" permet de conserver les parcelles auxquelles aucune information de propriété n'est associée.
*/
-- Vue personne_morale_regroupee
 SELECT cpm.id_parcelle,
    string_agg(DISTINCT cpm.denomination_proprietaire_parcelle::text, ' - '::text) FILTER (WHERE cpm.code_droit_proprietaire::text = 'P'::text) AS proprietaire,
    string_agg(DISTINCT cpm.denomination_proprietaire_parcelle::text, ' - '::text) FILTER (WHERE cpm.code_droit_proprietaire::text = 'Z'::text) AS gestionnaire_bien_de_l_etat,
    string_agg(DISTINCT cpm.denomination_proprietaire_parcelle::text, ' - '::text) FILTER (WHERE cpm.code_droit_proprietaire::text = 'G'::text) AS gerant_mandataire_gestionnaire,
    string_agg(DISTINCT cpm.denomination_proprietaire_parcelle::text, ' - '::text) FILTER (WHERE cpm.code_droit_proprietaire::text = 'B'::text) AS bailleur_a_construction,
    string_agg(DISTINCT cpm.denomination_proprietaire_parcelle::text, ' - '::text) FILTER (WHERE cpm.code_droit_proprietaire::text = 'R'::text) AS preneur_a_construction,
    string_agg(DISTINCT cpm.denomination_proprietaire_parcelle::text, ' - '::text) FILTER (WHERE cpm.code_droit_proprietaire::text = 'E'::text) AS emphytheote,
    string_agg(DISTINCT cpm.denomination_proprietaire_parcelle::text, ' - '::text) FILTER (WHERE cpm.code_droit_proprietaire::text = 'S'::text) AS syndic_de_copropriete,
    string_agg(DISTINCT cpm.denomination_proprietaire_parcelle::text, ' - '::text) FILTER (WHERE cpm.code_droit_proprietaire::text = 'N'::text) AS nu_proprietaire,
    string_agg(DISTINCT cpm.denomination_proprietaire_parcelle::text, ' - '::text) FILTER (WHERE cpm.code_droit_proprietaire::text = 'U'::text) AS usufruitier
   FROM cadastre.cadastre_personne_morale cpm
  GROUP BY cpm.id_parcelle;

-- Vue personne_morale_regroupee
 SELECT mr.id_parcelle,
    cp.commune,
    mr.proprietaire,
    mr.gestionnaire_bien_de_l_etat,
    mr.gerant_mandataire_gestionnaire,
    mr.bailleur_a_construction,
    mr.preneur_a_construction,
    mr.emphytheote,
    mr.syndic_de_copropriete,
    mr.nu_proprietaire,
    mr.usufruitier,
    cp.geom::geometry(MultiPolygon,2154) AS geom
   FROM cadastre.cadastre_parc cp
     LEFT JOIN cadastre.personne_morale_regroupe mr ON mr.id_parcelle::text = cp.id::text;
