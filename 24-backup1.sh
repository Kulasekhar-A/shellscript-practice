#!/bin/bash

LOGS_FOLDER="/var/log/shell-script"
LOGS_FILE="/var/log/shell-script/$0.log"

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}

USERID=$(id -u)

#to check root user  or not

if [ $USERID -ne 0 ]; then
  echo -e "$R Please run this script with root user access $N" | tee -a $LOGS_FILE
  exit 1
fi

mkdir -p  $LOGS_FOLDER

log(){

    echo -e "$(date "+%y-%m-%d %H:%M:%S") | $1" | tee -a $LOGS_FILE
}
#what is the backup in source_dir dest_dir days
USAGE(){

    echo -e "$R USAGE : sudo backup <SOURCE_DIR> <DEST_DIR> <DAYS> [ default 14 days ]$N"
}

if [ $# -lt 2 ]; then
  USAGE
fi

if [ ! -d $SOURCE_DIR ]; then
   echo -e "$R source directory : $SOURCE_DIR does not exist$N"
   exit 1
fi 

if [ ! -d $DEST_DIR ]; then
   echo -e "$R destination directory : $DEST_DIR does not exist$N"
   exit 1
fi 

FILES=$(find $SOURCE_DIR -name "*.log" -type f -mtype +$DAYS)

log "backup started"
log "source directory : $SOURCE_DIR"
log "destination directory :$DEST_DIR"
log "days : $DAYS"