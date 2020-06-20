#!/bin/sh

### STOP README ###
# It is strongly recommended that these steps be run ad-hoc by copying and pasting sections.
# Verify services are correctly installed before proceeding to the next system.
###

### PRE-REQS ###
# jdk8 is installed and JAVA_HOME is set 
###

#if cherry picking in zsh need this to print matching, unsetting because it can mess w/term
setopt KSH_ARRAYS BASH_REMATCH
if [[ $(printenv JAVA_HOME) =~ .*jdk-8.* ]]; then
  echo "JAVA_HOME set correctly " ${BASH_REMATCH[0]} 
else
  echo "JAVA_HOME should be set to JDK-8" ${BASH_REMATCH[0]}
  echo "Please fix JAVA_HOME before proceeding" 
fi
unsetopt KSH_ARRAYS BASH_REMATCH

if [[ $(java -version 2>&1) =~ .*1\\.8\\.0.* ]]; then

setopt KSH_ARRAYS BASH_REMATCH
if [[ $(java -version 2>&1) =~ .*\"1\\.8\\..*\" ]]; then
  echo "java cmd set correctly" ${BASH_REMATCH[0]}
else
  echo "java cmd should be set to JDK-8" ${BASH_REMATCH[0]}
  echo "Please fix java cmd before proceeding"
fi
unsetopt KSH_ARRAYS BASH_REMATCH

# verify... file needs to be run from ~/Developer/personal/dotfiles
dev="$HOME/Developer"
dotfiles="$dev/personal/dotfiles"

# create branch in homebrew-core... will store modifications only temporarily then pin the formulaes
pushd /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core 
git checkout -b big-data

### ZK 3.4.14(latest expects java9+) 

# make sure no process is running on 2181 $(lsof -i :2181)
lsof -i :2181 && { echo 'A process is already running on 2181'; echo 'Please investigate before continuing.'; }

#todo replace with local rb file
brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/6d8197bbb5f77e62d51041a3ae552ce2f8ff1344/Formula/zookeeper.rb
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

# MySQL latest
brew install mysql

#interactively set the password for the root user and choose 'y' for all prompts to grant everything
mysql_secure_installation

#install hive 1.2.2
cp $dev/personal/dotfiles/big-data/hive/rb/hive.rb /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/
brew install hive
brew pin hive

#add mysql jdbc drivers
mkdir -p ~/Data/appData/mysql/jars
cd ~/Data/appData/mysql/jars
wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.46.tar.gz
tar -zxvf mysql-connector-java-5.1.46.tar.gz
cd mysql-connector-java-5.1.46
sudo cp mysql-connector-java-5.1.46.jar /Library/Java/Extensions/
sudo chown "$USER":admin /Library/Java/Extensions/mysql-connector-java-5.1.46.jar

# default user/pass change this here and in sql script, if desired
# update the config file(if cherry picking take this whole section)
JDBCUSER='dbuser'
JDBCPASS='dbpassword'
[[ -z "$JDBCUSER" ]] && { echo "JDBC user must be set"; exit 1; } || echo "JDBC user is set"
[[ -z "$JDBCPASS" ]] && { echo "JDBC password must be set"; exit 1; } || echo "JDBC password is set"
sed -e "s|@@HOME@@|$HOME|g 
        s|@@JDBCUSER@@|$JDBCUSER|g
        s|@@JDBCPASS@@|$JDBCPASS|g" $dev/personal/dotfiles/big-data/hive/hive-site.xml >| /usr/local/Cellar/hive/1.2.2/libexec/conf/hive-site.xml

# verify that the contents of hive-site.xml has proper usr/pass

### Configure the Metastore 
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
mkdir -p ~/Data/appData/hive/scripts
cp $dev/personal/dotfiles/big-data/hive/run-hive.sh ~/Data/appData/hive/scripts
chmod u+x ~/Data/appData/hive/scripts/run-hive.sh



#brew install apache-spark
#will get errors when running 'spark-shell' need to add hostname to /private/etc/hosts
#sudo vim /private/etc/hosts ADD LINE below 
#127.0.0.1       macbook-pro-user


# deal with git cleanup in brew folder
popd
## big-data end