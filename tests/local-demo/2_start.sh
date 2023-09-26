#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
KUBECONFIG="$SCRIPT_DIR/demo/kubeconfig-manager.conf"
minikube delete --all
rm -rf $KUBECONFIG
minikube start -p manager --memory 3078 --cpus 2 --network bridge
kubectl config view --context manager --flatten --minify > k.tmp
mv k.tmp $KUBECONFIG
	