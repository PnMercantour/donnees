# ag_pasto

## Description
 _Description générale du schéma: quel type d'information, pour quelles utilisations, de quelles sources_

 Ce schéma contient les données liées à l'agro-pastoralisme dans le parc du mercantour. 



## Tables remarquables



### Brulages dirigés:  ag_pasto.c_brulages_diriges_bru
Ensemble des brulages dirigés opérés sur les années 2012, 2014, 2016 et 2017 sur le territoire de l'aire d'adhésion optimale du Parc National du Mercantour.

#### Description des colonnes remarquables

|Nom 	|Définition|
|:--:|:--:|
|id  (int4) 	|Identifiant unique|
|nom  (text) 	|Nom du lieu dit où est réalisé le brulage|
|up_id  (int4)| 	Unité pastorale concernée (Clé étrangère)|
|annee  (int4) 	|Année du brulage|
|avis  (text) 	|Avis favorable ou défavorable donné|
|demandeur  (text)|Personne ayant demandé le brulage|
|objectif  (text)| 	Objectif du brulage|
|commentaire  (text) 	|Commentaire libre |




Résolution 	    30 m

lien: https://catalogue.parcnational.fr/catalogue/pnm/fre/catalog.search#/metadata/9ade3346-9d12-43de-a1bb-42930cfcd4f7
Généalogie 	

Données issues de Force06, compilés.
(SCV Nicolas Manié 2017).

###  Conventions de Pâturage Pluri-annuelles : c_convention_paturage_cpa 
Ensemble des dernières versions des CPP (Conventions de Pâturage Pluri-annuelles) connues pour chaque alpage situé dans la zone optimale d'adhésion du PNM (Parc National du Mercantour).

#### Description des colonnes remarquables


|Nom 	|Définition|
|:--:|:--:|
|id  (int4) 	|Identifiant unique|
|locataire  (int4) 	|Exploitant signataire du contrat (Clé étrangère)|
|type_location  (int4) 	|Type de contrat (Clé étrangère)|
|unite_pastorale_1  (int4)| 	|Unité pastorale principalement concernée (Clé étrangère)|
|commune  (int4) 	|Commune sur laquelle se trouve le terrain loué (Clé étrangère)|
|surface_location  (float4)| 	|Surface louée (ha)|
|surface_reelement_paturable  (float4)| 	|Surface paturable louée (ha)|
|journees_max_paturage  (int4)| 	|Nombre maximum de journées de paturage souhaitées|
|debut_contractualisation  (date)| 	|Date de début d'application du contrat|
|fin_contractualisation  (date)| 	|Date de fin d'application du contrat|
|montant  (float4)| 	|Montant du contrat (€)|
|effectif_bovin  (float4)| 	|Effectif bovin souhaité|
|effectif_caprin  (float4)| 	Effectif caprin souhaité|
|effectif_equin  (float4)| 	Effectif équin souhaité|
|effectif_ovin  (float4) |	Effectif ovin souhaité|
|effectif_porcin  (float4)| 	Effectif procin souhaité|
|effectif_total  (float4) |	Effectif total souhaité (UGB)|
|periode_paturage_1_debut  (date)| 	Date de début de la première utilisation de l'unité pastorale|
|periode_paturage_1_fin  (date) 	|Date de fin de la première utilisation de l'unité pastorale|
|periode_paturage_2_debut  (date) 	|Date de début de la deuxième utilisation de l'unité pastorale|
|periode_paturage_2_fin  (date) 	|Date de début de la deuxième utilisation de l'unité pastorale|
|commentaire  (text) 	|Commentaire libre|
|statut  (int4) 	|Nature des documents en possession du Parc National du Mercantour (Clé étrangère)|
|unite_pastorale_2  (int4) 	|Unité pastorale minoritairement concernée (Clé étrangère) |



Résolution 	30 m
#### Généalogie 
Données issues des contrats entre une commune et/ou l'ONF, l'exploitant et le PNM.
Données géographiques déterminées sur la base des données parcellaires cadastrales et forestière, ou à défaut, sur carte IGN au 1/250000ème.
L'identité des exploitants est anonymisé par une clé d'identifiant unique.
Données produites dans le cadre d'une compilation / correction du jeu de données thématique et des conventions papiers (SCV Nicolas Manié 2017).







###  Défens du Parc national du Mercantour : c_defen_def 
Ensemble des défens connus, définis comme tel dans les CPP (Conventions de Pâturage Pluri-annuelles) des alpages situés dans la zone optimale d'adhésion du PNM (Parc National du Mercantour).


#### Généalogie 

Données issues des contrats entre une commune et/ou l'ONF, l'exploitant et le PNM.
Données géographiques déterminées sur la base des données parcellaires cadastrales et forestière, ou à défaut, sur carte IGN au 1/250000ème.
Données produites dans le cadre d'une compilation / correction du jeu de données thématique et des conventions papiers (SCV Nicolas Manié 2017).

Résolution: 30 m



### Mesures agro-environnementales de gestion pastorale: c_mesure_gestion_pastorale_meg
Ensemble des mesures HE09 (gestion pastorale) contenues dans les contrats MAE (Mesures Agro-Environnementales) créées par le Parc National du Mercantour.

#### Description des colonnes remarquables

|Nom 	|Définition|
|:--:|:--:|
|id  (int4) 	|Identifiant unique|
|maec  (int4) 	Contrat de mesures dans lequel est énoncé la mesure (Clé étrangère)|
|type_mesure_gestion  (int4) 	Typologie de la mesure de gestion (Clé étrangère)|
|surface  (float4) 	Surface concernée par la mesure|
|mesure  (text) 	Engagement du bénéficiaire|
|commentaire  (text) 	Commentaire libre, contient des précisions sur l'objectif de la mesure |



#### Généalogie 	

Données issues des contrats MAE (Mesures Agro-Environnementales) créées par le Parc National du Mercantour.
Données géographiques déterminées sur la base des données parcellaires cadastrales et forestière, ou à défaut, sur carte IGN au 1/250000ème.
Données produites dans le cadre d'une compilation / correction du jeu de données thématique et des contrats papiers (SCV Nicolas Manié 2017).

Résolution 	30 m


### Mesures agro-environnementales de gestion des prairies: c_mesure_pres_fauche_mep 
Ensemble des mesures HE07 (prairies fleuries) et HE08 (fauche à pied) contenues dans les contrats MAE (Mesures Agro-Environnementales) créées par le Parc National du Mercantour.

#### Description des colonnes remarquables
|Nom 	|Définition|
|:--:|:--:|
|id  (int4) 	|Identifiant unique|
|surface  (float4) 	|Surface concernée par la mesure|
|commentaire  (text) |	Commentaire libre|
|prairie  (int4) 	|Prairie sur laquelle est réalisée la mesure (Clé étrangère)|
|engagement_unitaire  (int4) |	Engagement unitaire concerné (Clé étrangère)|
|debut_contractualisation  (date) 	|Date de début d'application du contrat|
|fin_contractualisation  (date) 	|Date de fin d'application du contrat|
|montant_contrat  (float4) 	|Montant du contrat (€)|
|pac_parcelle_engagee  (text) |	Numéro d'ilot et de parcelle engagée tel que défini dans la déclaration PAC|
|pacage  (text) 	|Numéro de déclarant PAC|
|avenant  (bool) 	|Existence d'un avenant |

#### Généalogie 	

Données issues des contrats MAE (Mesures Agro-Environnementales) créées par le Parc National du Mercantour.
Données géographiques déterminées sur la base des données parcellaires cadastrales et forestière, ou à défaut, sur carte IGN au 1/250000ème.
Données produites dans le cadre d'une compilation / correction du jeu de données thématique et des contrats papiers (SCV Nicolas Manié 2017).


Résolution: 30 m


###  obs_priorite_maec
Observations des espèces de flore du Docob de geonature de la Stratégie flore niveau 1 et 2 de priorité, + 3 espèces : 
- Reine des Alpes
- Fritillaire de Moggridge
- Rossolis à feuilles rondes (Drosera)
<!--NB: Couche A VERIFIER APRES INTEGRATION DU DOCOB.  -->

Filtre important sur cette couche pour le plan de gestion maec
extract(year from date_min)>2000 AND
("priorite" < 3 AND
("protegee" = 'true' OR 
"ic" = 'true')) or 
"cd_ref" in (97133, 95442, 98978)

###  Parcelles visitées lors du concours Prairies Fleuries: c_parcelles_visitees_pf_vis 

#### Description des colonnes remarquables
|Nom 	|Définition|
|:--:|:--:|
|id  (int4) |	Identifiant unique|
|prairie_id  (int4) 	|Prairie visitée (Clé étrangère)|
|annee  (int4) 	|Année de la visite|
commentaire  (text) 	|Commentaire libre|
|id_agriculteur  (int4) 	|Exploitant participant au concours prairies fleuries (Clé étrangère) |

#### Généalogie 	

Données issues d'une compilation / correction du jeu de données thématique existant.
(SCV Nicolas Manié 2017).
Résolution: 30 m



### Prairies du Parc national du Mercantour : c_prairie_pra

Ensemble des prairies répertoriées et situés dans la zone optimale d'adhésion du PNM (Parc National du Mercantour).


#### Description des colonnes remarquables
|Nom 	|Définition|
|:--:|:--:|
|id  (int4) 	|Identifiant unique|
|exploitant  (int4) 	|Exploitant de la prairie (Clé étrangère)|
|irrigation  (int4) 	|Moyens d'irrigation de la prairie (Clé étrangère)|
|nom  (text) 	|Nom de référence de la prairie|
|surface  (float4) 	|Surface de la prairie (ha)|
|nombre_fauche  (float4) 	|Nombre de fauches réalisés dans l'année|
|deprimage  (bool) 	|Déprimage utilisé ou non|
|paturage  (bool) 	|Pâturage ou non|
|mecanisable  (bool) 	|Fauche mécanisable ou non|
|eligible_maec_4_fleurs  (bool) 	|Prairie pouvant prétendre à l'établissement d'une Mesure Agro-Environnementale HE07 - Prairies Fleuries|
|effectif_bovin  (float4) 	|Effectif bovin souhaité|
|effectif_caprin  (float4) 	|Effectif caprin souhaité|
|effectif_equin  (float4) 	|Effectif équin souhaité|
|effectif_ovin  (float4) 	|Effectif ovin souhaité|
|effectif_porcin  (float4) 	|Effectif porcin souhaité|
|commentaire  (text) 	|Commentaire libre|
|fertilisation  (int4) 	|Fertilisants utilisés ou non|
|date_fauche_1  (text) 	|Date de la première fauche|
|date_fauche_2  (text) 	|Date de la deuxième fauche|
|date_fauche_3  (text) 	|Date de la troisième fauche |


#### Généalogie 	
 	

Ensemble des prairies répertoriées lors d'un inventaire initial en 2010, puis complété et mis à jour lors de la création de ce jeu de données.
Les prairies sont toutessitués dans la zone optimale d'adhésion du PNM (Parc National du Mercantour).
L'identité des exploitants est anonymisé par une clé d'identifiant unique.
(SCV Nicolas Manié 2017)

Résolution : 30m


### Unités pastorales du Parc national du Mercantour : c_unite_pastorale_unp
Ensemble des unités pastorales répertoriées et situés dans la zone optimale d'adhésion du PNM (Parc National du Mercantour).

#### Description des colonnes remarquables
|Nom 	|Définition|
|:--:|:--:|
|id  (int4) 	|Identifiant unique|
|nom  (text) 	|Nom de référence de l'unité pastorale|
|commentaire  (text) |	Commentaire libre|
|commune  (int4) 	|Commune sur laquelle la majoritée de l'unité pastorale est implentée (Clé étrangère) |


#### Généalogie 	

Ensemble des unités pastorales issus du jeu de donnée thématique, complété et mis à jour lors de la création de ce jeu de données. Les unités pastorales sont toutes situés dans la zone optimale d'adhésion du PNM (Parc National du Mercantour). L'identité des exploitants est anonymisé par une clé d'identifiant unique.
(SCV Nicolas Manié 2017)


Résolution: 30 m




### Contacts sur les unités pastorales : t_contact_up_cup 
Données d'actualisation générées suite à la visite d'une unité pastorale située dans la zone optimale d'adhésion du PNM (Parc National du Mercantour).


#### Description des colonnes remarquables
|Nom 	|Définition|
|:--:|:--:|
|id  (int4) 	|Identifiant unique|
|date  (date) 	|Date du contact|
|objet  (text) 	|Motif du contact|
|commentaire  (text) 	|Commentaire libre|
|up_id  (int4) 	|Unité pastorale concernée (Clé étrangère)|
|berger  (int4) 	|Berger rencontré (Clé étrangère)|
|vocation  (int4) 	|Vocation constatée (Clé étrangère)|
|exploitant  (int4) 	|Exploitant rencontré (Clé étrangère)|
|visite_terrain  (bool) 	|Visite sur le terrain ou à contac t à distance (téléphone, mail, courrier, ..)|
|effectif_bovin  (float4) 	|Effectif bovin constaté|
|effectif_caprin  (float4) 	|Effectif caprin constaté|
|effectif_equin  (float4) 	|Effectif équin constaté|
|effectif_ovin  (float4) 	|Effectif ovin constaté|
|effectif_porcin  (float4) 	|Effectif porcin constaté|
|periode_utilisation_1_debut  (date) 	|Date de début de la première utilisation de l'unité pastorale|
|periode_utilisation_1_fin  (date) 	|Date de fin de la première utilisation de l'unité pastorale|
|periode_utilisation_2_debut  (date) 	|Date de début de la deuxième utilisation de l'unité pastorale|
|periode_utilisation_2_fin  (date) 	|Date de fin de la deuxième utilisation de l'unité pastorale |

#### Généalogie 	

Données actualisées et historisées de l'utilisation réelle d'une unité pastorale située dans la zone optimale d'adhésion du PNM (Parc National du Mercantour), générées suite à la visite de celle-ci.
L'identité des exploitants est anonymisé par une clé d'identifiant unique.
(SCV Nicolas Manié 2017)






<!--
### Exploitants: t_exploitant_exp 
Annuaire des exploitants opérant dans la zone optimale d'adhésion du PNM (Parc National du Mercantour).

#### Description des colonnes remarquables
|Nom 	|Définition|
|:--:|:--:|
|id  (int4) 	|Identifiant unique|
|type_exploitation  (int4) |	Type d'exploitation exploitée par l'exploitant (Clé étrangère)|
|nom  (text) 	|Nom de famille de l'exploitant|
|adresse  (text) |	Adresse de l'exploitant|
|tel  (text) 	|Numéro de téléphone de l'exploitant|
|email  (text) 	|Email de l'exploitant|
|groupe_exploitant  (int4) 	|Regroupement d'exploitant auquel appartient l'exploitant (Clé étrangère)|
|commentaire  (text) 	|Commentaire libre|
|prenom  (text) 	|Prénom de l'exploitant |
Contraintes légales 	
Données permettant l'identification d'individus (nom et prénom). Ne pas diffuser 

-->




Contraintes pour la ressource 	

Utilisation restreinte 

#### Généalogie 	

Annuaire des exploitants opérant dans la zone optimale d'adhésion du PNM (Parc National du Mercantour).
Données issues des contrats.
(SCV Nicolas Manié 2017).


### Contrats de Mesures agro-environnementales de gestion pastorale : t_maec_gestion_pastorale_mgp 
Ensemble des contrats MAE (Mesures Agro-Environnementales) contenant des mesures HE09 (gestion pastorale) créées par le Parc National du Mercantour.

|Nom| 	Définition|
|id  (int4) 	|Identifiant unique|
|unite_pastorale  (int4) 	|Unité pastorale concernée (Clé étrangère)|
|engagement_unitaire  (int4)| 	Engagement unitaire concerné (Clé étrangère)|
|debut_contractualisation  (date) |	Date de début d'application du contrat|
|fin_contractualisation  (date) 	|Date de fin d'application du contrat|
|montant  (float4) 	|Montant (€)|
|pacage  (text) 	|Numéro de déclarant PAC|
|commentaire  (text) 	|Commentaire libre|
|avenant  (bool) 	|Existence d'un avenant |


#### Généalogie 	

Données issues des contrats MAE (Mesures Agro-Environnementales) créées par le Parc National du Mercantour.
Données géographiques déterminées sur la base des données parcellaires cadastrales et forestière, ou à défaut, sur carte IGN au 1/250000ème.
Données produites dans le cadre d'une compilation / correction du jeu de données thématique et des contrats papiers (SCV Nicolas Manié 2017).


### tr_engagement_unitaire_eun
Types d engagement unitaire pour les MAEC

### tr_entomo_enjeu
Espèces d'insectes sensibles aux pratiques agropastorales

### tr_entomo_taxref
Correspondance cd_ref cd_nom des taxons entomo à enjeu en taxref v15


### tr_especes_enjeu_agropasto_eap
Ne pas utiliser, table remplacée par tr_entomo_enjeu

### tr_fertilisation_prairie_fer
Types de fertilisation d une prairie


### tr_irrigation_prairie_iri
Types d irrigation d une prairie


### tr_mesure_gestion_pastorale_mpa
Types de mesures de gestion pour les MAEC gestion pastorale


### tr_statut_cpp_sta
Statut possible d'une CPP

### tr_type_location_loc
Type de location d un pâturage

### t_regroupement_propriete_rpr
Groupement de propriétés

### tr_type_paec_tpa
Types de PAEC


### tr_vocation_unite_pastorale_vup
Vocations de l unité pastorale

<!-- 
## Tables remarquables
_Les tables accessibles, le type de données_
Contient X tables accessibles. 
- La première table qui fait des trucs
- la deuxième qui est aussi très intéressante
- sans parler de la troisième


#	# Description des colonnes remarquables

Attention: Ne sont décrites ici que les colonnes remarquables, ou dont le nom pourrait prêter à confusion. 

#### table_1
| Nom de la colonne      | Type | Description     |
| :---        |    :----:   |          :---: |
| n_truc      | (PK) int       | c'est le numéro du truc   |
| nom_truc   | string        | c'est le nom du fameux truc      |

#### table_2
| Nom de la colonne      | Type | Description     |
| :---        |    :----:   |          :---: |
| n_machin      | int       | c'est le numéro du machin   |
| n_truc   | string        | c'est le numéro du truc      |

#### table_3
| Nom de la colonne      | Type | Description     |
| :---        |    :----:   |          :---: |
|...      |...       |...   |

## Exemples de Requêtes
_Quelques exemples de requêtes toutes écrites qui permettent de faire des trucs_

```postgreSQL
--Requête pour avoir tous les trucs commençant par "a" ou "A"
SELECT *
FROM table_1
WHERE nom_truc ILIKE 'a%'
```

## Dépendances

table_3 mise à jour à partir de **schema1.table_46** et **schema3.table_18**



## Projets Qgis

## Mises à jour

Tous les ans, ou quand les couches de références changent. 
-->

