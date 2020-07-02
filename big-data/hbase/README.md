# HBase

## Directories

```console
/usr/local/Cellar/hbase/2.2.3/libexec
/usr/local/Cellar/hbase/2.2.3/libexec/conf
/usr/local/Cellar/hbase/2.2.3/libexec/logs
```

## Start hbase

```console
hbase-start
```

## Stop hbase

```console
hbase-stop
```

## Validate the install

```console
bin ❯ hbase shell
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/usr/local/Cellar/hadoop/3.2.1_1/libexec/share/hadoop/common/lib/slf4j-log4j12-1.7.25.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/usr/local/Cellar/hbase/2.2.3/libexec/lib/client-facing-thirdparty/slf4j-log4j12-1.7.25.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.slf4j.impl.Log4jLoggerFactory]
2020-07-01 19:20:43,557 WARN  [main] util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
HBase Shell
Use "help" to get list of supported commands.
Use "exit" to quit this interactive shell.
For Reference, please visit: http://hbase.apache.org/2.0/book.html#shell
Version 2.2.3, r6a830d87542b766bd3dc4cfdee28655f62de3974, 2020年 01月 10日 星期五 18:27:51 CST
Took 0.0020 seconds
hbase(main):001:0> create 'test', 'cf1'
Created table test
Took 1.0716 seconds
=> Hbase::Table - test
hbase(main):002:0> put 'test', 'row1', 'cf1:name', 'John Smith'
Took 0.1281 seconds
hbase(main):003:0> put 'test', 'row1', 'cf1:gender', 'Male'
Took 0.0046 seconds
hbase(main):004:0> put 'test', 'row1', 'cf1:age', 45
Took 0.0068 seconds
hbase(main):005:0> scan 'test'
ROW                                               COLUMN+CELL
 row1                                             column=cf1:age, timestamp=1593645688163, value=45
 row1                                             column=cf1:gender, timestamp=1593645679002, value=Male
 row1                                             column=cf1:name, timestamp=1593645670977, value=John Smith
1 row(s)
Took 0.0187 seconds
hbase(main):006:0> disable 'test'
Took 0.7804 seconds
hbase(main):007:0> drop 'test'
Took 0.2437 seconds
hbase(main):008:0> exit
```

### Issues initializing HBase

May need to delete data in Zookeeper.
