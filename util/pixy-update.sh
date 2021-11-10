#!/bin/bash
##/pixy/util/pixy-update.sh


# GENERAL CONFIG
echo -e "[PIXY-UPDATE]\tGENERAL CONFIG\t"

## pull /pixy from www.github.com/coleroper26/pixy
git -C /pixy pull
echo -e "[PIXY-UPDATE]\tDONE\tgit"

## crontab
crontab -r                              # remove
crontab /pixy/config/crontab-root       # replace
echo -e "[PIXY-UPDATE]\tDONE\tcrontab"

## rc.local
mv /etc/rc.local /etc/rc.local.bak      # backup
cp /pixy/config/rc.local /etc/rc.local  # replace
echo -e "[PIXY-UPDATE]\tDONE\trc.local\n"



# SERVICES
echo -e "[PIXY-UPDATE]\tSERVICES\t"

## stop services
systemctl stop squid.service
systemctl stop udhcpd.service
systemctl stop networking.service
echo -e "[PIXY-UPDATE]\tDONE\tservices stopped"

## network interfaces
mv /etc/network/interfaces /etc/network/interfaces.bak  # backup
cp /pixy/config/interfaces /etc/network/interfaces      # replace
systemctl start networking.service                      # start
/pixy/util/iptables-setup.sh                            # setup iptables
echo -e "[PIXY-UPDATE]\tDONE\tnetworking.service"

## udhcpd
/pixy/util/udhcpd-setup.sh                              # setup udhcpd
echo -e "[PIXY-UPDATE]\tDONE\tudhcpd.service"

## squid
mv /etc/squid/squid.conf   /etc/squid/squid.conf.bak    # backup
cp /pixy/config/squid.conf /etc/squid/squid.conf        # replace
systemctl start squid.service                           # start
echo -e "[PIXY-UPDATE]\tDONE\tsquid.service\n"

