create database hive_metastore;
use hive_metastore;
create user hive_user@localhost identified by 'hivepassword';
grant all privileges on hive_metastore.* to 'hive_user'@'localhost';
flush privileges;