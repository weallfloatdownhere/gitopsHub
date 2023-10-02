#!/usr/bin/env bash

echo "${0}"

for hookdir in "$(find $(git rev-parse --show-toplevel)/* -name ".hooks" -type d)" ; do
  for hookscript in $hookdir/*; do
    $hookscript;
  done
done