#!/bin/bash

set -e

LOGS_FOLDER="/var/log/shell-script"
LOGS_FILE="/var/log/shell-script/$0.log"

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
  echo -e "$R Please run this script with root user access $N" | tee -a $LOGS_FILE
  exit 1
fi

mkdir -p  $LOGS_FOLDER

VALIDATE(){
   if [ $1 -ne 0 ]; then
       echo -e" $2 ...$R FAILURE  $N" | tee -a $LOGS_FILE
       exit 1
   else
       echo -e " $2 ... $G SUCCESS $N" | tee -a $LOGS_FILE
   fi
}

for package in $@
do
  dnf list installed $package &>> $LOGS_FILE
  if [ $? -ne 0 ]; then
     echo "$package not installed,installing now"
     dnf install $package -y &>> $LOGS_FILE
     VALIDATE $? "package installation"
  else
     echo -e "$package Already installe ... $Y skipping now $N"
  fi
done
      
