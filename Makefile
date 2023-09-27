KUBECONFIG=${PWD}/manager/manager.kubeconfig

install:
	kubectl apply -n argocd -k bootstrap/argocd/overlay
	kubectl wait --for=condition=available deployment -l "app.kubernetes.io/name=argocd-server" -n argocd --timeout=300s
	kubectl apply -n argocd -f bootstrap/bootstrap.yaml