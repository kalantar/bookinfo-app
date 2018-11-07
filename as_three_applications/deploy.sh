#!/bin/bash

CLUSTER="${1}"

for chart in ratings-app reviews-app bookinfo expose-productpage; do
   HELM_HOME=$HOME/.kube/${CLUSTER} helm --kube-context ${CLUSTER} install -n $chart src/$chart --tls
done
