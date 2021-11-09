#!/bin/sh

# setup
echo 1 > /proc/sys/net/ipv4/ip_forward  # enable ipv4 packet forwarding
modprobe ip_tables                      # load iptables module
modprobe ip_conntrack                   # track connections

## cleanup
iptables -F         # flush primary table
iptables -t nat -F  # flush nat table
iptables -X         # delete user-defined chains

## transparent out of eth0 from eth1
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

## redirect all port 80 traffic to port 3128
iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 3128

