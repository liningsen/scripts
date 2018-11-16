#!/bin/sh
PID=`ps -ef | grep wpa | grep -v grep | awk 'BEGIN{FS=" "}{print $2}'`
if [[ ! -z $PID ]]; then
	echo "wpa_supplicant is running " $PID
	echo "kill complete"
else
	echo "wpa_supplican is NOT running"
	ip link set wlp4s0 up
	wpa_supplicant -B -i wlp4s0 -c /etc/wpa_supplicant/LeeAP.conf
	dhcpcd wlp4s0
fi
echo "Complete"
