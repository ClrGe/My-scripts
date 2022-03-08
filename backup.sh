#!/usr/bin/bash

NOW=$(date +"%Y-%m-%d")
destination_backup=/Backup
vhost=/etc/apache2/sites-available 
source $1
mysqldump -u $BDDlog -p$BDDpwd  $BDD > $fichierBackupBDD
tar -czf $fichierBackUp $vhost $fichiersSites $fichierBackupBDD
rm $fichierBackupBDD
