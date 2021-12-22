#!/bin/bash

# See if script is running as root
if [ "$(id -u)" -ne 0 ]
then
    echo "ERROR! This script must be run by root"
    echo ""
    echo "Stopping the script ..."
    echo ""
    echo "==============================================="   
    exit 1
fi

#copy first 39 lines to temp file
head -39 firstrun.sh > result.sh

# add all commands to temp file
echo "#Start fallback preconfig" >> result.sh
echo "file=\"/etc/dhcpcd.conf\"" >> result.sh
echo "sed -i 's/#profile static_eth0/profile static/' \$file" >> result.sh
echo "sed -i 's/#static ip_address=192.168.1.23/static ip_address=192.168.168.168/' \$file" >> result.sh
echo "line=\`grep -n ' # fallback to static profile' \$file | awk -F: '{ print \$1}'\`" >> result.sh
echo "sed -i \"\$line,\$ s/#interface eth0/interface eth0/\" \$file" >> result.sh
echo "sed -i 's/#fallback static_eth0/arping 192.168.66.6\nfallback static_eth0/' \$file" >> result.sh
echo "#end fallback preconf" >> result.sh

#copy last 3 files to temp file
tail -3 firstrun.sh >> result.sh

#replace firtrun with temp file
cp ./result.sh  ./firstrun.sh

#rm temp file
rm -f ./result.sh