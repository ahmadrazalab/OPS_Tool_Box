# High Resource Usage Application Setup Guide

This guide walks through deploying a Python-based application in Kubernetes designed to consume high memory and CPU resources. This setup is useful for testing Kubernetes resource management, scaling, and monitoring under stress.

---

## Table of Contents

- [Requirements](#requirements)
- [Step 1: Docker Setup](#step-1-docker-setup)
- [Step 2: High Resource Usage Python Script](#step-2-high-resource-usage-python-script)
- [Step 3: Dockerfile](#step-3-dockerfile)
- [Step 4: Build and Push Docker Image](#step-4-build-and-push-docker-image)
- [Step 5: Kubernetes Deployment](#step-5-kubernetes-deployment)
- [Step 6: Kubernetes Service](#step-6-kubernetes-service)
- [Verification](#verification)

---

### Requirements

- Docker installed locally
- Kubernetes cluster setup (e.g., minikube, EKS, etc.)
- kubectl command-line tool configured to communicate with the Kubernetes cluster

---

### Step 1: Docker Setup

Ensure Docker is installed and running on your machine. Verify by running:

```bash
docker --version
```

### Step 2: High Resource Usage Python Script

Create a Python file named `high_resource_usage.py`. This script will consume high CPU and memory by creating large data structures and performing intensive operations.

```python
import time
import random

def consume_memory():
    data = []
    while True:
        # Simulate memory usage by appending large lists
        data.append([random.random() for _ in range(1000000)])
        # Pause briefly to keep the CPU usage high
        time.sleep(0.1)
        # Release some memory to avoid crashes (optional)
        if len(data) > 50:  
            data.pop(0)

def consume_cpu():
    while True:
        # Simulate high CPU usage by performing computations
        _ = [x ** 2 for x in range(1000000)]

if __name__ == "__main__":
    consume_memory()
    consume_cpu()
```

### Step 3: Dockerfile

Create a Dockerfile to containerize the high resource usage application.

```Dockerfile
# Use a lightweight Python base image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy the Python script into the container
COPY high_resource_usage.py .

# Set the command to run the Python script
CMD ["python", "high_resource_usage.py"]
```

### Step 4: Build and Push Docker Image

Build and push the Docker image to a registry such as Docker Hub or GitHub Container Registry.

```bash
# Build the Docker image
docker build -t USERNAME/high-resource-usage-app:latest .

# Push the image to the registry
docker push USERNAME/high-resource-usage-app:latest
```

Replace `USERNAME` with your Docker Hub or registry username.

---

### Step 5: Kubernetes Deployment

Create a Kubernetes deployment file, `high-resource-deployment.yaml`, to deploy the application to the Kubernetes cluster.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: high-resource-deployment
  labels:
    app: high-resource
spec:
  replicas: 2  # Number of replicas for load testing
  selector:
    matchLabels:
      app: high-resource
  template:
    metadata:
      labels:
        app: high-resource
    spec:
      containers:
      - name: high-resource
        image: USERNAME/high-resource-usage-app:latest
        imagePullPolicy: Always
        resources:
          limits:
            memory: "512Mi"
            cpu: "500m"
          requests:
            memory: "256Mi"
            cpu: "250m"
```

Apply the deployment file:

```bash
kubectl apply -f high-resource-deployment.yaml
```

---

### Step 6: Kubernetes Service

Create a service file, `high-resource-service.yaml`, if you want to expose the application (e.g., for monitoring or access purposes).

```yaml
apiVersion: v1
kind: Service
metadata:
  name: high-resource-service
spec:
  selector:
    app: high-resource
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080  # Adjust if needed to match the container's exposed port
  type: ClusterIP  # Use LoadBalancer if external access is required
```

Apply the service file:

```bash
kubectl apply -f high-resource-service.yaml
```

---

### Verification

1. **Check Pod Status**: Confirm the pods are running and consuming high resources as expected.

   ```bash
   kubectl get pods
   ```

2. **Monitor Resource Usage**: Use the following command to see the real-time resource usage of the pods.

   ```bash
   kubectl top pods
   ```

3. **Inspect Logs**: View any output from the containers if needed.

   ```bash
   kubectl logs <pod-name>
   ```

Replace `<pod-name>` with the actual pod name retrieved from the `kubectl get pods` command.

---

> This guide completes the setup for deploying a high-resource usage application in Kubernetes, ideal for testing cluster performance and monitoring setups.