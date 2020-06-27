#!/bin/bash

HIVE_VER=2.3.7
JDBCUSER='hive_user'
JDBCPASS='hivepassword'

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

# if MySQL not installed
if [[ ! $(brew list -1 | tr '\n' ',' | egrep "(^|,)mysql(,|$)") ]]; then 

  # Latest RDBMS used to store the HIVE metadata(table structure and location of data in hdfs)
  brew install mysql

  #interactively set the password for the root user and choose 'y' for all prompts to grant everything
  mysql_secure_installation

  #Add mysql jdbc drivers to connect to MySQL for metadata
  mkdir -p $HOME/Data/appData/mysql/jars
  cd $HOME/Data/appData/mysql/jars
  wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.46.tar.gz
  
  tar -zxvf mysql-connector-java-5.1.46.tar.gz
  cd mysql-connector-java-5.1.46
  sudo cp mysql-connector-java-5.1.46.jar /Library/Java/Extensions/
  sudo chown "$USER":admin /Library/Java/Extensions/mysql-connector-java-5.1.46.jar
  ln -s /Library/Java/Extensions/mysql-connector-java-5.1.46.jar /usr/local/Cellar/hive/2.3.7/libexec/

  # Create the Metastore and User
  # Interactive
  mysql -u root -p 
  # [enter the commands from big-data/hive/create-metastore.sql ]
  # 
  ## OR ## 
  # 
  ## Run script
  # cat $HOME/Developer/personal/dotfiles/big-data/hive/create-metastore.sql | mysql -u root -p 
  #
  ###

  # create metastore tables
  HIVE_VER=2.3.7
  pushd /usr/local/Cellar/hive/2.3.7/libexec/scripts/metastore/upgrade/mysql/ 
  cat /usr/local/Cellar/hive/2.3.7/libexec/scripts/metastore/upgrade/mysql/hive-schema-2.3.0.mysql.sql | mysql hive_metastore -u root -p
  popd
  
  # verify
  echo "show tables;" | mysql hive_metastore -u hive_user -p

fi

# Install Hive
brew unpin hive
brew remove hive

cp $HOME/Developer/personal/dotfiles/big-data/hive/rb/hive.rb /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/
brew install hive
brew pin hive
read -p "done brew install hive"

# default user/pass change this here and in sql script, if desired
# update the config file(if cherry picking take this whole section)
# jdbc connection for metadata

sed -e "s|@@HOME@@|$HOME|g 
        s|@@JDBCUSER@@|$JDBCUSER|g
        s|@@JDBCPASS@@|$JDBCPASS|g" $HOME/Developer/personal/dotfiles/big-data/hive/hive-site.xml >| /usr/local/Cellar/hive/${HIVE_VER}/libexec/conf/hive-site.xml
read -p "temp"

# verify that the contents of hive-site.xml has proper usr/pass

# create logs folder in $HIVE_HOME
mkdir -p /usr/local/Cellar/hive/${HIVE_VER}/libexec/logs

# Script to start HiveServer2 and HiveMetastore services
# Must start hivemetastore before running hive or errors will occur running queries
cp $HOME/Developer/personal/dotfiles/big-data/hive/run-hive.sh /usr/local/Cellar/hive/${HIVE_VER}/libexec/bin
chmod u+x /usr/local/Cellar/hive/${HIVE_VER}/libexec/bin/run-hive.sh

# Finished Hive install see hive/README.md to complete
