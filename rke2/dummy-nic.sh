#!/bin/bash

# This script creates a dummy interface, default route, and a nameserver entry to support running RKE2 on baremetal without being connected to any network.
# If RKE2 is installed while connected, make sure to update the IPs to match the network that RKE2 was installed with otherwise etcd will not start up.
#
# The server can also be reconnected to a network as long as it is assigned the same IP that RKE2 was installed with. Simply power the machine off, reconnect
# networking cables, and power the machine back on. On startup, the dummy interface should be gone and the default interface should be configured instead, and
# RKE2 should be running or in the process of starting back up

# Stop RKE2 that is probably failing to start
sudo systemctl stop rke2-server

# Create dummy interface
sudo ip link add dummy0 type dummy
sudo ip link set dummy0 up
sudo ip addr add 192.168.4.82/16 dev dummy0
sudo ip route add default via 192.168.0.1 dev dummy0 metric 100

# Restart RKE2
echo "Restarting RKE2..."
sudo systemctl restart rke2-server