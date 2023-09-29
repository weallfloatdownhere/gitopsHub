#!/usr/bin/env bash

export KUBECONFIG="$(git rev-parse --show-toplevel)/manager/manager.kubeconfig"
rm -rf ~/.kube/config
rm -rf $KUBECONFIG
minikube delete --all
minikube start -p manager --memory 3078 --cpus 2 --network bridge
kubectl config view --context manager --flatten --minify > $(git rev-parse --show-toplevel)/manager/k.tmp
mv $(git rev-parse --show-toplevel)/manager/k.tmp $KUBECONFIG