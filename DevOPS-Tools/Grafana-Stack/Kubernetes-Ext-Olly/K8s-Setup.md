# Configure Logging and Monitoring in EKS/Kind/Minikube with External Prometheus and Loki Service

## Logs Collection via Promtail and Push to External Loki

### Step 1: Add the Grafana Helm repository

```bash
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm show values grafana/promtail > promtail-values.yaml
```

### Step 2: Edit Custom Endpoint Push

Open the `promtail-values.yaml` file and configure the Loki API endpoint.

```bash
nano promtail-values.yaml
```

Update the Loki URL under the `clients` section:

```yaml
config:
  clients:
    - url: http://12.34.56.78:3100/loki/api/v1/push  # Update the Loki API endpoint
```

### Step 3: Apply Changes

Install Promtail using the modified `promtail-values.yaml` file:

```bash
helm install promtail grafana/promtail -f promtail-values.yaml --namespace monitoring --create-namespace
```

Check the status of Promtail pods:

```bash
k get pods -n monitoring
```

View Promtail logs:

```bash
kubectl logs -n monitoring -l app.kubernetes.io/name=promtail
```

Check the status of Promtail pods again:

```bash
k get pods -n monitoring
```

---

## Metrics Collection and Sending to `k*s_prometheus-server` and Then External Prometheus Server

### Step 1: Install Prometheus

Update the Helm repositories and install Prometheus in the `monitoring` namespace:

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm search repo prometheus-community
helm install prometheus prometheus-community/prometheus --namespace monitoring --create-namespace
k get pods -n monitoring
```

### Step 2: Export Prometheus Values

Export the Prometheus default values to customize them:

```bash
helm show values prometheus-community/prometheus > prom-values.yaml
```

### Step 3: Edit Remote Write Endpoint for Custom Push

Open the `prom-values.yaml` file and edit the remote write endpoint for the external Prometheus server.

```bash
nano prom-values.yaml
```

Modify the `remote_write` section:

```yaml
remoteWrite:
  - url: "http://<external-prometheus-ip>:9090/api/v1/write"
```
Modify the `Persistent storage` section:

```yaml
server:
  enabled: true
  persistence:
    enabled: false  # Disable persistent storage
```
Modify the `Persistent storage` section:
```yaml
alertmanager:
  enabled: true
  persistence:
    enabled: false  # Disable persistence to avoid using PersistentVolumes
```
> If Required `kubectl delete statefulset prometheus-alertmanager -n monitoring`

> **Note:** Ensure that the external Prometheus has the flag `--web.enable-remote-write-receiver` enabled to accept connections from the EKS Prometheus.

### Step 4: Apply Changes

Install or upgrade Prometheus with the modified configuration:

```bash
helm upgrade --install prometheus prometheus-community/prometheus -f prom-values.yaml --namespace monitoring
```

Check the status of Prometheus pods:

```bash
k get pods -n monitoring
kubectl describe pod <prometheus-server-pod-name> -n monitoring
```

`Imp` : Grafana Dash ID's for Kubernetes : 15760 / 15757
---

## Step 5: if prometheus pod is in error state due to PV and PVC 

Create a PV and PVC with storage class in any one of the nodes which use the local storage to storage the data or you can use the AWS ebs if needed in you enviroment. `Provide the Node Name`

```bash
# cat persistent-volumes.yaml 
apiVersion: v1
kind: PersistentVolume
metadata:
  name: prometheus-server-pv
spec:
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  local:
    path: /mnt/data/prometheus  # Path on the node verify the permissions of this dir 
  nodeAffinity:
    required:
      nodeSelectorTerms:
        - matchExpressions:
            - key: kubernetes.io/hostname
              operator: In
              values:
                - <NODE-NAME> # Node name where PV have to be create in local storage /mnt/data/prometheus

# cat persistent-volume-claim.yaml 
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: prometheus-server
  namespace: monitoring
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
  storageClassName: prometheus-storage  # Use the StorageClass if needed

# cat storage-class.yaml 
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: prometheus-storage
provisioner: kubernetes.io/no-provisioner  # This is for local storage (not cloud)
volumeBindingMode: WaitForFirstConsumer
```

> This setup allows you to collect logs via Promtail and metrics via Prometheus in your EKS cluster, pushing them to external Loki and Prometheus services for centralized monitoring.