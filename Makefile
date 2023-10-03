.SILENT:

#!make
include $(COREFILE)
export $(shell sed 's/=.*//' "$(COREFILE)" 2>&1)

STATIC_DIR_ARGO=${PWD}/management/argo
STATIC_FILE_BOOTSTRAP=${PWD}/management/bootstrap/core/bootstrap.yaml

deps:
	- curl -sLS https://get.arkade.dev | sudo sh
	- arkade get kubectl
	- arkade get kustomize
	- arkade get helm
	- arkade get task

fails:
ifndef KUBECONFIG
$(error KUBECONFIG is not set)
endif
	if [ ! -f "$(KUBECONFIG)" ]; then echo "ERROR - Specified KUBECONFIG does NOT exists. Current config -> $(KUBECONFIG)" && exit 1; fi


local:
	KUBECONFIG=${PWD}/minikube.kubeconfig make -C ./provisioning/clusters/minikube start


.PHONY: install
install:
	make fails
	export KUBECONFIG=$(KUBECONFIG)
	export SOURCE_REPO=$(git ls-remote --get-url origin)
	kustomize build --enable-alpha-plugins --load-restrictor=LoadRestrictionsNone ${STATIC_DIR_ARGO} | kubectl apply -f -
	kubectl wait --for=condition=available deployment -l "app.kubernetes.io/name=argocd-server" -n argocd --timeout=300s
	envsubst < ${STATIC_FILE_BOOTSTRAP} | kubectl apply -f -

#rm -rf $(KUBECONFIG)