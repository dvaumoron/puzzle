#!/usr/bin/env bash

# ensure there is no remaining puzzlecluster in kind
kind delete cluster -n puzzlecluster

# create fake cluster with kind
kind create cluster -n puzzlecluster --config deploy/conf/cluster-kind.yaml --wait 30s

./deploy/copy_images.sh
