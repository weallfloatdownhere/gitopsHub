# KUBECONFIG=[PATH] make install
install:
	kubectl apply -k management/resources/argocd/overlays/current
	kubectl wait --for=condition=available deployment -l "app.kubernetes.io/name=argocd-server" -n argocd --timeout=300s
	kubectl apply -f management/root.yaml -n argocd