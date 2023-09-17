#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
CLI_VCLUSTER_URL="https://github.com/loft-sh/vcluster/releases/latest/download/vcluster-linux-amd64"
CLI_VCLUSTER_DST="$SCRIPT_DIR/vcluster"
if [[ ! -f "$CLI_VCLUSTER_DST" ]]; then
curl -L -o "$CLI_VCLUSTER_DST" "$CLI_VCLUSTER_URL"
fi
chmod +x "$CLI_VCLUSTER_DST"