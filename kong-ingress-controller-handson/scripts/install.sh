#!/bin/bash

# Install Kong Ingress Controller with Helm
helm install kong kong/ingress -n kong -f ../values-kic.yaml --create-namespace

# Apply general manifests
kubectl apply -f ../manifests/

# Apply echo service manifests
kubectl apply -f ../manifests/echo-service/

# Apply task service manifests
kubectl apply -f ../manifests/task-service/