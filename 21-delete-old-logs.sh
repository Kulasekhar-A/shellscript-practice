#!/bin/bash

LOGS_DIR=/home/ec2-user/app-logs
LOGS_FILE="/$LOGS_DIR/$0.log"

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

#check the directory it is present or not
if [ ! -d $LOGS_DIR ]; then
   echo -e "$LOGS_DIR does not exist"
   exit 1
fi

#find the files in particular directory
FILES_TO_DELETE=$(find $LOGS_DIR -name "*.log" -mtime +14)
echo "$FILES_TO_DELETE"

while IFS= read -r FILE_PATH
do
  # Process the line here
  echo "$FILE_PATH"
done <<< $FILES_TO_DELETE