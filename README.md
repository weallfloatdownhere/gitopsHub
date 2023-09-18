# gitopsHub
Repository that manages the HUB part of a multi-clusters. multi-tenancy, gitops driven whole Kubernetes infrastructure.

The `Hub` is a complete up and running Kubernetes cluster. The sole purpose of this cluster is to ultimatly give Devops operator
a centrilized way of managing an almost infinite amount of other Kubernetes clusters called `Spokes`.

## Getting started

Starting the dev environment

. This script will start a minikube kubernetes cluster (`lab-hub`).
. The hub resulting kubeconfig file will be located there at tests/kubeconfig.lab-hub.kubeconfig
. Then the script will download the latest `vcluster` client from Github.

```bash
connect to vcluster
vcluster connect dev-environment --server https://localhost:8443 -- bash
```


## TODO
https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/configmap/

## Charts
- https://github.com/loft-sh/vcluster/tree/v0.7.0-alpha.1/charts
- https://www.vcluster.com/docs/getting-started/deployment
- https://artifacthub.io/packages/helm/crossplane/crossplane

## Sources
- https://github.com/kyverno/policies
- https://github.com/salaboy/from-monolith-to-k8s

## References
- https://gist.github.com/eddycharly/58aac2e6955d0118947f3ec751a41d44
- https://github.com/codefresh-contrib/kubecon-eu-2023-demo-crossplane-vcluster
- https://github.com/argoproj/argo-cd/issues/4651
- https://github.com/a1tan/argocdsecretsynchronizer
- https://github.com/kyverno/policies/blob/main/argo/argo-cluster-generation-from-rancher-capi
- https://github.com/crossplane/crossplane/blob/master/design/one-pager-helm-provider.md


## Powered by
- [ArgoCD - Declarative continuous deployment for Kubernetes.](https://github.com/argoproj/argo-cd)
- [Kyverno - Kubernetes Native Policy Management.](https://github.com/kyverno/kyverno)
- [Crossplane - Cloud Native Control Planes.](https://github.com/crossplane/crossplane)
- [Vcluster - Create fully functional virtual Kubernetes clusters - Each vcluster runs inside a namespace of the underlying k8s cluster. It's cheaper than creating separate full-blown clusters and it offers better multi-tenancy and isolation than regular namespaces.](https://github.com/loft-sh/vcluster)
