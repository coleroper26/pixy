#!/bin/bash
# /home/pi/pixy/util/update-blocklist.sh

## pull /home/pi/pixy from www.github.com/coleroper26/pixy
git -C pull /home/pi/pixy

## reconfigure Squid proxy
squid -k reconfigure

