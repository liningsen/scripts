#!/bin/sh

sudo ifconfig enp0s3 down
sleep 3
sudo ifconfig enp0s3 up
