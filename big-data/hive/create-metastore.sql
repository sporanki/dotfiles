create database hive;
use hive;
create user dbuser@localhost identified by 'dbpassword';
grant all privileges on hive.* to 'dbuser'@'localhost';
flush privileges;