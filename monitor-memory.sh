#!/bin/bash 
#######################################################################################
#Script Name    :monitor-memory.sh
#Description    :Bash script send alert mail when server memory is running low
#Args           :       
#Author         :Abdalluh Mostafa
#Email          :abdalluh.mostafa@gmail.com     
#######################################################################################
## Declare mail variables
##Email subject 
subject="Server Memory Status Alert"
##Sending mail as
from="server@domain.com"
## Sending mail to
to="admin@domain.com"
## Send carbon copy to
also_to="admin2@domain.com"

## get total free memory size in megabytes(MB) 
free=$(free -mt | grep Total | awk '{print $4}')

## check if free memory is less or equals to  100MB
if [[ "$free" -le 100  ]]; then
        ## get top processes consuming system memory and save to temporary file 
        ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head >/tmp/top_proccesses_consuming_memory.txt

        file=/tmp/top_proccesses_consuming_memory.txt
        ## send email if system memory is running low
        echo -e "Warning, server memory is running low!\n\nFree memory: $free MB" | mailx -a "$file" -s "$subject" -r "$from" -c "$to" "$also_to"
fi

exit 0

