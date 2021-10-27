#!/bin/sh

# ensure ipv4 packet forwarding enabled
echo 1 > /proc/sys/net/ipv4/ip_forward

# cleanup
iptables -F         # flush primary table
iptables -t nat -F  # flush nat table
iptables -X         # delete user-defined chains

# redirect port 80 traffic to port 3128
iptables -t nat -A PREROUTING -m physdev --physdev-in eth1 -p tcp --dport 80 -j REDIRECT --to-port 3128
