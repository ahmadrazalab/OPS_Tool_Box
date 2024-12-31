# Log Generator Setup Guide

This guide provides instructions to set up a Python-based log generator using Docker and Kubernetes. The log generator randomly outputs log messages with different severity levels, which is helpful for testing log collection, monitoring setups, and more.

---

## Table of Contents

- [Requirements](#requirements)
- [Step 1: Docker Setup](#step-1-docker-setup)
- [Step 2: Python Log Generator Script](#step-2-python-log-generator-script)
- [Step 3: Dockerfile](#step-3-dockerfile)
- [Step 4: Build and Push Docker Image](#step-4-build-and-push-docker-image)
- [Step 5: Kubernetes Deployment](#step-5-kubernetes-deployment)
- [Step 6: Kubernetes Service](#step-6-kubernetes-service)

---

### Requirements

- Docker installed locally
- Kubernetes cluster setup (e.g., minikube, EKS, etc.)
- kubectl command-line tool configured to communicate with the Kubernetes cluster

---

### Step 1: Docker Setup

Make sure Docker is installed on your machine. Verify the installation by running:

```bash
docker --version
```

### Step 2: Python Log Generator Script

Create a Python file named `log_generator.py` with the following content. This script generates log messages at random intervals with varying log levels.

```python
import time
import random
import sys

def generate_random_log():
    levels = ["INFO", "DEBUG", "WARNING", "ERROR", "CRITICAL"]
    messages = [
        "Service started successfully.",
        "Connection established to database.",
        "Unexpected input received.",
        "Memory usage high.",
        "Disk space is low.",
        "CPU usage threshold exceeded.",
        "Service restarted.",
        "Invalid configuration detected.",
        "User authentication failed.",
        "Network timeout error."
    ]
    return f"{random.choice(levels)} - {random.choice(messages)}"

def main():
    while True:
        log_entry = generate_random_log()
        print(log_entry)
        time.sleep(0.06)

if __name__ == "__main__":
    main()
```

### Step 3: Dockerfile

Create a Dockerfile to containerize the Python log generator application.

```Dockerfile
# Use a lightweight Python base image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy the Python script into the container
COPY log_generator.py .

# Set the command to run the Python script
CMD ["python", "log_generator.py"]
```

### Step 4: Build and Push Docker Image

Build and push the Docker image to a registry, such as Docker Hub or GitHub Container Registry.

```bash
# Build the Docker image
docker build -t USERNAME/random-log-generator:latest .

# Push the image to the registry
docker push USERNAME/random-log-generator:latest
```

Replace `USERNAME` with your Docker Hub or registry username.

---

### Step 5: Kubernetes Deployment

Create a Kubernetes deployment file, `log-generator-deployment.yaml`, to deploy the application to the Kubernetes cluster.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: log-generator-deployment
  labels:
    app: log-generator
spec:
  replicas: 2  # Number of replicas
  selector:
    matchLabels:
      app: log-generator
  template:
    metadata:
      labels:
        app: log-generator
    spec:
      containers:
      - name: log-generator
        image: ghcr.io/USERNAME/random-log-generator:latest
        imagePullPolicy: Always
        resources:
          limits:
            memory: "128Mi"
            cpu: "100m"
          requests:
            memory: "64Mi"
            cpu: "50m"
        env:
        - name: LOG_LEVEL
          value: "INFO"  # Optional environment variable
```

Apply the deployment file:

```bash
kubectl apply -f log-generator-deployment.yaml
```

---

### Step 6: Kubernetes Service

Create a service file, `log-generator-service.yaml`, to expose the application within or outside the cluster.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: log-generator-service
spec:
  selector:
    app: log-generator
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080  # Adjust if needed to match the container's exposed port
  type: LoadBalancer  # Use ClusterIP if external access is not required
```

Apply the service file:

```bash
kubectl apply -f log-generator-service.yaml
```

---

### Verifying Deployment

1. Confirm the pods are running:

   ```bash
   kubectl get pods
   ```

2. Confirm the service is exposed:

   ```bash
   kubectl get svc log-generator-service
   ```

Access logs by viewing the pod logs:

```bash
kubectl logs <pod-name>
```

Replace `<pod-name>` with the actual pod name listed from the `kubectl get pods` command.

---