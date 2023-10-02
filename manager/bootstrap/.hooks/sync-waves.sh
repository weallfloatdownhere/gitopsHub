#/usr/bin/env bash

GIT_ROOT=$(git rev-parse --show-toplevel)

for d in "$GIT_ROOT/manager/bootstrap/*" ; do
  for FILE in $d/*; do
    wave='"'$(basename $(dirname $FILE) | cut -d '-' -f3)'"' yq -i e '.metadata.annotations.["argocd.argoproj.io/sync-wave"] = env(wave)' $FILE;
  done
done