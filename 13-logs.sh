#!/bin/bash

LOGS_FOLDER="/var/log/shell-script"
LOGS_FILE="/var/log/shell-script/$0.log"

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
  echo "Please run this script with root user access"
  exit 1
fi

mkdir -p $LOGS_FOLDER

VALIDATE(){
if [ $1 -ne o ]; then
  echo " Installing $2..FAILURE"
  exit1
else
  echo " Installing $2..SUCCESS"
fi
}

dnf install nodejs -y &>> $LOGS_FILE
VALIDATE $? "Installing nodejs"

dnf install mysql -y &>> $LOGS_FILE
VALIDATE $? "Installing MySQL"

dnf insstall nginx -y &>> $LOGS_FILE
VALIDATE $? "Installing nginx"
