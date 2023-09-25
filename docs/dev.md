# Basic getting started (Clean it later)


### Provision and deploy manager cluster (minikube)
```bash
(
minikube delete --all && \
export WORKSPACE="$(git rev-parse --show-toplevel)/.workspace" && \
mkdir -p $WORKSPACE && \
export KUBECONFIG="$WORKSPACE/kubeconfig-manager" && \
rm -rf $KUBECONFIG && \
export CONTEXT="manager" && \
mkdir -p $WORKSPACE && \
$(git rev-parse --show-toplevel)/actions/distros/minikube/init.sh $CONTEXT $WORKSPACE/kubeconfig-manager && \
$(git rev-parse --show-toplevel)/actions/deploy/manager.sh $KUBECONFIG $CONTEXT
)
```

### Provision a demo workload cluster (vagrant)
```bash
(
export WORKSPACE="$(git rev-parse --show-toplevel)/.workspace"
mkdir -p $WORKSPACE
cat <<EOF > $WORKSPACE/Vagrantfile
Vagrant.configure("2") do |config|
  config.vagrant.plugins = "vagrant-libvirt"
  config.vm.define :cluster do |cluster|
    cluster.vm.box = "generic/ubuntu2010"
    cluster.vm.network :private_network, :ip => "10.20.30.40"
  end
end
EOF
cd $WORKSPACE
virsh undefine .workspace_cluster > /dev/null 2>&1
virsh vol-delete --pool default .workspace_cluster.img > /dev/null 2>&1
vagrant destroy --force > /dev/null 2>&1
vagrant up --provision --provider=libvirt
)
```

### Install VM Prerequisites and the Bring Your Own Host agent binary

*Step references*

https://github.com/vmware-tanzu/cluster-api-provider-bringyourownhost/blob/main/docs/getting_started.md#vm-prerequisites

https://stackoverflow.com/questions/305035/how-to-use-ssh-to-run-a-local-shell-script-on-a-remote-machine


```bash
export WORKLOAD_USER="vagrant"
export WORKLOAD_PASSWORD="vagrant"
export WORKLOAD_IP="192.168.121.215"
export BYOH_AGENT_DOWNLOAD="https://github.com/vmware-tanzu/cluster-api-provider-bringyourownhost/releases/download/v0.4.0/byoh-hostagent-linux-amd64"
sshpass -p $WORKLOAD_PASSWORD ssh $WORKLOAD_USER@$WORKLOAD_IP <<'ENDSSH'
sudo apt-get -y install socat ebtables ethtool conntrack
grep -q "127.0.1.1.*$(hostname)" /etc/hosts || sudo echo "127.0.0.1.*$(hostname)" >> /etc/hosts
ENDSSH
```

