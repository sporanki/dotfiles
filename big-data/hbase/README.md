# HBase

## Directories

```console
/usr/local/Cellar/hbase/1.3.5/libexec
/usr/local/Cellar/hbase/1.3.5/libexec/conf
/usr/local/Cellar/hbase/1.3.5/libexec/logs
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
hbase master* ❯ hbase shell
2020-06-28 05:14:53,797 WARN  [main] util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/usr/local/Cellar/hbase/1.3.5/libexec/lib/slf4j-log4j12-1.7.5.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/usr/local/Cellar/hadoop/3.2.1_1/libexec/share/hadoop/common/lib/slf4j-log4j12-1.7.25.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.slf4j.impl.Log4jLoggerFactory]
HBase Shell; enter 'help<RETURN>' for list of supported commands.
Type "exit<RETURN>" to leave the HBase Shell
Version 1.3.5, rb59afe7b1dc650ff3a86034477b563734e8799a9, Wed Jun  5 15:57:14 PDT 2019

hbase(main):001:0> create 'test', 'cf1'
0 row(s) in 1.4700 seconds

=> Hbase::Table - test
hbase(main):002:0> list
TABLE
test
1 row(s) in 0.0300 seconds

=> ["test"]
hbase(main):003:0> put 'test', 'row1', 'cf1:name', 'John Smith'
0 row(s) in 0.0740 seconds

hbase(main):004:0> put 'test', 'row1', 'cf1:gender', 'Male'
0 row(s) in 0.0150 seconds

hbase(main):005:0> put 'test', 'row1', 'cf1:age', 45
0 row(s) in 0.0140 seconds

hbase(main):006:0> scan 'test'
ROW                 COLUMN+CELL
 row1               column=cf1:age, timestamp=1593335746470, value=45
 row1               column=cf1:gender, timestamp=1593335739814, value=Male
 row1               column=cf1:name, timestamp=1593335726091, value=John S
                    mith
1 row(s) in 0.0250 seconds

hbase(main):007:0> disable 'test'
0 row(s) in 2.3010 seconds

hbase(main):008:0> drop 'test'
0 row(s) in 1.2610 seconds

hbase(main):009:0> exit
```
