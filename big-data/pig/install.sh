#!/bin/bash

# Pig 0.17.0

# PRE-REQS
# jdk8 is installed and 
# JAVA_HOME is set correctly before running
# Hadoop

if [[ ! -d "/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home" ]]; then
  echo "JDK-8 must be installed on machine" && exit 1 
fi

# Install Pig 0.17.0
brew unpin pig
brew remove pig

brew install pig
brew pin pig
VER=$(brew info pig | ggrep -oP '(?<=^/usr/local/Cellar/pig/).*?(?=\s)')
read -p "Installed pig \"${VER}\" via homebrew(enter)"

mkdir -p /usr/local/Cellar/pig/${VER}/libexec/logs
mkdir -p /usr/local/Cellar/pig/${VER}/libexec/conf
echo "log4j.rootLogger=fatal" > /usr/local/Cellar/pig/${VER}/libexec/conf/nolog.conf

echo "Finished Pig install see pig/README.md to complete"
echo "Update big-data-env.sh with Pig version ${VER}"
