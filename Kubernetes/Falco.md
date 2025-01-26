# Try Falco on Kubernetes

![alt text](<../.github/Images/Screenshot from 2025-01-11 18-15-31.png>)
## Deploy Falco

### 1. Install the Helm Repository
```bash
helm repo add falcosecurity https://falcosecurity.github.io/charts
helm repo update
```

### 2. Install Falco
```bash
helm install --replace falco --namespace falco --create-namespace --set tty=true falcosecurity/falco
```

### 3. Verify Falco Pods

```bash
kubectl get pods -n falco
```

Falco pods might take a few seconds to start. Wait until they are ready:

```bash
kubectl wait pods --for=condition=Ready --all -n falco
```

Falco comes with a pre-installed set of rules that alert you upon suspicious behavior.

## Trigger a Rule

### 1. Create a Deployment

```bash
kubectl create deployment nginx --image=nginx
```

### 2. Trigger a Rule

```bash
kubectl exec -it $(kubectl get pods --selector=app=nginx -o name) -- cat /etc/shadow
```

### 3. View Falco Logs

```bash
kubectl logs -l app.kubernetes.io/name=falco -n falco -c falco | grep Warning
```

You should see a log similar to this:

```
09:46:05.727801343: Warning Sensitive file opened for reading by non-trusted program (file=/etc/shadow gparent=systemd ggparent=<NA> gggparent=<NA> evt_type=openat user=root user_uid=0 user_loginuid=-1 process=cat proc_exepath=/usr/bin/cat parent=containerd-shim command=cat /etc/shadow terminal=34816 container_id=bf74f1749e23 container_image=docker.io/library/nginx container_image_tag=latest container_name=nginx k8s_ns=default k8s_pod_name=nginx-7854ff8877-h97p4)
```

This is your first Falco event 🦅! The rule that triggered this event is pre-installed in Falco.

## Create a Custom Rule

### 1. Define a Custom Rule
Now let's create a custom rule to alert when a file is opened for writing in the `/etc` directory. Create a file named `falco_custom_rules_cm.yaml` with the following content:

```yaml
customRules:
  custom-rules.yaml: |-
    - rule: Write below etc
      desc: An attempt to write to /etc directory
      condition: >
        (evt.type in (open,openat,openat2) and evt.is_open_write=true and fd.typechar='f' and fd.num>=0)
        and fd.name startswith /etc
      output: "File below /etc opened for writing (file=%fd.name pcmdline=%proc.pcmdline gparent=%proc.aname[2] ggparent=%proc.aname[3] gggparent=%proc.aname[4] evt_type=%evt.type user=%user.name user_uid=%user.uid user_loginuid=%user.loginuid process=%proc.name proc_exepath=%proc.exepath parent=%proc.pname command=%proc.cmdline terminal=%proc.tty %container.info)"
      priority: WARNING
      tags: [filesystem, mitre_persistence]
```

### 2. Load the Custom Rule into Falco

```bash
helm upgrade --namespace falco falco falcosecurity/falco --set tty=true -f falco_custom_rules_cm.yaml
```

Falco pods may take a few seconds to restart. Wait until they are ready:

```bash
kubectl wait pods --for=condition=Ready --all -n falco
```

### 3. Trigger the New Rule

```bash
kubectl exec -it $(kubectl get pods --selector=app=nginx -o name) -- touch /etc/test_file_for_falco_rule
```

### 4. Check the Logs

```bash
kubectl logs -l app.kubernetes.io/name=falco -n falco -c falco | grep Warning
```

You should see a log like:

```
13:14:27.811647863: Warning File below /etc opened for writing (file=/etc/test_file_for_falco_rule pcmdline=containerd-shim -namespace k8s.io -id d5438fedb274ac82963d99987313dae8da512236ace2f70472a772d95090b607 -address /run/containerd/containerd.sock gparent=systemd ggparent=<NA> gggparent=<NA> evt_type=openat user=root user_uid=0 user_loginuid=-1 process=touch proc_exepath=/usr/bin/touch parent=containerd-shim command=touch /etc/test_file_for_falco_rule terminal=34816 container_id=bf74f1749e23 container_image=docker.io/library/nginx container_image_tag=latest container_name=nginx k8s_ns=default k8s_pod_name=nginx-7854ff8877-h97p4)
```

## Deploy Falcosidekick and Falcosidekick UI

### 1. Install Falcosidekick
To forward alerts to a custom location or display them in a GUI, install Falcosidekick and its web UI using Helm:

```bash
helm upgrade --namespace falco falco falcosecurity/falco -f falco_custom_rules_cm.yaml --set falcosidekick.enabled=true --set falcosidekick.webui.enabled=true
```

### 2. Verify Falcosidekick Service

```bash
kubectl -n falco get svc
```

You should see something like:

```
NAME                     TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
falco-falcosidekick      ClusterIP   10.43.212.119   <none>        2801/TCP   61s
falco-falcosidekick-ui   ClusterIP   10.43.35.87     <none>        2802/TCP   60s
```

### 3. Forward the Falcosidekick UI Port

```bash
kubectl -n falco port-forward svc/falco-falcosidekick-ui 2802
```

Then, open your browser and go to `http://localhost:2802`. The default login is `admin` / `admin`.

### 4. View Events in the UI
Trigger an event again:

```bash
kubectl exec -it $(kubectl get pods --selector=app=nginx -o name) -- cat /etc/shadow
```

You should see the event appear in the Falcosidekick UI.

![alt text](<../.github/Images/Screenshot from 2025-01-11 18-15-35.png>)
## Cleanup

To remove Falco from your cluster:

```bash
helm -n falco uninstall falco
```


> Send Logs to Loki `Coming Soon`