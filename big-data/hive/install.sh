#!/bin/bash

# Hive 1.2.2

# PRE-REQS
# jdk8 is installed and 
# JAVA_HOME is set correctly before running
# Hadoop

if [[ ! $(printenv JAVA_HOME) =~ .*jdk-8.* ]]; then
  echo "JAVA_HOME should be set to JDK-8 $(printenv JAVA_HOME)"
  echo "Please fix JAVA_HOME before proceeding" 
fi

if [[ ! $(java -version 2>&1 | grep '1.8.0') ]]; then
  echo "Java cmd should be set to JDK-8"
  echo "Please fix java cmd before proceeding"
fi

# MySQL latest, an RDBMS is used to store the HIVE metadata(table structure and location of data in hdfs)
brew install mysql

#interactively set the password for the root user and choose 'y' for all prompts to grant everything
mysql_secure_installation

# Install Hive 1.2.2
brew unpin hive
brew remove hive

cp $HOME/Developer/personal/dotfiles/big-data/hive/rb/hive.rb /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/
brew install hive
brew pin hive

#Add mysql jdbc drivers to connect to MySQL for metadata
mkdir -p $HOME/Data/appData/mysql/jars
cd $HOME/Data/appData/mysql/jars
wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.46.tar.gz
tar -zxvf mysql-connector-java-5.1.46.tar.gz
cd mysql-connector-java-5.1.46
sudo cp mysql-connector-java-5.1.46.jar /Library/Java/Extensions/
sudo chown "$USER":admin /Library/Java/Extensions/mysql-connector-java-5.1.46.jar

# default user/pass change this here and in sql script, if desired
# update the config file(if cherry picking take this whole section)
# jdbc connection for metadata
JDBCUSER='dbuser'
JDBCPASS='dbpassword'
sed -e "s|@@HOME@@|$HOME|g 
        s|@@JDBCUSER@@|$JDBCUSER|g
        s|@@JDBCPASS@@|$JDBCPASS|g" $HOME/Developer/personal/dotfiles/big-data/hive/hive-site.xml >| /usr/local/Cellar/hive/1.2.2/libexec/conf/hive-site.xml

# verify that the contents of hive-site.xml has proper usr/pass

# Configure the Metastore in RDBMS
# Interactive
mysql -u root -p 
# [enter the commands from big-data/hive/create-metastore.sql ]
# 
## OR ## 
# 
## Run script
# cat $HOME/Developer/personal/dotfiles/big-data/hive/create-metastore.sql | $mysql -u root -p 
#
###

# create logs folder in $HIVE_HOME
mkdir -p /usr/local/Cellar/hive/1.2.2/libexec/logs

# Script to start HiveServer2 and HiveMetastore services
mkdir -p $HOME/Data/appData/hive/scripts
cp $HOME/Developer/personal/dotfiles/big-data/hive/run-hive.sh $HOME/Data/appData/hive/scripts
chmod u+x $HOME/Data/appData/hive/scripts/run-hive.sh

# Finished Hive install see hive/README.md to complete
