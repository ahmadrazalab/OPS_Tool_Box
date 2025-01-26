kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml


kubectl get pods -n kube-system | grep metrics-server


4. Modify Metrics Server Configuration (If Needed)
If your cluster uses self-signed certificates or has custom configurations, the Metrics Server might fail. In that case:

Edit the deployment:

bash
Copy
Edit
kubectl edit deployment metrics-server -n kube-system
Add the following arguments under containers.args:

yaml
Copy
Edit
- --kubelet-insecure-tls
- --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname