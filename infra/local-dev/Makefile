#!make
include config.env
export $(shell sed 's/=.*//' config.env)

KUBECONFIG := $(shell git rev-parse --show-toplevel)/manager/manager.kubeconfig
TMPCONF := $(shell git rev-parse --show-toplevel)/manager/k.tmp

.EXPORT_ALL_VARIABLES:

start:
	export KUBECONFIG=$(TMPCONF)
	minikube delete -p manager
	minikube start -p manager --cpus $$MINIKUBE_CPUS --memory $$MINIKUBE_RAM --network bridge
	kubectl config view --context manager --flatten --minify > $(TMPCONF) 
	mv $(TMPCONF) $(KUBECONFIG)
	export KUBECONFIG=$(KUBECONFIG)
	watch kubectl get pods -A

stop:
	minikube delete --all
	minikube stop