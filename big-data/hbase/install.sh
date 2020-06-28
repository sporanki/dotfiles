#!/bin/bash

# HBase 1.3.5

# PRE-REQS
# jdk8 is installed and 
# JAVA_HOME is set correctly before running
# Zookeeper
# Hadoop

if [[ ! -d "/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home" ]]; then
  echo "JDK-8 must be installed on machine" && exit 1 
fi

# Install HBase
brew update && brew upgrade
brew unpin hbase
brew remove hbase

brew install hbase
brew pin hbase
VER=$(brew info hbase | ggrep -oP '(?<=^/usr/local/Cellar/hbase/).*?(?=\s)')
read -p "Installed hbase \"${VER}\" via homebrew(enter)"

# backup configs
cp -p /usr/local/Cellar/hbase/${VER}/libexec/conf/hbase-env.sh /usr/local/Cellar/hbase/${VER}/libexec/conf/hbase-env.sh.og 
cp -p /usr/local/Cellar/hbase/${VER}/libexec/conf/hbase-site.xml /usr/local/Cellar/hbase/${VER}/libexec/conf/hbase-site.xml.og 

# update configs
cp -p $HOME/Developer/personal/dotfiles/big-data/hbase/hbase-env.sh /usr/local/Cellar/hbase/${VER}/libexec/conf/hbase-env.sh
cp -p $HOME/Developer/personal/dotfiles/big-data/hbase/hbase-site.xml /usr/local/Cellar/hbase/${VER}/libexec/conf/hbase-site.xml

echo "Finished HBase install see hbase/README.md to complete"
echo "Update big-data-env.sh with HBase version ${VER}"