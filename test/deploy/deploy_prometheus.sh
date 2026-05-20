#!/usr/bin/env bash

kubectl apply -f deploy/conf/k8s/prometheus-configmap.yaml
kubectl apply -f deploy/conf/k8s/prometheus.yaml
kubectl apply -f deploy/conf/k8s/prometheus-service.yaml
