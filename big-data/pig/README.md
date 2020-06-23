# Pig

## Directories

```console
/usr/local/Cellar/pig/0.17.0_1/libexec
/usr/local/Cellar/pig/0.17.0_1/libexec/conf
/usr/local/Cellar/pig/0.17.0_1/libexec/logs
```

## Verify local mode

```console
pig-local
```

Output:

```console
logs ❯ pig-local
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/usr/local/Cellar/hbase/1.2.6.1/libexec/lib/slf4j-log4j12-1.7.5.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.slf4j.impl.Log4jLoggerFactory]
20/06/22 19:51:02 INFO pig.ExecTypeProvider: Trying ExecType : LOCAL
20/06/22 19:51:02 INFO pig.ExecTypeProvider: Picked LOCAL as the ExecType
20/06/22 19:51:02 INFO pig.Main: Loaded log4j properties from file: /usr/local/Cellar/pig/0.17.0_1/libexec/conf/nolog.conf
grunt> quit
```

## Verify Map Reduce Mode

```console
pig-mr
```

Output:

```console
logs ❯ pig-mr
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/usr/local/Cellar/hbase/1.2.6.1/libexec/lib/slf4j-log4j12-1.7.5.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.slf4j.impl.Log4jLoggerFactory]
20/06/22 19:52:05 INFO pig.ExecTypeProvider: Trying ExecType : LOCAL
20/06/22 19:52:05 INFO pig.ExecTypeProvider: Trying ExecType : MAPREDUCE
20/06/22 19:52:05 INFO pig.ExecTypeProvider: Picked MAPREDUCE as the ExecType
20/06/22 19:52:05 INFO pig.Main: Loaded log4j properties from file: /usr/local/Cellar/pig/0.17.0_1/libexec/conf/nolog.conf
grunt> quit
```
