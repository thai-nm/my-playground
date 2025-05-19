kubectl port-forward -n kong svc/kong-gateway-admin  8001:8001 & \
kubectl port-forward -n kong svc/kong-gateway-proxy  8000:80 & \
kubectl port-forward -n kong svc/kong-gateway-manager  8002:8002 & \

echo "Press CTRL-C to stop port forwarding and exit the script"
wait