#/bin/bash

export KAFKA_VERSION=2.3.1
export KAFKA_HOME=/usr/local/Cellar/kafka/2.3.1/libexec
export KAFKA_CONF_DIR=/usr/local/etc/kafka
export PATH=$KAFKA_HOME/bin:$PATH

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
esac