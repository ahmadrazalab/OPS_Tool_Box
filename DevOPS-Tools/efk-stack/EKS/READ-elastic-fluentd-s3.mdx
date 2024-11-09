To deploy Fluentd as a DaemonSet on your EKS cluster for forwarding logs from Elasticsearch to S3, follow these step-by-step instructions.

### Step 1: Create an IAM Role for Fluentd (for S3 Access)

1. **Go to the AWS IAM Console** and create a new IAM role for Fluentd.
2. Attach the following policies:
   - `AmazonS3FullAccess` or create a custom policy with specific permissions (e.g., `s3:PutObject`, `s3:GetObject`, and `s3:ListBucket`) for your S3 bucket.
3. **Enable IAM Roles for Service Accounts (IRSA)** in EKS by associating the role with the Fluentd service account:
   - Note your **EKS cluster name** and **AWS region**.
   - Run the following command to associate the IAM role with Fluentd:
     ```bash
     eksctl create iamserviceaccount \
       --name fluentd-sa \
       --namespace logging \
       --cluster <your-cluster-name> \
       --attach-policy-arn arn:aws:iam::<your-account-id>:policy/FluentdS3AccessPolicy \
       --approve \
       --region <your-region>
     ```

### Step 2: Create an S3 Bucket (if not created yet)

1. **Go to the Amazon S3 Console** and create a bucket.
2. Choose your desired region and configure any required settings, such as enabling versioning or encryption.

### Step 3: Create a ConfigMap for Fluentd Configuration

1. **Create a ConfigMap YAML** with Fluentd configurations, including Elasticsearch as the source and S3 as the output.
2. Save the following YAML configuration as `fluentd-configmap.yaml`:

   ```yaml
   apiVersion: v1
   kind: ConfigMap
   metadata:
     name: fluentd-config
     namespace: logging
   data:
     fluent.conf: |
       <source>
         @type elasticsearch
         host <elasticsearch-host>
         port <elasticsearch-port>
         index_name <elasticsearch-index-name>
         logstash_format true
         user <elasticsearch-username>
         password <elasticsearch-password>
       </source>

       <match **>
         @type s3
         aws_key_id <your-aws-access-key>
         aws_sec_key <your-aws-secret-key>
         s3_bucket <your-s3-bucket-name>
         s3_region <your-s3-region>
         path logs/k8s/
         buffer_path /var/log/fluent/s3
         time_slice_format %Y%m%d%H
         time_slice_wait 10m
         time_format %Y%m%dT%H%M%S%z
         compress gzip
         <format>
           @type json
         </format>
       </match>
   ```

   Replace the placeholders (`<elasticsearch-host>`, `<elasticsearch-port>`, etc.) with your Elasticsearch and S3 information.

3. Apply the ConfigMap to your cluster:
   ```bash
   kubectl apply -f fluentd-configmap.yaml
   ```

### Step 4: Deploy the Fluentd DaemonSet

1. Create a DaemonSet YAML file named `fluentd-daemonset.yaml` with the following content:

   ```yaml
   apiVersion: apps/v1
   kind: DaemonSet
   metadata:
     name: fluentd
     namespace: logging
   spec:
     selector:
       matchLabels:
         name: fluentd
     template:
       metadata:
         labels:
           name: fluentd
       spec:
         serviceAccountName: fluentd-sa  # Ensure it matches the IAM role in Step 1
         containers:
         - name: fluentd
           image: fluent/fluentd-kubernetes-daemonset
           env:
             - name: AWS_REGION
               value: "<your-s3-region>"
           resources:
             limits:
               memory: 500Mi
               cpu: 500m
           volumeMounts:
             - name: config-volume
               mountPath: /fluentd/etc
         volumes:
           - name: config-volume
             configMap:
               name: fluentd-config
   ```

2. Apply the DaemonSet configuration:
   ```bash
   kubectl apply -f fluentd-daemonset.yaml
   ```

### Step 5: Verify the Deployment

1. Check the status of Fluentd pods:
   ```bash
   kubectl get pods -n logging -l name=fluentd
   ```

2. Verify that logs are being forwarded to your S3 bucket:
   - Check your S3 bucket to ensure logs are being stored according to the path and structure you defined.

With this setup, Fluentd will run as a DaemonSet on each node, pulling logs from Elasticsearch and sending them to S3 for long-term storage.
