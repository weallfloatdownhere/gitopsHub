# [Lightweight Kubernetes distribution](https://github.com/k3s-io/k3s)

Lightweight Kubernetes. Production ready, easy to install, half the memory, all in a binary less than 100 MB.

### What is this?

K3s is a fully conformant production-ready Kubernetes distribution with the following changes:

It is packaged as a single binary.
It adds support for sqlite3 as the default storage backend. Etcd3, MySQL, and Postgres are also supported.
It wraps Kubernetes and other components in a single, simple launcher.
It is secure by default with reasonable defaults for lightweight environments.
It has minimal to no OS dependencies (just a sane kernel and cgroup mounts needed).
It eliminates the need to expose a port on Kubernetes worker nodes for the kubelet API by exposing this API to the Kubernetes control plane nodes over a websocket tunnel.

## Related tools

### K3sUp

k3sup is a light-weight utility to get from zero to KUBECONFIG with k3s on any local or remote VM. All you need is ssh access and the k3sup binary to get kubectl access immediately.

The tool is written in Go and is cross-compiled for Linux, Windows, MacOS and even on Raspberry Pi.

### Resources

- K3s on [Github](https://github.com/k3s-io/k3s)
- K3s Official [Website](https://k3s.io/)
- K3sUp on [Github](https://github.com/alexellis/k3sup)