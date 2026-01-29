#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
  echo "Please run this script with root user access"
  exit 1
fi

VALIDATE(){
if [ $1 -ne o ]; then
  echo " Installing $2..FAILURE"
  exit 1
else
  echo " Installing $2..SUCCESS"
fi
}

dnf install nodejs -y
VALIDATE $? "Installing nodejs"

dnf install mysql -y
VALIDATE $? "Installing MySQL"

dnf install nginx -y
VALIDATE $? "Installing nginx"
