#!/usr/bin/env bash

buildah from --name prometheus-working-container scratch
buildah copy prometheus-working-container ./prometheus/prometheus /prometheus
buildah copy prometheus-working-container ./prometheus/promtool /promtool
buildah copy prometheus-working-container ./prometheus/consoles /consoles
buildah copy prometheus-working-container ./prometheus/console_libraries /console_libraries
buildah config --port 9090 prometheus-working-container
buildah config --entrypoint '["/prometheus", "--config.file=prometheus.yaml"]' prometheus-working-container
buildah commit prometheus-working-container prometheus
buildah rm prometheus-working-container

buildah push prometheus docker-daemon:prometheus:latest
