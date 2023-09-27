 VERSION="v1.12.2"
 
 helm template \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version $VERSION \
  --set installCRDs=true \
  > cert-manager.yaml