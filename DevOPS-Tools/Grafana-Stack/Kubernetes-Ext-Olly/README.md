# 🚀 Exposing Kubernetes Metrics and Logs with Externally Hosted Prometheus and Loki Services 🌟

## Overview
In this project, I implemented an external monitoring and logging setup for multiple Kubernetes clusters and VMs using Prometheus, Loki, and Grafana. This approach is designed to be flexible, allowing the integration of multiple endpoints from different sources. The solution ensures centralized observability while maintaining separation between application workloads and monitoring infrastructure.

## 🎯 Use Cases
- **Centralized Observability**: Enables monitoring and logging across multi-cluster setups, ideal for DevSecOps pipelines or hybrid environments.
- **Modular Architecture**: Keeps logging and monitoring external to the primary cluster, reducing resource impact on production workloads.

## 🔍 Key Highlights

### 1️⃣ Centralized Monitoring:
- **Prometheus Deployment**: Configured for Kubernetes service discovery to monitor nodes and pods dynamically.
- **External Remote-Write**: Metrics from clusters like EKS, KIND, and Minikube are pushed to an external Prometheus server.

### 2️⃣ Centralized Logging:
- **Promtail Integration**: Sends logs from Kubernetes clusters to an external Loki instance using custom endpoints.
- **Grafana Integration**: Visualizes both logs and metrics, offering actionable insights.

### 3️⃣ Scalable Deployment:
- Utilized Docker Compose to deploy Prometheus, Loki, and Grafana as external services.
- Clear separation between clusters and monitoring infrastructure improves scalability and reduces downtime.

### 4️⃣ Metric Server Integration:
- Deployed Metric Server in Kubernetes clusters to monitor node and pod resource usage effectively.


---

