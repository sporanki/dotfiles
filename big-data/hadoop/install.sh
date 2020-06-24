#!/bin/bash

# Hadoop 2.8.1

# PRE-REQS
# jdk8 is installed and 
# JAVA_HOME is set correctly before running

if [[ ! $(printenv JAVA_HOME) =~ .*jdk-8.* ]]; then
  echo "JAVA_HOME should be set to JDK-8 $(printenv JAVA_HOME)"
  echo "Please fix JAVA_HOME before proceeding" 
fi

if [[ ! $(java -version 2>&1 | grep '1.8.0') ]]; then
  echo "Java cmd should be set to JDK-8"
  echo "Please fix java cmd before proceeding"
fi

# Install Hadoop 2.8.1
brew unpin Hadoop
brew remove Hadoop

cp $HOME/Developer/personal/dotfiles/big-data/hadoop/rb/hadoop.rb /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/
brew install hadoop
brew pin hadoop

# backup configs
cp -p /usr/local/Cellar/hadoop/2.8.1/libexec/etc/hadoop/hadoop-env.sh /usr/local/Cellar/hadoop/2.8.1/libexec/etc/hadoop/hadoop-env.sh.og 
cp -p /usr/local/Cellar/hadoop/2.8.1/libexec/etc/hadoop/core-site.xml /usr/local/Cellar/hadoop/2.8.1/libexec/etc/hadoop/core-site.xml.og 
cp -p /usr/local/Cellar/hadoop/2.8.1/libexec/etc/hadoop/hdfs-site.xml /usr/local/Cellar/hadoop/2.8.1/libexec/etc/hadoop/hdfs-site.xml.og 
cp -p /usr/local/Cellar/hadoop/2.8.1/libexec/etc/hadoop/yarn-site.xml /usr/local/Cellar/hadoop/2.8.1/libexec/etc/hadoop/yarn-site.xml.og 

# update configs
cp -p $HOME/Developer/personal/dotfiles/big-data/hadoop/hadoop-env.sh /usr/local/Cellar/hadoop/2.8.1/libexec/etc/hadoop/hadoop-env.sh
cp -p $HOME/Developer/personal/dotfiles/big-data/hadoop/core-site.xml /usr/local/Cellar/hadoop/2.8.1/libexec/etc/hadoop/core-site.xml
cp -p $HOME/Developer/personal/dotfiles/big-data/hadoop/mapred-site.xml /usr/local/Cellar/hadoop/2.8.1/libexec/etc/hadoop/mapred-site.xml
cp -p $HOME/Developer/personal/dotfiles/big-data/hadoop/yarn-site.xml /usr/local/Cellar/hadoop/2.8.1/libexec/etc/hadoop/yarn-site.xml
sed "s|@@HOME@@|$HOME|g" $HOME/Developer/personal/dotfiles/big-data/hadoop/hdfs-site.xml >| /usr/local/Cellar/hadoop/2.8.1/libexec/etc/hadoop/hdfs-site.xml

mkdir -p $HOME/Data/appData/hadoop/dfs/name
mkdir -p $HOME/Data/appData/hadoop/dfs/data
hdfs namenode -format

# Finished Hadoop install see hadoop/README.md to complete
