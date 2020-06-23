# Big Data on MacOS

This project installs an integrated hadoop environment locally.

Verify services are correctly installed before proceeding to the next system.

- Zookeeper
- Hadoop
- Hive(Depends on Hadoop)
- Pig(Depends on Hadoop)
- Hbase(Depends on Zookeeper, Hadoop)
- Kafka(Depends on Zookeeper)
- Spark(Depends on Hadoop, Hive)

It is necessary to source `big-data-env.sh` from your `~/.zshrc` script.

For each sytem run the commands in the `install.sh` script and then follow the instructions in `README.md`

## Homebrew

In order to deploy older and slightly customized versions of these systems I override the default homebrew-core files located at:

`/usr/local/Homebrew/Library/Taps/homebrew/homebrew-core`

After installing each system the formula is pinned to preserve the version. It is then safe to run

`brew update && brew upgrade`

Any changes in the aforementioned folder will be stashed in git when `remote brew update` is invoked.

## Appendix

### show running java processes

`jps`

### check if a port is in use

`lsof -i :2181`

### show pinned formulas

`brew list --pinned`
