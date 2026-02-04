#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_DIR=/home/ec2-user/app1-logs
LOGS_FILE="$LOGS_DIR/$0.log"

if [ ! -d $LOGS_DIR ]; then
  echo "$LOGS_DIR does not exist"
  exit 1
fi

#find the files in particular directory
FILES_TO_DELETE=$(find $LOGS_DIR -name "*.log" -mtime +14)


while IFS= read -r FILE_PATH
do
  # Process the line here
  echo "Deleting file : $FILE_PATH"
  rm -f $FILE_PATH
  echo "Deleted file : $FILE_PATH"
done <<< $FILES_TO_DELETE