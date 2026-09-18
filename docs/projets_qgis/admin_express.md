# admin_express

## Schéma
Sources et structure de la donnée utile à la construction des projets : [admin_express](../bd_pnm/admin_express.md).

## Projet admin_express 

Le projet QGIS `admin_express` permet de parcourir les données administratives régionales (des relations sont établies entre les différentes couches pour faciliter la navigation à partir des outils QGIS d'identification des entités).

!!! info "Les communes du territoire du PNM sont directement accessibles dans le schéma [limites](../bd_pnm/limites.md)"


??? Note "Documentation pour utilisateurs avancés et maintenance"
    ## Mise à jour du projet

    Il est vivement recommandé de mettre à jour le projet git lorsque le schema ou le projet QGIS sont modifiés en base.

    Le script [admin_express/bin/dump_schema](../bd_pnm/admin_express/bin/dump_schema) lit depuis la base de données la version courante du schema sql et l'enregistre dans [schema.sql](../bd_pnm/admin_express/sql/schema.sql).

    Le script [admin_express/bin/dump_project](../bd_pnm/admin_express/bin/dump_project) télécharge la version courante du projet QGIS depuis la base de données et l'enregistre dans [admin_express.qgs](../bd_pnm/admin_express/QGIS/admin_express.qgs).