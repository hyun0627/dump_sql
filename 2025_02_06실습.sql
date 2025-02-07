use 02_05;

desc menu;
select * from menu;
commit;
rollback;

# alter table 테이블명 auto_increment = n << auto_increment의 초기값을 n으로 초기화
alter table menu auto_increment = 1;

# alter ~ add를 사용 -> 기존 테이블에 새 칼럼들을 추가
alter table menu add created datetime default current_timestamp,
				 add updated datetime default current_timestamp;

# alter ~ change 사용 -> menuname의 타입 길이를 조정하고 null 허용에서 not null로 변경
alter table menu change menuname menuname varchar(24) not null;
 
# update 이용 -> menuname이 null값인 값을 찾아 작두콩차로 바꾸고 현재 시간으로 updated시간을 바꿈
update menu set menuname = '작두콩차' , updated = current_timestamp() where menuname is null;

# after 이용 -> 새로 만들 컬럼명의 위치를 설정해줌
alter table menu add comment varchar(64) after price;

# drop 이용

alter table sales change created created datetime default current_timestamp,
				  change updated updated datetime default current_timestamp;
                  
desc sales;