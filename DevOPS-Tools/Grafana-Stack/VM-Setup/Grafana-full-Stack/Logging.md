# Grafana + Loki + Promtail Setup with NGINX Proxy

This guide provides instructions to set up Grafana Loki for log aggregation, Promtail as a log forwarder on multiple servers, and configure NGINX to host Grafana, pushing logs from Promtail to Loki and visualizing them in Grafana.

## Prerequisites

- **Ubuntu servers** for Loki, Promtail, and Grafana.
- **Multiple servers** (at least 5) to install Promtail and push logs to Loki.

---

## Step 1: Install Grafana Loki

1. **Create Loki directory**:
   ```bash
   sudo mkdir -p /etc/loki /var/lib/loki
   ```

2. **Download and install Loki**:
   ```bash
   wget https://github.com/grafana/loki/releases/download/v2.8.1/loki-linux-amd64.zip
   unzip loki-linux-amd64.zip
   sudo mv loki-linux-amd64 /usr/local/bin/loki
   sudo chmod +x /usr/local/bin/loki
   ```

3. **Create Loki configuration file**:
   ```bash
   sudo nano /etc/loki/loki-config.yml
   ```

   Add the following content to `loki-config.yml`: 
   `Note`:Below is the example configuration for 24 hours log retention
   ```yaml
    auth_enabled: false

    server:
    http_listen_port: 3100
    grpc_listen_port: 9096
    log_level: debug
    grpc_server_max_concurrent_streams: 1000

    common:
    instance_addr: 127.0.0.1
    path_prefix: /tmp/loki
    storage:
        filesystem:
        chunks_directory: /tmp/loki/chunks
        rules_directory: /tmp/loki/rules
    replication_factor: 1
    ring:
        kvstore:
        store: inmemory

    ingester_rf1:
    enabled: false

    query_range:
    results_cache:
        cache:
        embedded_cache:
            enabled: true
            max_size_mb: 100

    schema_config:
    configs:
        - from: 2020-10-24
        store: tsdb
        object_store: filesystem
        schema: v13
        index:
            prefix: index_
            period: 24h

    pattern_ingester:
    enabled: true
    metric_aggregation:
        enabled: true
        loki_address: localhost:3100

    ruler:
    alertmanager_url: http://localhost:9093

    frontend:
    encoding: protobuf

    # By default, Loki will send anonymous, but uniquely-identifiable usage and configuration
    # analytics to Grafana Labs. These statistics are sent to https://stats.grafana.org/
    #
    # Statistics help us better understand how Loki is used, and they show us performance
    # levels for most users. This helps us prioritize features and documentation.
    # For more information on what's sent, look at
    # https://github.com/grafana/loki/blob/main/pkg/analytics/stats.go
    # Refer to the buildReport method to see what goes into a report.
    #
    # If you would like to disable reporting, uncomment the following lines:
    #analytics:
    #  reporting_enabled: false


    # Compactor configuration for retention
    compactor:
    working_directory: /opt/loki-logs-retention
    compaction_interval: 10m
    retention_enabled: true
    retention_delete_delay: 2h
    retention_delete_worker_count: 150
    delete_request_store: filesystem

    # Set global retention to 48 hours
    limits_config:
    retention_period: 25h
   ```

4. **Create Loki systemd service**:
   ```bash
   sudo nano /etc/systemd/system/loki.service
   ```

   Add the following content:
   ```ini
   [Unit]
   Description=Loki service
   After=network.target

   [Service]
   ExecStart=/usr/local/bin/loki -config.file=/etc/loki/loki-config.yml
   Restart=always
   User=root

   [Install]
   WantedBy=multi-user.target
   ```

5. **Start and enable Loki service**:
   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable loki
   sudo systemctl start loki
   ```

6. **Verify Loki is running**:
   ```bash
   sudo journalctl -u loki -f
   ```

---

## Step 2: Install and Configure Promtail on Multiple Servers

1. **Add Grafana APT repository**:
   ```bash
   sudo mkdir -p /etc/apt/keyrings/
   wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor > /etc/apt/keyrings/grafana.gpg
   echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee /etc/apt/sources.list.d/grafana.list
   ```

2. **Install Promtail**:
   ```bash
   sudo apt-get update
   sudo apt-get install promtail
   ```

3. **Configure Promtail**:
   ```bash
   sudo nano /etc/promtail/config.yml
   ```

   Example Promtail configuration to forward logs from NGINX, SSH, cron, and application logs:
   ```yaml
   clients:
     - url: http://<LOKI_SERVER_IP>:3100/loki/api/v1/push

   scrape_configs:
     - job_name: nginx-logs
       static_configs:
         - targets:
             - localhost
           labels:
             job: nginx
             __path__: /var/log/nginx/*log
     - job_name: ssh-logs
       static_configs:
         - targets:
             - localhost
           labels:
             job: ssh
             __path__: /var/log/auth.log
     - job_name: cron-logs
       static_configs:
         - targets:
             - localhost
           labels:
             job: cron
             __path__: /var/log/syslog
     - job_name: app-logs
       static_configs:
         - targets:
             - localhost
           labels:
             job: application
             __path__: /var/log/myapp/*.log
   ```

4. **Allow Promtail access to log files**:
   ```bash
   sudo usermod -aG adm promtail
   sudo chmod o+r /var/log/nginx/
   ```

5. **Create Promtail systemd service**:
   ```bash
   sudo nano /etc/systemd/system/promtail.service
   ```

   Add the following content:
   ```ini
   [Unit]
   Description=Promtail service
   After=network.target

   [Service]
   ExecStart=/usr/bin/promtail -config.file=/etc/promtail/config.yml
   Restart=always
   User=promtail

   [Install]
   WantedBy=multi-user.target
   ```

6. **Start and enable Promtail service**:
   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable promtail
   sudo systemctl start promtail
   ```

7. **Verify Promtail logs**:
   ```bash
   journalctl -u promtail -f
   ```

> **Repeat the Promtail installation on each server (at least 5 servers)**.

---

## Step 3: Install Grafana and Configure NGINX

1. **Install Grafana**:
   ```bash
   sudo apt-get install grafana
   ```

2. **Start and enable Grafana**:
   ```bash
   sudo systemctl enable grafana-server
   sudo systemctl start grafana-server
   ```

3. **Set up NGINX reverse proxy for Grafana**:
   Install NGINX if it isn’t installed:
   ```bash
   sudo apt-get install nginx
   ```

4. **Configure NGINX for Grafana**:
   ```bash
   sudo nano /etc/nginx/sites-available/grafana.conf
   ```

   Add the following configuration:
   ```nginx
   server {
       listen 80;
       server_name grafana.example.com;

       location / {
           proxy_pass http://localhost:3000;
           proxy_set_header Host $host;
           proxy_set_header X-Real-IP $remote_addr;
           proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
           proxy_set_header X-Forwarded-Proto $scheme;
       }
   }
   ```

5. **Enable and restart NGINX**:
   ```bash
   sudo ln -s /etc/nginx/sites-available/grafana.conf /etc/nginx/sites-enabled/
   sudo systemctl restart nginx
   ```

---

## Step 4: Configure Grafana to Use Loki as a Data Source

1. **Access Grafana**: Open a browser and navigate to `http://grafana.example.com`.

2. **Add Loki Data Source**:
   - Go to **Configuration > Data Sources > Add data source**.
   - Select **Loki** and enter the following URL: `http://localhost:3100`.
   - Click **Save & Test** to verify the connection.

---

## Step 5: View Logs in Grafana

After setting up Promtail to push logs to Loki and configuring Grafana to use Loki, you can now visualize logs from your servers in Grafana.

1. **Create a new dashboard** in Grafana.
2. Add **Loki-based panels** to query and visualize logs from your NGINX, SSH, cron, and application logs.

---

## Troubleshooting

- **Verify Promtail logs**:
   ```bash
   journalctl -u promtail -f
   ```

- **Check Loki service logs**:
   ```bash
   journalctl -u loki -f
   ```

- **Check NGINX configuration syntax**:
   ```bash
   sudo nginx -t
   ```

---

> This completes the setup of Grafana Loki, Promtail on multiple servers, and Grafana with NGINX reverse proxy.
