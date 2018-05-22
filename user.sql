create database login;
use login;
create table user(
username varchar(100) NOT NULL, 
account varchar(100) NOT NULL, 
password varchar(100) NOT NULL, 
repeatPass varchar(100) NOT NULL, 
email varchar(100) NOT NULL, 
phone varchar(100) NOT NULL, 
card varchar(100) NOT NULL, 
birth varchar(100) NOT NULL, 
sex varchar(100) NOT NULL,
primary key (username)
)