#!/bin/bash

pushd src

for app in bookinfo productpage details reviews ratings expose-productpage
do
  helm package $app
  mv $app*.tgz ../helm-repo
done

popd
