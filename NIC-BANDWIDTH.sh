#!/bin/bash
#
# Written by : Roshan Wakode
#
_REPORT_PATH=/root/FACEKEY-NETWORK
_FILE_NAME1=Network-EventLog-`date +%F --date="yesterday"`
_TO_EMAIL=roshanwakode159@gmail.com,xxx@xxx.xxx

if [ ! -f  "$_REPORT_PATH/$_FILE_NAME1" ]
 then
  touch $_REPORT_PATH/$_FILE_NAME1
  echo -e 'Time               ens32\nHH:MM:SS     KB/s in    KB/s out\n-----------------------------------------------------------------------------------------------------------------------' > $_REPORT_PATH/$_FILE_NAME1
 else
  NET=$(ifstat -i eno1 -t -q 1 1 | sed -n '3p')
#Specifiy your adapter name 
  IN=$(echo $NET | awk {'print $2'})
  OUT=$(echo $NET | awk {'print $3'})
  if [[ $IN -ge 10000 && $OUT -le 12000 ]]
#specify bandwidth in KiloBytes per second where you want to restrict
   then
   else
   echo -e "$NET" >> $_REPORT_PATH/$_FILE_NAME1
  fi
fi
### Send Email with attachment
TIME=$(date +'%H%M%S')
if [ $TIME -eq 170000 ]
then
 echo -e "Hello Team, Find Network utilization report of **** machine dated of $(date +%F --date=yesterday),attachment is enclosed in this emai" | mutt -a "$_REPORT_PATH/$_FILE_NAME1" -s "Report: Network utilization Logs For Facekey Machine $(date +%F --date=yesterday)" -- $_TO_EMAIL
fi
sleep 5

