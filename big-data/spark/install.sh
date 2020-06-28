#!/bin/bash

# Spark 3.0.0

# PRE-REQS
# jdk8 is installed and 
# JAVA_HOME is set correctly before running
# Hadoop
# Hive

if [[ ! -d "/Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home" ]]; then
  echo "JDK-11 must be installed on machine" && exit 1 
fi

# Install Spark 3.0.0
brew update && brew upgrade
brew unpin apache-spark
brew remove apache-spark

#cp $HOME/Developer/personal/dotfiles/big-data/spark/rb/apache-spark.rb /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/
brew install apache-spark
brew pin apache-spark
VER=$(brew info apache-spark | ggrep -oP '(?<=^/usr/local/Cellar/apache-spark/).*?(?=\s)')
read -p "Installed apache-spark \"${VER}\" via homebrew(enter)"


# Integrate Spark with Hive
# link hive-site file -> spark-conf link
# ln -s /usr/local/Cellar/hive/${HIVE_VERSION}/libexec/conf/hive-site.xml /usr/local/Cellar/apache-spark/${VER}/libexec/conf/hive-site.xml

# link jdbc file -> spark-jars link
# ln -s /Library/Java/Extensions/mysql-connector-java-5.1.46.jar /usr/local/Cellar/apache-spark/${VER}/libexec/jars/mysql-connector-java-5.1.46.jar

### Finished Spark install see /README.md to complete