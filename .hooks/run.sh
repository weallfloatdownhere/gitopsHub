#!/usr/bin/env bash

# Run all repository hooks scripts.

for hookdir in "$(find $(git rev-parse --show-toplevel)/ -name ".hooks" -type d)" ; do
  for hookscript in $hookdir/*; do
    if [[ "$(basename ${0})" != "$(basename $hookscript)" ]]; then
      $hookscript;
    fi
  done
done

#for hookdir in "$(find $(git rev-parse --show-toplevel)/* -name ".hooks" -type d)" ; do
#  for hookscript in $hookdir/*; do
#    $hookscript;
#  done
#done