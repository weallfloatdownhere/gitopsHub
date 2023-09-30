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
	exit 0

stop:
	minikube delete --all
	minikube stop
	exit 0

install:
	sudo apt-get -y update
	sudo apt-get install -y kubectl virtualbox docker curl
	curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
	sudo install minikube-linux-amd64 /usr/local/bin/minikube