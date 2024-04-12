#!/bin/bash

# Helper script intended to be run on a RHEL or Ubuntu machine to configure and install RKE2
sudo ./install-deps.sh
sudo ./rke2-install.sh
# sudo ./os-prep.sh # Appends lines to grub. Don't rerun this multiple times
sudo ./rke2-config.sh
sudo ./rke2-startup.sh -t my-awesome-cluster-token -s 192.168.4.82 -T "rhel-devbox rhel-direct"
# Copy the kubeconfig and kubectl into locations for current user to use
mkdir -p ~/.kube
sudo cp /etc/rancher/rke2/rke2.yaml ~/.kube/config
sudo chown $USER:$USER ~/.kube/config
sudo cp /var/lib/rancher/rke2/bin/kubectl /usr/local/bin/kubectl
sudo chmod +x /usr/local/bin/kubectl