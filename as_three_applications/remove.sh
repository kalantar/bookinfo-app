#!/bin/bash

CLUSTER="${1}"

for chart in expose-productpage bookinfo reviews-app ratings-app; do
  HELM_HOME=$HOME/.kube/${CLUSTER} helm --kube-context ${CLUSTER} delete $chart --purge --tls
done
