# Kind Cluster Setup Guide `LocalHost`

This document provides step-by-step instructions for setting up and managing a Kubernetes cluster using **kind** (Kubernetes IN Docker).

## Prerequisites

- Install Docker on your local machine.
- Install kind. Follow the [installation guide](https://kind.sigs.k8s.io/docs/user/quick-start/#installation) for your operating system.
- Install `kubectl`. Follow the [installation guide](https://kubernetes.io/docs/tasks/tools/install-kubectl/) for your operating system.

## Cluster Configuration

Create a YAML configuration file named `kind-cluster-config.yaml` with the following content:

```yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
    image: kindest/node:v1.30.4@sha256:976ea815844d5fa93be213437e3ff5754cd599b040946b5cca43ca45c2047114
  
  - role: worker
    image: kindest/node:v1.30.4@sha256:d46b7aa29567e93b27f7531d258c372e829d7224b25e3fc6ffdefed12476d3aa
  
  - role: worker
    image: kindest/node:v1.30.4@sha256:d46b7aa29567e93b27f7531d258c372e829d7224b25e3fc6ffdefed12476d3aa
```

## Step 1: Create the Cluster

To create the kind cluster using the configuration file, run the following command:

```bash
kind create cluster --config kind-cluster-config.yaml
```

## Step 2: Verify the Cluster

Once the cluster is created, verify the status of the cluster with the following commands:

```bash
kubectl cluster-info
kubectl api-resources
```

You can also check the list of clusters you have created with:

```bash
kind get clusters
```

## Step 3: Delete the Cluster

To delete the cluster, run:

```bash
kind delete cluster
```

If you want to delete a specific cluster by name:

```bash
kind delete cluster --name <cluster-name>
```

## Step 4: Manage Kind Clusters

To create a cluster with a custom name and configuration, you can use:

```bash
kind create cluster --config kind-cluster-config.yaml --name drops
```

Check the cluster info again with:

```bash
kubectl cluster-info
```

To delete the custom named cluster:

```bash
kind delete cluster --name drops
```

## Step 5: Multi-Cluster Management

If you are managing multiple kind clusters, you can switch contexts using the following commands:

- List all contexts:

  ```bash
  kubectl config get-contexts
  ```

- Check the current context:

  ```bash
  kubectl config current-context
  ```

- Switch to a specific context:

  ```bash
  kubectl config use-context kind-drops
  ```

## Step 6: Deploy Metrics Server

To monitor resource usage in your cluster, you can deploy the Metrics Server:

```bash
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```

After deploying, verify that the Metrics Server is running:

```bash
kubectl get deployment metrics-server -n kube-system
```

## Conclusion

You have successfully set up and managed a Kubernetes cluster using kind. This setup allows for easy testing and development of Kubernetes applications in a local environment.

For more information, refer to the official [kind documentation](https://kind.sigs.k8s.io/docs/).
