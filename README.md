# Super Gitops repository.
Structured repository to managed a fleet of Kubernetes clusters in an opionated way.

## Getting started

Todo..

## Development

Todo..


## Download charts

```bash
 VERSION="v1.12.2"
 
 helm template \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version $VERSION \
  --set installCRDs=true \
  --set startupapicheck.enabled=false \
  > cert-manager.yaml
```

## Powered by

Todo..

## Resources

- https://metal3.io/blog/2022/07/08/One_cluster_multiple_providers.html