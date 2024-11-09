# Apache Kafka Performance Testing with Native Tools

## Overview

Apache Kafka provides built-in performance testing tools to help users evaluate the throughput and latency of their Kafka producers and consumers. This document covers how to use `kafka-producer-perf-test.sh` and `kafka-consumer-perf-test.sh` to perform performance tests on Kafka.

### Prerequisites

- Apache Kafka installed and running.
- Access to the Kafka command-line tools (found in the `bin` directory of your Kafka installation).
- A topic created in your Kafka cluster to send messages to.

## Kafka Producer Performance Test

### Tool: `kafka-producer-perf-test.sh`

This script measures the performance of Kafka producers by sending a specified number of messages to a Kafka topic at a defined throughput.

### Command Syntax

```bash
bin/kafka-producer-perf-test.sh \
  --topic <topic_name> \
  --num-records <number_of_records> \
  --record-size <size_of_each_record> \
  --throughput <target_throughput> \
  --producer-props <producer_properties>
```

### Parameters

- `--topic`: The name of the Kafka topic to which messages will be sent.
- `--num-records`: Total number of records to produce (e.g., 1,000,000).
- `--record-size`: Size of each message in bytes (e.g., 1000).
- `--throughput`: Target throughput in records per second (e.g., 10,000).
- `--producer-props`: Additional properties for the producer, such as `bootstrap.servers` to specify Kafka broker addresses.

### Example Usage

To produce 1,000,000 messages of size 1000 bytes at a target throughput of 10,000 messages per second to a topic named `test_topic`, use the following command:

```bash
bin/kafka-producer-perf-test.sh \
  --topic test_topic \
  --num-records 1000000 \
  --record-size 1000 \
  --throughput 10000 \
  --producer-props bootstrap.servers=localhost:9092
```

### Output

The script will output metrics such as:
- Total messages sent
- Throughput (messages per second)
- Average latency
- Minimum and maximum latency

## Kafka Consumer Performance Test

### Tool: `kafka-consumer-perf-test.sh`

This script measures the performance of Kafka consumers by consuming messages from a Kafka topic and calculating throughput and latency.

### Command Syntax

```bash
bin/kafka-consumer-perf-test.sh \
  --topic <topic_name> \
  --num-records <number_of_records> \
  --consumer-props <consumer_properties>
```

### Parameters

- `--topic`: The name of the Kafka topic from which messages will be consumed.
- `--num-records`: Total number of records to consume (e.g., 1,000,000).
- `--consumer-props`: Additional properties for the consumer, such as `bootstrap.servers` and `group.id` for the consumer group.

### Example Usage

To consume 1,000,000 messages from a topic named `test_topic`, use the following command:

```bash
bin/kafka-consumer-perf-test.sh \
  --topic test_topic \
  --num-records 1000000 \
  --consumer-props bootstrap.servers=localhost:9092 \
  --group test_group
```

### Output

The script will output metrics such as:
- Total messages consumed
- Throughput (messages per second)
- Average latency
- Minimum and maximum latency

## Monitoring and Analysis

While running these tests, it is crucial to monitor the Kafka brokers to capture:
- CPU, memory, and disk usage.
- Network throughput.
- Any errors or warnings in the broker logs.

### Additional Considerations

- Ensure that your Kafka cluster is adequately sized for the expected load.
- Experiment with different configurations, such as the number of partitions, replication factors, and message sizes, to assess their impact on performance.
- Conduct tests in an environment that simulates your production workload to get realistic performance metrics.

> Using the built-in performance testing tools provided by Apache Kafka, you can effectively evaluate the performance of your Kafka producers and consumers. This will help you identify bottlenecks, optimize configurations, and ensure that your Kafka cluster can handle the desired load.
