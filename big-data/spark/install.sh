#!/bin/bash

# Spark 2.2.1

# PRE-REQS
# jdk8 is installed and 
# JAVA_HOME is set correctly before running
# Hadoop
# Hive

if [[ ! $(printenv JAVA_HOME) =~ .*jdk-8.* ]]; then
  echo "JAVA_HOME should be set to JDK-8 $(printenv JAVA_HOME)" && exit 1 
fi

if [[ ! $(java -version 2>&1 | grep '1.8.0') ]]; then
  echo "Java cmd should be set to JDK-8" && exit 1
fi

# Install Spark 2.2.1
brew unpin apache-spark
brew remove apache-spark

cp $HOME/Developer/personal/dotfiles/big-data/spark/rb/apache-spark.rb /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/
brew install apache-spark
brew pin apache-spark

# Integrate Spark with Hive
# link hive-site file -> spark-conf link
ln -s /usr/local/Cellar/hive/1.2.2/libexec/conf/hive-site.xml /usr/local/Cellar/apache-spark/2.2.1/libexec/conf/hive-site.xml
# link jdbc file -> spark-jars link
ln -s /Library/Java/Extensions/mysql-connector-java-5.1.46.jar /usr/local/Cellar/apache-spark/2.2.1/libexec/jars/mysql-connector-java-5.1.46.jar

### Finished Spark install see /README.md to complete