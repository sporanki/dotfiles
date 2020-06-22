# Hive

## Directories

```console
/usr/local/Cellar/hive/1.2.2/libexec
/usr/local/Cellar/hive/1.2.2/libexec/logs
/usr/local/Cellar/hive/1.2.2/libexec/bin
```

## Start MySQL used as the metadata store for hive

```console
brew services start mysql
```

## Start hive

```console
hive-start
```

## Stop hive

```console
hive-stop
```

## Run beeline interactive shell

```console
hive-connect
#inside sql shell
show databases;
show tables;
create table test(id int, name string);
insert into test values(1,'John Smith');
select * from test;
```

## Output from running sql commands above

```console
logs ❯ /usr/local/Cellar/hive/1.2.2/libexec/bin/beeline -u jdbc:hive2://localhost:10000/default -n $USER

Connecting to jdbc:hive2://localhost:10000/default
Connected to: Apache Hive (version 1.2.2)
Driver: Hive JDBC (version 1.2.2)
Transaction isolation: TRANSACTION_REPEATABLE_READ
Beeline version 1.2.2 by Apache Hive
0: jdbc:hive2://localhost:10000/default> show databases;
+----------------+--+
| database_name  |
+----------------+--+
| default        |
+----------------+--+
1 row selected (0.237 seconds)
0: jdbc:hive2://localhost:10000/default> show tables;
+-----------+--+
| tab_name  |
+-----------+--+
+-----------+--+
No rows selected (0.051 seconds)
0: jdbc:hive2://localhost:10000/default> create table test(id int, name string);
No rows affected (0.118 seconds)
0: jdbc:hive2://localhost:10000/default> insert into test values(1,'John Smith');
INFO  : Number of reduce tasks is set to 0 since there's no reduce operator
INFO  : number of splits:1
INFO  : Submitting tokens for job: job_1592610998645_0001
INFO  : The url to track the job: http://localhost:8088/proxy/application_1592610998645_0001/
INFO  : Starting Job = job_1592610998645_0001, Tracking URL = http://localhost:8088/proxy/application_1592610998645_0001/
INFO  : Kill Command = /usr/local/Cellar/hadoop/2.8.1/libexec/bin/hadoop job  -kill job_1592610998645_0001
INFO  : Hadoop job information for Stage-1: number of mappers: 1; number of reducers: 0
INFO  : 2020-06-20 17:14:14,818 Stage-1 map = 0%,  reduce = 0%
INFO  : 2020-06-20 17:14:19,968 Stage-1 map = 100%,  reduce = 0%
INFO  : Ended Job = job_1592610998645_0001
INFO  : Stage-4 is selected by condition resolver.
INFO  : Stage-3 is filtered out by condition resolver.
INFO  : Stage-5 is filtered out by condition resolver.
INFO  : Moving data to: hdfs://localhost:9000/apps/hive/warehouse/test/.hive-staging_hive_2020-06-20_17-14-06_613_7275691198359555370-3/-ext-10000 from hdfs://localhost:9000/apps/hive/warehouse/test/.hive-staging_hive_2020-06-20_17-14-06_613_7275691198359555370-3/-ext-10002
INFO  : Loading data to table default.test from hdfs://localhost:9000/apps/hive/warehouse/test/.hive-staging_hive_2020-06-20_17-14-06_613_7275691198359555370-3/-ext-10000
INFO  : Table default.test stats: [numFiles=1, numRows=1, totalSize=13, rawDataSize=12]
No rows affected (14.624 seconds)
0: jdbc:hive2://localhost:10000/default> select * from test;
+----------+-------------+--+
| test.id  |  test.name  |
+----------+-------------+--+
| 1        | John Smith  |
+----------+-------------+--+
1 row selected (0.086 seconds)

```

### Show on hadoop filesystem

```console
logs ❯ hadoop fs -ls /apps/hive/warehouse/test
20/06/21 19:01:29 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
Found 1 items
-rwxr-xr-x   1 user supergroup         13 2020-06-20 17:14 /apps/hive/warehouse/test/000000_0
```

# Appendix

## MySQL commands

### show users

```sql
select user, host from mysql.user;
```

### drop user

```sql
drop user dbuser;

```

# Troubleshooting

## Beeline error when trying to run beeline as jdbc user

This error makes sense Hive needs to access hdfs, in order to do that pass '-n \$USER' instead of jdbc user, that's only for metastore configured in xml.

```console
/usr/local/Cellar/hive/1.2.2/libexec/bin/beeline -u jdbc:hive2://localhost:10000/default -n dbuser

FAILED: Execution Error, return code 1 from org.apache.hadoop.hive.ql.exec.DDLTask. MetaException(message:Got exception: org.apache.hadoop.security.AccessControlException Permission denied: user=dbuser, access=WRITE, inode="/":$USER:supergroup:drwxr-xr-x
```
