#!/bin/bash

# HBase 1.2.6.1

# PRE-REQS
# jdk8 is installed and 
# JAVA_HOME is set correctly before running
# Zookeeper
# Hadoop

if [[ $(printenv JAVA_HOME) =~ .*jdk-8.* ]]; then
else
  echo "JAVA_HOME should be set to JDK-8 $(printenv JAVA_HOME)"
  echo "Please fix JAVA_HOME before proceeding" 
fi

if [[ $(java -version 2>&1) =~ .*\"1\\.8\\..*\" ]]; then
else
  echo "Java cmd should be set to JDK-8"
  echo "Please fix java cmd before proceeding"
fi

# Install HBase 1.2.6.1
cp $dev/personal/dotfiles/big-data/hbase/rb/hbase.rb /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/
brew install hbase
brew pin hbase

# backup configs
cp -p /usr/local/Cellar/hbase/1.2.6.1/libexec/conf/hbase-env.sh /usr/local/Cellar/hbase/1.2.6.1/libexec/conf/hbase-env.sh.og 
cp -p /usr/local/Cellar/hbase/1.2.6.1/libexec/conf/hbase-site.xml /usr/local/Cellar/hbase/1.2.6.1/libexec/conf/hbase-site.xml.og 

# update configs
cp -p $dev/personal/dotfiles/big-data/hbase/hbase-env.sh /usr/local/Cellar/hbase/1.2.6.1/libexec/conf/hbase-env.sh
cp -p $dev/personal/dotfiles/big-data/hbase/hbase-site.xml /usr/local/Cellar/hbase/1.2.6.1/libexec/conf/hbase-site.xml

# Finished HBase install see hbase/README.md to complete