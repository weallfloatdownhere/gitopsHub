## Generating a Kubeconfig with your own CA

https://cluster-api.sigs.k8s.io/tasks/certs/generate-kubeconfig
https://cluster-api.sigs.k8s.io/tasks/certs/using-custom-certificates
https://github.com/kubernetes-sigs/cluster-api/blob/main/docs/book/src/clusterctl/configuration.md

Create a new Certificate Signing Request (CSR) for the admin user with the system:masters Kubernetes role, or specify any other role under O.

```bash
openssl req  -subj "/CN=admin/O=system:masters" -new -newkey rsa:2048 -nodes -keyout admin.key  -out admin.csr
```

Sign the CSR using the [cluster-name]-ca key:

```bash
openssl x509 -req -in admin.csr -CA tls.crt -CAkey tls.key -CAcreateserial -out admin.crt -days 5 -sha256
```

Update your kubeconfig with the sign key:

```bash
kubectl config set-credentials cluster-admin --client-certificate=admin.crt --client-key=admin.key --embed-certs=true
```

Provider Name	Label
CAPI	        cluster.x-k8s.io/provider=cluster-api
CABPK	        cluster.x-k8s.io/provider=bootstrap-kubeadm
CABPM	        cluster.x-k8s.io/provider=bootstrap-microk8s
CABPKK3S	    cluster.x-k8s.io/provider=bootstrap-kubekey-k3s
CABPOCNE	    cluster.x-k8s.io/provider=bootstrap-ocne
CACPK	        cluster.x-k8s.io/provider=control-plane-kubeadm
CACPM	        cluster.x-k8s.io/provider=control-plane-microk8s
CACPN	        cluster.x-k8s.io/provider=control-plane-nested
CACPKK3S	    cluster.x-k8s.io/provider=control-plane-kubekey-k3s
CACPOCNE	    cluster.x-k8s.io/provider=control-plane-ocne
CAPA	        cluster.x-k8s.io/provider=infrastructure-aws
CAPB	        cluster.x-k8s.io/provider=infrastructure-byoh
CAPC	        cluster.x-k8s.io/provider=infrastructure-cloudstack
CAPD	        cluster.x-k8s.io/provider=infrastructure-docker
CAPIM	        cluster.x-k8s.io/provider=infrastructure-in-memory
CAPDO	        cluster.x-k8s.io/provider=infrastructure-digitalocean
CAPG	        cluster.x-k8s.io/provider=infrastructure-gcp
CAPH	        cluster.x-k8s.io/provider=infrastructure-hetzner
CAPIBM	        cluster.x-k8s.io/provider=infrastructure-ibmcloud
CAPKK	        cluster.x-k8s.io/provider=infrastructure-kubekey
CAPK	        cluster.x-k8s.io/provider=infrastructure-kubevirt
CAPM3	        cluster.x-k8s.io/provider=infrastructure-metal3
CAPN	        cluster.x-k8s.io/provider=infrastructure-nested
CAPO	        cluster.x-k8s.io/provider=infrastructure-openstack
CAPOCI	        cluster.x-k8s.io/provider=infrastructure-oci
CAPP	        cluster.x-k8s.io/provider=infrastructure-packet
CAPV	        cluster.x-k8s.io/provider=infrastructure-vsphere
CAPVC	        cluster.x-k8s.io/provider=infrastructure-vcluster
CAPVCD	        cluster.x-k8s.io/provider=infrastructure-vcd
CAPX	        cluster.x-k8s.io/provider=infrastructure-nutanix
CAPZ	        cluster.x-k8s.io/provider=infrastructure-azure
CAPOSC	        cluster.x-k8s.io/provider=infrastructure-outscale

https://cluster-api.sigs.k8s.io/reference/providers
https://cluster-api.sigs.k8s.io/developer/architecture/controllers/cluster#secrets