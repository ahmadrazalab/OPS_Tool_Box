helm repo add elastic https://helm.elastic.co
helm repo update


# elastic search
helm install elasticsearch elastic/elasticsearch --namespace logging --create-namespace
kubectl get pods --namespace=logging -l app=elasticsearch-master -w
kubectl get secrets --namespace=logging elasticsearch-master-credentials -ojsonpath='{.data.password}' | base64 -d
helm --namespace=logging test elasticsearch


# kibana





# Fluentbit
helm repo add fluent https://fluent.github.io/helm-charts
helm repo update
helm install fluent-bit fluent/fluent-bit --namespace logging --set output.elasticsearch.enabled=true --set output.elasticsearch.host=elasticsearch.logging.svc.cluster.local --set output.elasticsearch.port=9200 --set output.elasticsearch.index=kubernetes-logs
```
output:
  elasticsearch:
    enabled: true
    host: "elasticsearch.logging.svc.cluster.local"
    port: 9200
    index: "kubernetes-logs"
    type: "_doc"
```



kubectl create secret generic fluentd-aws-credentials --from-literal=AWS_ACCESS_KEY_ID=x --from-literal=AWS_SECRET_ACCESS_KEY=x -n kube-logging

























