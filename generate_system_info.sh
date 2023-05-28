#!/bin/bash

if [[ $# -eq 0 ]] ; then
    echo 'No output file provided,exiting'
    exit 1
elif [[ $# -ge 2 ]] ; then
    echo "too many arguments provided"
    exit 1
fi

filename=$1
root_dir=$(pwd)
if ! command -v lshw &> /dev/null
then
    echo "lshw could not be found"
    echo "installing lshw..."
    sudo apt-get update
    sudo apt-get install lshw
fi
# system info
sudo lshw -html -disable scsi -sanitize > $root_dir/report.html


## file of informations
touch $root_dir/$filename
# OS
echo "OS INFO" >> $root_dir/$filename
uname -a >> $root_dir/$filename
echo "-------------------" >> $root_dir/$filename
# GPU info
if ! command -v glxinfo &> /dev/null
then 
    echo "glxinfo could not be found"
else
    echo "GPU INFO" >> $root_dir/$filename
    glxinfo -B >> $root_dir/$filename
    exit 0
fi