#!/bin/bash

# Elasticsearch 7.6.2

# PRE-REQS
# jdk8+ is installed and 
# JAVA_HOME is set correctly before running

if [[ ! -d "/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home" ]]; then
  echo "JDK-8 must be installed on machine" && exit 1 
fi

# Install Elasticsearch 7.6.2
brew unpin elasticsearch
brew remove elasticsearch

brew install elasticsearch
brew pin elasticsearch

# backup configs
cp -p /usr/local/Cellar/elasticsearch/7.6.2/libexec/config/elasticsearch.yml /usr/local/Cellar/elasticsearch/7.6.2/libexec/config/elasticsearch.yml.og

# update configs
sed "s|@@HOME@@|$HOME|g" $HOME/Developer/personal/dotfiles/big-data/elasticsearch/elasticsearch.yml >| /usr/local/Cellar/elasticsearch/7.6.2/libexec/config/elasticsearch.yml

mkdir -p /Users/keith/Data/appData/elasticsearch/data
$ mkdir -p /usr/local/Cellar/elasticsearch/6.2.4/libexec/logs
# Finished Elasticsearch install see Elasticsearch/README.md to complete
