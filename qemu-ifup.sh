#!/bin/sh
set -x

switch=br0

ip link add $switch type bridge
ip addr add 10.10.10.1/24 broadcast 10.10.10.255 dev $switch
ip link set $switch up

if [ -n "$1" ];then
        # tunctl -u `whoami` -t $1 (use ip tuntap instead!)
        ip tuntap add $1 mode tap user `whoami`
        ip link set $1 up
        sleep 0.5s
        # brctl addif $switch $1 (use ip link instead!)
        ip link set $1 master $switch
	# Add NAT
	iptables -t nat -A POSTROUTING -o wlx503eaab0800a -j MASQUERADE
        exit 0
else
        echo "Error: no interface specified"
        exit 1
fi
