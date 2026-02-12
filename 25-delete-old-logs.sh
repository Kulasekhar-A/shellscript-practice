#!/bin/bash

LOGS_DIR=/var/log/myapp
LOGS_FILE="/$LOGS_DIR/$0.log"

if [ ! -d $LOGS_DIR ]; then
    echo "$LOGS_DIR does not exist"
    exit 1
fi

FILES_TO_DELETE=$(find $LOGS_DIR -name "*.log" -mtime +14)
echo "$FILES_TO_DELETE"

while IFS=read -r FILE_PATH
do
 echo "delete file: $FILE_PATH"
 rm -f $FILE_PATH
 echo "delete file: $FILE_PATH"
done <<< $FILES_TO_DELETE