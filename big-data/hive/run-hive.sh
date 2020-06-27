#/bin/bash

case $1 in
  start)
    echo "Starting metastore..."
    nohup $HIVE_HOME/bin/hive --service metastore > $HIVE_HOME/logs/metastore.log 2>&1 &
    sleep 10
    ps -ef | grep HiveMetaStore | grep -v grep | awk '{print $2}' > $HIVE_HOME/metastore.pid
    
    echo "Starting hiveserver2..."
    nohup $HIVE_HOME/bin/hiveserver2 > $HIVE_HOME/logs/hiveserver2.log 2>&1 &
    sleep 10
    ps -ef | grep HiveServer | grep -v grep | awk '{print $2}' > $HIVE_HOME/hiveserver2.pid
    ;;
 
  stop)
    # there are issues here... doesn't seem to kill
    hiveserver2_pid=`cat $HIVE_HOME/hiveserver2.pid`
    echo "Stopping hiveserver2...$hiveserver2_pid"
    kill $hiveserver2_pid
    sleep 10
    rm $HIVE_HOME/hiveserver2.pid

    metastore_pid=`cat $HIVE_HOME/metastore.pid`
    echo "Stopping metastore... $metastore_pid"
    kill $metastore_pid
    sleep 10
    rm $HIVE_HOME/metastore_pid
    ;;
esac