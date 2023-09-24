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

If you dont have external access to the ArgoCD service NodePort, LoadBalancer for example, you can use kubectl to forward an http tunel
to the service on your local system.

*Using this command, the Management cluster's ArgoCD WebUI should be accessible at: http(s)://127.0.0.1:8080*

```bash
$ kubectl port-forward -n argocd svc/argocd-server 8080:80
```