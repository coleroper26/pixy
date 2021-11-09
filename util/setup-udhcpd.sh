#!/bin/bash

# CONFIG

## remove previous config
rm /etc/udhcpd.conf

## copy base config  to /etc/udhcpd.conf
cp /pixy/config/udhcpd.conf /etc/udhcpd.conf


# DNS

## get dns servers provided by eth0
# DNS=$(grep -h "nameserver" "/etc/resolv.conf" | sed "s/^.* //")
DNS=$(grep -h "nameserver" "/etc/resolv.conf" | sed "s/^.* //" | tr "\n" " ")
# DNS="${DNS//\\n/ }"

## if no dns servers were provided, use 8.8.8.8 and 8.8.4.4
([[ ! -z "$DNS" ]]) || DNS="8.8.8.8 8.8.4.4"

## append the dns servers to /etc/udhcpd.conf
echo $"option dns ${DNS}" >> "/etc/udhcpd.conf"


# SERVICE

# start udhcpd.service
systemctl start udhcpd.service

