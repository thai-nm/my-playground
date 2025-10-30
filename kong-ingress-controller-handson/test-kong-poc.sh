#!/bin/bash

# Script to test Kong Ingress Controller PoC
set -e

echo "🚀 Kong Ingress Controller PoC Test Script"
echo "==========================================="

# Apply the test application manifests
echo "📦 Deploying test applications..."
kubectl apply -f test-app-kong-poc.yaml

# Wait for pods to be ready
echo "⏳ Waiting for pods to be ready..."
kubectl wait --for=condition=ready pod -l app=echo-server -n kong-test --timeout=60s
kubectl wait --for=condition=ready pod -l app=httpbin -n kong-test --timeout=60s

# Get Kong proxy service details
echo "🔍 Getting Kong proxy service details..."
KONG_PROXY_IP=$(kubectl get svc -n kong kong-proxy -o jsonpath='{.status.loadBalancer.ingress[0].ip}' 2>/dev/null || echo "localhost")
KONG_PROXY_PORT=$(kubectl get svc -n kong kong-proxy -o jsonpath='{.spec.ports[?(@.name=="kong-proxy")].nodePort}' 2>/dev/null || echo "80")

echo "Kong Proxy: ${KONG_PROXY_IP}:${KONG_PROXY_PORT}"

# Add entries to /etc/hosts (requires sudo)
echo "📝 Adding test domains to /etc/hosts..."
echo "Note: You may need to run this manually with sudo:"
echo "sudo bash -c 'echo \"127.0.0.1 echo.local echo-api.local httpbin.local\" >> /etc/hosts'"

# Test commands
echo ""
echo "🧪 Test Commands:"
echo "=================="
echo ""
echo "1. Test echo server:"
echo "   curl -H \"Host: echo.local\" http://localhost/ping"
echo ""
echo "2. Test echo server with path:"
echo "   curl -H \"Host: echo-api.local\" http://localhost/api/ping"
echo ""
echo "3. Test httpbin (may require JWT token):"
echo "   curl -H \"Host: httpbin.local\" http://localhost/get"
echo ""
echo "4. Check Kong plugins applied:"
echo "   curl -H \"Host: echo.local\" -i http://localhost/ping"
echo "   # Look for X-Kong-Test and rate limiting headers"
echo ""
echo "5. View Kong admin API (if enabled):"
echo "   kubectl port-forward -n kong svc/kong-admin 8001:8001"
echo "   curl http://localhost:8001/services"
echo ""

# Show pod status
echo "📊 Current pod status:"
kubectl get pods -n kong-test -o wide

echo ""
echo "✅ PoC setup complete! Use the test commands above to verify Kong functionality."