#!/bin/bash

# Nifi 1.11.4

# PRE-REQS
# jdk8+ is installed and 
# JAVA_HOME is set correctly before running

if [[ ! -d "/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home" ]]; then
  echo "JDK-8 must be installed on machine" && exit 1 
fi

# Install Nifi 1.11.4
brew unpin nifi
brew remove nifi

brew install nifi
brew pin nifi

# Finished Nifi install see Nifi/README.md to complete
