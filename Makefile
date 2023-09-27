# KUBECONFIG=[PATH] make install
install:
	kubectl apply -k manager/resources/argocd/overlays/current
	kubectl wait --for=condition=available deployment -l "app.kubernetes.io/name=argocd-server" -n argocd --timeout=300s
	kubectl apply -f manager/root.yaml -n argocd