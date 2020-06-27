#!/bin/bash

# Hadoop 3.2.1_1

# PRE-REQS
# jdk8 is installed and 
# JAVA_HOME is set correctly before running

if [[ ! $(printenv JAVA_HOME) =~ .*jdk-8.* ]]; then
  echo "JAVA_HOME should be set to JDK-8 $(printenv JAVA_HOME)" && exit 1 
fi

if [[ ! $(java -version 2>&1 | grep '1.8.0') ]]; then
  echo "Java cmd should be set to JDK-8" && exit 1
fi

# Install
brew update && brew upgrade
brew unpin Hadoop
brew remove Hadoop

read -p "Please verify hadoop processes are NOT running before continuing(ctrl+c to exit)"

brew install hadoop
brew pin hadoop
VER=$(brew info hadoop | ggrep -oP '(?<=^/usr/local/Cellar/hadoop/).*?(?=\s)')
read -p "Installed hadoop ${VER} via homebrew"

# backup configs
cp -p /usr/local/Cellar/hadoop/${VER}/libexec/etc/hadoop/hadoop-env.sh /usr/local/Cellar/hadoop/${VER}/libexec/etc/hadoop/hadoop-env.sh.og 
cp -p /usr/local/Cellar/hadoop/${VER}/libexec/etc/hadoop/core-site.xml /usr/local/Cellar/hadoop/${VER}/libexec/etc/hadoop/core-site.xml.og 
cp -p /usr/local/Cellar/hadoop/${VER}/libexec/etc/hadoop/hdfs-site.xml /usr/local/Cellar/hadoop/${VER}/libexec/etc/hadoop/hdfs-site.xml.og 
cp -p /usr/local/Cellar/hadoop/${VER}/libexec/etc/hadoop/yarn-site.xml /usr/local/Cellar/hadoop/${VER}/libexec/etc/hadoop/yarn-site.xml.og 

echo "Backed up hadoop default configs"

# update configs
cp -p $HOME/Developer/personal/dotfiles/big-data/hadoop/hadoop-env.sh /usr/local/Cellar/hadoop/${VER}/libexec/etc/hadoop/hadoop-env.sh
cp -p $HOME/Developer/personal/dotfiles/big-data/hadoop/core-site.xml /usr/local/Cellar/hadoop/${VER}/libexec/etc/hadoop/core-site.xml
cp -p $HOME/Developer/personal/dotfiles/big-data/hadoop/mapred-site.xml /usr/local/Cellar/hadoop/${VER}/libexec/etc/hadoop/mapred-site.xml
cp -p $HOME/Developer/personal/dotfiles/big-data/hadoop/yarn-site.xml /usr/local/Cellar/hadoop/${VER}/libexec/etc/hadoop/yarn-site.xml
sed "s|@@HOME@@|$HOME|g" $HOME/Developer/personal/dotfiles/big-data/hadoop/hdfs-site.xml >| /usr/local/Cellar/hadoop/${VER}/libexec/etc/hadoop/hdfs-site.xml

echo "Updated hadoop configs"

read -p "Re-creating hdfs filesystem do you wish to continue?(ctrl-c to abort)"

# add if exists
rm -rf $HOME/Data/appData/hadoop/dfs/name/*
rm -rf $HOME/Data/appData/hadoop/dfs/data/*

# hfs-site.xml Determines where on the local filesystem the DFS name node should store the name table(fsimage)
mkdir -p $HOME/Data/appData/hadoop/dfs/name
# hfs-site.xml Determines where on the local filesystem an DFS data node should store its blocks.
mkdir -p $HOME/Data/appData/hadoop/dfs/data

read -p "About to format the hdfs filesystem"
hdfs namenode -format
read -p "Done formatting the hdfs filesystem"

echo "Finished Hadoop install see hadoop/README.md to complete"
echo "Update big-data-env.sh with HADOOP version ${VER}"
