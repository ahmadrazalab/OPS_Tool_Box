# Kafka Setup Guide

This guide provides instructions for setting up Apache Kafka (version 3.7.0) on your system. The setup includes necessary directories, binaries, configurations, and libraries for running Kafka and its components effectively.

## Table of Contents

1. [Directory Structure](#directory-structure)
2. [Prerequisites](#prerequisites)
3. [Installation Steps](#installation-steps)
4. [Configuration Files](#configuration-files)
5. [Starting Kafka](#starting-kafka)
6. [Using Kafka Command-Line Tools](#using-kafka-command-line-tools)
7. [Python Integration](#python-integration)

---

## Directory Structure

The following is the directory structure for the Kafka installation:

```
kafka_2.12-3.7.0
├── bin                  # Contains scripts to run Kafka and Zookeeper
├── config               # Configuration files for Kafka and Zookeeper
├── kafka-consumer.py    # Python consumer script
├── kafka-logger.py      # Python logger script
└── libs                 # Required libraries and dependencies
```

### Key Directories and Files

- **bin/**: Scripts to start, stop, and manage Kafka and Zookeeper instances.
- **config/**: Contains properties files for configuring Kafka and its components.
- **libs/**: Contains all the necessary jar files required for Kafka to function.

---

## Prerequisites

Before installing Kafka, ensure that you have the following prerequisites:

- **Java**: Kafka requires Java 8 or later. Ensure that it is installed and the `JAVA_HOME` environment variable is set correctly.
- **Zookeeper**: Kafka uses Zookeeper for cluster management. It can be run separately or within Kafka.

---

## Installation Steps

1. **Download Kafka**:
   - Download the Kafka binary from the [Apache Kafka website](https://kafka.apache.org/downloads).
   - Extract the downloaded tar.gz file to your desired installation directory.

2. **Verify Installation**:
   - Navigate to the Kafka directory:
     ```bash
     cd kafka_2.12-3.7.0
     ```
   - Note : Tested Kafka Version is `kafka_2.12-3.7.0` ( https://archive.apache.org/dist/kafka/3.7.0/kafka_2.12-3.7.0.tgz )
   - Check if the `bin` directory contains all necessary scripts.

---

## Configuration Files

The configuration files are located in the `config/` directory. Key files include:

- **server.properties**: Configuration for Kafka brokers.
- **zookeeper.properties**: Configuration for Zookeeper.
- **connect-distributed.properties**: Configuration for running Kafka Connect in distributed mode.

### Example of `server.properties`

```properties
# Basic Kafka server configuration
broker.id=0
listeners=PLAINTEXT://localhost:9092
log.dirs=/tmp/kafka-logs
num.partitions=1
```

### Example of `zookeeper.properties`

```properties
# Basic Zookeeper configuration
tickTime=2000
dataDir=/tmp/zookeeper
clientPort=2181
```

---

## Starting Kafka

1. **Start Zookeeper**:
   - Use the following command to start Zookeeper:
     ```bash
     bin/zookeeper-server-start.sh config/zookeeper.properties
     ```

2. **Start Kafka Server**:
   - Once Zookeeper is running, start the Kafka server:
     ```bash
     bin/kafka-server-start.sh config/server.properties
     ```

---

## Using Kafka Command-Line Tools

Kafka provides various command-line tools located in the `bin/` directory. Here are some commonly used commands:

- **Create a Topic**:
  ```bash
  bin/kafka-topics.sh --create --topic my-topic --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1
  ```

- **List Topics**:
  ```bash
  bin/kafka-topics.sh --list --bootstrap-server localhost:9092
  ```

- **Produce Messages**:
  ```bash
  bin/kafka-console-producer.sh --topic my-topic --bootstrap-server localhost:9092
  ```

- **Consume Messages**:
  ```bash
  bin/kafka-console-consumer.sh --topic my-topic --from-beginning --bootstrap-server localhost:9092
  ```

---

## Python Integration

For Python integration, the `kafka-consumer.py` and `kafka-logger.py` scripts can be used. These scripts demonstrate how to interact with Kafka using Python.

### Example of Using `kafka-consumer.py`

Make sure you have the `kafka-python` library installed:

```bash
pip install kafka-python
```

Run the consumer script:

```bash
python kafka-consumer.py
```

---

## Conclusion

This guide provides a basic setup for Apache Kafka, covering installation, configuration, and usage of command-line tools. For advanced configurations and deployments, refer to the [official Kafka documentation](https://kafka.apache.org/documentation/).

> For troubleshooting, please check the logs located in the `/tmp/kafka-logs` directory or adjust the logging settings in the `log4j.properties` file found in the `config/` directory.