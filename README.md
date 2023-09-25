# Super Gitops repository.

# Getting started

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


https://gitlab.com/sylva-projects/sylva-elements/helm-charts/capi-rancher-import/-/tree/main/cattle-kustomize?ref_type=heads
https://github.com/vmware-tanzu/cluster-api-provider-bringyourownhost/blob/main/docs/getting_started.md
https://github.com/vmware-tanzu/cluster-api-provider-bringyourownhost
https://github.com/piomin/sample-kubernetes-cluster-api-argocd/tree/master
https://deploy.equinix.com/developers/guides/kubernetes-cluster-api/

## Powered by
- [ArgoCD - Declarative continuous deployment for Kubernetes.](https://github.com/argoproj/argo-cd)
- [Kyverno - Kubernetes Native Policy Management.](https://github.com/kyverno/kyverno)
- [K3sup - Bootstrap K3s over SSH in < 60s.](https://github.com/alexellis/k3sup)
- [Cluster-API - Home for Cluster API, a subproject of sig-cluster-lifecycle](https://github.com/kubernetes-sigs/cluster-api)
- [Crossplane - Cloud Native Control Planes.](https://github.com/crossplane/crossplane)
- [Vcluster - Create fully functional virtual Kubernetes clusters - Each one runnin inside a namespace of the underlying k8s cluster.](https://github.com/loft-sh/vcluster)
