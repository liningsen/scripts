#!/bin/sh

#wifi-menu -o wlp0s20f0u9

sudo dhcpcd $(ip link | grep enp | awk -F ':' '{print $2}')
