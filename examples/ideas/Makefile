.SILENT:

STATIC_DIR_ARGO=${PWD}/infrastructure/manager/argo-cd
STATIC_FILE_BOOTSTRAP=${PWD}/infrastructure/manager/bootstrap/bootstrap.yaml
STATIC_MINIKUBE_PROVISION=${PWD}/provisioning/kubernetes/minikube

deps:
	- curl -sLS https://get.arkade.dev | sudo sh
	- arkade get kubectl
	- arkade get kustomize
	- arkade get helm
	- arkade get task

local:
	rm -rf ${PWD}/minikube.kubeconfig
	make -C ${STATIC_MINIKUBE_PROVISION} start
	echo "SUCCES - Generated file: ${PWD}/minikube.kubeconfig"

install:
ifndef KUBECONFIG
	$(error KUBECONFIG is undefined)
endif
	#kustomize build --enable-alpha-plugins --load-restrictor=LoadRestrictionsNone ${STATIC_DIR_ARGO} | KUBECONFIG=${KUBECONFIG} kubectl apply -f -
	KUBECONFIG=${KUBECONFIG} kubectl apply -k ${STATIC_DIR_ARGO}
	KUBECONFIG=${KUBECONFIG} kubectl wait --for=condition=available deployment -l "app.kubernetes.io/name=argocd-server" -n argocd --timeout=300s
	SOURCE_REPO="$(shell git ls-remote --get-url origin)" envsubst < ${STATIC_FILE_BOOTSTRAP} | KUBECONFIG=${KUBECONFIG} kubectl apply -f -