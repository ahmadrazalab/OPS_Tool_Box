from confluent_kafka import Consumer, KafkaException, KafkaError
import sys
 
# Kafka broker address
bootstrap_servers = '<kafka-accessed-domain>:9092' # can be localhost:port or kafka.abc.com
 
# Kafka topic to consume from
topic = 'kafka-logs-topic1'  # Update this with your topic name
 
# Consumer configuration
conf = {
    'bootstrap.servers': bootstrap_servers,
    'group.id': 'my_consumer_group',  # Consumer group ID
    'auto.offset.reset': 'earliest'   # Start consuming from the earliest message (optional)
}
 
# Create Kafka Consumer
consumer = Consumer(conf)
 
# Subscribe to topic
consumer.subscribe([topic])
 
try:
    while True:
        # Poll for messages
        msg = consumer.poll(1.0)
 
        if msg is None:
            continue
        if msg.error():
            if msg.error().code() == KafkaError._PARTITION_EOF:
                # End of partition, continue to next
                continue
            else:
                # Other errors
                print(msg.error())
                break
 
        # Print message value
        print('Received message: {}'.format(msg.value().decode('utf-8')))
 
except KeyboardInterrupt:
    pass
 
finally:
    # Close the consumer
    consumer.close()
