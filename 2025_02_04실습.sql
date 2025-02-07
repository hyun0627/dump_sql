/*
  2025_02_04 실습 및 필기
  배운것: show databases; // create database 데이터베이스명; // use 데이터베이스명 // create table 테이블명
  데이터 타입, UN, AI, PK // desc 테이블 명 // 여러가지 insert하는 방법 // commit 및 rollback
*/
show databases; # DB출력
create database kdt; # kdt라는 이름의 데이터베이스 생성
use kdt; # kdt라는 이름의 데이터베이스를 사용
show tables;
# 메뉴라는 이름의 테이블 생성
create table menu(
	id int unsigned auto_increment primary key, # id라는 컬럼은 음수X, 자동증가되면 기본키로 설정
    menuname varchar(32) not null, # menuname의 최대길이는 32
    price int unsigned default 0 # price라는 컬럼은 음수만 불가능, default-> 기본값 설정
    );	
desc menu;
select * from menu;

# menu테이블에 값 추가(한번에 하나씩) 
insert into menu values(1, 'Americanno', 2000); # 문자열 값 입력할때에는 작음 따옴표('')사용해야함
insert into menu values(2, 'Latte', 3000);
insert into menu(id, menuname) values(3, 'Mocca');
insert into menu(menuname, price) values('Cappuccino', 3000); # id를 입력하지 않으면 자동으로 증가가됨(자동증가)
insert into menu set menuname = 'Espresso', price = 2000; # 가장 많이 사용
insert into menu set menuname = '딸기쉐이크';

# menu테이블에 값 추가(한번에 여러개)
insert into menu(menuname, price) values 
	('Americanno', 2000),
	('Latte', 3000),
    ('Mocca' , 2500),
    ('Cappuccino', 3000),
    ('Espresso', 2000);
    
# Student라는 이름의 테이블 생성
create table Student(
	id int unsigned auto_increment primary key, # 번호 
    name varchar(20) not null, # 이름
    gender char(1), # 성별
    mobile varchar(20) not null default '000-0000-000', # 모바일번호
    birthday char(16) # 생년월일
    );
select * from Student;
desc student; # student에 대해서 설명해라 라는 뜻(구조 확인), desc에서 null의 의미 -> null이 들어갈 수 있는가 없는가

# Student테이블에 데이터 입력
insert into Student values(1,'짱구','남','010-1234-5678','2000.01.01');
insert into Student(name,mobile) values('유리','010-7894-1593');
insert into Student set name = '훈이', gender = '남', mobile = '010-4838-1597';
insert into Student set name = '철수', gender = '남', mobile = '010-1579-8231', birthday = '2000.01.02';
insert into Student set name = '흰둥이', birthday = '2005.03.19';

# 주문 테이블 생성
create table jumoon(
	id int unsigned auto_increment primary key, # 주문번호: 양의 정수, 자동증가, 기본키
    menu_name varchar(20) not null, # 메뉴명: 가변문자열(20칸), not null
    qty int unsigned not null, # 주문 수량: 양의 정수, not null
    total int unsigned, # 금액: 양의 정수 
    mobile varchar(20) # 모바일번호: 가변문자열(20칸)
    );
desc jumoon;
select * from jumoon;

create table Book(
	id int unsigned auto_increment primary key, # 번호: 양의정수, 기본키, 자동증가
    title varchar(128) not null, # 책제목: 가변문자열(128), not null
    writer varchar(64) not null, # 저자: 가변문자열(64), not null
    price int unsigned, # 가격: 양의 정수
    published date, # 출판연월일: 날짜 데이터타입
    company varchar(128) not null, # 출판사명: 가변문자열(128), not null
    isbn varchar(32) not null, # ISBN번호: 가변문자열(32), NOT NULL
    serialnumber int unsigned # 판번호: 양의 정수
    );
desc Book;
select * from Book;

drop table menu;
drop table Student;
drop table jumoon;
drop table book;

commit;
rollback;