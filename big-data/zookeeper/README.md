# Zookeeper

## Directories

```console
$HOME/Data/appData/zookeeper/data
/usr/local/etc/zookeeper
/usr/local/Cellar/zookeeper/3.4.14/
/usr/local/var/log/zookeeper/zookeeper.log
```

## Commands

### Start Zookeeper

```console
zkServer start
```

### Stop Zookeeper

```console
zkServer stop
```

### Status Zookeeper

```console
zkServer status
```

## Appendix

### Commandline interactive shell

List kafka broker ids via interactive shell

```console
~SPARK_CONF_DIR ❯ zkCli
Connecting to localhost:2181
Welcome to ZooKeeper!
JLine support is enabled

WATCHER::

WatchedEvent state:SyncConnected type:None path:null
[zk: localhost:2181(CONNECTED) 0] ls /brokers/ids
[0, 1]
[zk: localhost:2181(CONNECTED) 1]
```
