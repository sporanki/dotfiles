#!/bin/bash

# Elasticsearch 7.6.2

# PRE-REQS
# jdk8+ is installed and 
# JAVA_HOME is set correctly before running

if [[ ! -d "/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home" ]]; then
  echo "JDK-8 must be installed on machine" && exit 1 
fi

# Install Elasticsearch
brew update && brew upgrade
brew unpin elasticsearch
brew remove elasticsearch
rm -Rf /usr/local/etc/elasticsearch

brew install elasticsearch
brew pin elasticsearch
VER=$(brew info elasticsearch | ggrep -oP '(?<=^/usr/local/Cellar/elasticsearch/).*?(?=\s)')
read -p "Installed elasticsearch ${VER} via homebrew(enter)"

read -p "Do you want to remove existing elasticsearch data?[Nn]" -n 1 -r
[[ $REPLY =~ ^[Yy]$ ]] && rm -rf $HOME/Data/appData/elasticsearch/data/*
echo

# backup configs
cp -p /usr/local/Cellar/elasticsearch/${VER}/libexec/config/elasticsearch.yml /usr/local/Cellar/elasticsearch/${VER}/libexec/config/elasticsearch.yml.og

# update configs
sed "s|@@HOME@@|$HOME|g" $HOME/Developer/personal/dotfiles/big-data/elasticsearch/elasticsearch.yml >| /usr/local/Cellar/elasticsearch/${VER}/libexec/config/elasticsearch.yml

mkdir -p /usr/local/Cellar/elasticsearch/${VER}/libexec/logs

echo "Finished Elasticsearch install see elasticsearch/README.md to complete"
echo "Update big-data-env.sh with Elasticsearch version ${VER}"

