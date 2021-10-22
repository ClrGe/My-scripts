
#-----------SCRIPT DE BACKUP MULTI-SÎTES----------------

#!/usr/bin/bash

# Déclaration des variables génériques / applicables à tous les sîtes
NOW=$(date +"%Y-%m-%d")
destination_backup=/Backup
vhost=/etc/apache2/sites-available 

#Aller chercher les variables spécifiques du sîte dans le fichier .env
source $1

#Export DB
mysqldump -u $BDDlog -p$BDDpwd  $BDD > $fichierBackupBDD

#Creation archive tar.gz
tar -czf $fichierBackUp $vhost $fichiersSites $fichierBackupBDD

#Clean export DB
rm $fichierBackupBDD
