/*
   2025_02_25 실습 및 필기
   배운거: 데이터 삭제(delete), 비교연산자(in(), between ~ and, is null(where절에서는 is null로, set에서는 = null 사용))
		 산술연산자, 논리연산자, 문자열연산자(concat, like ~ %), 테이블 수정(update), 테이블 조회(select),
         오름차순(asc), 내림차순(desc), 집계함수(sum,avg,count), 문자열 함수(concat, length, substring(substr))
*/

select @@autocommit; # autocommit << 1이면 활성화 0이면 비활성화(autocommit이 활성화되어있으면 rollback해도 데이터가 복구되지 않음)
set autocommit = 0;
create database 02_05;
use 02_05;

# 메뉴라는 이름의 테이블 생성
create table menu(
	id int unsigned auto_increment primary key, # id라는 컬럼은 음수X, 자동증가되면 기본키로 설정
    menuname varchar(32), # menuname의 최대길이는 32
    price int unsigned default 0 # price라는 컬럼은 음수만 불가능, default-> 기본값 설정
	);

desc menu;

drop table menu;
delete from menu;
# alter table 테이블명 auto_increment = n << auto_increment의 초기값을 n으로 초기화
alter table menu auto_increment = 1;

# menu테이블에 값 추가(한번에 하나씩) 
insert into menu(menuname, price) values('Americanno', 2000); # 문자열 값 입력할때에는 작음 따옴표('')사용해야함
insert into menu(menuname, price) values('Latte', 3000);
insert into menu(menuname) values('Mocca');
insert into menu(menuname, price) values('Cappuccino', 3000); # id를 입력하지 않으면 자동으로 증가가됨(자동증가)
insert into menu set menuname = 'Espresso', price = 2000; # 가장 많이 사용
insert into menu set menuname = '딸기쉐이크';

delete from menu where menuname in('딸기쉐이크','Mocca');
delete from menu where price <= 2000;
delete from menu where menuname = '밀크쉐이크';
select * from menu where menuname not like '%o'; # like의 부정형은 not like
update menu set price = 3500 where menuname = '딸기쉐이크';
update menu set price = 4000 where price = 3000;
update menu set menuname = null where menuname = 'Mocca';
update menu set menuname = '아메리카노', price = 1800 where menuname = 'Americanno';
update menu set menuname = '아샷추', price = 3500 where menuname is null; # where절에서 null 쓰려면 is null로 써야함
update menu set menuname = null where menuname = 'Espresso';

# 칼럼명 옆에 제목을 써줌으로써 원하는 이름으로 바꿔줄 수 있음, 이때 제목명은 ''를 안해도 되지만 혹시 몰라서 그냥 하는게 편해보임
select concat('메뉴번호: ',id) '메뉴번호', concat('메뉴명: ',menuname) '메뉴명', 
			  concat('가격: ',price,'원') '가격(원)' from menu order by price asc, menuname desc; # asc -> 오름차순, desc -> 내림차순

# 가격을 오름차순으로 출력(기본값: asc(오름차순), desc(내림차순))
select * from menu order by price;

# 대표값 하나씩만 출력하는 법
select distinct price '가격(원)' from menu order by price;

# sum(),avg(),count() 사용
select sum(price), avg(price), count(*) from menu;

# length(), substring() 사용
select menuname, length(menuname) from menu; # length << 한글의 길이를 불러올때에는 한글자당 3byte로 읽음
select menuname, char_length(menuname) '메뉴명 길이' from menu; # 한글을 읽을 때는 char_length가 더 정확함

select * from menu;
commit;
rollback;

# Student라는 이름의 테이블 생성
create table Student(
	id int unsigned auto_increment primary key, # 번호 
    name varchar(20) not null, # 이름
    gender char(1), # 성별
    mobile varchar(20) not null default '000-0000-000', # 모바일번호
    birthday char(16) # 생년월일
    );
    
desc student; # student에 대해서 설명해라 라는 뜻(구조 확인), desc에서 null의 의미 -> null이 들어갈 수 있는가 없는가

# Student테이블에 데이터 입력
insert into Student values(1,'짱구','남','010-1234-5678','2000.01.01');
insert into Student(name,mobile) values('유리','010-7894-1593');
insert into Student set name = '훈이', gender = '남', mobile = '010-4838-1597';
insert into Student set name = '철수', gender = '남', mobile = '010-1579-8231', birthday = '2000.01.02';
insert into Student set name = '흰둥이', birthday = '2005.03.19';

select * from Student;
commit;

create table sales (
	id int unsigned auto_increment primary key, # 아이디
    menu varchar(32) not null, # 메뉴명
    qty int unsigned default 1, # 수량
    total int unsigned not null, # 금액
    mobile varchar(20) default '000-0000-0000', #모바일 번호
    created datetime, #생성시각
    updated datetime # 수정시각
    );

desc sales;

insert into sales set menu = '아메리카노', total = 2000, created = current_timestamp(), updated = current_timestamp();
insert into sales set menu = '카푸치노' , total = 3500, mobile = '010-1564-3586', created = current_timestamp(), updated = current_timestamp();
insert into sales set menu = '카페모카' , total = 3000, created = current_timestamp(), updated = current_timestamp();
insert into sales set menu = '아샷추', total = 3500, mobile = '010-4820-6150', created = current_timestamp(), updated = current_timestamp();
insert into sales set menu = '카페라떼', total = 4000, created = current_timestamp(), updated = current_timestamp();
insert into sales set menu = '에스프레소', total = 2500, created = current_timestamp(), updated = current_timestamp();

select * from sales;
commit;

create table person(
	firstname varchar(32),
    familyname varchar(32));
insert into person values('Tom','Clancy');
insert into person values('Donald','Trump');
insert into person values('Jimmy','Carter');

select firstname, length(firstname) '길이', familyname, length(familyname) '길이' from person;
select substring(firstname, 3,2), firstname from person where firstname = 'Jimmy'; # db에서는 인덱스가 1부터 시작
select substr(firstname, 2,3), firstname from person where firstname = 'Donald';# substr == substring 동일

select * from person;
select concat(firstname, ',' , familyname) from person; # concat -> 문자열 연결