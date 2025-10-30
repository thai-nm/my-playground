#!/bin/bash

# Create a kind cluster
kind create cluster --config kind.yaml

# Install Gateway API CRDs
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.3.0/standard-install.yaml

# Add Kong Helm repository
helm repo add kong https://charts.konghq.com
helm repo update
