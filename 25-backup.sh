#!/bin/bash

LOGS_FOLDER="/var/log/shell-script"
LOGS_FILE="$LOGS_FOLDER/backup.log"

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
echo "please run this script with root user access"
fi

mkdir -p $LOGS_FOLDER

log(){

    echo "$(date "+%y-%m_%d %H-%M-%S") | $1" | tee -a "$LOGS_FILE"
}

USAGE () {

    log "USAGE :: sudo backup <SOURCE_DIR> <DEST_DIR> <DAYS> [ default 14 days ]"
    exit 1
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

if [ -z "${FILES}" ]; then
log "no files to archive : skipping"
else
log "files found to archive : $FILES"
TIMESTAMP=$(date +%F-%H-%M-%S)
ZIP_FILE_NAME="$DEST_DIR/myapp-$TIMESTAMP.tar.gz"
tar -zcvf $ZIP_FILE_NAME $(find $SOURCE_DIR -name "*.log" -type f -mtime +"$DAYS")

if [ -f $ZIP_FILE_NAME ]; then
log "archiving is : success"
while IFS= read -r file
do
log "delete file : $file"
rm -f $file
log "delete file : $file"
done <<< "$FILES"
else
    log "Already archieving is ... $F failure $N"
    exit 1
fi
fi