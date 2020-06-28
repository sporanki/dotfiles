#!/bin/bash

# ZK
export ZOOKEEPER_VERSION=3.4.14
export ZOOKEEPER_HOME=/usr/local/Cellar/zookeeper/${ZOOKEEPER_VERSION}/libexec
export ZOOKEEPER_CONF_DIR=/usr/local/etc/zookeeper
export PATH=$ZOOKEEPER_HOME/bin:$PATH

# Hadoop
export HADOOP_VERSION=3.2.1_1
export HADOOP_HOME=/usr/local/Cellar/hadoop/${HADOOP_VERSION}/libexec
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop/
export PATH=$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH

# Hive 
export HIVE_VERSION=3.1.2_1
export HIVE_HOME=/usr/local/Cellar/hive/${HIVE_VERSION}/libexec
export HIVE_CONF_DIR=$HIVE_HOME/conf
export PATH=$HIVE_HOME/bin:$PATH
alias hive-start='/usr/local/Cellar/hive/${HIVE_VERSION}/libexec/bin/run-hive.sh start'
alias hive-stop='/usr/local/Cellar/hive/${HIVE_VERSION}/libexec/bin/run-hive.sh stop'
alias hive='$HIVE_HOME/bin/hive'

# Pig
export PIG_VERSION=0.17.0_1
export PIG_HOME=/usr/local/Cellar/pig/${PIG_VERSION}/libexec
export PATH=$PIG_HOME/bin:$PATH
alias pig-mr='pig -l $PIG_HOME/logs -4 $PIG_HOME/conf/nolog.conf'
alias pig-local='pig -x local -l $PIG_HOME/logs -4 $PIG_HOME/conf/nolog.conf'

# Hbase
#export HBASE_VERSION=1.2.6.1
export HBASE_VERSION=1.3.5
export HBASE_HOME=/usr/local/Cellar/hbase/${HBASE_VERSION}/libexec
export HBASE_CONF_DIR=$HBASE_HOME/conf
export PATH=$HBASE_HOME/bin:$PATH
alias hbase-start='$HBASE_HOME/bin/start-hbase.sh'
alias hbase-stop='$HBASE_HOME/bin/stop-hbase.sh'

# Kafka
export KAFKA_VERSION=2.3.1
export KAFKA_HOME=/usr/local/Cellar/kafka/${KAFKA_VERSION}/libexec
export KAFKA_CONF_DIR=/usr/local/etc/kafka
export PATH=$KAFKA_HOME/bin:$PATH
alias kafka-start='$HOME/Data/appData/kafka/scripts/run-kafka.sh start'
alias kafka-stop='$HOME/Data/appData/kafka/scripts/run-kafka.sh stop'
alias topic='kafka-topics --zookeeper localhost:2181'

# Spark
export SPARK_VERSION=2.2.1
export SPARK_HOME=/usr/local/Cellar/apache-spark/${SPARK_VERSION}/libexec
export SPARK_CONF_DIR=$SPARK_HOME/conf
export SPARK_JARS_DIR=$SPARK_HOME/jars
export PATH=$SPARK_HOME/bin:$PATH

# Elasticsearch
export ELASTICSEARCH_VERSION=7.6.2
export ELASTICSEARCH_HOME=/usr/local/Cellar/elasticsearch/${ELASTICSEARCH_VERSION}/libexec
export ELASTICSEARCH_CONF_DIR=$ELASTICSEARCH_HOME/config
export PATH=$PATH:$ELASTICSEARCH_HOME/bin
alias elasticsearch-start='elasticsearch --daemonize --pidfile $ELASTICSEARCH_HOME/elasticsearch.pid'
alias elasticsearch-stop='kill `cat $ELASTICSEARCH_HOME/elasticsearch.pid`'
alias elasticsearch-restart='elasticsearch-stop && elasticsearch-start'

# Nifi
export NIFI_VERSION=1.11.4
export NIFI_HOME=/usr/local/Cellar/nifi/${NIFI_VERSION}/libexec
export NIFI_CONF_DIR=$NIFI_HOME/conf
export PATH=$PATH:$NIFI_HOME/bin
alias nifi-start='nifi start'
alias nifi-stop='nifi stop'
alias nifi-status='nifi status'

# Common Hadoop File System Aliases
alias hf="hadoop fs"                                         # Base Hadoop fs command
alias hfcat="hf -cat"                                        # Output a file to standard out
alias hfchgrp="hf -chgrp"                                    # Change group association of files
alias hfchmod="hf -chmod"                                    # Change permissions
alias hfchown="hf -chown"                                    # Change ownership
alias hfcfl="hf -copyFromLocal"                              # Copy a local file reference to HDFS
alias hfctl="hf -copyToLocal"                                # Copy a HDFS file reference to local
alias hfcp="hf -cp"                                          # Copy files from source to destination
alias hfdu="hf -du"                                          # Display aggregate length of files
alias hfdus="hf -dus"                                        # Display a summary of file lengths
alias hfget="hf -get"                                        # Get a file from hadoop to local
alias hfgetm="hf -getmerge"                                  # Get files from hadoop to a local file
alias hfls="hf -ls"                                          # List files
alias hfll="hf -lsr"                                         # List files recursivly
alias hfmkdir="hf -mkdir"                                    # Make a directory
alias hfmv="hf -mv"                                          # Move a file
alias hfput="hf -put"                                        # Put a file from local to hadoop
alias hfrm="hf -rm"                                          # Remove a file
alias hfrmr="hf -rmr"                                        # Remove a file recursivly
alias hfsr="hf -setrep"                                      # Set the replication factor of a file
alias hfstat="hf -stat"                                      # Returns the stat information on the path
alias hftail="hf -tail"                                      # Tail a file
alias hftest="hf -test"                                      # Run a series of file tests. See options
alias hftouch="hf -touchz"                                   # Create a file of zero length

# Convenient Hadoop File System Aliases
alias hfet="hf -rmr .Trash"                                  # Remove/Empty the trash
function hfdub() {                                           # Display aggregate size of files descending
   hadoop fs -du "$@" | sort -k 1 -n -r
}

#Common Hadoop Job Commands
alias hj="hadoop job"                                        # Base Hadoop job command
alias hjstat="hj -status"                                    # Print completion percentage and all job counters
alias hjkill="hj -kill"                                      # Kills the job
alias hjhist="hj -history"                                   # Prints job details, failed and killed tip details
alias hjlist="hj -list"                                      # List jobs

#Common Hadoop DFS Admin Commands
alias habal="hadoop balancer"                                # Runs a cluster balancing utility
alias harep="hadoop dfsadmin -report"                        # Print the hdfs admin report
