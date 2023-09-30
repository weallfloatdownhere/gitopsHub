#/usr/bin/env bash

(
cd $(git rev-parse --show-toplevel)
export KUBECONFIG="$PWD/manager/manager.kubeconfig"
rm -rf ~/.kube/config $KUBECONFIG
minikube delete --all && minikube start -p manager --memory 3078 --cpus 2 --network bridge
kubectl config view --context manager --flatten --minify > manager/k.tmp
mv manager/k.tmp $KUBECONFIG
)