# Hive

## Directories

```console
/usr/local/Cellar/hive/2.3.7/libexec
/usr/local/Cellar/hive/2.3.7/libexec/logs
/usr/local/Cellar/hive/2.3.7/libexec/bin
```

## Start MySQL used as the metadata store for hive

```console
brew services start mysql
```

## Start hive (Must run before running ./hive)

```console
hive-start
```

## Stop hive

```console
hive-stop
```

## Run beeline interactive shell

```console
./hive
#inside sql shell
show databases;
show tables;
create table test(id int, name string);
insert into test values(1,'John Smith');
select * from test;
```

## Output from running sql commands above

```console
bin ❯ ./hive
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/usr/local/Cellar/hive/2.3.7/libexec/lib/log4j-slf4j-impl-2.6.2.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.apache.logging.slf4j.Log4jLoggerFactory]

Logging initialized using configuration in jar:file:/usr/local/Cellar/hive/2.3.7/libexec/lib/hive-common-2.3.7.jar!/hive-log4j2.properties Async: true
Hive-on-MR is deprecated in Hive 2 and may not be available in the future versions. Consider using a different execution engine (i.e. spark, tez) or using Hive 1.X releases.
hive (default)> show databases;
OK
database_name
default
Time taken: 0.771 seconds, Fetched: 1 row(s)
hive (default)> show tables;
OK
tab_name
Time taken: 0.054 seconds
hive (default)> create table test(id int, name string);
OK
Time taken: 0.956 seconds
hive (default)> insert into test values(1,'John Smith');
WARNING: Hive-on-MR is deprecated in Hive 2 and may not be available in the future versions. Consider using a different execution engine (i.e. spark, tez) or using Hive 1.X releases.
Query ID = user_20200626231413_252c876e-f791-4a18-8fe2-3c1987d221a1
Total jobs = 3
Launching Job 1 out of 3
Number of reduce tasks is set to 0 since there's no reduce operator
Starting Job = job_1592610998645_0002, Tracking URL = http://localhost:8088/proxy/application_1592610998645_0002/
Kill Command = /usr/local/Cellar/hadoop/2.8.1/libexec/bin/hadoop job  -kill job_1592610998645_0002
Hadoop job information for Stage-1: number of mappers: 1; number of reducers: 0
2020-06-26 23:14:21,910 Stage-1 map = 0%,  reduce = 0%
2020-06-26 23:14:28,105 Stage-1 map = 100%,  reduce = 0%
Ended Job = job_1592610998645_0002
Stage-4 is selected by condition resolver.
Stage-3 is filtered out by condition resolver.
Stage-5 is filtered out by condition resolver.
Moving data to directory hdfs://localhost:9000/apps/hive/warehouse/test/.hive-staging_hive_2020-06-26_23-14-13_210_3523127975562676356-1/-ext-10000
Loading data to table default.test
MapReduce Jobs Launched:
Stage-Stage-1: Map: 1   HDFS Read: 4141 HDFS Write: 81 SUCCESS
Total MapReduce CPU Time Spent: 0 msec
OK
_col0	_col1
Time taken: 16.437 seconds
hive (default)> select * from test;
OK
test.id	test.name
1	John Smith
Time taken: 0.094 seconds, Fetched: 1 row(s)
```

### Show on hadoop filesystem

```console
bin ❯ hadoop fs -ls /apps/hive/warehouse/test
20/06/26 23:16:22 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
Found 1 items
-rwxr-xr-x   1 apanizo supergroup         13 2020-06-26 23:14 /apps/hive/warehouse/test/000000_0
```

# Appendix

## MySQL commands

### show users

```sql
select user, host from mysql.user;
```

### drop user

```sql
drop user 'hive_user'@'localhost';

```

# Troubleshooting

## Beeline error when trying to run beeline as jdbc user

This error makes sense Hive needs to access hdfs, in order to do that pass '-n \$USER' instead of jdbc user, that's only for metastore configured in xml.

```console
/usr/local/Cellar/hive/1.2.2/libexec/bin/beeline -u jdbc:hive2://localhost:10000/default -n hive_user

FAILED: Execution Error, return code 1 from org.apache.hadoop.hive.ql.exec.DDLTask. MetaException(message:Got exception: org.apache.hadoop.security.AccessControlException Permission denied: user=hive_user, access=WRITE, inode="/":$USER:supergroup:drwxr-xr-x
```
