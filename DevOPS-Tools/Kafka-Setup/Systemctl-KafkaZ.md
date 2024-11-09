
# Running Apache Kafka and Zookeeper on Your Server

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Installing Java](#installing-java)
3. [Installing Zookeeper](#installing-zookeeper)
4. [Installing Kafka](#installing-kafka)
5. [Configuring Zookeeper](#configuring-zookeeper)
6. [Configuring Kafka](#configuring-kafka)
7. [Setting Up Systemd Services](#setting-up-systemd-services)
8. [Starting Services](#starting-services)
9. [Verifying the Installation](#verifying-the-installation)
10. [Troubleshooting](#troubleshooting)

## Prerequisites

- A server running a Linux-based operating system (e.g., Ubuntu, CentOS).
- Access to the terminal with `sudo` privileges.
- Basic understanding of terminal commands.

## Installing Java

Apache Kafka requires Java to run. Make sure you have Java installed:

1. **Update your package index:**

   ```bash
   sudo apt update
   ```

2. **Install OpenJDK:**

   ```bash
   sudo apt install openjdk-17-jdk
   ```

3. **Verify the installation:**

   ```bash
   java -version
   ```

## Installing Zookeeper

Zookeeper is required for managing Kafka brokers. Here’s how to install it:

1. **Download Zookeeper:**

   ```bash
   wget https://downloads.apache.org/zookeeper/zookeeper-3.8.0/apache-zookeeper-3.8.0-bin.tar.gz
   ```

2. **Extract the downloaded file:**

   ```bash
   tar -xzf apache-zookeeper-3.8.0-bin.tar.gz
   ```

3. **Move to `/opt`:**

   ```bash
   sudo mv apache-zookeeper-3.8.0-bin /opt/zookeeper
   ```

4. **Create a configuration file:**

   ```bash
   sudo nano /opt/zookeeper/conf/zoo.cfg
   ```

   Add the following configuration:

   ```ini
   tickTime=2000
   dataDir=/var/lib/zookeeper
   clientPort=2181
   maxClientCnxns=60
   ```

5. **Create the data directory:**

   ```bash
   sudo mkdir /var/lib/zookeeper
   ```

## Installing Kafka

1. **Download Kafka:**

   ```bash
   wget https://downloads.apache.org/kafka/3.4.0/kafka_2.13-3.4.0.tgz
   ```

2. **Extract the downloaded file:**

   ```bash
   tar -xzf kafka_2.13-3.4.0.tgz
   ```

3. **Move to `/opt`:**

   ```bash
   sudo mv kafka_2.13-3.4.0 /opt/kafka
   ```

## Configuring Zookeeper

Make sure Zookeeper is configured correctly. The configuration file was created earlier. You may edit it if needed.

## Configuring Kafka

1. **Create a configuration file for Kafka:**

   ```bash
   sudo nano /opt/kafka/config/server.properties
   ```

   Add or modify the following configurations:

   ```ini
   broker.id=0
   listeners=PLAINTEXT://:9092
   log.dirs=/var/lib/kafka/logs
   zookeeper.connect=localhost:2181
   ```

2. **Create the logs directory:**

   ```bash
   sudo mkdir -p /var/lib/kafka/logs
   ```

## Setting Up Systemd Services

### Create a Zookeeper Service

1. **Create the service file:**

   ```bash
   sudo nano /etc/systemd/system/zookeeper.service
   ```

2. **Add the following content:**

   ```ini
   [Unit]
   Description=Apache Zookeeper
   After=network.target

   [Service]
   User=your_username
   ExecStart=/opt/zookeeper/bin/zkServer.sh start /opt/zookeeper/conf/zoo.cfg
   ExecStop=/opt/zookeeper/bin/zkServer.sh stop
   Restart=on-failure

   [Install]
   WantedBy=multi-user.target
   ```

### Create a Kafka Service

1. **Create the service file:**

   ```bash
   sudo nano /etc/systemd/system/kafka.service
   ```

2. **Add the following content:**

   ```ini
   [Unit]
   Description=Apache Kafka
   After=zookeeper.service

   [Service]
   User=your_username
   ExecStart=/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties
   ExecStop=/opt/kafka/bin/kafka-server-stop.sh
   Restart=on-failure

   [Install]
   WantedBy=multi-user.target
   ```

## Starting Services

1. **Reload systemd to recognize the new services:**

   ```bash
   sudo systemctl daemon-reload
   ```

2. **Start Zookeeper:**

   ```bash
   sudo systemctl start zookeeper
   ```

3. **Start Kafka:**

   ```bash
   sudo systemctl start kafka
   ```

4. **Enable both services to start on boot:**

   ```bash
   sudo systemctl enable zookeeper
   sudo systemctl enable kafka
   ```

## Verifying the Installation

1. **Check the status of Zookeeper:**

   ```bash
   sudo systemctl status zookeeper
   ```

2. **Check the status of Kafka:**

   ```bash
   sudo systemctl status kafka
   ```

3. **Create a test topic:**

   ```bash
   /opt/kafka/bin/kafka-topics.sh --create --topic test --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1
   ```

4. **List topics to confirm:**

   ```bash
   /opt/kafka/bin/kafka-topics.sh --list --bootstrap-server localhost:9092
   ```

## Troubleshooting

- **Check logs** if Kafka or Zookeeper fail to start:
  - Zookeeper logs: `/opt/zookeeper/logs/zookeeper.out`
  - Kafka logs: `/opt/kafka/logs/server.log`
- **Ensure the correct version of Java** is installed.
- **Verify that no other services** are using the same ports (2181 for Zookeeper, 9092 for Kafka).

## Conclusion

You have successfully installed and configured Apache Kafka and Zookeeper on your server. Both services are set up to run automatically at startup, ensuring reliable operation. You can now start producing and consuming messages using Kafka.
