/*
-- Construction de l'identifiant des parcelles

Pour les données 2023 issues d'Etalab et de datagouv
https://www.data.gouv.fr/fr/datasets/fichiers-des-locaux-et-des-parcelles-des-personnes-morales/

Les numéros de parcelles permettant de faire la jointure entre le PCI et le fichier des personnes morales est structuré de la façon suivante
|Département  (lpad, '0',2)|Commune (lpad, '0',3)|prefixe (lpad, '0',3)|section  (lpad, '0',2)|numéro plan(lpad, '0',4)|
|:--:|:--:|:--:|:--:|:--:
|06|114|000|AA|0262||

Ce qui se traduit par la requête suivante pour réaliser une jointure.
(Par commodité, dans la table cadastre_personne_morale, le champs "id_parcelle" a été ajouté pour réaliser la jointure)
*/

SELECT * from cadastre.cadastre_parcelle parcelle
JOIN cadastre.cadastre_personne_morale morale
ON = parcelle.id = concat(
	'0', morale.departement::varchar, 
	lpad(morale.code_commune::varchar,3,'0') , 
	lpad(replace(morale.prefixe::varchar,' ',''),3,  '0' ),
	lpad(morale."section"::varchar,2,'0'),
	lpad(morale.plan::varchar, 4,'0'))  

/*
Deux vues ont été créées pour arriver à la jointure des géométries et données de propriétés.
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

-- Vue cadastre_parcelle_proprietaire
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
