#!/bin/bash
##/pixy/util/iptables-setup.sh

# setup
echo 1 > /proc/sys/net/ipv4/ip_forward  # enable ipv4 packet forwarding
modprobe ip_tables                      # load iptables module
modprobe ip_conntrack                   # track connections

## cleanup
iptables -F         # flush primary table
iptables -t nat -F  # flush nat table
iptables -X         # delete user-defined chains

## eth0 -> eth1 transparent
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

## from eth1 IP:80 -> IP:3128
iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 3128

