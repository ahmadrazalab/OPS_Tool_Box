# Setup Grafana Loki on Kubernetes
---


# Steps to Setup Grafana Loki on Kubernetes

### Setup Prerequisites

The following are prerequisites for setting up Grafana Loki:

- **Kubernetes Cluster** 
- **kubectl** (Kubernetes CLI tool)
- **Helm** installed on your system

Follow these steps to set up Grafana Loki logging on Kubernetes using Helm.

---

## Step 1: Add Grafana Helm Repository

To download the Helm chart for Grafana Loki, add the Grafana repository:

```bash
helm repo add grafana https://grafana.github.io/helm-charts
```

Then, update the Helm repo to ensure it's up-to-date:

```bash
helm repo update
```

Verify by listing available Loki-related charts:

```bash
helm search repo loki
```

From these, we'll use `grafana/loki-stack`, which includes Promtail, Grafana, and Loki.

---

## Step 2: Customize Helm Chart Configuration Values

Before deploying, save the default values to a YAML file:

```bash
helm show values grafana/loki-stack > loki.yaml
```

In `loki.yaml`, modify the `grafana` configuration to enable it by setting it to `true`, and optionally set the tag to `latest` to deploy the latest version.

### Persistent Volume Storage (Optional)
To store logs in a Persistent Volume instead of the file system, configure a PVC in Loki. Since Loki is deployed as a StatefulSet, it retains logs even after a pod restart.

**Images Used in this Helm Chart:**
- `grafana/loki`
- `docker.io/grafana/promtail`

---

## Step 3: Deploy Loki with Helm

Deploy the modified Helm chart using your YAML file:

```bash
helm upgrade --install --values loki.yaml loki grafana/loki-stack -n grafana-loki --create-namespace
```

This creates a namespace `grafana-loki` and deploys Grafana Loki components in Kubernetes.

---

## Step 4: Verify Deployment & Access Grafana UI

Check that everything is deployed and running:

```bash
kubectl get pod -n grafana-loki
```

### Port-forward to Access Grafana
Run the following command, replacing `<your-grafana-pod>` with your Grafana pod name, to port-forward Grafana to port 9090:

```bash
kubectl port-forward pod/<your-grafana-pod> -n grafana-loki 3000:3000
```

Alternatively, expose Grafana as a NodePort service for external access.

---

## Step 5: Log in to Grafana

Access Grafana at `http://localhost:9090`. Use the following command to retrieve the default `admin` password:

```bash
kubectl get secret --namespace grafana-loki loki-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```

Once logged in, navigate to **Connections > Data sources** to see that Loki is configured as the default data source.

---

## Step 6: Query Logs in Grafana

To check logs:

1. Go to **Explore** in the Grafana dashboard.
2. Choose a Label and Value to filter logs by Kubernetes components like container, pod, or namespace.

### Setting a Query Interval
Set a time interval, like `5s`, to refresh logs every 5 seconds. 

Once configured, press **Query** to view logs based on the chosen Label and Value. 

---

> This setup will allow you to monitor and query logs collected by Grafana Loki from your Kubernetes cluster.
