#!/bin/bash
# /pixy/util/update-pixy.sh
# scheduled updates

## pull /pixy from www.github.com/coleroper26/pixy
git -C pull /pixy

## stop services
systemctl stop squid.service
systemctl stop udhcpd.service
systemctl stop networking.service

## back up configuration files
mv /etc/network/interfaces  /etc/network/interfaces.bak
mv /etc/dhcpd/dhcpd.conf    /etc/dhcpd/dhcpd.conf.bak
mv /etc/squid/squid.conf    /etc/squid/squid.conf.bak

## replace configuration files
mv /pixy/config/interfaces /etc/network/interfaces
mv /pixy/config/dhcpd.conf /etc/dhcpd/dhcpd.conf
mv /pixy/config/squid.conf /etc/squid/squid.conf

## start services
systemctl start networking.service
systemctl start udhcpd.service
systemctl start squid.service

