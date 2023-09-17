#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

CLI_KUBECTL_URL="https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
CLI_VCLUSTER_URL="https://github.com/loft-sh/vcluster/releases/latest/download/vcluster-linux-amd64"

CLI_KUBECTL_DST="$SCRIPT_DIR/kubectl"
CLI_VCLUSTER_DST="$SCRIPT_DIR/vcluster"

# vcluster
if [ ! -f "$CLI_VCLUSTER_DST" ]; then curl -L -o "$CLI_VCLUSTER_DST" "$CLI_VCLUSTER_URL"; fi
# kubectl
if [ ! -f "$CLI_KUBECTL_DST" ]; then curl -L -o "$CLI_KUBECTL_DST" "$CLI_KUBECTL_URL"; fi

chmod +x "$CLI_KUBECTL_DST" "$CLI_VCLUSTER_DST"