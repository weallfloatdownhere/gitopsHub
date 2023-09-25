#!/usr/bin/env bash

set -o pipefail

if [[ -z "${1}" ]] || [[ -z "${2}" ]] ; then
  echo "./$(basename "$0") [KUBECONFIG] [CONTEXT]"
  exit 1
elif [ ! -f "$(realpath "${1}")" ]; then
  echo "ERROR - Specified kubeconfig file not found: $(realpath "${1}")"
  exit 1
fi

export GIT_ROOT=$(git rev-parse --show-toplevel)
export CONTEXT="${2}"
export KUBECONFIG="$(realpath "${1}")"

# https://cluster-api.sigs.k8s.io/tasks/certs/using-custom-certificates
# https://cluster-api.sigs.k8s.io/tasks/certs/generate-kubeconfig

kubectl apply -k "$GIT_ROOT/management/resources/argocd/overlays/current"
sleep 1
kubectl wait --for=condition=available deployment -l "app.kubernetes.io/name=argocd-server" -n argocd --timeout=300s
sleep 1
kubectl apply -f "$GIT_ROOT/management/root.yaml" -n argocd
sleep 1
kubectl get pods -n argocd