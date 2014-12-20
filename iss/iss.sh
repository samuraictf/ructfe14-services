#!/bin/sh

cd /home/iss

while true; do
    ./iss >> /home/iss/log.txt 2>&1
    sleep 5
done
