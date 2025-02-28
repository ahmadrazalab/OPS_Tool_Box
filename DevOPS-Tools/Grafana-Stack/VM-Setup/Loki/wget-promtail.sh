#!/bin/bash

set -e

# Update package lists
apt-get update -y

# Install required dependencies
apt-get install -y curl wget gnupg

# Install Loki and Promtail
apt-get install -y promtail

# Reload systemd, enable, and start Promtail service
systemctl daemon-reload
systemctl enable promtail
systemctl start promtail

# Verify service status
systemctl status promtail --no-pager

# Reload systemd, enable and start 
echo "Enabling and starting service..."
sudo systemctl daemon-reload
sudo systemctl enable promtail
sudo systemctl start promtail

# Check the status of the service
echo "Checking service status..."
sudo systemctl status promtail


echo ""
echo ""
echo ""
echo ""

