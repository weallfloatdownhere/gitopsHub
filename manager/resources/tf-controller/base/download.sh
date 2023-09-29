#/usr/bin/env bash

export RELEASE_VERSION="v0.16.0-rc.3"

export SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Delete old kustomization.yaml
rm -rf $SCRIPT_DIR/kustomization.yaml

# Download RBACS
wget https://github.com/weaveworks/tf-controller/releases/download/$RELEASE_VERSION/tf-controller.rbac.yaml -O $SCRIPT_DIR/tf-controller.rbac.yaml

# Download CRDS
wget https://github.com/weaveworks/tf-controller/releases/download/$RELEASE_VERSION/tf-controller.crds.yaml -O $SCRIPT_DIR/tf-controller.crds.yaml

# Download Deployments
wget https://github.com/weaveworks/tf-controller/releases/download/$RELEASE_VERSION/tf-controller.deployment.yaml -O $SCRIPT_DIR/tf-controller.deployment.yaml

# Download packages
# wget https://github.com/weaveworks/tf-controller/releases/download/$RELEASE_VERSION/tf-controller.packages.yaml -O $SCRIPT_DIR/tf-controller.packages.yaml

# Generate kustomization.yaml
kustomize create --autodetect