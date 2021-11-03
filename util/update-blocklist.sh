#!/bin/bash
# /home/pi/pixy/util/update-blocklist.sh

## pull /pixy from www.github.com/coleroper26/pixy
git -C pull /pixy

## reconfigure Squid proxy
squid -k reconfigure

