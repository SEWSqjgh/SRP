use login;
select * from student_user;
create table if not exists student_user (
studentName varchar(25) NOT NULL, 
studentID varchar(12) NOT NULL, 
password varchar(50) NOT NULL, 
repeatPass varchar(50) NOT NULL, 
primary key (studentName)
)default charset=utf8 ;
