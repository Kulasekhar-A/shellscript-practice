#!/bin/bash

LOGS_FOLDER="/var/log/shell-script"
LOGS_FILE="/var/log/shell-script/backup.log"

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} #14 days is the default value , if the user not supplied

USERID=$(id -u)

#to check root user  or not

if [ $USERID -ne 0 ]; then
  echo -e "$R Please run this script with root user access $N" 
  exit 1
fi

mkdir -p  $LOGS_FOLDER

log(){

    echo -e "$(date "+%y-%m-%d %H:%M:%S") | $1" | tee -a $LOGS_FILE
}
#how to use
USAGE(){

    log "$R USAGE : sudo backup <SOURCE_DIR> <DEST_DIR> <DAYS> [ default 14 days ]$N"
    exit 1
}

if [ $# -lt 2 ]; then
  USAGE
fi

#to check source_dir is present or not
if [ ! -d $SOURCE_DIR ]; then
   log "$R source directory : $SOURCE_DIR does not exist$N"
   exit 1
fi 

#to check destination_dir is present or not
if [ ! -d $DEST_DIR ]; then
   log "$R destination directory : $DEST_DIR does not exist$N"
   exit 1
fi 

#find the files
FILES=$(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)

log "backup started"
log "source directory : $SOURCE_DIR"
log "destination directory :$DEST_DIR"
log "days : $DAYS"

if [ -z ]