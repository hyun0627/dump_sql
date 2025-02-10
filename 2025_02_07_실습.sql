use exercise;

# 실습1: 직속 상관이 사장인 사람들의 부하직원
select * from employees
  where manage_id in(
  select employee_id 
  from employees 
  where manage_id = 100); 
  
# 실습2: 월급이 5000~10000 사이인 직원들의 매니저 명단
# 1. 월급이 5000 ~ 10000 사이인 직원들 출력
select * from employees where salary >= 5000 and salary <= 10000;
# 2. 이 직원들의 매니저 출력
select * from employees 
 where employee_id in(
 select manage_id 
 from employees 
 where salary >= 5000 and salary <= 10000);
 
# join 예제1
select em.employee_id, em.first_name, em.last_name, de.department_name
  from employees em, departments de
  where em.department_id = de.department_id
  order by em.employee_id asc;

# join 실습1 -> 나라가 어떤 대륙에 해당하는지 (일반(Oracle) Join / 내부조인(inner join))
select c.country_id '나라 코드', c.country_name '나라 이름', r.region_name '대륙 이름'
  from regions r, countries c 
  where r.region_id = c.region_id
  order by c.country_id asc;

# join 조건과 필터링 조건을 같이 쓸 때 (ANSI Join)
select c.country_id '나라 코드', c.country_name '나라 이름', r.region_name '대륙 이름'
  from regions r join countries c on r.region_id = c.region_id 
  where c.region_name = 'Asia'
  order by c.country_id asc;
  
# join 실습2(여러개 조인) // 직위명/부서명을 찾는 조인, 출력(사번,이름,직위명,부서명)
select e.employee_id '사번', e.first_name '이름', j.job_title '직위명', d.department_name '부서명'
  from employees e, jobs j, departments d
  where e.job_id = j.job_id and e.department_id = d.department_id
  order by e.employee_id;

# join 실습3(여러개 조인 - ANSI조인 사용) - 실습2를 ANSI조인을 사용하여 출력
select e.employee_id '사번', e.first_name '이름', j.job_title '직위명', d.department_name '부서명'
  from employees e join jobs j join departments d 
  on e.job_id = j.job_id and e.department_id = d.department_id
  where d.department_name = 'Executive'
  order by e.employee_id;
  
# Self-Join(예제)
select a.employee_id, a.first_name, a.last_name, b.first_name, b.last_name 
  from employees a, employees b
 where a.manage_id = b.employee_id;

# Join(실습) - 부서코드, 부서명, 부서주소 출력
select d.department_id '부서코드', d.department_name '부서명',
	   concat(l.street_address, ',' , l.city, ',' , l.state_province) '부서주소'
  from departments d, locations l
 where d.location_id = l.location_id
 order by d.department_id; 
 
# Outer Join 예제
select * from departments b right outer join employees a
  on a.department_id = b.department_id;

create view v_employee as
	select a.employee_id, a.first_name, a.last_name, b.department_name
	  from (select employee_id, first_name, last_name, department_id from employees) a
			left outer join
		   (select department_id, department_name from departments) b
		on a.department_id = b.department_id;
select * from v_employee;

alter table departments add foreign key(location_id) references locations(location_id);