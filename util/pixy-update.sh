#!/bin/bash
##/pixy/util/pixy-update.sh


## pull /pixy from www.github.com/coleroper26/pixy
git -C pull /pixy

## stop services
systemctl stop squid.service
systemctl stop udhcpd.service
systemctl stop networking.service

## network interfaces
mv /etc/network/interfaces /etc/network/interfaces.bak  # backup
mv /pixy/config/interfaces /etc/network/interfaces      # replace
systemctl start networking.service                      # start
/pixy/util/iptables-setup.sh                            # setup iptables

## udhcpd
/pixy/util/udhcpd-setup.sh                              # setup udhcpd

## squid
mv /etc/squid/squid.conf   /etc/squid/squid.conf.bak    # backup
mv /pixy/config/squid.conf /etc/squid/squid.conf        # replace
systemctl start squid.service                           # start
