#!/usr/bin/env bash
#
contexts=$(kubectl config --no-headers=true get-contexts | tr -s ' ' | cut -d ' ' -f 2)
for context in $contexts; do
  cluster=$(echo $context | cut -d '_' -f 4)
  kubectl config rename-context ${context} ${cluster}
done
