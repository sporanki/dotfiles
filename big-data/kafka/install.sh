#!/bin/bash

# Kafka 2.3.1

# PRE-REQS
# jdk8 is installed and 
# JAVA_HOME is set correctly before running
# Zookeeper

if [[ ! $(printenv JAVA_HOME) =~ .*jdk-8.* ]]; then
  echo "JAVA_HOME should be set to JDK-8 $(printenv JAVA_HOME)" && exit 1 
fi

if [[ ! $(java -version 2>&1 | grep '1.8.0') ]]; then
  echo "Java cmd should be set to JDK-8" && exit 1
fi

# Install Kafka 2.3.1
brew unpin kafka
brew remove kafka

cp $HOME/Developer/personal/dotfiles/big-data/kafka/rb/kafka.rb /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/
brew install kafka
brew pin kafka

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

### Finished Kafka install see kafka/README.md to complete
