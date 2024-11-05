```
cd /var/www/devops/kafka-setup/kafka_2.12-3.7.0/

# run zookerper
/var/www/devops/kafka-setup/kafka_2.12-3.7.0/bin/zookeeper-server-start.sh config/zookeeper.properties

# run kafka server oon 9092
/var/www/devops/kafka-setup/kafka_2.12-3.7.0/bin/kafka-server-start.sh config/server.properties

# run localer terminal and create a topic 
/var/www/devops/kafka-setup/kafka_2.12-3.7.0/bin/kafka-topics.sh --create --topic kafka-logs-topic1 --bootstrap-server localhost:9092

# show logs in terminal 
/var/www/devops/kafka-setup/kafka_2.12-3.7.0/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic kafka-logs-topic1 --from-beginning

# test server logs , mamnually create a log in kafka to check working 
/var/www/devops/kafka-setup/kafka_2.12-3.7.0/bin/kafka-console-producer.sh --topic kafka-logs-topic1 --bootstrap-server localhost:9092
```
