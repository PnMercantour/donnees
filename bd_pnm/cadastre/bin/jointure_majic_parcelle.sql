

/*

Pour les données 2023 issues d'Etalab et de datagouv
https://www.data.gouv.fr/fr/datasets/fichiers-des-locaux-et-des-parcelles-des-personnes-morales/

Les numéros de parcelles permettant de faire la jointure entre le PCI et le fichier des personnes morales est structuré de la façon suivante
|Département|Commune (lpad, '0',3)|prefixe (lpad, '0',3)|section|numéro plan(lpad, '0',4)|
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
	lpad("section"::varchar,2,'0'),
	lpad(morale.plan::varchar, 4,'0'))  
