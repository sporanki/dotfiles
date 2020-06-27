# Hadoop

## Directories

```console
/usr/local/Cellar/hadoop/3.2.1_1/libexec/etc/hadoop
/usr/local/Cellar/hadoop/3.2.1_1/libexec/
/usr/local/Cellar/hadoop/3.2.1_1/libexec/logs
```

## Format namenode (relies on on hdfs-site.xml for configuration)

```bash
hdfs namenode -format
```

## **_Before proceeding the SSH server must be installed see the appendix for more details_**

## Start hadoop

```bash
start-all.sh
```

## Stop hadoop

```bash
stop-all.sh
```

### Validate

Namenode UI: http://localhost:9870/
Resource Manager UI: http://localhost:8088/

```console
hadoop hadoop3* ❯ jps -ml
37029 org.apache.hadoop.hdfs.server.namenode.SecondaryNameNode
36794 org.apache.hadoop.hdfs.server.namenode.NameNode
37758 sun.tools.jps.Jps -ml
36895 org.apache.hadoop.hdfs.server.datanode.DataNode
```

```console
hdfs dfs -ls /
homebrew-core big-data\* ❯ hdfs dfs -ls /

20/06/19 20:14:50 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable

hdfs dfsadmin -report
homebrew-core big-data\* ❯ hdfs dfsadmin -report

2020-06-27 08:16:40,539 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
Configured Capacity: 499963174912 (465.63 GB)
Present Capacity: 257726066688 (240.03 GB)
DFS Remaining: 257726062592 (240.03 GB)
DFS Used: 4096 (4 KB)
DFS Used%: 0.00%
Replicated Blocks:
        Under replicated blocks: 0
        Blocks with corrupt replicas: 0
        Missing blocks: 0
        Missing blocks (with replication factor 1): 0
        Low redundancy blocks with highest priority to recover: 0
        Pending deletion blocks: 0
Erasure Coded Block Groups:
        Low redundancy block groups: 0
        Block groups with corrupt internal blocks: 0
        Missing block groups: 0
        Low redundancy blocks with highest priority to recover: 0
        Pending deletion blocks: 0

-------------------------------------------------
Live datanodes (1):

Name: 127.0.0.1:9866 (localhost)
Hostname: localhost
Decommission Status : Normal
Configured Capacity: 499963174912 (465.63 GB)
DFS Used: 4096 (4 KB)
Non DFS Used: 227078496256 (211.48 GB)
DFS Remaining: 257726062592 (240.03 GB)
DFS Used%: 0.00%
DFS Remaining%: 51.55%
Configured Cache Capacity: 0 (0 B)
Cache Used: 0 (0 B)
Cache Remaining: 0 (0 B)
Cache Used%: 100.00%
Cache Remaining%: 0.00%
Xceivers: 1
Last contact: Sat Jun 27 08:16:40 EDT 2020
Last Block Report: Sat Jun 27 08:06:33 EDT 2020
Num of Blocks: 0
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

Now add your public key to authorization

```console
.ssh ❯ cat ~/.ssh/id_ed25519.pub > ~/.ssh/authorized_keys
.ssh ❯ chmod 0600 ~/.ssh/authorized_keys
```

Verify by should not request password

```console
ssh localhost
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

### Error with start-all.sh

sbin ❯ ./start-all.sh
WARNING: Attempting to start all Apache Hadoop daemons as user in 10 seconds.
WARNING: This is not a recommended production deployment configuration.
WARNING: Use CTRL-C to abort.
Starting namenodes on [localhost]
localhost: user@localhost: Permission denied (publickey,password,keyboard-interactive).
Starting datanodes
localhost: user@localhost: Permission denied (publickey,password,keyboard-interactive).
Starting secondary namenodes [macbook-pro-user]
macbook-pro-user: Warning: Permanently added 'macbook-pro-user' (ECDSA) to the list of known hosts.
macbook-pro-user: user@macbook-pro-user: Permission denied (publickey,password,keyboard-interactive).
2020-06-27 07:52:57,555 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
Starting resourcemanager
Starting nodemanagers
localhost: user@localhost: Permission denied (publickey,password,keyboard-interactive).

Fix:

```console
ssh localhost
```

If prompted for password:
Add public key to authorized

```console
.ssh ❯ cat ~/.ssh/id_ed25519.pub > ~/.ssh/authorized_keys
.ssh ❯ chmod 0600 ~/.ssh/authorized_keys
```
