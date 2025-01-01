# Grafana + Node Exporter + Prometheus Setup for Metric Monitoring

This guide provides step-by-step instructions to set up **Grafana** with **Prometheus** and **Node Exporter** for monitoring system metrics across multiple servers.

## Prerequisites

- **Ubuntu servers** for Grafana, Prometheus, and Node Exporter.
- **Multiple servers** (at least 5) to install Node Exporter for metrics collection.

---

## Step 1: Install and Configure Prometheus

1. **Download Prometheus**:
   ```bash
   wget https://github.com/prometheus/prometheus/releases/download/v2.34.0/prometheus-2.34.0.linux-amd64.tar.gz
   tar xvfz prometheus-2.34.0.linux-amd64.tar.gz
   sudo mv prometheus-2.34.0.linux-amd64 /usr/local/prometheus
   ```

2. **Create Prometheus configuration file**:
   ```bash
   sudo nano /usr/local/prometheus/prometheus.yml
   ```

   Add the following configuration to set up Prometheus to scrape metrics from Node Exporter instances:
   ```yaml
   global:
     scrape_interval: 15s

   scrape_configs:
     - job_name: 'node_exporter'
       static_configs:
         - targets: ['<SERVER1_IP>:9100', '<SERVER2_IP>:9100', '<SERVER3_IP>:9100', '<SERVER4_IP>:9100', '<SERVER5_IP>:9100']
   ```
    Replace `<SERVER1_IP>`, `<SERVER2_IP>`, etc., with the IP addresses of your servers running Node Exporter.


   > Detailed configuration
   ```yaml
    # my global config
    global:
    scrape_interval: 15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
    evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
    # scrape_timeout is set to the global default (10s).

    # Alertmanager configuration
    alerting:
    alertmanagers:
        - static_configs:
            - targets:
            # - alertmanager:9093

    # Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
    rule_files:
    # - "first_rules.yml"
    # - "second_rules.yml"

    # A scrape configuration containing exactly one endpoint to scrape:
    # Here it's Prometheus itself.


    scrape_configs:
    - job_name: 'prometheus'
        scrape_interval: 5s
        static_configs:
        - targets: ['localhost:9090']

    # metrics of grafana vm 
    - job_name: 'grafana-vm-ne'
        scrape_interval: 5s
        static_configs:
        - targets: ['localhost:9100']

    # Uptime kuma metris
    - job_name: 'uptime'
        scrape_interval: 30s
        scheme: https
        static_configs:
        - targets: ['uptime.domain.com']
        basic_auth: 
        password: api-key-xxxx
    ```
   
3. **Create Prometheus systemd service**:
   ```bash
   sudo nano /etc/systemd/system/prometheus.service
   ```

   Add the following content:
   ```ini
    [Unit]
    Description=Prometheus
    Wants=network-online.target
    After=network-online.target

    [Service]
    User=prometheus
    Group=prometheus
    Type=simple
    ExecStart=/usr/local/bin/prometheus \
        --config.file /etc/prometheus/prometheus.yml \
        --storage.tsdb.path /var/lib/prometheus/ \
        --web.console.templates=/etc/prometheus/consoles \
        --web.console.libraries=/etc/prometheus/console_libraries

    [Install]
    WantedBy=multi-user.target
    ```


4. **Start and enable Prometheus service**:
   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable prometheus
   sudo systemctl start prometheus
   ```

---

## Step 2: Install Node Exporter on Each Server

1. **Download Node Exporter**:
   ```bash
   wget https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz
   tar xvfz node_exporter-1.3.1.linux-amd64.tar.gz
   sudo mv node_exporter-1.3.1.linux-amd64/node_exporter /usr/local/bin/
   ```

2. **Create Node Exporter systemd service**:
   ```bash
   sudo nano /etc/systemd/system/node_exporter.service
   ```

   Add the following content:
   ```ini
    [Unit]
    Description=Node Exporter
    Wants=network-online.target
    After=network-online.target

    [Service]
    User=node_exporter
    ExecStart=/usr/local/bin/node_exporter

    [Install]
    WantedBy=multi-user.target
   ```

3. **Start and enable Node Exporter**:
   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable node_exporter
   sudo systemctl start node_exporter
   ```

4. **Verify Node Exporter is running**:
   ```bash
   curl http://localhost:9100/metrics
   ```

> **Repeat the Node Exporter installation on each server** to ensure metrics are available from all desired servers.

---

## Step 3: Install and Configure Grafana with NGINX

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

## Step 4: Configure Grafana to Use Prometheus as Data Source

1. **Access Grafana**: Open a browser and navigate to `http://grafana.example.com`.

2. **Add Prometheus Data Source**:
   - Go to **Configuration > Data Sources > Add data source**.
   - Select **Prometheus** and enter the following URL: `http://localhost:9090`.
   - Click **Save & Test** to verify the connection.

---

## Step 5: Create Dashboards in Grafana

1. **Import Node Exporter Dashboards**:
   - Go to **Dashboards > Import** and use templates for **Node Exporter** from the [Grafana dashboard library](https://grafana.com/grafana/dashboards/).
   - Node Exporter dashboards will provide you with system-level metrics like CPU, memory, disk usage, network traffic, and more for each server.

---

> Your setup of Grafana with Prometheus and Node Exporter is now complete, providing comprehensive metrics monitoring across multiple servers.
