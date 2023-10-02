#!/usr/bin/env bash

# Run all repository hooks scripts.

for hookdir in "$(find $(git rev-parse --show-toplevel)/* -name ".hooks" -type d)" ; do
  for hookscript in $hookdir/*; do
    $hookscript;
  done
done