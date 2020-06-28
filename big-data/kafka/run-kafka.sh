#/bin/bash

case $1 in
  start)
    echo "Starting Kafka Broker with id: 0"
    $KAFKA_HOME/bin/kafka-server-start.sh -daemon $KAFKA_CONF_DIR/server0.properties
    echo "Starting Kafka Broker with id: 1"
    $KAFKA_HOME/bin/kafka-server-start.sh -daemon $KAFKA_CONF_DIR/server1.properties
  ;;
 
  stop)
    echo "Stopping Kafka Brokers"
    $KAFKA_HOME/bin/kafka-server-stop.sh
  ;;
  
  *)
    echo "USAGE: run-kafka.sh [start|stop]"
    exit 1
esac