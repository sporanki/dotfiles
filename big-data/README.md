# Big Data on MacOS

This project installs a pseudo-distributed hadoop ecosystem.

This install uses hdfs.

Services are configured to integrate with each other.

Verify services are correctly installed before proceeding to the next service.

- Zookeeper
- Hadoop
- Hive(Depends on Hadoop)
- Pig(Depends on Hadoop)
- Hbase(Depends on Zookeeper, Hadoop)
- Kafka(Depends on Zookeeper)
- Spark(Depends on Hadoop, Hive)
- Elasticsearch
- Nifi

It is necessary to source `big-data-env.sh` from your `~/.zshrc` script.

For each service run the commands in the `install.sh` script and then complete the instructions in `README.md`

## Homebrew

In order to deploy older and slightly customized versions of these services I override the default homebrew-core files located at:

`/usr/local/Homebrew/Library/Taps/homebrew/homebrew-core`

After installing each service the formula is pinned to preserve the version. It is then safe to run

`brew update && brew upgrade`

Any changes in the aforementioned folder will be stashed in git when `remote brew update` is invoked.

## Appendix

### Show running java processes

`jps`

### Check if a port is in use in MacOS

`lsof -i :2181`

### Show pinned formulas

`brew list --pinned`
