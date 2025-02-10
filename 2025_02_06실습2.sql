create database exercise;
use exercise;

# employees 테이블 생성(employee_id, first_name, last_name, email,
# 					 phone_number, hire_date, job_id, salary,
#					 commission_pct, manage_id, department_id)
create table employees (
	employee_id decimal(6,0),
	first_name varchar(20),
	last_name varchar(25),
	email varchar(25),
	phone_number varchar(20),
	hire_date date,
	job_id varchar(10),
	salary decimal(8,2),
	commission_pct decimal(2,2),
	manage_id decimal(6,0),
	department_id decimal(4,0)
	);
desc employees;
select * from employees;
alter table employees change employee_id employee_id decimal(6,0) primary key; # 기본키 선언
# 외래키 선언 -> add foreign key(컬럼명) references 겹치는 테이블명(겹치는 컬럼명)
alter table employees add foreign key(department_id) references departments(department_id);
select employee_id, count(*) from employees group by employee_id;
select * from departments;
commit;

# departments 테이블 생성(department_id, department_name,
#					   manager_id, location_id)
create table departments(
	department_id decimal(4,0),
    department_name varchar(30),
    manager_id decimal(6,0),
    location_id decimal(4,0)
    );

desc departments;
select * from departments;
alter table departments change department_id department_id decimal(4,0) primary key;
commit;

# jobs 테이블 생성(job_id, job_title, min_salary, max_salary)
create table jobs(
	job_id varchar(10),
    job_title varchar(35),
    min_salary decimal(6,0),
    max_salary decimal(6,0)
    );

desc jobs;
select * from jobs;
commit;

# locations 테이블 생성(location_id, street_address, postal_code,
#					 city, state_province, country_id)
create table locations(
	location_id decimal(4,0),
    street_address varchar(40),
    postal_code varchar(12),
    city varchar(30),
    state_province varchar(25),
    country_id char(2)
    );

desc locations;
select * from locations;
commit;

# countries 테이블 생성(country_id, country_name, region_id)
create table countries(
	country_id char(2) primary key,
    country_name varchar(40),
    region_id int
    );

desc countries;
select * from countries;
commit;

# job_history 테이블 생성(employee_id, start_date, end_date, job_id, department_id)
create table job_history(
	employee_id decimal(6,0),
    start_date date,
    end_date date,
    job_id varchar(10),
    department_id decimal(4,0)
    );
    
desc job_history;
select * from job_history;
commit;

# regions 테이블 생성(region_id, region_name)
create table regions(
	region_id int,
    region_name varchar(25)
    );
    
desc regions;
select * from regions;
commit;

select count(*) from employees; # 107
select count(*) from departments; # 26
select count(*) from jobs; # 19
select count(*) from job_history; # 10
select count(*) from countries; # 25
commit;

# 급여가 5천과 만 사이에 있는 직원 수 및 사원 리스트
select employee_id, first_name, last_name, manage_id, salary, department_id from employees order by employee_id;
select count(*) from employees where salary between 5000 and 10000; 

select employee_id,first_name, last_name, salary from employees where salary between 5000 and 10000 order by salary asc;
 
# 부서코드가 50이고 월급이 5000이상인 사원 수 및 리스트
select count(*) from employees where department_id = 50 and salary >= 5000;
select employee_id, first_name, last_name, salary, department_id from employees where department_id = 50 and salary >= 5000 order by salary asc;

# manage_id 가 100인 사원들 리스트 출력 및 인원 수 출력
select employee_id, first_name, last_name, manage_id from employees where manage_id = 100;
select count(*) from employees where manage_id = 100;

# 직속 상관이 사장인 사람들의 부하직원
select * from employees
  where manage_id in(
  select employee_id 
  from employees 
  where manage_id = 100); 
  
# 직속 상관이 사장인 사람들의 부하직원의 명수  
select count(*) from employees
  where manage_id in(
  select employee_id
  from employees 
  where manage_id = 100); 

# 월급이 5000~10000 사이인 직원들의 매니저 명단
# 1. 월급이 5000 ~ 10000 사이인 직원들 출력
select * from employees where salary >= 5000 and salary <= 10000;
# 2. 이 직원들의 매니저 출력
select * from employees 
 where employee_id in(
 select manage_id 
 from employees 
 where salary >= 5000 and salary <= 10000);

# 같은 급여끼리 묶은 후 같은 급여가 몇명인지 나옴
select salary,count(*) from employees group by salary order by salary asc;

# 같은 부서가 몇명인지 출력
select department_id '부서코드',count(*) '몇 명'
  from employees 
  group by department_id 
  order by department_id asc;
select * from employees where department_id is null;
select * from employees;

# 같은 일을 하는 사람이 몇명인지 출력
select job_id '직업코드', count(*) '몇 명'
  from employees
  group by job_id
  order by count(*) asc;
 
# 같은 해애 입사한 사람이 몇명인지 출력(10명 이상인 경우만 출력), 닉네임을 영어로 설정하면 group by 같은 곳에 닉네임을 적어도 실행 가능
select substr(hire_date,1,4) '입사년도', count(*) '몇 명' 
  from employees
  group by substr(hire_date,1,4)
  having count(*) >= 10
  order by count(*) asc;

# 지역별 나라 개수
select region_id '지역코드' , count(*) '나라 개수' 
  from countries
  group by region_id
  order by region_id;
