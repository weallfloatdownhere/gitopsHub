# gitopsHub

## Description

```
- management/
    - applications/
        - requirements/ # Contains required argocd applications for each of these components: argo-cd, kyverno and its policies.
        - addons/       # Contains argocd applications for non-essentials cluster addons such as an ingress-controller, monitoring, etc.
        - root.yaml     # Root argocd application applying the concept of ArgoCD App of Apps on both directories mentioned above.

    - policies/         # Contains all Kyverno policies manifests to be applied on the management cluster.
                          Please note that this directory is deployed recursively, which mean that you can create as much sub-directories as you need.

```

## Charts
- https://github.com/loft-sh/vcluster/tree/v0.7.0-alpha.1/charts
- https://www.vcluster.com/docs/getting-started/deployment
- https://artifacthub.io/packages/helm/crossplane/crossplane

## Sources
- https://cluster-api.sigs.k8s.io/user/concepts
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
- [K3sup - Bootstrap K3s over SSH in < 60s.](https://github.com/alexellis/k3sup)
- [Crossplane - Cloud Native Control Planes.](https://github.com/crossplane/crossplane)
- [Vcluster - Create fully functional virtual Kubernetes clusters - Each vcluster runs inside a namespace of the underlying k8s cluster. It's cheaper than creating separate full-blown clusters and it offers better multi-tenancy and isolation than regular namespaces.](https://github.com/loft-sh/vcluster)
