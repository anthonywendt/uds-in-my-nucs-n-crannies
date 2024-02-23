# RKE2 Installation

This directory contains scripts to install and configure RKE2. It is intended to ease installation on baremetal and is based on scripts used in the [uds_rke2_image_builder repository](https://github.com/defenseunicorns/uds-rke2-image-builder).

Simply modify the `start-node.sh` script to use your desired bootstrap node IP or hostname, cluster token, and kube API SAN(s), copy all of the scripts onto the machine(s) you want to configure as RKE2 node(s) and execute the `start-node.sh`.

If RKE2 needs reinstalled, run the rke_uninstall command and rerun the `start-node.sh` in this directory. Make sure to not include the `os-prep.sh` in subsequent installs.