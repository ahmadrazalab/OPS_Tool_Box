# Deploy Metric Server in Kubernetes (K8s)

To deploy the **Metric Server** in your Kubernetes cluster, follow these steps:

```bash
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.6.1/components.yaml
kubectl get pods -n kube-system
kubectl top nodes
kubectl top pods --all-namespaces
```

If you encounter any **TLS** issues, follow these troubleshooting steps:

### If getting TLS-related errors:
```bash
kubectl logs -n kube-system -l k8s-app=metrics-server
kubectl edit deployment metrics-server -n kube-system
```

- Add the following flag to the `args` section to disable **TLS verification** (this is necessary in some environments like **kind**):

```yaml
args:
- --kubelet-insecure-tls
```

> This will allow the Metric Server to connect without performing TLS verification.

