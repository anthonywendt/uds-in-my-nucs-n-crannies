#!/bin/bash
set -e

# Setup RKE2 configuration files
config_dir=/etc/rancher/rke2
config_file=$config_dir/config.yaml
mkdir -p $config_dir

cp -f rke2-config.yaml $config_file
chown -R root:root $config_file