# Linkerd Setup in Minikube with Emojivoto App

## **1. Prerequisites**
Ensure you have the following installed:
- [Minikube](https://minikube.sigs.k8s.io/docs/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Linkerd CLI](https://linkerd.io/2/getting-started/)

## **2. Start Minikube**
```sh
minikube start --cpus=4 --memory=8192 --kubernetes-version=v1.28.0
```

## **3. Install Linkerd CLI**
```sh
curl -sL https://run.linkerd.io/install | sh
export PATH=$HOME/.linkerd2/bin:$PATH
linkerd version
```

## **4. Install Linkerd in Minikube**
### Install CRDs
```sh
linkerd install --crds | kubectl apply -f -
```
### Install Control Plane
```sh
linkerd install --set proxyInit.runAsRoot=true | kubectl apply -f -
```
### Verify Installation
```sh
linkerd check
```

## **5. Install Linkerd Viz (Observability Extension)**
```sh
linkerd viz install | kubectl apply -f -
linkerd viz check
```
To access the dashboard:
```sh
linkerd viz dashboard &
```

## **6. Deploy the Emojivoto App**
```sh
kubectl apply -f https://run.linkerd.io/emojivoto.yml
kubectl get pods -n emojivoto
```

### Inject Linkerd into the App
```sh
kubectl get -n emojivoto deploy -o yaml | linkerd inject - | kubectl apply -f -
kubectl get pods -n emojivoto
```

## **7. Testing Linkerd Functionality**
### **Traffic Monitoring**
```sh
linkerd viz stat deployments -n emojivoto
```

### **Live Traffic Inspection**
```sh
linkerd viz tap -n emojivoto deploy/web
```

### **Enable Automatic Retries**
```sh
linkerd profile -n emojivoto voting-svc --tap deploy/web --tap-duration 10s | kubectl apply -f -
kubectl get sp -n emojivoto
linkerd viz stat deployments -n emojivoto
```

### **Add Timeout Policy**
Create `timeout-policy.yaml`:
```yaml
apiVersion: linkerd.io/v1alpha2
kind: ServiceProfile
metadata:
  name: voting-svc.emojivoto.svc.cluster.local
  namespace: emojivoto
spec:
  routes:
  - name: "/api/vote"
    condition:
      method: POST
    timeout: 2s
```
Apply it:
```sh
kubectl apply -f timeout-policy.yaml
linkerd viz stat deploy -n emojivoto
```

### **Traffic Splitting for Canary Deployment**
Deploy Voting v2:
```sh
kubectl apply -f https://run.linkerd.io/emojivoto-voting-v2.yml
```
Create `traffic-split.yaml`:
```yaml
apiVersion: split.smi-spec.io/v1alpha2
kind: TrafficSplit
metadata:
  name: voting-split
  namespace: emojivoto
spec:
  service: voting-svc
  backends:
  - service: voting-svc
    weight: 80
  - service: voting-svc-v2
    weight: 20
```
Apply:
```sh
kubectl apply -f traffic-split.yaml
linkerd viz stat svc -n emojivoto
```

### **Simulating a Failure**
```sh
kubectl delete pod -n emojivoto -l app=emoji-svc
linkerd viz stat deploy -n emojivoto
```

## **8. Next Steps**
- Deploy your own microservices with Linkerd.
- Explore **mTLS security**, **policy-based access control**, and **multi-cluster setups**.
- Apply Linkerd to a **production environment**.
