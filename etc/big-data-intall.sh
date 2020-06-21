#!/bin/bash

### STOP README ###
# It is strongly recommended that these steps be run ad-hoc by copying and pasting sections.
# Verify services are correctly installed before proceeding to the next system.
###

### PRE-REQS ###
# jdk8 is installed and JAVA_HOME is set correctly before running
###

#if cherry picking this in zsh need to add this opt to populate BASH_REMATCH, unsetting because it can mess w/term
[[ -n "$ZSH_VERSION" ]] && setopt KSH_ARRAYS BASH_REMATCH
if [[ $(printenv JAVA_HOME) =~ .*jdk-8.* ]]; then
  echo "JAVA_HOME set correctly " ${BASH_REMATCH[0]} 
else
  echo "JAVA_HOME should be set to JDK-8" ${BASH_REMATCH[0]}
  echo "Please fix JAVA_HOME before proceeding" 
fi
[[ -n "$ZSH_VERSION" ]] && unsetopt KSH_ARRAYS BASH_REMATCH

[[ -n "$ZSH_VERSION" ]] && setopt KSH_ARRAYS BASH_REMATCH
if [[ $(java -version 2>&1) =~ .*\"1\\.8\\..*\" ]]; then
  echo "java cmd set correctly" ${BASH_REMATCH[0]}
else
  echo "java cmd should be set to JDK-8" ${BASH_REMATCH[0]}
  echo "Please fix java cmd before proceeding"
fi
[[ -n "$ZSH_VERSION" ]] && unsetopt KSH_ARRAYS BASH_REMATCH

# verify... file needs to be run from $HOME/Developer/personal/dotfiles
dev="$HOME/Developer"
dotfiles="$dev/personal/dotfiles"

### ZK 3.4.14(latest expects java9+) 
# make sure no process is running on 2181 $(lsof -i :2181)
lsof -i :2181 && { echo 'A process is already running on 2181'; echo 'Please investigate before continuing.'; }

#todo replace with local rb file
#brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/6d8197bbb5f77e62d51041a3ae552ce2f8ff1344/Formula/zookeeper.rb
cp $dev/personal/dotfiles/big-data/zk/rb/zookeeper.rb /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/
brew pin zookeeper

mdkir -p $HOME/Data/appData/zookeeper/data
# backup
cp -p /usr/local/etc/zookeeper/zoo.cfg /usr/local/etc/zookeeper/zoo.cfg.og 
# update template and cp, appears noclobber is set use >| to override
sed "s|@@HOME@@|$HOME|g" $dev/personal/dotfiles/big-data/zk/zoo.cfg >| /usr/local/etc/zookeeper/zoo.cfg 
#verify zkServer start... zkServer status=standalone mode

### Hadoop 2.8.1
cp $dev/personal/dotfiles/big-data/hadoop/rb/hadoop.rb /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/
brew install hadoop
brew pin hadoop

# backup configs
cp -p /usr/local/Cellar/hadoop/2.8.1/libexec/etc/hadoop/hadoop-env.sh /usr/local/Cellar/hadoop/2.8.1/libexec/etc/hadoop/hadoop-env.sh.og 
cp -p /usr/local/Cellar/hadoop/2.8.1/libexec/etc/hadoop/core-site.xml /usr/local/Cellar/hadoop/2.8.1/libexec/etc/hadoop/core-site.xml.og 
cp -p /usr/local/Cellar/hadoop/2.8.1/libexec/etc/hadoop/hdfs-site.xml /usr/local/Cellar/hadoop/2.8.1/libexec/etc/hadoop/hdfs-site.xml.og 
cp -p /usr/local/Cellar/hadoop/2.8.1/libexec/etc/hadoop/yarn-site.xml /usr/local/Cellar/hadoop/2.8.1/libexec/etc/hadoop/yarn-site.xml.og 

# update configs
cp -p $dev/personal/dotfiles/big-data/hadoop/hadoop-env.sh /usr/local/Cellar/hadoop/2.8.1/libexec/etc/hadoop/hadoop-env.sh
cp -p $dev/personal/dotfiles/big-data/hadoop/core-site.xml /usr/local/Cellar/hadoop/2.8.1/libexec/etc/hadoop/core-site.xml
cp -p $dev/personal/dotfiles/big-data/hadoop/mapred-site.xml /usr/local/Cellar/hadoop/2.8.1/libexec/etc/hadoop/mapred-site.xml
cp -p $dev/personal/dotfiles/big-data/hadoop/yarn-site.xml /usr/local/Cellar/hadoop/2.8.1/libexec/etc/hadoop/yarn-site.xml
sed "s|@@HOME@@|$HOME|g" $dev/personal/dotfiles/big-data/hadoop/hdfs-site.xml >| /usr/local/Cellar/hadoop/2.8.1/libexec/etc/hadoop/hdfs-site.xml

mkdir -p $HOME/Data/appData/hadoop/dfs/name
mkdir -p $HOME/Data/appData/hadoop/dfs/data
hdfs namenode -format

### MySQL latest, RDBMS is used to store the HIVE metadata(table structure and location of data in hdfs)
brew install mysql

#interactively set the password for the root user and choose 'y' for all prompts to grant everything
mysql_secure_installation

### Hive 1.2.2
cp $dev/personal/dotfiles/big-data/hive/rb/hive.rb /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/
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
[[ -z "$JDBCUSER" ]] && { echo "JDBC user must be set"; exit 1; } || echo "JDBC user is set"
[[ -z "$JDBCPASS" ]] && { echo "JDBC password must be set"; exit 1; } || echo "JDBC password is set"
sed -e "s|@@HOME@@|$HOME|g 
        s|@@JDBCUSER@@|$JDBCUSER|g
        s|@@JDBCPASS@@|$JDBCPASS|g" $dev/personal/dotfiles/big-data/hive/hive-site.xml >| /usr/local/Cellar/hive/1.2.2/libexec/conf/hive-site.xml

# verify that the contents of hive-site.xml has proper usr/pass

### Configure the Metastore in RDBMS
## Interactive
# mysql -u root -p 
# [enter the commands from big-data/hive/create-metastore.sql ]
# 
## OR ## 
# 
## Run script
# cat $dev/personal/dotfiles/big-data/hive/create-metastore.sql | $mysql -u root -p 
#
###

# create logs folder in $HIVE_HOME
mkdir -p /usr/local/Cellar/hive/1.2.2/libexec/logs

# Script to start HiveServer2 and HiveMetastore services
mkdir -p $HOME/Data/appData/hive/scripts
cp $dev/personal/dotfiles/big-data/hive/run-hive.sh $HOME/Data/appData/hive/scripts
chmod u+x $HOME/Data/appData/hive/scripts/run-hive.sh

### HBase 1.2.6.1
cp $dev/personal/dotfiles/big-data/hbase/rb/hbase.rb /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/
brew install hbase
brew pin hbase

# backup configs
cp -p /usr/local/Cellar/hbase/1.2.6.1/libexec/conf/hbase-env.sh /usr/local/Cellar/hbase/1.2.6.1/libexec/conf/hbase-env.sh.og 
cp -p /usr/local/Cellar/hbase/1.2.6.1/libexec/conf/hbase-site.xml /usr/local/Cellar/hbase/1.2.6.1/libexec/conf/hbase-site.xml.og 

# update configs
cp -p $dev/personal/dotfiles/big-data/hbase/hbase-env.sh /usr/local/Cellar/hbase/1.2.6.1/libexec/conf/hbase-env.sh
cp -p $dev/personal/dotfiles/big-data/hbase/hbase-site.xml /usr/local/Cellar/hbase/1.2.6.1/libexec/conf/hbase-site.xml

### Kafka 2.3.1 ~Confluent 5.3.1
cp $dev/personal/dotfiles/big-data/kafka/rb/kafka.rb /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/
brew install kafka
brew pin kafka

#Creating 2 brokers 0->:9093,1->:9094
#create log folder
mkdir -p $HOME/Data/appData/kafka/data/broker0/kafka-logs
mkdir -p $HOME/Data/appData/kafka/data/broker1/kafka-logs

sed "s|@@HOME@@|$HOME|g" $dev/personal/dotfiles/big-data/kafka/server0.properties >| /usr/local/etc/kafka/server0.properties
sed "s|@@HOME@@|$HOME|g" $dev/personal/dotfiles/big-data/kafka/server1.properties >| /usr/local/etc/kafka/server1.properties

#create start/stop scripts
mkdir -p $HOME/Data/appData/kafka/scripts
cp $dev/personal/dotfiles/big-data/kafka/run-kafka.sh $HOME/Data/appData/kafka/scripts
chmod u+x $HOME/Data/appData/kafka/scripts/run-kafka.sh

#brew install apache-spark
#will get errors when running 'spark-shell' need to add hostname to /private/etc/hosts
#sudo vim /private/etc/hosts ADD LINE below 
#127.0.0.1       macbook-pro-user

## big-data end