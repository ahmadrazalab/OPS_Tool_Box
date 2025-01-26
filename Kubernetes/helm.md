# Helm Setup and Common Commands

## What is Helm?

Helm is a package manager for Kubernetes that simplifies the process of deploying and managing applications on Kubernetes clusters using Helm charts.

## Prerequisites

- A **Kubernetes Cluster** running.
- **kubectl** (Kubernetes CLI tool) installed and configured to communicate with your cluster.

---

## Step 1: Install Helm

### On Linux / macOS

1. **Download the Helm binary:**
   ```bash
   curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
   ```

2. **Verify the installation:**
   ```bash
   helm version
   ```

### On Windows

1. **Using Chocolatey (if installed):**
   ```powershell
   choco install kubernetes-helm
   ```

2. **Using Scoop (if installed):**
   ```powershell
   scoop install helm
   ```

3. **Verify the installation:**
   ```powershell
   helm version
   ```

---

## Step 2: Add a Helm Repository

Helm uses repositories to store charts. To add a repository, use the following command:

```bash
helm repo add <repo-name> <repo-url>
```

### Example: Add the Bitnami Repository

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
```

---

## Step 3: Update Helm Repositories

To ensure you have the latest charts, update your Helm repositories:

```bash
helm repo update
```

---

## Commonly Used Helm Commands

Here are some useful Helm commands for managing your applications in Kubernetes:

### Install a Helm Chart

To install a chart from a repository:

```bash
helm install <release-name> <chart-name>
```

**Example: Install the NGINX chart:**
```bash
helm install my-nginx bitnami/nginx
```

### List Installed Releases

To list all installed releases in the current namespace:

```bash
helm list
```

### Upgrade a Release

To upgrade a release with a new chart version or configuration:

```bash
helm upgrade <release-name> <chart-name> --values <values-file.yaml>
```

### Uninstall a Release

To uninstall a release:

```bash
helm uninstall <release-name>
```

### Get Release Status

To get the status of a release:

```bash
helm status <release-name>
```

### Fetch a Chart

To download a chart from a repository without installing it:

```bash
helm fetch <chart-name>
```

### Create a New Helm Chart

To create a new Helm chart:

```bash
helm create <chart-name>
```

### Validate a Chart

To check a chart for errors:

```bash
helm lint <chart-directory>
```

---

## Conclusion

Helm simplifies the deployment and management of applications on Kubernetes. This documentation provides the basic setup and commonly used commands to get started with Helm.

> For more advanced usage and additional commands, refer to the official [Helm documentation](https://helm.sh/docs/).