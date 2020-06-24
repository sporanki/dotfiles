# Hadoop

## Directories

```console
/usr/local/Cellar/hadoop/2.8.1/libexec/etc/hadoop
/usr/local/Cellar/hadoop/2.8.1/libexec/
/usr/local/Cellar/hadoop/2.8.1/libexec/logs
```

## Format namenode (relies on on hdfs-site.xml for configuration)

```bash
hdfs namenode -format
```

## **_Before proceeding the SSH server must be installed see the appendix for more details_**

## Start hadoop(in order)

```bash
start-dfs.sh
start-yarn.sh
```

## Stop hadoop(in order)

```bash
stop-yarn.sh
stop-dfs.sh
```

### Verify

Namenode UI: http://localhost:50070/
Resource Manager UI: http://localhost:8088/

```bash
jps
```

### Validate

```console
hdfs dfs -ls /
homebrew-core big-data\* ❯ hdfs dfs -ls /

20/06/19 20:14:50 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable

hdfs dfsadmin -report
homebrew-core big-data\* ❯ hdfs dfsadmin -report

20/06/19 20:15:37 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
Configured Capacity: 499963174912 (465.63 GB)
Present Capacity: 270710243328 (252.12 GB)
DFS Remaining: 270710231040 (252.12 GB)
DFS Used: 12288 (12 KB)
DFS Used%: 0.00%
Under replicated blocks: 0
Blocks with corrupt replicas: 0
Missing blocks: 0
Missing blocks (with replication factor 1): 0
Pending deletion blocks: 0

---

Live datanodes (1):

Name: 127.0.0.1:50010 (localhost)
Hostname: localhost
Decommission Status : Normal
Configured Capacity: 499963174912 (465.63 GB)
DFS Used: 12288 (12 KB)
Non DFS Used: 216241803264 (201.39 GB)
DFS Remaining: 270710231040 (252.12 GB)
DFS Used%: 0.00%
DFS Remaining%: 54.15%
Configured Cache Capacity: 0 (0 B)
Cache Used: 0 (0 B)
Cache Remaining: 0 (0 B)
Cache Used%: 100.00%
Cache Remaining%: 0.00%
Xceivers: 1
Last contact: Fri Jun 19 20:15:37 EDT 2020
```

# Appendix

## Install SSH server

Solution: Check if sshd is running

```bash
sudo systemsetup -getremotelogin
```

If not enabled you have to enable via the UI.

```
1.Open the Apple menu in the upper left corner of the screen, and select "System Preferences...".
2.Under "Internet & Wireless", select "Sharing".
3.In the left column of services, enable "Remote Login".
4.Highlight the "Remote Login" service and enable access for the users you would like to have SSH access.
5.You can select all users, or specific users by selecting "Only these users:" and adding the appropriate users by clicking "+".
6.Take note of the command displayed underneath the words "Remote Login: On" in the upper middle part of the screen.
7.Write this command down as you will need it to log in from a different system.
8.If your firewall is enabled (which it is by default), you may need to restart the firewall to allow SSH communications to pass through port 22.
9.Open "System Prefrences", click "Security", and restart the Firewall.

Test that the firewall is not blocking SSH access by going to a different system and entering the ssh login command in step 6 above.

If you cannot login, restart the firewall or reboot.
```

Verify by re-running

```bash
sudo systemsetup -getremotelogin
```

## Error when trying to start-dfs.sh

```console
~HADOOP_CONF_DIR ❯ start-dfs.sh
20/06/19 17:24:39 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
Starting namenodes on [localhost]
localhost: ssh: connect to host localhost port 22: Connection refused
localhost: ssh: connect to host localhost port 22: Connection refused
Starting secondary namenodes [0.0.0.0]
0.0.0.0: ssh: connect to host 0.0.0.0 port 22: Connection refused
20/06/19 17:24:41 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform...
using builtin-java classes where applicable
```

This error occurs because sshd is not installed. @see Install ssh server for fix.

## Resource Manager is not running

Web page isn't responding process is not visible when running jps

## Output of successful dfs-start.sh

```console
start-dfs.sh
20/06/19 18:02:20 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
Starting namenodes on [localhost]
The authenticity of host 'localhost (::1)' can't be established.
ECDSA key fingerprint is SHA256:L4dTZ6OxSR6/09Z+03mmo0LJAesfHfMIOcSTZVbXQa8.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
localhost: Warning: Permanently added 'localhost' (ECDSA) to the list of known hosts.
Password:
localhost: starting namenode, logging to /usr/local/Cellar/hadoop/2.8.1/libexec/logs/hadoop-user-namenode-macbook-pro-user.out
Password:
localhost: starting datanode, logging to /usr/local/Cellar/hadoop/2.8.1/libexec/logs/hadoop-user-datanode-macbook-pro-user.out
Starting secondary namenodes [0.0.0.0]
The authenticity of host '0.0.0.0 (0.0.0.0)' can't be established.
ECDSA key fingerprint is SHA256:L4dTZ6OxSR6/09Z+03mmo0LJAesfHfMIOcSTZVbXQa8.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
0.0.0.0: Warning: Permanently added '0.0.0.0' (ECDSA) to the list of known hosts.
Password:
0.0.0.0: starting secondarynamenode, logging to /usr/local/Cellar/hadoop/2.8.1/libexec/logs/hadoop-user-secondarynamenode-macbook-pro-user.out
20/06/19 18:02:52 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
```

## Output of successful yarn start... well not really successful check next

Turns out new env. just needed to be sourced to get \$JAVA_HOME

```console
~HADOOP_CONF_DIR ❯ start-yarn.sh
starting yarn daemons
starting resourcemanager, logging to /usr/local/Cellar/hadoop/2.8.1/libexec/logs/yarn-user-resourcemanager-macbook-pro-user.out
Password:
localhost: starting nodemanager, logging to /usr/local/Cellar/hadoop/2.8.1/libexec/logs/yarn-user-nodemanager-macbook-pro-user.out
localhost: WARNING: An illegal reflective access operation has occurred
localhost: WARNING: Illegal reflective access by org.apache.hadoop.security.authentication.util.KerberosUtil (file:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/hadoop-auth-2.8.1.jar) to method sun.security.krb5.Config.getInstance()
localhost: WARNING: Please consider reporting this to the maintainers of org.apache.hadoop.security.authentication.util.KerberosUtil
localhost: WARNING: Use --illegal-access=warn to enable warnings of further illegal reflective access operations
localhost: WARNING: All illegal access operations will be denied in a future release
```

## Output of successful namenode format

```console
hdfs namenode -format
20/06/19 17:02:04 INFO namenode.NameNode: STARTUP_MSG:
/\***\*\*\*\*\*\*\***\*\*\*\*\***\*\*\*\*\*\*\***\*\*\*\*\***\*\*\*\*\*\*\***\*\*\*\*\***\*\*\*\*\*\*\***
STARTUP_MSG: Starting NameNode
STARTUP_MSG: user = user
STARTUP_MSG: host = macbook-pro-user/127.0.0.1
STARTUP_MSG: args = [-format]
STARTUP_MSG: version = 2.8.1
STARTUP_MSG: classpath = /usr/local/Cellar/hadoop/2.8.1/libexec/etc/hadoop/:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/jaxb-impl-2.2.3-1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/activation-1.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/commons-configuration-1.6.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/commons-beanutils-1.7.0.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/xz-1.0.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/junit-4.11.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/stax-api-1.0-2.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/apacheds-i18n-2.0.0-M15.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/jaxb-api-2.2.2.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/mockito-all-1.8.5.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/jackson-jaxrs-1.9.13.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/commons-logging-1.1.3.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/curator-recipes-2.7.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/jetty-sslengine-6.1.26.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/jersey-json-1.9.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/htrace-core4-4.0.1-incubating.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/avro-1.7.4.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/log4j-1.2.17.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/nimbus-jose-jwt-3.9.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/commons-cli-1.2.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/commons-digester-1.8.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/servlet-api-2.5.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/protobuf-java-2.5.0.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/xmlenc-0.52.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/jackson-xc-1.9.13.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/jetty-util-6.1.26.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/httpclient-4.5.2.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/guava-11.0.2.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/commons-compress-1.4.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/hadoop-annotations-2.8.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/commons-io-2.4.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/jackson-core-asl-1.9.13.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/jersey-core-1.9.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/jsp-api-2.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/commons-codec-1.4.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/netty-3.6.2.Final.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/jetty-6.1.26.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/commons-beanutils-core-1.8.0.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/jersey-server-1.9.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/java-xmlbuilder-0.4.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/paranamer-2.3.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/zookeeper-3.4.6.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/commons-collections-3.2.2.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/jettison-1.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/asm-3.2.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/api-asn1-api-1.0.0-M20.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/apacheds-kerberos-codec-2.0.0-M15.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/hamcrest-core-1.3.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/hadoop-auth-2.8.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/httpcore-4.4.4.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/api-util-1.0.0-M20.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/curator-framework-2.7.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/commons-net-3.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/gson-2.2.4.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/slf4j-log4j12-1.7.10.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/jets3t-0.9.0.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/commons-lang-2.6.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/json-smart-1.1.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/jcip-annotations-1.0.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/snappy-java-1.0.4.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/jackson-mapper-asl-1.9.13.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/commons-math3-3.1.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/jsch-0.1.51.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/jsr305-3.0.0.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/slf4j-api-1.7.10.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/lib/curator-client-2.7.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/hadoop-common-2.8.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/hadoop-common-2.8.1-tests.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/common/hadoop-nfs-2.8.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/lib/xercesImpl-2.9.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/lib/commons-logging-1.1.3.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/lib/htrace-core4-4.0.1-incubating.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/lib/log4j-1.2.17.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/lib/commons-cli-1.2.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/lib/xml-apis-1.3.04.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/lib/servlet-api-2.5.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/lib/protobuf-java-2.5.0.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/lib/okio-1.4.0.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/lib/xmlenc-0.52.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/lib/jetty-util-6.1.26.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/lib/guava-11.0.2.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/lib/commons-io-2.4.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/lib/jackson-core-asl-1.9.13.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/lib/jersey-core-1.9.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/lib/commons-codec-1.4.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/lib/netty-3.6.2.Final.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/lib/jetty-6.1.26.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/lib/jersey-server-1.9.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/lib/asm-3.2.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/lib/commons-lang-2.6.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/lib/leveldbjni-all-1.8.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/lib/jackson-mapper-asl-1.9.13.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/lib/netty-all-4.0.23.Final.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/lib/commons-daemon-1.0.13.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/lib/okhttp-2.4.0.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/lib/jsr305-3.0.0.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/lib/hadoop-hdfs-client-2.8.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/hadoop-hdfs-nfs-2.8.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/hadoop-hdfs-2.8.1-tests.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/hadoop-hdfs-2.8.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/hadoop-hdfs-client-2.8.1-tests.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/hadoop-hdfs-native-client-2.8.1-tests.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/hadoop-hdfs-native-client-2.8.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/hdfs/hadoop-hdfs-client-2.8.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/jaxb-impl-2.2.3-1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/activation-1.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/zookeeper-3.4.6-tests.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/commons-math-2.2.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/aopalliance-1.0.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/guice-servlet-3.0.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/xz-1.0.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/stax-api-1.0-2.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/jaxb-api-2.2.2.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/jackson-jaxrs-1.9.13.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/commons-logging-1.1.3.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/fst-2.24.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/jersey-json-1.9.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/log4j-1.2.17.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/commons-cli-1.2.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/servlet-api-2.5.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/protobuf-java-2.5.0.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/javassist-3.18.1-GA.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/objenesis-2.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/jackson-xc-1.9.13.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/jetty-util-6.1.26.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/guava-11.0.2.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/commons-compress-1.4.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/commons-io-2.4.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/jackson-core-asl-1.9.13.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/jersey-core-1.9.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/commons-codec-1.4.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/netty-3.6.2.Final.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/jetty-6.1.26.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/jersey-server-1.9.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/guice-3.0.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/jersey-client-1.9.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/jersey-guice-1.9.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/zookeeper-3.4.6.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/commons-collections-3.2.2.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/jettison-1.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/asm-3.2.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/commons-lang-2.6.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/leveldbjni-all-1.8.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/jackson-mapper-asl-1.9.13.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/javax.inject-1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/jsr305-3.0.0.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/curator-test-2.7.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/lib/curator-client-2.7.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/hadoop-yarn-server-tests-2.8.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/hadoop-yarn-api-2.8.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/hadoop-yarn-applications-distributedshell-2.8.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/hadoop-yarn-server-timeline-pluginstorage-2.8.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/hadoop-yarn-registry-2.8.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/hadoop-yarn-server-sharedcachemanager-2.8.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/hadoop-yarn-applications-unmanaged-am-launcher-2.8.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/hadoop-yarn-server-applicationhistoryservice-2.8.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/hadoop-yarn-server-common-2.8.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/hadoop-yarn-server-resourcemanager-2.8.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/hadoop-yarn-client-2.8.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/hadoop-yarn-common-2.8.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/hadoop-yarn-server-nodemanager-2.8.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/yarn/hadoop-yarn-server-web-proxy-2.8.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/mapreduce/lib/aopalliance-1.0.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/mapreduce/lib/guice-servlet-3.0.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/mapreduce/lib/xz-1.0.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/mapreduce/lib/junit-4.11.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/mapreduce/lib/avro-1.7.4.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/mapreduce/lib/log4j-1.2.17.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/mapreduce/lib/protobuf-java-2.5.0.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/mapreduce/lib/commons-compress-1.4.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/mapreduce/lib/hadoop-annotations-2.8.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/mapreduce/lib/commons-io-2.4.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/mapreduce/lib/jackson-core-asl-1.9.13.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/mapreduce/lib/jersey-core-1.9.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/mapreduce/lib/netty-3.6.2.Final.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/mapreduce/lib/jersey-server-1.9.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/mapreduce/lib/guice-3.0.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/mapreduce/lib/jersey-guice-1.9.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/mapreduce/lib/paranamer-2.3.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/mapreduce/lib/asm-3.2.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/mapreduce/lib/hamcrest-core-1.3.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/mapreduce/lib/leveldbjni-all-1.8.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/mapreduce/lib/snappy-java-1.0.4.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/mapreduce/lib/jackson-mapper-asl-1.9.13.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/mapreduce/lib/javax.inject-1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/mapreduce/hadoop-mapreduce-client-hs-2.8.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/mapreduce/hadoop-mapreduce-client-core-2.8.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.8.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/mapreduce/hadoop-mapreduce-client-app-2.8.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/mapreduce/hadoop-mapreduce-client-hs-plugins-2.8.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/mapreduce/hadoop-mapreduce-client-jobclient-2.8.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/mapreduce/hadoop-mapreduce-client-shuffle-2.8.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/mapreduce/hadoop-mapreduce-client-common-2.8.1.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/share/hadoop/mapreduce/hadoop-mapreduce-client-jobclient-2.8.1-tests.jar:/usr/local/Cellar/hadoop/2.8.1/libexec/contrib/capacity-scheduler/\*.jar
STARTUP_MSG: build = https://git-wip-us.apache.org/repos/asf/hadoop.git -r 20fe5304904fc2f5a18053c389e43cd26f7a70fe; compiled by 'vinodkv' on 2017-06-02T06:14Z
STARTUP_MSG: java = 1.8.0_252 \***\*\*\*\*\*\*\***\*\*\*\*\***\*\*\*\*\*\*\***\*\*\*\*\***\*\*\*\*\*\*\***\*\*\*\*\***\*\*\*\*\*\*\***/
20/06/19 17:02:04 INFO namenode.NameNode: registered UNIX signal handlers for [TERM, HUP, INT]
20/06/19 17:02:04 INFO namenode.NameNode: createNameNode [-format]
20/06/19 17:02:05 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
Formatting using clusterid: CID-35aee33c-3d78-4e9f-b8fb-4055e89533af
20/06/19 17:02:05 INFO namenode.FSEditLog: Edit logging is async:false
20/06/19 17:02:05 INFO namenode.FSNamesystem: KeyProvider: null
20/06/19 17:02:05 INFO namenode.FSNamesystem: fsLock is fair: true
20/06/19 17:02:05 INFO namenode.FSNamesystem: Detailed lock hold time metrics enabled: false
20/06/19 17:02:05 INFO blockmanagement.DatanodeManager: dfs.block.invalidate.limit=1000
20/06/19 17:02:05 INFO blockmanagement.DatanodeManager: dfs.namenode.datanode.registration.ip-hostname-check=true
20/06/19 17:02:05 INFO blockmanagement.BlockManager: dfs.namenode.startup.delay.block.deletion.sec is set to 000:00:00:00.000
20/06/19 17:02:05 INFO blockmanagement.BlockManager: The block deletion will start around 2020 Jun 19 17:02:05
20/06/19 17:02:05 INFO util.GSet: Computing capacity for map BlocksMap
20/06/19 17:02:05 INFO util.GSet: VM type = 64-bit
20/06/19 17:02:05 INFO util.GSet: 2.0% max memory 889 MB = 17.8 MB
20/06/19 17:02:05 INFO util.GSet: capacity = 2^21 = 2097152 entries
20/06/19 17:02:05 INFO blockmanagement.BlockManager: dfs.block.access.token.enable=false
20/06/19 17:02:05 INFO blockmanagement.BlockManager: defaultReplication = 1
20/06/19 17:02:05 INFO blockmanagement.BlockManager: maxReplication = 512
20/06/19 17:02:05 INFO blockmanagement.BlockManager: minReplication = 1
20/06/19 17:02:05 INFO blockmanagement.BlockManager: maxReplicationStreams = 2
20/06/19 17:02:05 INFO blockmanagement.BlockManager: replicationRecheckInterval = 3000
20/06/19 17:02:05 INFO blockmanagement.BlockManager: encryptDataTransfer = false
20/06/19 17:02:05 INFO blockmanagement.BlockManager: maxNumBlocksToLog = 1000
20/06/19 17:02:05 INFO namenode.FSNamesystem: fsOwner = user (auth:SIMPLE)
20/06/19 17:02:05 INFO namenode.FSNamesystem: supergroup = supergroup
20/06/19 17:02:05 INFO namenode.FSNamesystem: isPermissionEnabled = true
20/06/19 17:02:05 INFO namenode.FSNamesystem: HA Enabled: false
20/06/19 17:02:05 INFO namenode.FSNamesystem: Append Enabled: true
20/06/19 17:02:05 INFO util.GSet: Computing capacity for map INodeMap
20/06/19 17:02:05 INFO util.GSet: VM type = 64-bit
20/06/19 17:02:05 INFO util.GSet: 1.0% max memory 889 MB = 8.9 MB
20/06/19 17:02:05 INFO util.GSet: capacity = 2^20 = 1048576 entries
20/06/19 17:02:05 INFO namenode.FSDirectory: ACLs enabled? false
20/06/19 17:02:05 INFO namenode.FSDirectory: XAttrs enabled? true
20/06/19 17:02:05 INFO namenode.NameNode: Caching file names occurring more than 10 times
20/06/19 17:02:05 INFO util.GSet: Computing capacity for map cachedBlocks
20/06/19 17:02:05 INFO util.GSet: VM type = 64-bit
20/06/19 17:02:05 INFO util.GSet: 0.25% max memory 889 MB = 2.2 MB
20/06/19 17:02:05 INFO util.GSet: capacity = 2^18 = 262144 entries
20/06/19 17:02:05 INFO namenode.FSNamesystem: dfs.namenode.safemode.threshold-pct = 0.9990000128746033
20/06/19 17:02:05 INFO namenode.FSNamesystem: dfs.namenode.safemode.min.datanodes = 0
20/06/19 17:02:05 INFO namenode.FSNamesystem: dfs.namenode.safemode.extension = 30000
20/06/19 17:02:05 INFO metrics.TopMetrics: NNTop conf: dfs.namenode.top.window.num.buckets = 10
20/06/19 17:02:05 INFO metrics.TopMetrics: NNTop conf: dfs.namenode.top.num.users = 10
20/06/19 17:02:05 INFO metrics.TopMetrics: NNTop conf: dfs.namenode.top.windows.minutes = 1,5,25
20/06/19 17:02:05 INFO namenode.FSNamesystem: Retry cache on namenode is enabled
20/06/19 17:02:05 INFO namenode.FSNamesystem: Retry cache will use 0.03 of total heap and retry cache entry expiry time is 600000 millis
20/06/19 17:02:05 INFO util.GSet: Computing capacity for map NameNodeRetryCache
20/06/19 17:02:05 INFO util.GSet: VM type = 64-bit
20/06/19 17:02:05 INFO util.GSet: 0.029999999329447746% max memory 889 MB = 273.1 KB
20/06/19 17:02:05 INFO util.GSet: capacity = 2^15 = 32768 entries
20/06/19 17:02:05 INFO namenode.FSImage: Allocated new BlockPoolId: BP-1845993473-127.0.0.1-1592600525532
20/06/19 17:02:05 INFO common.Storage: Storage directory /Users/user/Data/appData/hadoop/dfs/name has been successfully formatted.
20/06/19 17:02:05 INFO namenode.FSImageFormatProtobuf: Saving image file /Users/user/Data/appData/hadoop/dfs/name/current/fsimage.ckpt_0000000000000000000 using no compression
20/06/19 17:02:05 INFO namenode.FSImageFormatProtobuf: Image file /Users/user/Data/appData/hadoop/dfs/name/current/fsimage.ckpt_0000000000000000000 of size 324 bytes saved in 0 seconds.
20/06/19 17:02:05 INFO namenode.NNStorageRetentionManager: Going to retain 1 images with txid >= 0
20/06/19 17:02:05 INFO util.ExitUtil: Exiting with status 0
20/06/19 17:02:05 INFO namenode.NameNode: SHUTDOWN_MSG:
/\***\*\*\*\*\*\*\***\*\*\*\*\***\*\*\*\*\*\*\***\*\*\*\*\***\*\*\*\*\*\*\***\*\*\*\*\***\*\*\*\*\*\*\***
SHUTDOWN_MSG: Shutting down NameNode at macbook-pro-user/127.0.0.1 \***\*\*\*\*\*\*\***\*\*\*\*\***\*\*\*\*\*\*\***\*\*\*\*\***\*\*\*\*\*\*\***\*\*\*\*\***\*\*\*\*\*\*\***/
```