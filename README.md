# Super Gitops repository.

## Local development

First, let's begin by starting a minikube kubernetes cluster which is going to our **Management cluster**

```bash
$ export WORKSPACE="$PWD/.workspace"
$ export CLUSTERNAME="manager"
$ mkdir -p $WORKSPACE
$ ./actions/provision/kubernetes/minikube/cluster-init.sh $CLUSTERNAME $WORKSPACE/kubeconfig-manager
```

We can now deploy our management cluster resources on the kubernetes cluster.

```bash
$ export KUBECONFIG="$WORKSPACE/kubeconfig-manager"
$ export CONTEXT="manager"
$ ./actions/deploy/manager.sh $KUBECONFIG $CONTEXT
```