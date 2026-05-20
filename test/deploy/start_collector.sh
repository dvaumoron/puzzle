#!/usr/bin/env bash

# collector port listing :
# - 1888 is pprof extension
# - 8888 is Prometheus metrics exposed by the collector
# - 8889 is Prometheus exporter metrics
# - 13133 is health_check extension
# - 4317 isOTLP gRPC receiver
# - 4318 is OTLP http receiver
# - 55679 is zpages extension
docker run -p 4317:4317 -p 8888:8888 -p 8889:8889 -v $PWD/deploy/conf/otel-collector.yaml:/etc/otelcol-contrib/config.yaml  otel/opentelemetry-collector
