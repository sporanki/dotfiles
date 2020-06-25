#!/bin/bash

# Pig 0.17.0

# PRE-REQS
# jdk8 is installed and 
# JAVA_HOME is set correctly before running
# Hadoop

if [[ ! $(printenv JAVA_HOME) =~ .*jdk-8.* ]]; then
  echo "JAVA_HOME should be set to JDK-8 $(printenv JAVA_HOME)" && exit 1 
fi

if [[ ! $(java -version 2>&1 | grep '1.8.0') ]]; then
  echo "Java cmd should be set to JDK-8" && exit 1
fi

# Install Pig 0.17.0
brew unpin pig
brew remove pig

brew install pig
brew pin pig

mkdir -p /usr/local/Cellar/pig/0.17.0_1/libexec/logs
mkdir -p /usr/local/Cellar/pig/0.17.0_1/libexec/conf
echo "log4j.rootLogger=fatal" > /usr/local/Cellar/pig/0.17.0_1/libexec/conf/nolog.conf

# Finished Pig install see pig/README.md to complete
