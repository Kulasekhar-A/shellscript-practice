#!/bin/bash

LOGS_FOLDER="/var/log/shell-script"
LOGS_FILE="$LOGS_FOLDER/backup.log"

SOURCE_DIR="/var/log/myapp"
DEST_DIR=$1
DAYS=${3:-14}

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
echo "please run this script with root user access"
fi

log(){

    echo "$(date "+%y-%m_%d %H-%M-%S") | $1" | tee -a "$LOGS_FILE"
}

USAGE () {

    log "USAGE :: sudo backup <SOURCE_DIR> <DEST_DIR> <DAYS> [ default 14 days ]"
}

if [ $#  -lt 2 ]; then
USAGE
fi

if [ ! -d $SOURCE_DIR ]; then
log "source directory : $SOURCE_DIR does not exist"
fi

if [ ! -d $DEST_DIR ]; then
log " destination directory : $DEST_DIR does not exist"
fi

FILES=$(find "$SOURCE_DIR" -name "*.log" -type f -mtime +"$DAYS")

log "backup started"
log "source directory : $SOURCE_DIR"
log "destination directory : $DEST_DIR"
log "Days : $DAYS"