#!/bin/bash

/usr/sbin/apache2ctl -D FOREGROUND &
echo "perm loop"

while true 
do
    if [ "$(find /var/www/html -mmin -1)" ]
	then
		echo "setting perms"
		cd /var/www/html
		chmod -R 777 .
	fi
	sleep 5
done
