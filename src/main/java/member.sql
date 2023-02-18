

drop table member;

select * from member;
select * from bbs;
create table member(
	id varchar(50) primary key,
	pwd varchar(50) not null,
	name varchar(50) not null,
	email varchar(50) unique, 
	auth int 

);

select id
from member
where id = 'fweewf';

select count(*)
from member
where id = 'adbc';