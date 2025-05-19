# CNOK: Scripts

This folder contains several automation scripts to support repeatitive works.

## Prerequisites

- `docker` or `podman`
- `kind`
- `kubectl`
- `helm`

## Usage

1. Create a Kind cluster:
   ```bash
   kind create cluster --config ../kind/config.yaml
   ```

2. Build container images:
   - If using Docker:
     ```bash
     ./build-container-image-docker.sh
     ```
   - If using Podman:
     ```bash
     ./build-container-image-podman.sh
     ```

3. Load images into Kind cluster:
   - If using Docker:
     ```bash
     ./load-container-image-docker.sh
     ```
   - If using Podman:
     ```bash
     ./load-container-image-podman.sh
     ```

4. Set up Kong Gateway:
   ```bash
   ./spin-up-kong.sh
   ```

5. Deploy services:
   ```bash
   ./deploy-services.sh
   ```

6. Expose Kong Gateway locally:
   ```bash
   ./expose-kong-local.sh
   ```

## Available Scripts

- `build-container-image-docker.sh`: Builds container images using Docker
- `build-container-image-podman.sh`: Builds container images using Podman
- `load-container-image-docker.sh`: Loads built images into Kind cluster using Docker
- `load-container-image-podman.sh`: Loads built images into Kind cluster using Podman
- `spin-up-kong.sh`: Sets up Kong Gateway in the Kubernetes cluster
- `deploy-services.sh`: Deploys all microservices to the cluster
- `expose-kong-local.sh`: Creates port forwards to access Kong services locally