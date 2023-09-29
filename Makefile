ARGO_FLAVOR=flamingo
KUBECONFIG=${PWD}/manager/manager.kubeconfig

clean:
	- kubectl delete -f manager/bootstrap.yaml
	- kubectl delete ns argo-rollouts
	- kubectl delete ns cert-manager
	- kubectl delete ns cluster-api
	- kubectl delete ns capi-operator-system
	- kubectl delete ns kyverno
	- kubectl delete ns flux-system
	- kubectl delete ns argocd

install:
# Cert-manager
	kustomize build --enable-helm --enable-alpha-plugins --load-restrictor=LoadRestrictionsNone manager/resources/cert-manager/overlay | kubectl apply -f -
	kubectl wait --for=condition=available deployment -l "app.kubernetes.io/component=webhook" -n cert-manager --timeout=100s
	kubectl wait --for=condition=available deployment -l "app.kubernetes.io/component=controller" -n cert-manager --timeout=100s
	kubectl wait --for=condition=available deployment -l "app.kubernetes.io/component=cainjector" -n cert-manager --timeout=100s
# Argocd
	kustomize build --enable-alpha-plugins --load-restrictor=LoadRestrictionsNone manager/resources/argocd/overlay/$(ARGO_FLAVOR) | kubectl apply -f -
	kubectl wait --for=condition=available deployment -l "app.kubernetes.io/name=argocd-server" -n argocd --timeout=300s
# Argo-rollouts
	kustomize build --enable-alpha-plugins --load-restrictor=LoadRestrictionsNone manager/resources/argo-rollouts/overlay | kubectl apply -f -
	kubectl wait --for=condition=available deployment -l "app.kubernetes.io/name=argo-rollouts" -n argo-rollouts --timeout=300s
# Tf-controller
	kustomize build --enable-alpha-plugins --load-restrictor=LoadRestrictionsNone manager/resources/tf-controller/overlay | kubectl apply --server-side --validate=false -f -
	kubectl wait --for=condition=available deployment -l "app.kubernetes.io/name=tf-controller" -n flux-system --timeout=300s
	
# Bootstrap App-ofApps
	kubectl apply -n argocd -f manager/bootstrap.yaml

connect:
	kubectl port-forward -n argocd svc/argocd-server 8080:80