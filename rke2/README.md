# RKE2 Installation

This directory contains scripts to install and configure RKE2. It is intended to ease installation on baremetal and is based on scripts used in the [uds_rke2_image_builder repository](https://github.com/defenseunicorns/uds-rke2-image-builder).

Simply modify the `start-node.sh` script to use your desired bootstrap node IP or hostname, cluster token, and kube API SAN(s), copy all of the scripts onto the machine(s) you want to configure as RKE2 node(s) and execute the `start-node.sh`.

If RKE2 needs reinstalled, run the rke_uninstall command and rerun the `start-node.sh` in this directory. Make sure to not include the `os-prep.sh` in subsequent installs.

# Disconnected Baremetal Node

*This section has only been tested on RHEL 8.9 with RKE2 installed via airgap tarball method*

TLDR;
Connected to legit network, install and start RKE2

RKE2 expects there to be a default route and an interface with an assigned IP address before it will startup. The `dummy-nic.sh` script can be run on a host to either enable installing RKE2 while that host is not connected to a network (assuming you have all of the airgap tarballs available on the machine), or a host that already has RKE2 installed that has been disconnected from a network to enable RKE2 to start up while being disconnected. If you want an RKE2 host to work both while connected to a network and while disconnected, ensure that the same IP settings are used for the dummy interface as the network that you use when RKE2 is connected. If during startup the host IP doesn't match the IP that RKE2 was installed with, etcd will not start properly since it doesn't think the host is a member of the etcd cluster.

If you have a baremetal node with RKE2 preinstalled and you need it to start without being connected to a network, simply edit the `dummy-nic.sh` script to use the IP settings that RKE2 was installed with and then run the script. It will stop RKE2, create the dummy interface, and then restart RKE2. Now you should be able to interact with the cluster and access services locally on the machine while being disconnected. To use it connected again, power the system down, reconnect networking cables, and power back up. The dummy interface will be gone, and the default interface will be configured for the network you are attached to again.
