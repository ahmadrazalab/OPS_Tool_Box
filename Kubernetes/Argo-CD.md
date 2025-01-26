# Simple Guide: Install Argo CD in Kubernetes

## 1. Create a Namespace for Argo CD

```bash
kubectl create namespace argocd
```

## 2. Install Argo CD

Apply the Argo CD manifest in the `argocd` namespace:

```bash
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

## 3. Access the Argo CD UI

### Option 1: Port Forwarding

Expose the Argo CD API server locally:

```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
# or
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort", "ports": [{"port": 80, "targetPort": 8080, "nodePort": 30080}, {"port": 443, "targetPort": 8081, "nodePort": 30443}]}}'

```

Access the UI at: [https://localhost:8080](https://localhost:8080)

### Option 2: Ingress (Optional)

If you prefer external access, set up an ingress with your domain.

## 4. Log In to Argo CD

1. **Get the initial admin password**:

   ```bash
   kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
   ```

2. **Login to the Argo CD UI**:

   - **Username**: `admin`
   - **Password**: [Use the password from above]

## 5. Deploy Your First Application

1. Connect your Git repository from the **Settings > Repositories** in the Argo CD UI.
2. Create a new application by specifying:
   - **Application Name**
   - **Repository URL**
   - **Target Namespace** and other settings.

Argo CD will deploy the application to your Kubernetes cluster.

---

