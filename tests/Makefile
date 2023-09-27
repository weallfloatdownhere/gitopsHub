KUBECONFIG_MANAGER=${PWD}/demo-manager.kubeconfig

clean:
	minikube delete -p manager
	rm -rf $(KUBECONFIG_MANAGER)

install:
	minikube start -p manager --memory 3078 --cpus 2 --network bridge
	kubectl config view --flatten --minify --context manager > $(KUBECONFIG_MANAGER)