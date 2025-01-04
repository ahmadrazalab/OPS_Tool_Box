# Grafana and Prometheus Setup in Kubernetes Using Helm

This README provides step-by-step instructions for setting up Grafana and Prometheus for monitoring in a Kubernetes cluster using Helm.

## Prerequisites

1. **Kubernetes Cluster**: A running Kubernetes cluster. You can use Minikube, a managed cluster, or any other Kubernetes provider.
2. **Helm**: Installed and configured in your environment. Follow [Helm’s installation guide](https://helm.sh/docs/intro/install/) if needed.
3. **kubectl**: Installed and configured for your Kubernetes cluster. Refer to the [kubectl installation guide](https://kubernetes.io/docs/tasks/tools/install-kubectl/) for setup instructions.
## Step 1: Create a Namespace

First, create a namespace for monitoring resources:

```bash
kubectl create namespace monitoring
```

## Step 2: Add Helm Repositories

Add the required Helm chart repositories for Prometheus and Grafana:

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
```

## Step 3: Install Prometheus

Install Prometheus using Helm:

```bash
helm install prometheus prometheus-community/prometheus -n monitoring
```

The Prometheus server can be accessed via port 80 using the following DNS name from within your cluster:

```
prometheus-server.monitoring.svc.cluster.local
```

## Step 4: Install Grafana

Install Grafana using Helm:

```bash
helm install grafana grafana/grafana -n monitoring
```

### Accessing Grafana

1. Get your 'admin' user password by running the following command:

   ```bash
   kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
   ```

   The default password will be displayed. For example:
   ```
   PASS : aIwX6UK5LLkHQWKmGGQvCtME0BA93YKaH4T91tZt
   ```

2. You can access Grafana at:

```
grafana.monitoring.svc.cluster.local
```

## Step 5: Expose Services to Localhost

To access Prometheus and Grafana from your local machine, use port-forwarding: (or you can use LB or ingress )

```bash
kubectl port-forward service/prometheus-server --namespace monitoring 8090:80
kubectl port-forward service/grafana --namespace monitoring 3000:80
kubectl patch svc grafana -n monitoring -p '{"spec": {"type": "NodePort"}}'
```

Now you can access:
- **Prometheus:** `http://localhost:8090`
- **Grafana:** `http://localhost:3000`

## Step 6: Configure Prometheus as a Data Source in Grafana

1. Open Grafana (`http://localhost:3000`) and log in.
2. Go to **Configuration > Data Sources**.
3. Click **Add Data Source** and select **Prometheus**.
4. Set the **URL** to `http://prometheus-server.monitoring.svc.cluster.local:80`.
5. Click **Save & Test** to verify the data source is working.


## Step 7: Import Dashboards

You can enhance your Grafana setup by importing pre-configured dashboards. Here are some popular Kubernetes dashboards:

### Dashboard IDs

Refer to the following dashboards from [dotdc/grafana-dashboards-kubernetes](https://github.com/dotdc/grafana-dashboards-kubernetes):

| Dashboard Name                      | Dashboard ID |
|-------------------------------------|--------------|
| k8s-addons-prometheus.json         | 19105        |
| k8s-addons-trivy-operator.json     | 16337        |
| k8s-system-api-server.json          | 15761        |
| k8s-system-coredns.json             | 15762        |
| k8s-views-global.json               | 15757        |
| k8s-views-namespaces.json           | 15758        |
| k8s-views-nodes.json                | 15759        |
| k8s-views-pods.json                 | 15760        |


## Cleanup (Optional)

To uninstall Prometheus and Grafana, run the following commands:

```bash
helm uninstall prometheus -n monitoring
helm uninstall grafana -n monitoring
kubectl delete namespace monitoring
```

## Troubleshooting

- **Grafana or Prometheus Not Accessible**: Ensure port-forwarding is set up correctly or check the service type for external access.
- **Data Not Showing in Grafana**: Confirm that the Prometheus data source URL is correct in Grafana.

## Additional Resources

- [Helm Charts for Prometheus](https://github.com/prometheus-community/helm-charts)
- [Helm Charts for Grafana](https://github.com/grafana/helm-charts)
- [Prometheus Documentation](https://prometheus.io/docs/)
- [Grafana Documentation](https://grafana.com/docs/)

---

> This README provides a foundational setup for Grafana and Prometheus, which you can further customize based on your monitoring needs.