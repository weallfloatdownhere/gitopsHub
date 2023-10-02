#/usr/bin/env bash

GIT_ROOT=$(git rev-parse --show-toplevel)
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

for d in "$GIT_ROOT/manager/bootstrap/*" ; do
  for FILE in $d/*; do
    YAML=$(basename $FILE);
    WAVE=$(basename $(dirname $FILE) | cut -d '-' -f3);
    yq -i e '.metadata.annotations.["argocd.argoproj.io/sync-wave"] = "env(WAVE)"' $YAML;
  done
done