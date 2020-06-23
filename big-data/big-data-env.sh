#!/bin/bash

### PRE-REQS ###
# jdk8 is installed and JAVA_HOME is set 
###

# ZK
export ZOOKEEPER_HOME=/usr/local/Cellar/zookeeper/3.4.14/libexec
export ZOOKEEPER_CONF_DIR=/usr/local/etc/zookeeper
export ZOOKEEPER_VERSION=3.4.14
export PATH=$ZOOKEEPER_HOME/bin:$PATH

# Hadoop
export HADOOP_VERSION=2.8.1
export HADOOP_HOME=/usr/local/Cellar/hadoop/2.8.1/libexec
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop/
export PATH=$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH

# Hive 
export HIVE_VERSION=1.2.2
export HIVE_HOME=/usr/local/Cellar/hive/1.2.2/libexec
export HIVE_CONF_DIR=$HIVE_HOME/conf
export PATH=$HIVE_HOME/bin:$PATH
alias hive-start='$HOME/Data/appData/hive/scripts/run-hive.sh start'
alias hive-stop='$HOME/Data/appData/hive/scripts/run-hive.sh stop'
alias hive-connect='$HIVE_HOME/bin/beeline -u jdbc:hive2://localhost:10000/default -n $USER'

# Pig
export PIG_VERSION=0.17.0_1
export PIG_HOME=/usr/local/Cellar/pig/0.17.0_1/libexec
export PATH=$PIG_HOME/bin:$PATH
alias pig-mr='pig -l $PIG_HOME/logs -4 $PIG_HOME/conf/nolog.conf'
alias pig-local='pig -x local -l $PIG_HOME/logs -4 $PIG_HOME/conf/nolog.conf'

# Hbase
export HBASE_VERSION=1.2.6.1
export HBASE_HOME=/usr/local/Cellar/hbase/1.2.6.1/libexec
export HBASE_CONF_DIR=$HBASE_HOME/conf
export PATH=$HBASE_HOME/bin:$PATH
alias hbase-start='$HBASE_HOME/bin/start-hbase.sh'
alias hbase-stop='$HBASE_HOME/bin/stop-hbase.sh'

# Kafka
export KAFKA_VERSION=2.3.1
export KAFKA_HOME=/usr/local/Cellar/kafka/2.3.1/libexec
export KAFKA_CONF_DIR=/usr/local/etc/kafka
export PATH=$KAFKA_HOME/bin:$PATH
alias kafka-start='$HOME/Data/appData/kafka/scripts/run-kafka.sh start'
alias kafka-stop='$HOME/Data/appData/kafka/scripts/run-kafka.sh stop'
alias topic='kafka-topics --zookeeper localhost:2181'

# Spark
export SPARK_VERSION=2.2.1
export SPARK_HOME=/usr/local/Cellar/apache-spark/2.2.1/libexec
export SPARK_CONF_DIR=$SPARK_HOME/conf
export SPARK_JARS_DIR=$SPARK_HOME/jars
export PATH=$SPARK_HOME/bin:$PATH

# Elasticsearch
export ELASTICSEARCH_VERSION=7.6.2
export ELASTICSEARCH_HOME=/usr/local/Cellar/elasticsearch/7.6.2/libexec
export ELASTICSEARCH_CONF_DIR=$ELASTICSEARCH_HOME/config
export PATH=$PATH:$ELASTICSEARCH_HOME/bin
alias elasticsearch-start='elasticsearch --daemonize --pidfile $ELASTICSEARCH_HOME/elasticsearch.pid'
alias elasticsearch-stop='kill `cat $ELASTICSEARCH_HOME/elasticsearch.pid`'
alias elasticsearch-restart='elasticsearch-stop && elasticsearch-start'