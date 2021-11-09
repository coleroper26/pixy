#!/bin/bash
##/pixy/util/pixy-update.sh


## pull /pixy from www.github.com/coleroper26/pixy
git -C /pixy pull
echo -e "[PIXY-UPDATE]\tDONE\tgit pull\n"

## stop services
systemctl stop squid.service
systemctl stop udhcpd.service
systemctl stop networking.service
echo -e "[PIXY-UPDATE]\tDONE\tservices stopped\n"

## network interfaces
mv /etc/network/interfaces /etc/network/interfaces.bak  # backup
mv /pixy/config/interfaces /etc/network/interfaces      # replace
systemctl start networking.service                      # start
/pixy/util/iptables-setup.sh                            # setup iptables
echo -e "[PIXY-UPDATE]\tDONE\tnetwork interfaces\n"

## udhcpd
/pixy/util/udhcpd-setup.sh                              # setup udhcpd
echo -e "[PIXY-UPDATE]\tDONE\tudhcpd\n"

## squid
mv /etc/squid/squid.conf   /etc/squid/squid.conf.bak    # backup
mv /pixy/config/squid.conf /etc/squid/squid.conf        # replace
systemctl start squid.service                           # start
echo -e "[PIXY-UPDATE]\tDONE\tservices started\n"
