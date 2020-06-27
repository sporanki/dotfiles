#!/bin/bash

# Hive 3.1.2
JDBCUSER='hive_user'
JDBCPASS='hivepassword'

DRIVER_URL="https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.46.tar.gz"

# PRE-REQS
# jdk8 is installed and 
# JAVA_HOME is set correctly before running
# Hive

if [[ ! $(printenv JAVA_HOME) =~ .*jdk-8.* ]]; then
  echo "JAVA_HOME should be set to JDK-8 $(printenv JAVA_HOME)" && exit 1 
fi

if [[ ! $(java -version 2>&1 | grep '1.8.0') ]]; then
  echo "Java cmd should be set to JDK-8" && exit 1
fi

# Install Hive
brew unpin hive
brew remove hive

brew install hive
brew pin hive
VER=$(brew info hive | ggrep -oP '(?<=^/usr/local/Cellar/hive/).*?(?=\s)')
read -p "Installed hive \"${VER}\" via homebrew(enter)"

# if MySQL not installed
if [[ ! $(brew list -1 | tr '\n' ',' | egrep "(^|,)mysql(,|$)") ]]; then
  read -p "MySQL is not installed, installing now...(enter)"
  # Latest RDBMS used to store the HIVE metadata(table structure and location of data in hdfs)
  brew install mysql
  #interactively set the password for the root user and choose 'y' for all prompts to grant everything
  mysql_secure_installation
fi

#Add mysql jdbc drivers to connect to MySQL for metadata
if [[ ! -f "/usr/local/Cellar/hive/${VER}/libexec/lib/$DRIVER_NAME.jar" ]]; then
  DRIVER_FILE_NAME=${DRIVER_URL##*/}
  DRIVER_NAME=${DRIVER_FILE_NAME%.tar.gz} 
  
  read -p "did it extract??? to /tmp dfile_name=$DRIVER_FILE_NAME driver_name=$DRIVER_NAME"
  sudo cp /tmp/$DRIVER_NAME/$DRIVER_NAME.jar /Library/Java/Extensions/
  sudo chown "$USER":admin /Library/Java/Extensions/$DRIVER_NAME.jar
  set -x 
  ln -s /Library/Java/Extensions/$DRIVER_NAME.jar /usr/local/Cellar/hive/${VER}/libexec/lib/$DRIVER_NAME.jar
  read -p "MySQL JDBC connector installed(enter)"
fi

read -p "Do you want to remove existing metadatastore and user?[Yy]" -n 1 -r
[[ $REPLY =~ ^[Yy]$ ]] && cat $HOME/Developer/personal/dotfiles/big-data/hive/delete-metastore.sql | mysql -u root -p || echo

read -p "Create the Metastore table and user(enter)"
# Create Metastore user and database
cat $HOME/Developer/personal/dotfiles/big-data/hive/create-metastore.sql | mysql -u root -p 

echo "select user, host from mysql.user;" | mysql hive_metastore -u root -p
echo "show databases;" | mysql hive_metastore -u root -p
read -p "Should see user and hive_metastore database above(enter)"

# Update the configs
sed -e "s|@@HOME@@|$HOME|g 
        s|@@JDBCUSER@@|$JDBCUSER|g
        s|@@JDBCPASS@@|$JDBCPASS|g" $HOME/Developer/personal/dotfiles/big-data/hive/hive-site.xml >| /usr/local/Cellar/hive/${VER}/libexec/conf/hive-site.xml

read -p "Populate the hive-metastore schema(relies on hive-site.xml)"
schematool -dbType mysql -initSchema
echo "show tables;" | mysql hive_metastore -u hive_user -p
read -p "Verify tables above"

# create logs folder in $HIVE_HOME
mkdir -p /usr/local/Cellar/hive/${VER}/libexec/logs

# Script to start HiveServer2 and HiveMetastore services
# Must start hivemetastore before running hive or errors will occur running queries
cp $HOME/Developer/personal/dotfiles/big-data/hive/run-hive.sh /usr/local/Cellar/hive/${VER}/libexec/bin
chmod u+x /usr/local/Cellar/hive/${VER}/libexec/bin/run-hive.sh

# Finished Hive install see hive/README.md to complete
