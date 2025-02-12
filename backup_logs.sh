#!/bin/bash

LOG_DIR="/var/log/httpd"           #
FILENAME="access_log"             
FILE_PATH="/var/log/httpd/access_log"    
BACKUP_DIR="/var/backups"          
MAX_BACKUPS_AGE=3                 
DATE=$(date +\%Y\%m\%d)            
ARCHIVE_NAME="log_$DATE.tar.gz"    

FILE_PATH=/var/log/htpd/access_log

tar -czf "$BACKUP_DIR/$ARCHIVE_NAME" -C "$LOG_DIR" "$FILENAME"


if [ $? -eq 0 ]; then
    echo "Archivierung von $FILENAME erfolgreich: $BACKUP_DIR/$ARCHIVE_NAME"
else
    echo "Fehler bei der Archivierung von $FILENAME!"
    exit 1
fi


find "$BACKUP_DIR" -name "log_*.tar.gz" -type f -mtime +$MAX_BACKUPS_AGE -exec rm {} \;


> "$FILE_PATH"

echo "old backups delete and file reset."