create database ex;
use ex;
create table worker(
id int unsigned auto_increment primary key,
name varchar(32) not null,
did int unsigned);
insert into worker set name='John', did = 10;
insert into worker set name='Jane', did = 20;
insert into worker set name='James', did = 40;
insert into worker set name='Jason', did = 60;
select * from worker;
update worker set did = 50 where name = 'Jason';
create table part(
id int unsigned primary key,
name varchar(32) not null);
insert into part set id=10, name='총무부';
insert into part set id=20, name='인사부';
insert into part set id=40, name='재정부';
insert into part set id=60, name='개발부';
insert into part set id=30, name='구매부';
select * from part;

select * from worker w left outer join part p on w.did = p.id;