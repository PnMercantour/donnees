# Publication des ZSM

Régulièrement, il est nécessaire de mettre à jour les ZSM.

Le projet décrit ici permet de gérer ces ZSM.

En plus de ça, il faut mettre en évidence le coeur du parc où les survols sont interdits/

```
Coeur de parc: Tout survol est interdit. 

Zone coeur ZSM: le parapente est autorisé au dessus de 1000 du point le plus haut de la zsm. Les survols motorisés sont interdits.

Zone périphérique ZSM: le parapente est autorisé à 300m les drones et planeurs sont autorisés au dessus de 1000m du point le plus haut de la zsm.

## représentation

Pour la zone périphérique de la ZSM, il est important de mettre en évidence plutôt le coeur, on va donc utiliser le générateur de géométrie: 
> difference( $geometry,  geometry(get_feature( 'limites_1cbe8a87_666e_4359_a653_78f1708f5442', 'nom' , 'coeur' )))

Qui permet de récupérer uniquement les zones périphériques hors du coeur. 

Pour les coeurs de zsm, il est important de les représenter même à l'intérieur du parc, pour ça on réutilise la même formule de différence de géométrie, mais uniquement pour une partie de la symbologie (le motif de lignes). 

On peut ensuite juste générer un atlas en filtrant avec " "type" = 'tampon' ". 

Il a tout de même été nécessaire de créer un champ "label", les "ê" ne passant pas par défaut. 
Sinon, pour gérer ça plus proprement:  
> passer par propriétés de la couche>Source>Encodage des données sources



