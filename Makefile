.SILENT:

#!make
include ${SECRETFILE}
export $(shell sed 's/=.*//' "${SECRETFILE}" 2>&1)

KUBECONFIG=${PWD}/manager.kubeconfig
STATIC_DIR_ARGO=${PWD}/manager/argo
STATIC_FILE_BOOTSTRAP=${PWD}/manager/bootstrap/core/bootstrap.yaml
STATIC_FILE_CLUSTER_CONF=${PWD}/manager/bootstrap/configuration.yaml

deps:
	- curl -sLS https://get.arkade.dev | sudo sh
	- arkade get kubectl
	- arkade get kustomize
	- arkade get helm

local:
	export KUBECONFIG=$(KUBECONFIG)
	make -C ./infrastructure/kubernetes/minikube start

clean:
	export KUBECONFIG=$(KUBECONFIG)
	- kustomize build --enable-alpha-plugins --load-restrictor=LoadRestrictionsNone ${STATIC_DIR_ARGO} | kubectl delete -f -

install:
	if [ -z "${SECRETFILE}" ]; then echo "ERROR - You need to set the SECRETFILE variable.. eg: export SECRETFILE=/my/dir/secrets.conf" && exit 1; fi
	export KUBECONFIG=$(KUBECONFIG)
	make read_kubeconf
	kustomize build --enable-alpha-plugins --load-restrictor=LoadRestrictionsNone ${STATIC_DIR_ARGO} | kubectl apply -f -
	kubectl wait --for=condition=available deployment -l "app.kubernetes.io/name=argocd-server" -n argocd --timeout=300s
	envsubst < ${STATIC_FILE_BOOTSTRAP} | kubectl apply -f -
	rm -rf $(KUBECONFIG)

read_kubeconf:
	if [ -z "${SOURCE_KUBECONFIG}" ]; then echo "ERROR - SOURCE_KUBECONFIG variable not found in ${SECRETFILE}" && exit 1; fi	
	echo $(SOURCE_KUBECONFIG) | base64 -d > ${KUBECONFIG}