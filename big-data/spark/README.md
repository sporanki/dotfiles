# Spark

## Directories

```console
/usr/local/Cellar/apache-spark/2.2.1/libexec
/usr/local/Cellar/apache-spark/2.2.1/libexec/conf
/usr/local/Cellar/apache-spark/2.2.1/libexec/bin
```

## Validate the install

During the Hive installation a test table was created in the default database.

Verify that we can see that table.

````

```console
logs ❯ spark-shell
Setting default log level to "WARN".
To adjust logging level use sc.setLogLevel(newLevel). For SparkR, use setLogLevel(newLevel).
20/06/21 22:20:40 WARN NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
20/06/21 22:20:40 WARN Utils: Your hostname, macbook-pro-user resolves to a loopback address: 127.0.0.1; using 192.168.1.182 instead (on interface en0)
20/06/21 22:20:40 WARN Utils: Set SPARK_LOCAL_IP if you need to bind to another address
20/06/21 22:20:40 WARN Utils: Service 'SparkUI' could not bind on port 4040. Attempting port 4041.
Spark context Web UI available at http://192.168.1.182:4041
Spark context available as 'sc' (master = local[*], app id = local-1592792440715).
Spark session available as 'spark'.
Welcome to
      ____              __
     / __/__  ___ _____/ /__
    _\ \/ _ \/ _ `/ __/  '_/
   /___/ .__/\_,_/_/ /_/\_\   version 2.2.1
      /_/

Using Scala version 2.11.8 (OpenJDK 64-Bit Server VM, Java 1.8.0_252)
Type in expressions to have them evaluated.
Type :help for more information.

scala> :type sc
org.apache.spark.SparkContext

scala> :type spark
org.apache.spark.sql.SparkSession

scala> sc.version
res0: String = 2.2.1

scala>
````

## Validate Hive integration

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
   /___/ .__/\_,_/_/ /_/\_\   version 2.2.1
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
