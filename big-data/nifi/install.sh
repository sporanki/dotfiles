#!/bin/bash

# Nifi 1.11.4

# PRE-REQS
# jdk8+ is installed and 
# JAVA_HOME is set correctly before running

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

# Install Nifi 1.11.4

brew install nifi
brew pin nifi

# Finished Nifi install see Nifi/README.md to complete
