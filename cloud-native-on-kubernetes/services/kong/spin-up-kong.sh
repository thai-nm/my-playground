# Install Gateway API CRDs
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.1.0/standard-install.yaml

# Install Kong GatewayClass and Gateway instance
kubectl apply -f ../manifests/kic.yaml

# Set up Kong Helm chart
helm repo add kong https://charts.konghq.com
helm repo update

# Install Kong ingress controller and Kong Gateway
helm upgrade --install kong kong/ingress -n kong --create-namespace -f ./values.yaml

# Install echo test app
kubectl apply -f ../manifests/echo-service.yaml