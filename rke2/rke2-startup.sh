#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Script must be run as root"
  exit 1
fi

if [ $# -eq 0 ]; then
  exit 1
fi

while getopts "t:T:s:a" o; do
  case "${o}" in
    t) token=${OPTARG} ;;
    T) tls_sans=${OPTARG} ;;
    s) server_host=${OPTARG} ;;
    a) agent=1 ;;
    *) exit 1 ;;
  esac
done

# Setup config file server, token, and TLS SANs
echo "Updating RKE2 Config file"
config_file=/etc/rancher/rke2/config.yaml

node_ip=$(ip route get $(ip route show 0.0.0.0/0 | grep -oP 'via \K\S+') | grep -oP 'src \K\S+')
if [ "$server_host" != "$node_ip" ]; then
  echo "Adding Cluster Join Server IP: ${server_host}"
  echo "server: https://${server_host}:9345" | tee -a $config_file >/dev/null
fi
if [ "$token" ]; then
  echo "token: ${token}" | tee -a $config_file >/dev/null
fi
if [ "${tls_sans}" ]; then
  echo "Adding TLS SANs: ${tls_sans}"
  echo "tls-san:" | tee -a $config_file >/dev/null
  for san in $tls_sans
  do
    echo "  - \"${san}\"" | tee -a $config_file >/dev/null
  done
fi

# Start RKE2
echo "Starting RKE2 service"
if [ -z $agent ]; then
  systemctl enable rke2-server.service
  systemctl start rke2-server.service
else
  systemctl enable rke2-agent.service
  systemctl start rke2-agent.service
fi