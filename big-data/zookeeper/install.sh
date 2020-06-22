#!/bin/bash

# Zookeeper 3.4.14 

# PRE-REQS
# jdk8 is installed and 
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

# Install Zookeeper 3.4.14 

# https://raw.githubusercontent.com/Homebrew/homebrew-core/6d8197bbb5f77e62d51041a3ae552ce2f8ff1344/Formula/zookeeper.rb
cp $dev/personal/dotfiles/big-data/zookeeper/rb/zookeeper.rb /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/
brew pin zookeeper

mdkir -p $HOME/Data/appData/zookeeper/data
# backup
cp -p /usr/local/etc/zookeeper/zoo.cfg /usr/local/etc/zookeeper/zoo.cfg.og 
# update template and cp
sed "s|@@HOME@@|$HOME|g" $dev/personal/dotfiles/big-data/zookeeper/zoo.cfg >| /usr/local/etc/zookeeper/zoo.cfg 

# Finished Zookeeper install see zookeeper/README.md to complete
