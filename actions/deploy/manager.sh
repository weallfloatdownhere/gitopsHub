#!/usr/bin/env bash

# set -o errexit
# set -o nounset
set -o pipefail

USAGE="./$(basename "$0") [KUBECONFIG] [CONTEXT]"

if [[ -z "${1}" ]] || [[ -z "${2}" ]] ; then
  echo "$USAGE"
  exit 1
elif [ ! -f "$(realpath "${1}")" ]; then
  echo "ERROR - Specified kubeconfig file not found: $(realpath "${1}")"
  exit 1
fi

export CONTEXT="${2}"
export KUBECONFIG="$(realpath "${1}")"

read -p "You are about to initialize a kubernetes cluster.
Kubeconfig file : $KUBECONFIG
Context         : $CONTEXT

Press ENTER to continue or CTRL-C to Abort..."

kubectl apply -k "$(git rev-parse --show-toplevel)/management/resources/argocd/overlays/current"
sleep 1
kubectl wait --for=condition=available deployment -l "app.kubernetes.io/name=argocd-server" -n argocd --timeout=300s
sleep 1
kubectl apply -f "$(git rev-parse --show-toplevel)/management/applications/root.yaml"
sleep 1
kubectl get pods -n argocd