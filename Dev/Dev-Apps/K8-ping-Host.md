# k8-ping-host

This application checks the network connectivity between Kubernetes pods by exposing a port and verifying if the connection is successful.

## **Kubernetes Deployment Configuration**

### **deployment.yaml**

The `deployment.yaml` file defines a Kubernetes Deployment for the `ping-test-pod` application. It specifies that one replica of the pod should be created with a container running the `noscopev6/host-test:ip` image. The container listens on port `8080`.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ping-test-pod
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ping-test-pod
  template:
    metadata:
      labels:
        app: ping-test-pod
    spec:
      containers:
        - name: ping-test-pod
          image: noscopev6/host-test:ip
          ports:
            - containerPort: 8080
```

- **apiVersion**: Defines the API version for the deployment (apps/v1).
- **kind**: The kind of Kubernetes resource being created, in this case, a `Deployment`.
- **metadata**: Defines the name for the deployment (`ping-test-pod`).
- **spec**: Specifies the number of replicas (1 in this case), the pod template, and container details (image `noscopev6/host-test:ip` and port `8080`).

---

### **service.yaml**

The `service.yaml` file creates a Kubernetes Service of type `NodePort` that exposes the `ping-test-pod` application. The service listens on port `10001` and forwards traffic to port `8080` inside the pod.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: ping-test-service
spec:
  type: NodePort
  selector:
    app: ping-test-pod
  ports:
    - protocol: TCP
      port: 10001  # Your chosen port
      targetPort: 8080
```

- **apiVersion**: Defines the API version for the service (v1).
- **kind**: The kind of Kubernetes resource being created, in this case, a `Service`.
- **metadata**: Defines the name for the service (`ping-test-service`).
- **spec**: Defines the service's type (`NodePort`), the selector to match the `ping-test-pod`, and the port mapping (port `10001` on the service is forwarded to port `8080` inside the container).

---

## **Docker Compose Configuration**

To run the application locally with Docker Compose, the following `docker-compose.yml` file will start the `ping-test-pod` service, exposing port `10001` and forwarding it to the container's port `8080`.

```yaml
version: '3.8'

services:
  ping-test-pod:
    image: noscopev6/host-test:ip
    ports:
      - "10001:8080"
```

- **version**: Specifies the version of Docker Compose configuration syntax (`3.8`).
- **services**: Defines the services to be run by Docker Compose.
  - **ping-test-pod**: Specifies the container to run (`noscopev6/host-test:ip`) and forwards port `10001` on the host to port `8080` in the container.

---

## **Usage**

### 1. **Deploy to Kubernetes**
- To deploy the application to your Kubernetes cluster, run the following commands:
  ```bash
  kubectl apply -f deployment.yaml
  kubectl apply -f service.yaml
  ```

### 2. **Access the Application**
- Once the deployment and service are running, you can access the application using the node's IP address and the assigned port (`10001`). For example:
  ```
  http://<node-ip>:10001
  ```

### 3. **Verify Connectivity**
- To check the connection between the Kubernetes pods, access the service via the exposed port. If the connection is successful, the application will respond as expected.

### 4. **Run Locally Using Docker Compose**
- If you want to run the application locally with Docker Compose, use the following command:
  ```bash
  docker-compose up
  ```
- The application will be available at `http://localhost:10001`.

---

This setup allows you to check network connectivity between Kubernetes pods or test it locally with Docker Compose.