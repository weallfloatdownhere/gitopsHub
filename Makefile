.SILENT:

#STATIC_MINIKUBE_PROVISION=${PWD}/provisioning/cluster/minikube
#STATIC_MINIKUBE_KUBECONFIG:=${PWD}/minikube.kubeconfig
#SOURCE_REPO:=$(shell git ls-remote --get-url origin)

STATIC_DIR_ARGO=${PWD}/management/applications/argo
STATIC_FILE_BOOTSTRAP=${PWD}/management/bootstrap/core/bootstrap.yaml

deps:
	- curl -sLS https://get.arkade.dev | sudo sh
	- arkade get kubectl
	- arkade get kustomize
	- arkade get helm
	- arkade get task

local:
	- rm -rf ${PWD}/minikube.kubeconfig
	make -C ${PWD}/provisioning/cluster/minikube start
	echo "SUCCES - Generated file: ${PWD}/minikube.kubeconfig"

install:
ifndef KUBECONFIG
	$(error KUBECONFIG is undefined)
endif
	kustomize build --enable-alpha-plugins --load-restrictor=LoadRestrictionsNone ${STATIC_DIR_ARGO} | KUBECONFIG=${KUBECONFIG} kubectl apply -f -
	KUBECONFIG=${KUBECONFIG} kubectl wait --for=condition=available deployment -l "app.kubernetes.io/name=argocd-server" -n argocd --timeout=300s
	SOURCE_REPO="$(shell git ls-remote --get-url origin)" envsubst < ${STATIC_FILE_BOOTSTRAP} | KUBECONFIG=${KUBECONFIG} kubectl apply -f -