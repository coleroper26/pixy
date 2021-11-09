#!/bin/bash

## check if domain name servers provided
# dns=$(grep -h "nameserver" "/etc/resolv.conf" | sed "s/^.* //")
DNS=$(grep -h "nameserver" "/home/pi/tmp.txt" | sed "s/^.* //")

# [[ -z "$dns" ]] && echo "Empty" || echo "Not empty"
([[ ! -z "$DNS" ]]) || DNS="8.8.8.8 8.8.4.4"
# (($dns)) || dns="8.8.8.8 8.8.4.4"

echo "option dns ${DNS}" >> "/home/pi/tmp.txt"
DNS_UDHCP="option dns ${DNS}"

echo $DNS_UDHCP

