# Irimia David was here on 18-11-2024-17:52!

#!/bin/bash

dns=$1

validare_ip() {
   local name=$1
   local ip=$2
   local dns=$3

   ip_nslookup=$(nslookup "$name" "$dns"  | grep 'Address:' | head -n 2 | tail -n 1 | cut -d ' ' -f 2)

   if [[ "$ip_nslookup" != "$ip" ]]; then
        echo "Bogus IP for $name in /etc/hosts!"
   fi

}

cat /etc/hosts | while read -r  ip name
do
    if [[ "$ip" == \#* ]]; then
	break
    fi
    
    validare_ip "$name" "$ip" "$dns"
done
