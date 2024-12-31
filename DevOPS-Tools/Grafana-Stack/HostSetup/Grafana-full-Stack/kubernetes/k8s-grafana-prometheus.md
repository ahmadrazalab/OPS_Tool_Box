# Setup Prometheus and Grafana on Kubernetes

## Prerequisites

Ensure you have the following before starting:

- A **Kubernetes Cluster** running.
- **kubectl** (Kubernetes CLI tool).
- **Helm** installed on your local machine.

---

## Step 1: Add Prometheus and Grafana Helm Repositories

First, add the Prometheus and Grafana Helm repositories to download the necessary charts.

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
```

List available charts for Prometheus and Grafana to confirm:

```bash
helm search repo prometheus
helm search repo grafana
```

---

## Step 2: Create Configuration Files for Prometheus and Grafana

Save the default configuration values to YAML files for customization:

1. **Prometheus configuration**:
   ```bash
   helm show values prometheus-community/kube-prometheus-stack > prometheus-values.yaml
   ```

2. **Grafana configuration**:
   ```bash
   helm show values grafana/grafana > grafana-values.yaml
   ```

### Optional: Persistent Volume Storage for Metrics

To retain metrics data in Prometheus across pod restarts, configure persistent storage in `prometheus-values.yaml`:

```yaml
prometheus:
  prometheusSpec:
    storageSpec:
      volumeClaimTemplate:
        spec:
          accessModes: ["ReadWriteOnce"]
          resources:
            requests:
              storage: 10Gi  # Adjust as needed
```

---

## Step 3: Deploy Prometheus and Grafana using Helm

1. **Install Prometheus** using your custom values file:

   ```bash
   helm upgrade --install prometheus prometheus-community/kube-prometheus-stack --namespace monitoring --create-namespace --values prometheus-values.yaml
   ```

   This command deploys Prometheus in a namespace called `monitoring` with the settings specified in `prometheus-values.yaml`.

2. **Install Grafana**:

   ```bash
   helm upgrade --install grafana grafana/grafana --namespace monitoring --values grafana-values.yaml
   ```

   By default, Grafana will be available within the same `monitoring` namespace.

---

## Step 4: Verify Deployments

Confirm that Prometheus and Grafana pods are running:

```bash
kubectl get pods -n monitoring
```

If both Prometheus and Grafana pods are running, the setup is successful.

---

## Step 5: Access Grafana UI

### Option 1: Port-forwarding (for local access)

To access Grafana locally, use port-forwarding:

```bash
kubectl port-forward svc/grafana -n monitoring 3000:80
```

Open a browser and navigate to `http://localhost:3000`.

### Option 2: Expose Grafana as a NodePort (for external access)

Alternatively, expose Grafana externally by changing the service type in `grafana-values.yaml` to NodePort:

```yaml
service:
  type: NodePort
  port: 80
  targetPort: 3000
  nodePort: 32000  # Adjust as needed
```

Then, reapply the Helm release:

```bash
helm upgrade --install grafana grafana/grafana --namespace monitoring --values grafana-values.yaml
```

Grafana will now be accessible at `http://<NODE_IP>:32000`.

---

## Step 6: Configure Prometheus as Data Source in Grafana

1. **Log in to Grafana** (default username: `admin`, password can be retrieved as follows):
   ```bash
   kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
   ```

2. **Add Prometheus as Data Source**:
   - Go to **Configuration > Data Sources** in the Grafana UI.
   - Select **Prometheus**.
   - Enter the URL for Prometheus as `http://prometheus-server.monitoring.svc.cluster.local`.
   - Click **Save & Test** to verify.

---

## Step 7: Import Node Exporter Dashboard for Kubernetes Metrics

1. Go to **Dashboards > Import** in Grafana.
2. Use Grafana’s [public dashboard library](https://grafana.com/grafana/dashboards/) and search for Node Exporter dashboards.
3. Enter the dashboard ID, for example, **1860** (for Node Exporter Full), and click **Load**.
4. Select **Prometheus** as the data source and click **Import**.

This will give you a complete view of system metrics across your Kubernetes nodes, including CPU, memory, and disk usage.

---

> **Note:** The above setup enables Grafana to monitor metrics from Prometheus across all Kubernetes nodes, providing a full monitoring solution within your cluster.
