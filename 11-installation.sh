#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
  echo "Please run this script with root user access"
  exit 1
fi

echo "Installing NodeJS"
dnf install nodejs -y

if [ $? -ne o ]; then
  echo " Installing NodeJS..FAILURE"
  exit1
else
  echo " Installing NodeJS..SUCCESS"
fi

dnf install mysql -y

if [ $? -ne o ]; then
  echo " Installing MySQL..FAILURE"
  exit1
else
  echo " Installing MySQL..SUCCESS"
fi

dnf insstall nginx -y
if [ $? -ne o ]; then
  echo " Installing nginx..FAILURE"
  exit1
else
  echo " Installing Nginx..SUCCESS"
fi
