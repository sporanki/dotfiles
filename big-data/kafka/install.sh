#!/bin/bash

# Kafka 2.5.0

# PRE-REQS
# jdk8 is installed and 
# JAVA_HOME is set correctly before running
# Zookeeper

if [[ ! -d "/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home" ]]; then
  echo "JDK-8 must be installed on machine" && exit 1 
fi

# Install Kafka
brew unpin kafka
brew remove kafka
rm -rf /usr/local/etc/kafka

lsof -i :9093 | grep -i java | awk '{print $2}' | xargs kill
echo "Killed existing processes on 9093"
[[ ! -z $(lsof -i :9093 | grep -i java | awk '{print $2}') ]] && echo "Process still running on 9093 exiting" && exit 1

lsof -i :9094 | grep -i java | awk '{print $2}' | xargs kill
echo "Killed existing processes on 9094"
[[ ! -z $(lsof -i :9094 | grep -i java | awk '{print $2}') ]] && echo "Process still running on 9094 exiting" && exit 1

brew install kafka
brew pin kafka

read -p "Do you want to remove the existing write ahead logs?[Nn]" -r
[[ $REPLY =~ ^[Yy]$ ]] && rm -Rf $HOME/Data/appData/kafka/data/broker0/kafka-logs/*; rm -Rf $HOME/Data/appData/kafka/data/broker1/kafka-logs/*

#Creating 2 brokers 0->:9093,1->:9094
#create log folder
mkdir -p $HOME/Data/appData/kafka/data/broker0/kafka-logs
mkdir -p $HOME/Data/appData/kafka/data/broker1/kafka-logs

sed "s|@@HOME@@|$HOME|g" $HOME/Developer/personal/dotfiles/big-data/kafka/server0.properties >| /usr/local/etc/kafka/server0.properties
sed "s|@@HOME@@|$HOME|g" $HOME/Developer/personal/dotfiles/big-data/kafka/server1.properties >| /usr/local/etc/kafka/server1.properties

#create start/stop scripts
mkdir -p $HOME/Data/appData/kafka/scripts
cp $HOME/Developer/personal/dotfiles/big-data/kafka/run-kafka.sh $HOME/Data/appData/kafka/scripts
chmod u+x $HOME/Data/appData/kafka/scripts/run-kafka.sh

echo "Finished Kafka install see hbase/README.md to complete"
echo "Update big-data-env.sh with Kafka version ${VER}"
