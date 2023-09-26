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

