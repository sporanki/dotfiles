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

# Install Hadoop 3.2.1_1
brew update && brew upgrade
brew unpin Hadoop
brew remove Hadoop

#cp $HOME/Developer/personal/dotfiles/big-data/hadoop/rb/hadoop.rb /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/
brew install hadoop
brew pin hadoop

read -p "You have installed hadoop via homebrew"

# backup configs
cp -p /usr/local/Cellar/hadoop/3.2.1_1/libexec/etc/hadoop/hadoop-env.sh /usr/local/Cellar/hadoop/3.2.1_1/libexec/etc/hadoop/hadoop-env.sh.og 
cp -p /usr/local/Cellar/hadoop/3.2.1_1/libexec/etc/hadoop/core-site.xml /usr/local/Cellar/hadoop/3.2.1_1/libexec/etc/hadoop/core-site.xml.og 
cp -p /usr/local/Cellar/hadoop/3.2.1_1/libexec/etc/hadoop/hdfs-site.xml /usr/local/Cellar/hadoop/3.2.1_1/libexec/etc/hadoop/hdfs-site.xml.og 
cp -p /usr/local/Cellar/hadoop/3.2.1_1/libexec/etc/hadoop/yarn-site.xml /usr/local/Cellar/hadoop/3.2.1_1/libexec/etc/hadoop/yarn-site.xml.og 

read -p "You have backed up hadoop default configs"

# update configs
cp -p $HOME/Developer/personal/dotfiles/big-data/hadoop/hadoop-env.sh /usr/local/Cellar/hadoop/3.2.1_1/libexec/etc/hadoop/hadoop-env.sh
cp -p $HOME/Developer/personal/dotfiles/big-data/hadoop/core-site.xml /usr/local/Cellar/hadoop/3.2.1_1/libexec/etc/hadoop/core-site.xml
cp -p $HOME/Developer/personal/dotfiles/big-data/hadoop/mapred-site.xml /usr/local/Cellar/hadoop/3.2.1_1/libexec/etc/hadoop/mapred-site.xml
cp -p $HOME/Developer/personal/dotfiles/big-data/hadoop/yarn-site.xml /usr/local/Cellar/hadoop/3.2.1_1/libexec/etc/hadoop/yarn-site.xml
sed "s|@@HOME@@|$HOME|g" $HOME/Developer/personal/dotfiles/big-data/hadoop/hdfs-site.xml >| /usr/local/Cellar/hadoop/3.2.1_1/libexec/etc/hadoop/hdfs-site.xml

read -p "You have updated hadoop configs"

read -p "You are about to re-create your hdfs filesystem do you wish to continue?(ctrl-c to abort)"

# add if exists
rm -rf $HOME/Data/appData/hadoop/dfs/name/*
rm -rf $HOME/Data/appData/hadoop/dfs/data/*

mkdir -p $HOME/Data/appData/hadoop/dfs/name
mkdir -p $HOME/Data/appData/hadoop/dfs/data

read -p "You are about to format the hdfs filesystem"
hdfs namenode -format
read -p "You are done formatting the hdfs filesystem"

# Finished Hadoop install see hadoop/README.md to complete
