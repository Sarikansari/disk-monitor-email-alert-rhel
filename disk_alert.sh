#!/bin/bash

#monitoring the free fs space disk
FU=$(df -h | grep "nvme0n1p2" | awk '{print $5}' | tr -d %)
TO="sarik5720@gmail.com"

if [[ $FU -ge 30 ]]
then
        echo "Warning, disk space is low - $FU %" | mail -s "Disk SPACE ALERT!" $TO
else
        echo "Disks are in good"
fi
