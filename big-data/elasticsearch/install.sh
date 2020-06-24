#!/bin/bash

# Elasticsearch 7.6.2

# PRE-REQS
# jdk8+ is installed and 
# JAVA_HOME is set correctly before running

if [[ ! $(printenv JAVA_HOME) =~ .*jdk-8.* ]]; then
  echo "JAVA_HOME should be set to JDK-8 $(printenv JAVA_HOME)"
  echo "Please fix JAVA_HOME before proceeding" 
fi

if [[ ! $(java -version 2>&1 | grep '1.8.0') ]]; then
  echo "Java cmd should be set to JDK-8"
  echo "Please fix java cmd before proceeding"
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
