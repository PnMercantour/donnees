 # bd_aigle_royal
 ## Description
 _Description générale du schéma: quel type d'information, pour quelles utilisations, de quelles sources_ </br>
 C'est un schéma qui contient des informations vides.  Il est supposé servir à aucun utilisateur pour faire des trucs.
 Les données sont issues de https://www.sourcededonnees.com, et sont mises à jour manuellement quand elles changent, c'est-à-dire jamais. 






<!--
 ## Utilisation du projet Qgis
_Description du projet Qgis accessible par défaut dans le projet._
-->


## Aires de reproduction de l'Aigle royal  : c_aires

Localisation des aires de reproduction de l'Aigle royal.

|Nom|Définition|
|:--:|:--:| 	
|id  (int4) 	|Identifiant unique des entité de la table|
|id_origin  (int4) 	|Identifiant historique des entité de la table (old)|
|id_aire  (int4) 	|Identifant unique de l'aire utilisé pour les relations avec les tables liées|
|id_couple  (int4) 	|identifiant du couple rattaché à l'aire de reproduction|
|info_loc  (varchar) 	|Précision sur la localisation de l'aire|
|altitude  (int4) 	|Altitude de l'aire|
|annee  (int4) 	|Année de découverte de l'aire|
|observations  (varchar) 	|Observations compléntaires sur l'aire de reproduction|
|id_substrat  (int4) 	|Identifiant faisant référence à la table de référence de la nomenclature des substrats|
|id_exposition  (int4) 	|Identifiant faisant référence à la table de référence de la nomenclature des expositions|
|id_secteur  (int4) 	|Identifiant faisant référence à la table de référence de la nomenclature des secteurs référents du PN |

#### Contraintes légales 	

L124-4-I-2 du code de l'environnement : La protection de l'environnement auquel ces informations ont trait, comme par exemple la localisation d'espèces rares.

Conditions inconnues 


#### Généalogie 	

Couche spatiale des aires de reproduction de l'aigle royal produite à partir des prospections de suivi réalisées par les gardes-moniteurs du Parc national du Mercantour depuis la mise en oeuvre du protocole de suivi par échantillonnage initié en 2001.




## Couples et territoires de l'Aigle royal : c_couple_territoire 

|Nom|Définition|
|:--:|:--:| 	
|id  (int4) 	|Identifiant unique des entité de la table|
|id_couple  (int4) 	|Identifiant unique de chaque couple propre à chaque secteur responsable du suivi. Composé de 3 chiffres : le premier représente l'identifiant de chaque secteur référent et les 2 suivants s'incrémentent de 01 à 99|
|nom_couple  (varchar) 	|Nom commun donné au couple (se rapportant généralement au lieu dit de découverte)|
|annee_couple  (int4) 	|Année de découverte du couple (lié à la découverte des aires)|
|id_territoire  (int4) 	|Identifiant unique de chaque territoire du couple|
|nom_territoire  (varchar) 	|Nom commun donné au territoire du couple (se rapportant généralement au lieu dit de découverte)|
|id_secteur  (int4) 	|Identifiant du secteur référent en charge du suivi du couple et de son territoire |


#### Contraintes légales 	

L124-4-I-2 du code de l'environnement : La protection de l'environnement auquel ces informations ont trait, comme par exemple la localisation d'espèces rares.

Conditions inconnues 

#### Généalogie 	

Couche spatiale des territoires des couples d'aigle royaux produite à partir des prospections réalisées par les gardes-moniteurs du Parc national du Mercantour depuis la mise en oeuvre du protocole de suivi par échantillonnage initié en 2001.


##  Suivi de la reproduction de l'Aigle royal : t_suivi_repro 

|Nom|Définition|
|:--:|:--:| 
|id  (int4) 	|Identifiant unique des entités de la table|
|id_suivi_repro  (int4) 	|Identifiant unique de chaque suivi de la reproduction réalisé|
|id_couple  (int4) 	|Identifiant unique de chaque couple propre à chaque secteur responsable du suivi. Composé de 3 chiffres : le premier représente l'identifiant de chaque secteur référent et les 2 suivants s'incrémentent de 01 à 99|
|id_aire  (int4) 	|Identifiant unique de chaque aire de nidification propre à chaque secteur responsable du suivi. Composé de 5 chiffres : le premier représente l'identifiant de chaque secteur référent, les 2 suivants s'incrémentent de 01 à 99 suivant la numérotation du couple et les 2 derniers correspondent à la numérotation de l'aire au sein du territoire du couple en s'incrémentant de 01 à 99|
|annee  (int4) 	|Année du suivi réalisé|
|observations  (varchar) 	|Commentaires et observations sur le suivi réalisé|
|id_code_repro  (int2) 	|Identifiant du code de reproduction faisant référence à la table de nomenclature correspondante|
|suivi_protocole  (bool) |	Indique si le suivi a été réalisé dans le cadre du protocole d'échentillonnage (true) ou de manière aléatoire (false)|
|date_couvaison  (date) 	|Date de couvaison lorsque celle-ci a été identifiée lors du suivi|
|precision_date_couvaison  (text) 	|Elements de précision concernant la date de couvaison lorsque celle-ci a été identifiée lors du suivi|
|date_envol  (date) 	|Date d'envol du jeune de l'année suivie lorsqu'elle est connue|
|precision_date_envol  (text) 	|Elements de précision concernant la date d'envol du jeune de l'année suivie lorsqu'elle est connue |

#### Contraintes légales 	

L124-4-I-2 du code de l'environnement : La protection de l'environnement auquel ces informations ont trait, comme par exemple la localisation d'espèces rares.

Conditions inconnues 


#### Généalogie 	

Table des suivi de la reproduction des couples d'aigle royaux produite à partir des prospections réalisées par les gardes-moniteurs du Parc national du Mercantour depuis la mise en oeuvre du protocole de suivi par échantillonnage initié en 2001.




##  Nomenclature des codes de suivi de la reproduction de l'Aigle royal : tr_codes_repro
Nomenclature utilisé pour le suivi de la reproduction de l'Aigle royal dans le cadre du protocole par échantillonnage du Parc national du Mercantour.


|Nom|Définition|
|:--:|:--:| 
|id  (int4) 	Identifiant unique de chaque entité de la table|
|id_code_repro  (int4) 	Identifiant unique et clé primaire des codes de suivi de la reproduction|
|old_code_repro  (varchar) 	Ancien identifiant des codes de suivi de la reproduction (historique)|
|libelle  (varchar) 	Libellé complet du code de suivi de la reproduction|
|succes  (bool) 	Indicateur de succès (true) ou d'échec (false) pour chaque code de suivi de la reproduction |


#### Généalogie 	

Table de référence (dictionnaire) contenant la nommenclature utilisé pour le suivi de la reproduction de l'Aigle royal dans le cadre du protocole par échantillonnage du Parc national du Mercantour.

##  Nomenclature des codes d'exposition pour les aires de nidification de l'Aigle royal : tr_exposition
Nomenclature utilisée pour l'exposition des aires de nidification de l'Aigle royal.

|Nom|Définition|
|:--:|:--:| 
|id  (int4) 	|Identifiant unique de chaque entité de la table|
|id_exposition  (int4) 	|Identifiant unique et clé primaire des codes d'exposition des aires de nidification|
|code_exposition  (varchar) 	|Code du type d'exposition|
|libelle  (varchar) 	|Libellé du type d'exposition |
#### Contraintes légales 	

L124-4-I-2 du code de l'environnement : La protection de l'environnement auquel ces informations ont trait, comme par exemple la localisation d'espèces rares.

Conditions inconnues

#### Généalogie 	
Table de référence (dictionnaire) contenant la nommenclature utilisée pour l'exposition des aires de nidification de l'Aigle royal dans le cadre du protocole par échantillonnage du Parc national du Mercantour.


<!--

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


_____
_Documentation pour utilisateurs avancés et maintenance_


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



## Code de création des tables

[lien](./README.md)
-->


