#!/bin/bash

cat /etc/hosts | while read -r  ip name
do
    if [[ "$ip" == \#* ]]; then
	break
    fi
	
    if [ "$name" == "localhost" ] ||  [ "$name" == "FMI" ]; then
	ip_nslookup=$(nslookup "$name"  | grep 'Address:' | head -n 2 | tail -n 1 | cut -d ' ' -f 2)
    else
    	ip_nslookup=$(nslookup "$name" 8.8.8.8 | grep 'Address:' | head -n 2 | tail -n 1 | cut -d ' ' -f 2)
    fi

    if [[ "$ip_nslookup" != "$ip" ]]; then
	echo "Bogus IP for $name in /etc/hosts!"
    fi
done
