clean:
	minikube delete -p manager
	rm -rf ${PWD}/manager.kubeconfig

install:
	minikube start -p manager --memory 3078 --cpus 2 --network bridge
	kubectl config view --flatten --minify --context manager > ${PWD}/manager.kubeconfig
	export KUBECONFIG=${PWD}/manager.kubeconfig