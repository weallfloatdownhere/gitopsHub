#!/usr/bin/env bash

# VBoxManage dhcpserver add --ifname vboxnet0 --ip 192.168.56.100 --netmask 255.255.255.0 --lowerip 192.168.56.101 -upperip

# set -o errexit
# set -o nounset
set -o pipefail

VBoxManage dhcpserver remove --netname vboxnet3
VBoxManage dhcpserver add --netname vboxnet3 --ip 192.168.10.1 --netmask 255.255.255.0 --lower-ip 192.168.10.100 --upper-ip 192.168.10.120 --enable
VBoxManage dhcpserver restart vboxnet3

GIT_ROOT=$(git rev-parse --show-toplevel)

(
  cd "$(dirname $0)" \
  && vagrant destroy -f \
  && vagrant up --provision
)