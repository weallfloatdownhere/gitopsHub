# https://raw.githubusercontent.com/vmware-tanzu/cluster-api-provider-bringyourownhost/main/hack/install-host-agent-service.sh

#!/usr/bin/env bash

# Copyright 2022 VMware, Inc. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0
# Compatible with: Ubuntu 20.04.*
# Binary download: https://github.com/vmware-tanzu/cluster-api-provider-bringyourownhost/releases/download/v0.4.0/byoh-hostagent-linux-amd64
# Usage: ./install-host-agent-service.sh path/to/agent/binary

set -o errexit
set -o nounset
set -o pipefail

source /etc/os-release

if [[ "$NAME" != "Ubuntu" ]]; then
echo "System is not an Ubuntu distribution."
exit 1
elif [[ "$VERSION_ID" != *"20.04"* ]]; then
echo "Compatible with: Ubuntu 20.04.*"
exit 1
fi



BIN_DIRECTORY=$(git rev-parse --show-toplevel)
BIN="$BIN_DIRECTORY/bin/byoh-hostagent-linux-amd64"

# Check binary and create one if it doesn't exists
if [[ ! -f "$BIN" ]]
then
    echo "Binary doesn't exists. Creating binary..."
    make host-agent-binaries
else
    BIN="$1"
    BIN_DIRECTORY=$(cd `dirname $1` && pwd)
fi



# Create the services and watchers
cat << EOF > /etc/systemd/system/host-agent.service
[Unit]
Description=host-agent service
After=network.target
[Service]
Type=simple
WorkingDirectory="$BIN_DIRECTORY"
ExecStart="$BIN"
User=root
Group=root
[Install]
WantedBy=multi-user.target
EOF

cat << EOF > /etc/systemd/system/host-agent-watcher.service
[Unit]
Description=host-agent restarter
After=network.target
[Service]
Type=oneshot
ExecStart=/usr/bin/systemctl restart host-agent.service
[Install]
WantedBy=multi-user.target
EOF

cat << EOF > /etc/systemd/system/host-agent-watcher.path
[Path]
Unit=host-agent-watcher.service
PathChanged=/root/.byoh/config
[Install]
WantedBy=multi-user.target
EOF

# Enable and start the watchers and services
systemctl enable host-agent-watcher.{path,service}
systemctl start host-agent-watcher.{path,service}
systemctl enable host-agent.service
systemctl start host-agent.service