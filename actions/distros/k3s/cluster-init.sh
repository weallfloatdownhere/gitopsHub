#!/usr/bin/env bash

set -o pipefail

export WORKLOAD_USER="vagrant"
export WORKLOAD_PASSWORD="vagrant"
export WORKLOAD_IP="192.168.121.113"
export WORKLOAD_SSHKEY="$PWD/id_rsa.pub"

sshpass -p $WORKLOAD_PASSWORD ssh-copy-id -i $WORKLOAD_SSHKEY -o StrictHostKeyChecking=no $WORKLOAD_USER@$WORKLOAD_IP

# k3sup install --host $HOST --user ubuntu --ssh-key $HOME/ec2-key.pem