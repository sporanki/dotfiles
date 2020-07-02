# Big Data on MacOS

This project installs a pseudo-distributed hadoop ecosystem using hdfs.

Services are configured to integrate with each other.

Verify services are correctly installed before proceeding to the next service.

- Zookeeper
- Hadoop
- Hive(Depends on Hadoop)
- \*Pig(Depends on Hadoop) Not currently compatible with Hadoop 3 this system should be skipped
- Hbase(Depends on Zookeeper, Hadoop)
- Kafka(Depends on Zookeeper)
- Spark(Depends on Hadoop(optional), Hive(optional))
- Elasticsearch
- Nifi

It is necessary to source `big-data-env.sh` from your `~/.zshrc` script.

For each service run the commands in the `install.sh` script and then complete the instructions in `README.md`

## Startup (No need to run all service can be cherry picked)

Verify processes are stopped via

Commands to start up

```console
zoo-start
hadoop-start
hive-start
hbase-start
kafka-start
elasticsearch-start
nifi-start
```

## Shutdown

Verify processes are stopped via

Commands to shutdown

```console
nifi-stop
elasticsearch-stop
kafka-stop
hive-stop
hbase-stop
hadoop-stop
zoo-stop
```

List java processes

```console
jps -ml
```
