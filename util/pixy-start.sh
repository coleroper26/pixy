#!/bin/bash
##/pixy/util/pixy-start.sh


## setup iptables
/pixy/util/iptables-setup.sh

## setup udhcpd
/pixy/util/udhcpd-setup.sh

echo -e "[PIXY-START]\tDONE\n"
