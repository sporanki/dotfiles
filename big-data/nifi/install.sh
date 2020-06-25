#!/bin/bash

# Nifi 1.11.4

# PRE-REQS
# jdk8+ is installed and 
# JAVA_HOME is set correctly before running

if [[ ! $(printenv JAVA_HOME) =~ .*jdk-8.* ]]; then
  echo "JAVA_HOME should be set to JDK-8 $(printenv JAVA_HOME)" && exit 1 
fi

if [[ ! $(java -version 2>&1 | grep '1.8.0') ]]; then
  echo "Java cmd should be set to JDK-8" && exit 1
fi

# Install Nifi 1.11.4
brew unpin nifi
brew remove nifi

brew install nifi
brew pin nifi

# Finished Nifi install see Nifi/README.md to complete
