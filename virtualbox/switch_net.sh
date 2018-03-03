#!/bin/sh

read -p "Enter NetSegment : [default:0/1] >> " SEG
if [ "$SEG" = "1" ]; then
    sudo sed -i 's/^IPADDR=192.168.0.9/IPADDR=192.168.1.9/' \
        /etc/sysconfig/network-scripts/ifcfg-enp0s3
    echo "SWITCH TO 192.168.1.9"
elif [ "$SEG" = "0" ]; then
    sudo sed -i 's/^IPADDR=192.168.1.9/IPADDR=192.168.0.9/' \
        /etc/sysconfig/network-scripts/ifcfg-enp0s3
    echo "SWITCH TO 192.168.0.9"
else
    echo "ERROR"
fi

sudo systemctl restart network
echo "SWITCH COMPLETE"
