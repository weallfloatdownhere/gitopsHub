# gitopsHub
Repository that manages the HUB part of a multi-clusters. multi-tenancy, gitops driven whole Kubernetes infrastructure.

# Getting started

The `Hub` is a complete up and running Kubernetes cluster. The sole purpose of this cluster is to ultimatly give Devops operator
a centrilized way of managing an almost infinite amount of other Kubernetes clusters called `Spokes`.


- [ArgoCD - Declarative continuous deployment for Kubernetes.](https://github.com/argoproj/argo-cd)
- [Kyverno - Kubernetes Native Policy Management.](https://github.com/kyverno/kyverno)
- [Crossplane - Cloud Native Control Planes.](https://github.com/crossplane/crossplane)
- [Vcluster - Create fully functional virtual Kubernetes clusters - Each vcluster runs inside a namespace of the underlying k8s cluster. It's cheaper than creating separate full-blown clusters and it offers better multi-tenancy and isolation than regular namespaces.](https://github.com/loft-sh/vcluster)


### TODO
- DEMO: https://github.com/kyverno/policies/tree/main/argo/argo-cluster-generation-from-rancher-capi

## Charts
- https://artifacthub.io/packages/helm/crossplane/crossplane

## Sources
- https://github.com/kyverno/policies

## References
- https://gist.github.com/eddycharly/58aac2e6955d0118947f3ec751a41d44
- https://github.com/codefresh-contrib/kubecon-eu-2023-demo-crossplane-vcluster
- https://github.com/argoproj/argo-cd/issues/4651
- https://github.com/kyverno/policies/blob/main/argo/argo-cluster-generation-from-rancher-capi