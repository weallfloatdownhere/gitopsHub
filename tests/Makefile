WORKSPACE=${PWD}/workspace
VAGRANTIP=192.168.121.164
KUBECONFIG_MINIKUBE=$(WORKSPACE)/manager/kubeconfig-minikube-manager

dependencies:
	sudo apt-get -y update
	sudo apt install -y qemu ebtables dnsmasq-base
	sudo apt install -y libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev
	sudo apt install -y docker.io vagrant virtualbox
	sudo groupadd docker
	sudo groupadd libvirt
	sudo usermod -aG libvirt ${USER}
	sudo usermod -aG docker ${USER}
	vagrant plugin install vagrant-libvirt
	sudo systemctl enable docker.service --now
	sudo systemctl enable containerd.service --now
	sudo systemctl daemon-reload
	curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
	sudo install minikube-linux-amd64 /bin/minikube
	sudo rm -rf minikube-linux-amd64

clean:
	pkill kubectl -9 || true
	virsh undefine workspace_cluster || true
	virsh vol-delete --pool default workspace_cluster.img || true
	minikube delete --all --purge
	docker system prune --force --all
	sudo systemctl restart docker
	sudo systemctl restart containerd
	sudo systemctl daemon-reload
	vagrant global-status --prune
	rm -rf $(WORKSPACE) k.tmp .vagrant nohup.out

minikube:
	rm -rf ${KUBECONFIG_MINIKUBE}
	mkdir -p $(WORKSPACE)/manager
	KUBECONFIG=${KUBECONFIG_MINIKUBE} minikube start -p manager --memory 3078 --cpus 2 --network bridge
	KUBECONFIG=${KUBECONFIG_MINIKUBE} kubectl config view --context manager --flatten --minify > k.tmp
	mv k.tmp ${KUBECONFIG_MINIKUBE}

vagrant:
	mkdir -p $(WORKSPACE)/vagrant
	cp Vagrantfile $(WORKSPACE)/vagrant/Vagrantfile
	cd $(WORKSPACE)/vagrant/ && vagrant up --provision --provider=libvirt

tests:
	make clean
	make minikube

# KUBECONFIG=/my/workspace/dir/kubeconfig-minikube-manager make manager
manager:
	kubectl apply -k ../management/resources/argocd/overlays/current
	kubectl wait --for=condition=available deployment -l "app.kubernetes.io/name=argocd-server" -n argocd --timeout=300s
	kubectl apply -f ../management/root.yaml -n argocd
	nohup kubectl port-forward -n argocd svc/argocd-server 8080:80 &
	python3 -m webbrowser https://localhost:8080