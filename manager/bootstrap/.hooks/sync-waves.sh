#/usr/bin/env bash

echo "${0}"

for d in "$(git rev-parse --show-toplevel)/manager/bootstrap/*" ; do
  for FILE in $d/*; do
    wave='"'$(basename $(dirname $FILE) | cut -d '-' -f3)'"' yq -i e '.metadata.annotations.["argocd.argoproj.io/sync-wave"] = env(wave)' $FILE;
  done
done