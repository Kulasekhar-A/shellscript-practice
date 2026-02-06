#!/bin/bash

LOGS_FOLDER="/var/log/shell-script"
LOGS_FILE="/var/log/shell-script/backup.log"

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} # 14 days is the default value, if the user not supplied

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
  echo -e "$R Please run this script with root user access $N" 
fi

mkdir -p  $LOGS_FOLDER

log(){

    echo -e "$(date "+%y-%m-%d %H:%M:%S") | $1" | tee -a $LOGS_FILE
}

USAGE(){

    log " $R USAGE :: sudo backup <SOURCE_DIR> <DEST_DIR> <DAYS> [ default 14 days ]$N"
    exit 1
}

if [ $# -lt 2 ]; then
 USAGE
fi

if [ ! -d $SOURCE_DIR ]; then
 loog "$R source directory : $SOURCE_DIR does not exist $N"
 exit 1
fi

if [ ! -d $DEST_DIR ]; then
 log "$R destination drectory : $DEST_DIR does not exist $N"
 exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)

log "backup started"
log "source directory : $SOURCE_DIR"
log "destination directory : $DEST_DIR"
log "Days : $DAYS"

if [ -z "${FILES}" ]; then
  log "no files to archieve : $Y skipping ... $N"
else
  log "files to found archieve: $FILES"
  TIMESTAMP=$(date +%F-%H-%M-%S)
  ZIP_FILE_NAME="$DEST_DIR/app-logs-$TIMESTAMP.tar.gz"
  tar -zcvf $ZIP_FILE_NAME $(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)

  if [ -f $ZIP_FILE_NAME ]; then
    log "Already archieving is ... $G success $N"
    while IFS= read -r FILE_PATH
    do
    # Process the line here
    log "Deleting file : $FILE_PATH"
    rm -f $FILE_PATH
    log "Deleted file : $FILE_PATH"
    done <<< $FILES
  else
    log "Already archieving is ... $F failure $N"
    exit 1
  fi
fi