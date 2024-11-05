from kafka import KafkaProducer
import json
 
# Kafka configuration
KAFKA_BROKER = '<kafka-accessed-domain>:9092' # KAFKA_BROKER = 'localhost:9092'
 
KAFKA_TOPIC = 'kafka-logs-topic1'
 
# Initialize the Kafka producer
producer = KafkaProducer(
    bootstrap_servers=KAFKA_BROKER,
    value_serializer=lambda v: json.dumps(v).encode('utf-8')
)

# Sample log message
log_message = {
    'level': 'INFO',
    'message': 'This is a sample log message for project1.',
    'timestamp': '2024-07-10T12:00:00'
}
 
# Send the log message to Kafka
producer.send(KAFKA_TOPIC, log_message)
producer.flush()
producer.close()
 
print(f"Log sent to Kafka topic {KAFKA_TOPIC}")
