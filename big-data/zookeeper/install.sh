#!/bin/bash

# Zookeeper 3.4.14

# PRE-REQS
# jdk8 is installed and 
# JAVA_HOME is set correctly before running

if [[ ! $(printenv JAVA_HOME) =~ .*jdk-8.* ]]; then
  echo "JAVA_HOME should be set to JDK-8 $(printenv JAVA_HOME)" && exit 1 
fi

if [[ ! $(java -version 2>&1 | grep '1.8.0') ]]; then
  echo "Java cmd should be set to JDK-8" && exit 1
fi

# Install Zookeeper
brew update && brew upgrade
brew unpin zookeeper
brew remove zookeeper
[ -d "/usr/local/etc/zookeeper" ] && rm -rf /usr/local/etc/zookeeper && echo "Removed /usr/local/etc/zookeeper"

lsof -i :2181 | grep -i java | awk '{print $2}' | xargs kill
echo "Killed existing processes on 2181"

[[ ! -z $(lsof -i :21810 | grep -i java | awk '{print $2}') ]] && echo "Process still running on 2181 exiting" && exit 1

echo "Copy local zookeeper brew file to override latest"
cp $HOME/Developer/personal/dotfiles/big-data/zookeeper/rb/zookeeper.rb /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/

brew install zookeeper
brew pin zookeeper

echo "Installed zookeeper via homebrew"

read -p "Do you want to remove existing zookeeper data?[Yy]" -n 1 -r
[[ $REPLY =~ ^[Yy]$ ]] && rm -rf $HOME/Data/appData/zookeeper/data/* || echo

mkdir -p $HOME/Data/appData/zookeeper/data
cp -p /usr/local/etc/zookeeper/zoo.cfg /usr/local/etc/zookeeper/zoo.cfg.og 

echo "Backed up hadoop default configs"

# update template and cp
sed "s|@@HOME@@|$HOME|g" $HOME/Developer/personal/dotfiles/big-data/zookeeper/zoo.cfg >| /usr/local/etc/zookeeper/zoo.cfg 

echo "Updated zookeeper configs"

echo "Finished Zookeeper install see zookeeper/README.md to complete"
