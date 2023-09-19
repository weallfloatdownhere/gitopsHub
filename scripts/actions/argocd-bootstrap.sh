#!/usr/bin/env bash


if [[ ! -z "$KUBECONFIG" ]]; then
echo "ERROR - KUBECONFIG is empty."
exit 1
elif [[ ! -f "$KUBECONFIG" ]]; then
echo "ERROR - Kubeconfig file ($KUBECONFIG) not found.."
exit 1
fi

kubectl apply -k "$ARGO_DIR"
sleep 1
kubectl wait --for=condition=available deployment -l "app.kubernetes.io/name=argocd-server" -n argocd --timeout=300s
kubectl apply -f "$ARGO_BOOTSTRAP_APP"