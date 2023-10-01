#/usr/bin/env bash

# Download an Helm chart locally and untar it in a specified directory.

# ./download-helm.sh URL CHARTNAME VERSION DESTDIR
# eg:  ./download-helmchart.sh https://charts.deliveryhero.io node-problem-detector 2.3.11
# eg2: ../../scripts/utilities/download-helmchart.sh https://charts.deliveryhero.io node-problem-detector 2.3.11

URL="${1}"
CHARTNAME="${2}"
VERSION="${3}"
CHARTDEST="$PWD/$CHARTNAME/charts"

mkdir -p $CHARTDEST
helm pull --repo $URL $CHARTNAME --version $VERSION --untar --untardir $CHARTDEST
rm -rf $CHARTDEST/*$CHARTNAME*.tgz