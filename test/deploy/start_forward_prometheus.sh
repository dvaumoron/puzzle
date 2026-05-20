#!/usr/bin/env bash

kubectl port-forward service/prometheus-service 9090:8090
