# cat /etc/systemd/system/logs.service
[Unit]
Description=Breeze
After=network.target

[Service]
Type=simple
User=root
Group=root
WorkingDirectory=/var/www/html/logs-ui
ExecStart=/var/www/html/logs-ui/logs-pathbased
Restart=on-failure
RestartSec=5s

[Install]
WantedBy=multi-user.target
