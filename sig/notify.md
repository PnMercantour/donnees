# Utilisation de "Notify" pour lancer des raffraichissements de couche postgis dans Qgis

## Principe général et cadre d'utilisation

"Notify" est une commande postgresql qui permet d'envoyer une notification accompagnée d'une chaîne de caractères en "charge"
 (payload). 
Qgis dispose d'une fonctionnalité permettant d'écouter (listen) la base de données postgres, et de réaliser des raffraîchissements de couche quand une commande NOTIFY générale, ou accompagnée d'une chaîne de caractères spécifique.

## Exemples
Dans le cadre d'un projet de validation des observations, on ne souhaite visualiser qu'une partie des observations pour pouvoir les valider. 
Les observations validées doivent alors être remplacées par d'autres observations à valider. 

Dans ce cas, on peut mettre en place 
- une table "validation_observation", contenant toutes les observations à valider
- une vue "taxon_a_valider" où ne sont affichés que quelques taxons pour ne pas surcharger visuellement la carte
 
La table validation_observation est filtrée selon les taxons présents dans la vue "taxon_a_valider".

La vue taxons à valider peut être définie comme les 3 premiers taxons 


## Code / paramétrage


### Créer la fonction
```sql
CREATE FUNCTION public.notify_qgis() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ 
        BEGIN NOTIFY qgis;
        RETURN NULL;
        END; 
    $$;
```

### Créer le trigger qui appelle la fonction
```sql
CREATE TRIGGER notify_qgis_edit 
  AFTER INSERT OR UPDATE OR DELETE OR TRANSACT ON public.line 
    FOR EACH STATEMENT EXECUTE PROCEDURE public.notify_qgis();
```


### Paramétrer la couche qgis

Propriétés > Rendu 
Puis cocher : "Actualiser la couche lors de la notification". Optionnellement: "Seulement si le message est" si une charge (payload) précise a été définie dans la fonction. 

