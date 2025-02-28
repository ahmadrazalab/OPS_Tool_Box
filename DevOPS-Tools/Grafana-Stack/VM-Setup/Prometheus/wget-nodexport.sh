#!/bin/bash

# Variables
NODE_EXPORTER_VERSION="1.8.2"  # Update to the latest version as needed
NODE_EXPORTER_USER="node_exporter"
NODE_EXPORTER_DIR="/usr/local/bin"
NODE_EXPORTER_CONFIG="/etc/systemd/system/node_exporter.service"

# Update packages and install dependencies
echo "Updating packages and installing dependencies..."
sudo apt update && sudo apt install -y wget

# Download and extract Node Exporter
echo "Downloading Node Exporter..."
cd /tmp || exit
wget https://github.com/prometheus/node_exporter/releases/download/v$NODE_EXPORTER_VERSION/node_exporter-$NODE_EXPORTER_VERSION.linux-amd64.tar.gz

echo "Extracting Node Exporter..."
tar xzf node_exporter-$NODE_EXPORTER_VERSION.linux-amd64.tar.gz

# Move Node Exporter binary and set permissions
echo "Moving Node Exporter to $NODE_EXPORTER_DIR..."
sudo mv node_exporter-$NODE_EXPORTER_VERSION.linux-amd64/node_exporter $NODE_EXPORTER_DIR
sudo chown root:root $NODE_EXPORTER_DIR/node_exporter
sudo chmod +x $NODE_EXPORTER_DIR/node_exporter

# Create a dedicated user for Node Exporter
echo "Creating user $NODE_EXPORTER_USER..."
sudo useradd -rs /bin/false $NODE_EXPORTER_USER

# Set up systemd service file
echo "Setting up Node Exporter systemd service..."
sudo tee $NODE_EXPORTER_CONFIG > /dev/null <<EOF
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=$NODE_EXPORTER_USER
ExecStart=$NODE_EXPORTER_DIR/node_exporter
Restart=on-failure
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd, enable and start Node Exporter
echo "Enabling and starting Node Exporter service..."
sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter

# Check the status of the service
echo "Checking Node Exporter service status..."
sudo systemctl status node_exporter


echo ""
echo ""
echo ""
echo ""

# #################################################################

# Prometheus configuration for Node Exporter
echo " Prometheus configuration for Node Exporter (Update This in Prom Configuration)"
Systemhostname=$(hostname)
IPofSYSTEM=$(curl -s ifconfig.me)
# Print the configuration content to the terminal
cat <<EOF
# metrics of $Systemhostname VM
  - job_name: $Systemhostname
    scrape_interval: 5s
    static_configs:
      - targets: ['$IPofSYSTEM:9100']
EOF



#######################################################################
echo " Open 9100 port from this Server and allow Grafana IP (4.186.62.161)"

