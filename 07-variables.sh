#!/bin/bash

echo "All args passed to script : $@"
echo "Number of variables passed to script : $#"
echo "Script name : $0"
echo "Present working directry : $PWD"
echo "Home directory of the present user : $HOME"
echo "who is runnning the script : $USER"
echo "PID of the script : $$"
sleep 100 &
echo "PID of recently executed script : $!"
echo "All args passed to script : $*"