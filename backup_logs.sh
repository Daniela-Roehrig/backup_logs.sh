#!/bin/bash

LOG_DIR="/var/log/httpd"           #
FILENAME="access_log"             
FILE_PATH="/var/log/httpd/access_log"    
BACKUP_DIR="/var/backups"          
MAX_BACKUPS_AGE=3                 
DATE=$(date +\%Y\%m\%d)            
ARCHIVE_NAME="log_$DATE.tar.gz"    

mkdir -p "  $BACKUP_DIR"


tar -czf "$BACKUP_DIR/$ARCHIVE_NAME" -C "$LOG_DIR" "$FILENAME"


if [ $? -eq 0 ]; then
    echo "Archiving of $FILENAME successful: $BACKUP_DIR/$ARCHIVE_NAME"
else
    echo "Error during archiving of $FILENAME!"
    exit 1
fi


find "$BACKUP_DIR" -name "log_*.tar.gz" -type f -mtime +$MAX_BACKUPS_AGE -exec rm {} \;


> "$FILE_PATH"

echo "old backups delete and file reset."

chmod +x backup_files.sh