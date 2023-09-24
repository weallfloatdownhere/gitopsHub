#!/usr/bin/env bash

# set -o errexit
# set -o nounset
set -o pipefail

GIT_ROOT=$(git rev-parse --show-toplevel)

read -p "You are about the clean your whole local development stack.

Press enter to continue or CTRL-C to abort..."

echo "Wiping minikube running clusters.."
minikube delete --all --purge | true
echo "Deleting default ~/.kube/config file.."
rm -rf ~/.kube/config
echo "Deleting the local development workspace directory.."
rm -rf "$GIT_ROOT/.workspace"
echo "Done."
