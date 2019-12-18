#/bin/sh

switch=br0

ip link set $switch down
brctl delbr $switch
