create database evaluation;
use evaluation;

# Number1:Student 테이블 생성
create table Student(
  ID int unsigned auto_increment primary key, # 학생일련번호
  stname varchar(32) not null, # 이름
  gender varchar(2), # 성별, 가능한 값: 남/여
  birth char(8), # 생년월일
  mobile varchar(20), # 모바일 번호
  hpcode char(5), # 우편번호
  haddress varchar(128), # 자택주소
  scode int unsigned, # 학교코드 -> 학교테이블의 아이디(외래키 설정)
  syear char(4)
  );
alter table Student add foreign key(scode) references School(ID);
desc Student;

# Number3:Student 테이블에 값 입력
insert into Student set stname = '짱구', gender = '남', birth = '19960503', mobile = '010-3157-7825',
						hpcode = '02536', haddress = '짱구네집', scode = 1, syear = 2006;
insert into Student(stname, gender, birth, mobile, hpcode, haddress, scode, syear) 
			values('유리', '여', '19960116', '010-1593-1563', '01653', '유리네집', 1, 2006),
				  ('맹구', '남', '19960813', '010-4820-4983', '06813', '맹구네집', 2, 2006),
                  ('철수', '남', '19961005', '010-1352-1770', '25963', '철수네집', 3, 2006),
                  ('훈이', '남', '19961202', '010-8550-4992', '07513', '훈이네집', 4, 2006);

select ID '학생일련번호', stname '이름', gender '성별', birth '생년월일', mobile '모바일번호', 
	   hpcode '자택우편번호', haddress '자택주소', scode '학교코드' , syear '입학연도' from Student;

# Number2:School테이블 생성
create table School(
  ID int unsigned auto_increment primary key, # 학교일련번호
  sname varchar(32) not null, # 학교명
  spcode char(5), # 우편번호
  saddress varchar(128), # 학교 주소
  eyear char(4), # 설립연도
  repnumber varchar(20) # 대표전화번호
);
desc School;

# Number4:학교 데이터 insert
insert into School(sname, spcode, saddress, eyear, repnumber) 
			values('떡잎초등학교', '08115', '떡잎초', '1970', '02-135-4330'),
				  ('방범초등학교', '07451', '방범초', '1965', '02-772-1593'),
                  ('미선초등학교', '09945', '떡잎초앞', '1950', '02-775-1563');
insert into School set sname = '흰둥이초등학교', eyear = '1955', spcode = '01135';
insert into School set sname = '도쿄초등학교', saddress = '도쿄', eyear = 1947, spcode = '05133';
				  
select ID '학교코드', sname '학교이름', spcode '학교우편번호', saddress '학교주소', 
	   eyear '설립연도', repnumber '대표전화번호' from School;
       
# Number5: 학생데이터 중 한 학생의 이름 수정 및 학교 데이터 중 학교의 주소를 수정하는 DML
update Student set stname = '수지' where stname = '유리'; # 유리라는 이름을 수지로 변경
update School set saddress = '흰둥이집앞' where saddress is null; # 학교 주소가 null값인 학교의 주소를 변경

# Number6: 학생 데이터 중 한 학생 삭제, 학교데이터 중 한 학교를 삭제
delete from Student where stname = '훈이'; # 훈이라는 이름을 가진 학생의 데이터 삭제 
delete from School where eyear < 1950; # 설립연도가 1950년 미만인 학교의 데이터 삭제

# Number7: 임의의 조건에 해당하는 학생 명단을 조회하는 DML작성
select ID '학생일련번호', stname '이름', gender '성별', birth '생년월일', mobile '모바일번호', 
	   hpcode '자택우편번호', haddress '자택주소', scode '학교코드' , syear '입학연도' from Student
       where gender = '남'; # 성별인 남학생인 학생들만 출력
       
# Number8: 학교테이블에서 임의의 조건에 해당하는 학교 목록을 조회하는 DML문 작성
select ID '학교코드', sname '학교이름', spcode '학교우편번호', saddress '학교주소', 
	   eyear '설립연도', repnumber '대표전화번호' from School
       where eyear >= 1950 and eyear <= 1965; # 설립연도가 1950년부터 1965년 사이에 있는 학교들 목록 출력

# Number9: 학교 테이블과 학생 테이블을 조인, 모든 학생의 명단과 각 학생의 학교명을 출력
select st.stname '이름', st.gender '성별', st.scode '학교코드', sc.sname '학교이름' 
		from Student st left outer join School sc
		on st.scode = sc.ID; # 테이블 조인 후 이름, 성별, 학교코드, 학교이름만 출력

# Number10: 외래키 참조무결성 위반 상황 재현
delete from School where sname = '떡잎초등학교';