# Local dev

First, let's begin by starting a minikube kubernetes cluster which is going to our **Management cluster**

```bash
$ export WORKSPACE="$(git rev-parse --show-toplevel)/.workspace"
$ export CONTEXT="manager"
$ mkdir -p $WORKSPACE
$ $(git rev-parse --show-toplevel)/actions/provision/kubernetes/minikube/cluster-init.sh $CONTEXT $WORKSPACE/kubeconfig-manager
```

We can now deploy our management cluster resources on the kubernetes cluster.

```bash
$ export WORKSPACE="$(git rev-parse --show-toplevel)/.workspace"
$ export KUBECONFIG="$WORKSPACE/kubeconfig-manager"
$ export CONTEXT="manager"
$ $(git rev-parse --show-toplevel)/actions/deploy/manager.sh $KUBECONFIG $CONTEXT
```

If you dont have external access to the ArgoCD service NodePort, LoadBalancer for example, you can use kubectl to forward an http tunel
to the service on your local system.

Using this command, the Management cluster's ArgoCD WebUI should be accessible at: `http(s)://127.0.0.1:8080`

*Default credentials for the demonstration are:*

- username: admin
- password: password

```bash
$ kubectl port-forward -n argocd svc/argocd-server 8080:80
```

When we are done, we can clean the environment using this script

```bash
$ $(git rev-parse --show-toplevel)/actions/utilities/clean-dev.sh
```