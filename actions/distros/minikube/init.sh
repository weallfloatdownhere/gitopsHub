#!/usr/bin/env bash

# set -o errexit
# set -o nounset
set -o pipefail

USAGE="./$(basename "$0") [CONTEXT] [CONFIG_DST]"

if [[ -z "${1}" ]] || [[ -z "${2}" ]] ; then
  echo "$USAGE"
  exit 1
elif [ -f "$(realpath "${2}")" ]; then
  echo "ERROR - Specified kubeconfig file destination already exists at: $(realpath "${2}")"
  exit 1
fi

export CONTEXT="${1}"
export KUBECONFIG="$(realpath "${2}")"

minikube delete -p $CONTEXT | true
minikube start -p $CONTEXT --memory 3078 --cpus 2 --network bridge
kubectl config view --context $CONTEXT --flatten --minify > .k.tmp
mv .k.tmp $KUBECONFIG

if [ -f "$KUBECONFIG" ]; then
  echo "
  New kubeconfig file generated succesfully at: $KUBECONFIG
  Cluster ip: $(minikube ip -p $CONTEXT)

  $ export KUBECONFIG=$KUBECONFIG
  $ kubectl get pods -A"
  exit 0
fi

echo "ERROR - Something went wrong, cant find the kubeconfig file: $KUBECONFIG"
