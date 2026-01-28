#!/bin/bash

NUMBER=$1

if [ $NUMBER -gt 20 ]; then
    echo "Given Number: $NUMBER is greater than 20"
 elif [ $NUMBER -eq 20 ]; then
   echo "Given number :$NUMBER is equal to 20"
 elif [ $NUMBER -ne 20 ]; then
    echo "Given number :$Number not equal to 30"
 else
    echo "Given Number: $NUMBER is less than 20"

fi