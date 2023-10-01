#!/usr/bin/bash

# Use the ../utillities/download-helmchart.sh to download the specified chart
# Once its done we gonna end up with new directories containing the chart files [CHARTNAME]/charts/[CHARTNAME]/{templates/ Chart.yaml values.yaml, etc..}
# Create the directory [CHARTNAME]/base
# Generate a kustomization.yaml in [CHARTNAME]/base/kustomization.yaml
# Copy values file from [CHARTNAME]/charts/[CHARTNAME]/values.yaml -> [CHARTNAME]/base/values.yaml
# Generate a default namespace file to [CHARTNAME]/base/namespace.yaml

# eg: 
# pwd: manager/applications
# ../../scripts/helpers/init-kustomize-helm-resource.sh URL CHARTNAME VERSION
# ../../scripts/helpers/init-kustomize-helm-resource.sh https://charts.deliveryhero.io node-problem-detector 2.3.11

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

URL="${1}"
CHARTNAME="${2}"
VERSION="${3}"

# Download chart
$SCRIPT_DIR/../utilities/download-helmchart.sh $URL $CHARTNAME $VERSION

# Create overlay directory
mkdir -p $PWD/$CHARTNAME/head

# Import values file
cp $PWD/$CHARTNAME/charts/$CHARTNAME/values.yaml $PWD/$CHARTNAME/head/values.yaml

# Namespace yaml
cat <<EOF > $PWD/$CHARTNAME/head/namespace.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: $CHARTNAME
  labels:
    name: $CHARTNAME
EOF

# Kustomization yaml
cat <<EOF > $PWD/$CHARTNAME/head/kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

helmGlobals: 
  chartHome: "../charts"

helmCharts:
- name: $CHARTNAME
  releaseName: $CHARTNAME
  version: $VERSION
  namespace: $CHARTNAME
  includeCRDs: true
  valuesFile: values.yaml

resources:
- namespace.yaml
EOF

# Test build
kustomize build --enable-helm --enable-alpha-plugins --load-restrictor=LoadRestrictionsNone $PWD/$CHARTNAME/overlay

