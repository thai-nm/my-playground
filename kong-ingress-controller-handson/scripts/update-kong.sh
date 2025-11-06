#! /bin/bash

helm upgrade --install kong kong/ingress -n kong -f values-kic.yaml --create-namespace
