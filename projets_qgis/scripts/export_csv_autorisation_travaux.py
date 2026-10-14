# objectif :  
#   1. table details depuis .xl fourni
#           pour alimenter la table bdd autorisations_travaux_details
#           afin d'avoir une table répertoriant les infos utiles d'un numéro d'autorisation (et non une duplication de ces mêmes infos par parcelle, maintenir de la donnée inutile)
#   2. table correspondance entre numero autorisation & numero parcelle ligne a ligne depuis .xl fournit 
#           pour alimenter la table bdd correspondance_autorisation_parcelles (numero_autorisation,id_parcelle)


import pandas as pd
import re
from pathlib import Path
from datetime import datetime

fichier_source = r"X:\2.2. INSTRUCTION ET POLICE\04_INSTRUCTION\11_Travaux\Recap pour SIG\Traitement avant import\recap autorisations 2011-2025 SIG-csv.csv"
outpath = Path.home() / "Downloads" / "autorisation_travaux" / str(datetime.now().strftime("%Y%m%d_%H%M%S"))
outpath.mkdir(parents=True, exist_ok=True)


# 1. Construction de la table autorisations_travaux_details

# affectation des noms de colonnes attendus dans la bdd
colonnes_details_autorisations = {
    "num_decision":"numero_autorisation",
    "ANNEE":"annee",
    "ETAT INSTRUCTION":"etat_instruction",
    "BENEFICIAIRE personne morale":"beneficiaire_personne_morale",
    "Représentant ou bénéficiaire personne physique":"representant_personne_physique",
    "OBJET":"objet",
    "Catégories autorisation":"categorie",
    "LIEU":"service_territorial",
    "REPONSE CS du":"reponse_cs"
}


#verifier que la colonne "parcelles" est bien formatée en 'texte' et non en 'nombre' dans le fichier .xl -> sinon on va avoir des 0 dans les parcelles

data_source = pd.read_csv(fichier_source, encoding='latin-1', sep=';') #/!\ accents, exporter le xl/ods en csv simple
data_source = data_source.dropna(axis=0, how='all')

autorisation_sans_parcelle = data_source[data_source['parcelles'].isna()|(data_source['parcelles'].str.strip()=='')] #pour le suivi
data_source = data_source[data_source['parcelles'].notna()&(data_source['parcelles'].str.strip()!='')] #supprime d'ores et déjà toutes les autorisations sans parcelles renseignées

autorisation_sans_parcelle.to_csv(f"{outpath}\\autorisations_sans_parcelle.csv",index=False,encoding='latin-1')
print(f"{len(autorisation_sans_parcelle)} autorisations sans parcelle.")


#format attendu de num_decision : 4 chiffres, un tiret, puis 1 à 5 chiffres/lettres
pattern_num_decision = r'^\d{4}-[A-Za-z0-9]{1,5}$'
mask = data_source['num_decision'].astype(str).str.match(pattern_num_decision)

data_rejetees = data_source[~mask]
data_rejetees.to_csv(f"{outpath}\\data_numdecision_incorrect.csv",index=False,encoding='latin-1')
print(f"{len(data_rejetees)} numéros d'autorisation incorrects \n {data_rejetees}")


data_source = data_source[mask]

colonnes_a_garder = list(colonnes_details_autorisations.keys())
details_autorisations = data_source[colonnes_a_garder].copy()
details_autorisations = details_autorisations.rename(columns=colonnes_details_autorisations)
details_autorisations = details_autorisations.drop_duplicates()

details_autorisations.to_csv(f"{outpath}\\details_autorisations.csv",index=False,encoding='latin-1')
print(f"details_autorisations.csv créé, nombres d'autorisations: {len(details_autorisations)}")


# 2. Construction de la table correspondance_autorisation_parcelles

#colonne d'où extraire les parcelles pour chaque autorisation
colonne_parcelles_par_autorisation = "parcelles"

parcelles = data_source[["num_decision", "commune","N°INSEE", colonne_parcelles_par_autorisation]].copy()

    # on veut garder une trace de ce qui est supprimé (ici les parcelles qui sont nulles avant traitement)
parcelles_nulles = parcelles[parcelles[colonne_parcelles_par_autorisation].isna()].copy()
parcelles_nulles["raison"] = "valeur nulle (NaN) dans la colonne parcelles"

# traitement : on suppose qu'on a stocké les parcelles séparées par des virgules dans la cellule
parcelles = parcelles.dropna(subset=[colonne_parcelles_par_autorisation]) 
parcelles[colonne_parcelles_par_autorisation] = parcelles[colonne_parcelles_par_autorisation].str.split(",") 
parcelles = parcelles.explode(colonne_parcelles_par_autorisation)
parcelles[colonne_parcelles_par_autorisation] = parcelles[colonne_parcelles_par_autorisation].str.strip()

    # on veut garder une trace de ce qui est supprimé (les parcelles qui sont nulles après traitement)
combinaisons_vides = parcelles[parcelles[colonne_parcelles_par_autorisation] == ""].copy()
combinaisons_vides["raison"] = "valeur vide après split (virgule mal placée)"


# on finit le traitement des valeurs vides
parcelles = parcelles[parcelles[colonne_parcelles_par_autorisation] != ""]


# on affecte à la colonne N°INSEE le code correspondant à la commune pour trouver l'id complet de la parcelle
fichier_communes = r"C:\Users\marine.caradec\Documents\01_Projets\01_SIG_Autorisation_Travaux\data\Communes-codes-INSEE-csv.csv"
data_communes = pd.read_csv(fichier_communes, encoding='latin-1', sep=';')

    #formate la colonne code insee en entier + compléter par de 0 pour obtenir 5 caractères
data_communes["code_insee"] = data_communes["code_insee"].astype(float).astype("Int64").astype(str).str.zfill(5)

correspondance_commune_codeisee = data_communes.set_index("commune")["code_insee"].to_dict()
parcelles["N°INSEE"]=parcelles["commune"].map(correspondance_commune_codeisee)

    # on veut garder une trace de ce qui est supprimé (parcelles pour lesquelles il n'y a pas de commune ou code insee - on distingue les deux pour identifier la cause du pb)
sans_commune = parcelles[parcelles["commune"].isna() | (parcelles["commune"].str.strip() == "")]
sans_commune["raison"] = "nom de commune non renseigné"

sans_code_insee = parcelles[parcelles["commune"].notna() & (parcelles["commune"].str.strip() != "") & parcelles["N°INSEE"].isna()]
sans_code_insee["raison"] = "correspondance code insee non trouvé sur le nom de commune"

valeurs_supprimees = pd.concat([parcelles_nulles, combinaisons_vides, sans_commune, sans_code_insee], ignore_index=True)

#on supprime toutes les combinaisons pour lesquelles il n'y a pas de code insee/nom de commune (mais c'est redondant -> si pas de commune, pas de code insee)
parcelles = parcelles[parcelles["commune"].notna() & (parcelles["commune"].str.strip() != "") & parcelles["N°INSEE"].notna()]
parcelles = parcelles.drop_duplicates()


def format_id_parcelle(parcelle):
    res = ""
    try:
        parcelle = str(parcelle).strip().upper()

        # Format attendu : 1 ou 2 lettres suivies de 1 à 4 chiffres (pas plus)
        if not re.match(r'^0?[A-Z]{1,2}\d{1,4}$', parcelle):
            return None
        
        a = ''.join(re.findall('[A-Z]', parcelle))
        b = parcelle.split(a)
        left = ''.join((b[0],a)).zfill(5) #section : préfixe 000 + lettres (complété par un 0 si une seule lettre)
        right = b[1].zfill(4) #numero_plan : complété par des 0 pour atteindre 4 chiffres
        res=''.join((left, right)).strip()
    except:
        res = None
    return res

parcelles["id_parcelle_formate"]=parcelles[colonne_parcelles_par_autorisation].apply(format_id_parcelle)

parcelles_non_formatees = parcelles[
    parcelles["id_parcelle_formate"].isna() & parcelles[colonne_parcelles_par_autorisation].notna()
]

parcelles["id_parcelle"]=(parcelles["N°INSEE"].astype(str)+parcelles["id_parcelle_formate"])

correspondance_autorisation_parcelles = parcelles[parcelles["id_parcelle"].notna()]


#noms de colonne affectés et recupérées pour convenir a la bdd
correspondance_autorisation_parcelles = correspondance_autorisation_parcelles.rename(columns={
        "num_decision":"numero_autorisation"
})
correspondance_autorisation_parcelles = correspondance_autorisation_parcelles[["numero_autorisation","id_parcelle"]]


valeurs_supprimees.to_csv(f"{outpath}\\combinaisons_autorisation_parcelle_supprimees.csv",index=False,encoding='latin-1')
print(f"{len(valeurs_supprimees)} combinaisons autorisation-parcelle supprimées après séparation des virugles, voir fichier combinaisons_autorisation_parcelle_supprimees.csv pour détails")

parcelles_non_formatees.to_csv(f"{outpath}\\parcelles_non_formatées.csv",index=False,encoding='latin-1')
print(f"{len(parcelles_non_formatees)} parcelles non formatées \n {parcelles_non_formatees}")

correspondance_autorisation_parcelles.to_csv(f"{outpath}\\correspondance_autorisation_parcelles.csv",index=False,encoding='latin-1')
print(f"correspondance_autorisation_parcelles.csv créé, nombres de combinaisons autorisation-parcelle : {len(parcelles)}")