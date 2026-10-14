# Charger un projet depuis la base de données


## Pourquoi charger un projet depuis la base ?

La base de données du Parc ne contient pas que des données : elle peut aussi stocker des [projets QGIS](./glossaire#projet), c'est-à-dire la mise en page et les options de représentation d'un ensemble de couches.

Les agents disposent ainsi de cartes « prêtes à l'emploi » pour différentes thématiques, en plus des données brutes. Tous les agents ouvrent le même projet et peuvent partager un même support de travail.


## Prérequis : [accès à la base de données du PNM](./installer_certificats_base_de_donnees.md)
Pour ouvrir un projet de la base, il faut avoir accès à la connexion "Service projets".  
Si elle n'apparaît pas dans votre liste de connexions décrite plus bas, suivez d'abord [ce tutoriel](./installation_certificats_base_de_donnees.md).

En cas de difficulté, contactez le SI : `si@mercantour-parcnational.fr`.


## Charger un projet

- Ouvrir QGIS  
- Dans la barre de menu, cliquer sur ++"Projet"++
- Puis ++"Ouvrir depuis"++ > ++"PostgreSQL"++

    ![](./img/charger_projet.png)

- Choisir la connexion **Service projets**
- Sélectionner le **schéma** qui vous intéresse : les projets sont regroupés par thème.
- Puis sélectionner le **projet** souhaité.

    ![](./img/charger_projet_postgresql_schema.png)


!!! tip "Quel projet ouvrir ?" 
    La page [Projets QGIS](../projets_qgis/index.md)  décrit chaque projet : à quoi il sert et comment l'utiliser.

!!! failure "Si vous ne voyez pas la connexion "Service projets" dans la liste des connexions"
    Il faut paramétrer l'accès à la base en suivant [ce lien](./installer_certificats_base_de_donnees.md).   
    Contactez le SI (`si@mercantour-parcnational.fr`) en cas de difficulté.  