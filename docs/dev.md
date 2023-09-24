# Local dev


## 1. Management cluster initialization

First, let's begin by starting a minikube kubernetes cluster which is going to our **Management cluster**

```bash
$ export WORKSPACE="$(git rev-parse --show-toplevel)/.workspace"
$ export CONTEXT="manager"
$ mkdir -p $WORKSPACE
$ $(git rev-parse --show-toplevel)/actions/provision/kubernetes/minikube/cluster-init.sh $CONTEXT $WORKSPACE/kubeconfig-manager
```

## 2. Management cluster resources deployment

We can now deploy our management cluster resources on the kubernetes cluster.

```bash
$ export WORKSPACE="$(git rev-parse --show-toplevel)/.workspace"
$ export KUBECONFIG="$WORKSPACE/kubeconfig-manager"
$ export CONTEXT="manager"
$ $(git rev-parse --show-toplevel)/actions/deploy/manager.sh $KUBECONFIG $CONTEXT
```

## 3. Check everything is running correctly

If you dont have external access to the ArgoCD service NodePort, LoadBalancer for example, you can use kubectl to forward an http tunel
to the service on your local system.

Using this command, the Management cluster's ArgoCD WebUI should be accessible at: `http(s)://127.0.0.1:8080`

*Default credentials for the demonstration are:*

- username: admin
- password: password

```bash
$ kubectl port-forward -n argocd svc/argocd-server 8080:80
```

## 4. Workload cluster initialization

We could use almost anything as workload cluster (vms, baremetal, raseberry pie, etc). This environment is using `Vagrant` and `Libvirt` to run a single ubuntu vanilla node with nothing installed on it yet.

*First, it is not already done, you have to install dependencies.*

```bash
$ sudo apt-get -y purge vagrant-libvirt
$ sudo apt-mark hold vagrant-libvirt
$ sudo apt-get -y update
$ sudo apt-get install -y qemu libvirt-daemon-system ebtables libguestfs-tools vagrant ruby-fog-libvirt
$ vagrant plugin install vagrant-libvirt
```

*Vagrantfile*

```groovy
Vagrant.configure("2") do |config|
  config.vagrant.plugins = "vagrant-libvirt"
  config.vm.define :cluster do |cluster|
    cluster.vm.box = "generic/ubuntu2010"
    cluster.vm.network :private_network, :ip => "10.20.30.40"
  end
end
```

We can now start the provisioning.

```bash
$ vagrant up --provision --provider=libvirt
```