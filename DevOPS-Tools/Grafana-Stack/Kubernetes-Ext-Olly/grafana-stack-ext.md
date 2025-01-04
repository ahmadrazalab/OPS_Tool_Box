
# Prometheus and Loki Configuration and Deployment Using Docker

## Prometheus Configuration (`prometheus.yml`)

### Configuration File

Create the Prometheus configuration file `prometheus.yml` as shown below:

```yaml
# cat prometheus.yml 
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'loki'
    static_configs:
      - targets: ['loki:3100']

  - job_name: 'kubernetes-pods'
    kubernetes_sd_configs:
      - role: pod
    relabel_configs:
      - source_labels: [__meta_kubernetes_pod_label_name]
        target_label: pod

  - job_name: 'kubernetes-nodes'
    kubernetes_sd_configs:
      - role: node
    relabel_configs:
      - source_labels: [__meta_kubernetes_node_label_name]
        target_label: node
```

In this configuration:
- Prometheus scrapes metrics from itself (`localhost:9090`), Loki (`loki:3100`), Kubernetes pods, and nodes.
- Kubernetes service discovery is used for pods and nodes, with relabeling to map labels to the appropriate metrics.

---

## Docker Compose Deployment for Prometheus, Loki, and Grafana

### `docker-compose.yml`

Use the following `docker-compose.yml` file to deploy Prometheus, Loki, and Grafana as Docker services:

```yaml
# cat docker-compose.yml 
services:
  prometheus:
    image: prom/prometheus:v2.41.0
    container_name: prometheus
    command:
      - "--config.file=/etc/prometheus/prometheus.yml"
      - "--web.enable-remote-write-receiver" # Enable remote write for data collection from EKS or KIND
    volumes:
      - /root/grafana/prometheus.yml:/etc/prometheus/prometheus.yml
    ports:
      - "9090:9090"
    networks:
      - monitoring
    restart: unless-stopped

  loki:
    image: grafana/loki:2.7.0
    container_name: loki
    ports:
      - "3100:3100"
    volumes:
      - ./loki-config.yml:/etc/loki/loki-config.yml
    networks:
      - monitoring
    restart: unless-stopped

  grafana:
    image: grafana/grafana:latest
    container_name: grafana
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=admin
    ports:
      - "3000:3000"
    volumes:
      - grafana-storage:/var/lib/grafana
    depends_on:
      - prometheus
      - loki
    networks:
      - monitoring
    restart: unless-stopped

networks:
  monitoring:
    driver: bridge

volumes:
  grafana-storage:
```

### Explanation of the Services:
- **Prometheus**:
  - Uses the `prom/prometheus:v2.41.0` Docker image.
  - Configures Prometheus to use the custom `prometheus.yml` configuration file.
  - Enables the `remote-write-receiver` to accept metrics sent from external sources (e.g., EKS or KIND).

- **Loki**:
  - Uses the `grafana/loki:2.7.0` Docker image.
  - Exposes Loki on port `3100`.
  - Mounts a custom `loki-config.yml` configuration file.

- **Grafana**:
  - Uses the `grafana/grafana:latest` Docker image.
  - Sets the default admin password for Grafana (`GF_SECURITY_ADMIN_PASSWORD=admin`).
  - Exposes Grafana on port `3000`.
  - Depends on the Prometheus and Loki services to be up and running.
  - Persists Grafana data using a Docker volume (`grafana-storage`).

### Networks and Volumes:
- The services are all connected to the `monitoring` network, created with the `bridge` driver.
- Grafana's data is persisted with a Docker volume (`grafana-storage`).

---

> This setup will deploy Prometheus, Loki, and Grafana using Docker Compose, providing centralized logging and monitoring services with external integration support.