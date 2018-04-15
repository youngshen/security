#!/bin/bash
if [ ! -n "$1" ] ;then
 echo "Usage: ./arping.sh [interface]"
 echo "Example: ./arping.sh eth0"
 echo "Example will perform an ARP scan of the local subnet to which eth0 is assigned"
 exit
fi
rm ./addr.txt
interface=$1
prefix=$(ifconfig $interface | grep 'inet 1' | cut -d 't' -f 2 | cut -d ' ' -f 2 | cut -d '.' -f 1-3)
for addr in $(seq 1 254);do
 #echo $prefix
 echo $addr
 arping -c 1 $prefix.$addr | grep "reply from" | cut -d " " -f 4 >> ./addr.txt
done
