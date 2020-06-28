# Spark

## Directories

```console
/usr/local/Cellar/apache-spark/3.0.0/libexec
/usr/local/Cellar/apache-spark/3.0.0/libexec/conf
/usr/local/Cellar/apache-spark/3.0.0/libexec/bin
```

## Validate the install

```console
3.0.0 ❯ spark-shell
2020-06-28 08:12:15,294 WARN util.Utils: Your hostname, macbook-pro-user resolves to a loopback address: 127.0.0.1; using 192.168.1.182 instead (on interface en0)
2020-06-28 08:12:15,295 WARN util.Utils: Set SPARK_LOCAL_IP if you need to bind to another address
2020-06-28 08:12:15,587 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
Setting default log level to "WARN".
To adjust logging level use sc.setLogLevel(newLevel). For SparkR, use setLogLevel(newLevel).
Spark context Web UI available at http://macbook.fios-router.home:4040
Spark context available as 'sc' (master = local[*], app id = local-1593346339820).
Spark session available as 'spark'.
Welcome to
      ____              __
     / __/__  ___ _____/ /__
    _\ \/ _ \/ _ `/ __/  '_/
   /___/ .__/\_,_/_/ /_/\_\   version 3.0.0
      /_/

Using Scala version 2.12.10 (OpenJDK 64-Bit Server VM, Java 1.8.0_252)
Type in expressions to have them evaluated.
Type :help for more information.

scala> :type sc
org.apache.spark.SparkContext

scala> :type spark
org.apache.spark.sql.SparkSession

scala> sc.version
res0: String = 3.0.0
```

## Validate Hive integration(havent' verified with newest version)

In the Hive README.md we create a test table in the default database.

Let's verify we can access the table via Hive.

```console
~SPARK_CONF_DIR ❯ spark-shell
Setting default log level to "WARN".
To adjust logging level use sc.setLogLevel(newLevel). For SparkR, use setLogLevel(newLevel).
20/06/21 22:24:44 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
20/06/21 22:24:44 WARN util.Utils: Your hostname, macbook-pro-user resolves to a loopback address: 127.0.0.1; using 192.168.1.182 instead (on interface en0)
20/06/21 22:24:44 WARN util.Utils: Set SPARK_LOCAL_IP if you need to bind to another address
20/06/21 22:24:44 WARN util.Utils: Service 'SparkUI' could not bind on port 4040. Attempting port 4041.
Spark context Web UI available at http://192.168.1.182:4041
Spark context available as 'sc' (master = local[*], app id = local-1592792684852).
Spark session available as 'spark'.
Welcome to
      ____              __
     / __/__  ___ _____/ /__
    _\ \/ _ \/ _ `/ __/  '_/
   /___/ .__/\_,_/_/ /_/\_\   version 3.0.0
      /_/

Using Scala version 2.11.8 (OpenJDK 64-Bit Server VM, Java 1.8.0_252)
Type in expressions to have them evaluated.
Type :help for more information.

scala> spark.sql("show databases").show
+------------+
|databaseName|
+------------+
|     default|
+------------+


scala> spark.sql("select * from default.test").show
+---+----------+
| id|      name|
+---+----------+
|  1|John Smith|
+---+----------+


scala>
```
