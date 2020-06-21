# HBase

/usr/local/Cellar/hbase/1.2.6.1/libexec
/usr/local/Cellar/hbase/1.2.6.1/libexec/conf
/usr/local/Cellar/hbase/1.2.6.1/libexec/logs

## start hbase

```console
hbase-start
```

## stop hbase

```console
hbase-stop
```

## validate the install

```console
~HBASE_CONF_DIR ❯ hbase shell
2020-06-21 00:10:20,800 WARN [main] util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/usr/local/Cellar/hbase/1.2.6.1/libexec/lib/slf4j-log4j12-1.7.5.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.slf4j.impl.Log4jLoggerFactory]
HBase Shell; enter 'help<RETURN>' for list of supported commands.
Type "exit<RETURN>" to leave the HBase Shell
Version 1.2.6.1, rUnknown, Sun Jun 3 23:19:26 CDT 2018

hbase(main):001:0> create 'test', 'cf1'
0 row(s) in 1.4020 seconds

=> Hbase::Table - test
hbase(main):002:0> list
TABLE
test
1 row(s) in 0.0210 seconds

=> ["test"]
hbase(main):003:0> put 'test', 'row1', 'cf1:name', 'John Smith'
0 row(s) in 0.1120 seconds

hbase(main):004:0> put 'test', 'row1', 'cf1:gender', 'Male'
0 row(s) in 0.0130 seconds

hbase(main):005:0> put 'test', 'row1', 'cf1:age', 45
0 row(s) in 0.0150 seconds

hbase(main):006:0> scan 'test'
ROW COLUMN+CELL
row1 column=cf1:age, timestamp=1592712800744, value=45
row1 column=cf1:gender, timestamp=1592712781013, value=Male
row1 column=cf1:name, timestamp=1592712758980, value=John Smith
1 row(s) in 0.0240 seconds

hbase(main):007:0> disable 'test'
0 row(s) in 2.2670 seconds

hbase(main):008:0> drop 'test'
0 row(s) in 1.2630 seconds

hbase(main):009:0> exit
~HBASE_CONF_DIR ❯
```
