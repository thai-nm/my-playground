#!/bin/bash

helm install kong kong/ingress -n kong -f values-kic.yaml --create-namespace

kubectl apply -f manifests/