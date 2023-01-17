/* 테이블간 관계 맺기 */
-- (1) 내부 조인 

-- (실습) world 데이터베이스에서 country와 city 테이블을 내부 조인해 국가별 도시 수를 구하되
-- 국가 코드가 아닌 국가명이 표시되도록 조회하고,
-- 마지막에는 전체 도시수의 합을 구하는 쿼리 작성하기 (with rollup)
use world;
select count(*) from country; -- 239
select count(*) from city; -- 4079

-- 1:m(country:city)의 관계에서 내부조인을 하면 m개의 집합체로 맞춰짐
select count(*) -- 4079
  from country a
  inner join city b
    on a.code = b.countrycode; 

-- 국가별 도시수를 구함
select a.name, count(*)
  from country a
  inner join city b
    on a.code = b.countrycode
  group by a.name
  order by 1;

-- 전체 도시수 합 구하기 (with rollup)
select if(grouping(a.name), '전체합',a.name) 국가명, count(*) 도시수합
  from country a
  inner join city b
    on a.code = b.countrycode
  group by a.name with rollup
  order by 1;

-- (실습) world 데이터베이스에서 country, city, countrylanguage 테이블을 조인해서
-- countryode가 'kor'인 경우로 한정해
-- 국가코드, 국가명, 대륙명, 인구수, 국가언어, 도시명, 도시인구가 출력되게 쿼리 작성하기

select count(*) from country; -- 239
select count(*) from city; -- 4079
select count(*) from countrylanguage; -- 984

-- 전체 국가에 대해 3개의 테이블 내부조인했을 때의 건수
select count(*) 
  from country a
  inner join city b
    on a.code = b.countrycode -- 4079
  inner join countrylanguage c
    on b.countrycode = c.countrycode; -- 30670

select count(*) from country where code = 'kor'; -- 1
select count(*) from city where countrycode = 'kor'; -- 70
select count(*) from countrylanguage where countrycode = 'kor'; -- 2

-- 한 국가(kor)에 대해 3개의 테이블 내부조인했을 때의 건수  
select count(*) 
  from country a
  inner join city b
    on a.code = b.countrycode -- 70
  inner join countrylanguage c
    on b.countrycode = c.countrycode -- 140
 where a.code = 'kor';
 
-- 조회해야 하는 정보 표시하기
-- 국가코드, 국가명, 대륙명, 인구수, 국가언어, 도시명, 도시인구
select a.code 국가코드, a.name 국가명, a.continent 대륙명, a.population 국가인구수, 
       c.language 국가언어, b.name 도시명, b.population 도시인구수
  from country a
  inner join city b
    on a.code = b.countrycode -- 70
  inner join countrylanguage c
    on b.countrycode = c.countrycode -- 140
 where a.code = 'kor'; 

-- 3 테이블 join식을 한번에
select a.code 국가코드, a.name 국가명, a.continent 대륙명, a.population 국가인구수, 
       c.language 국가언어, b.name 도시명, b.population 도시인구수
  from country a
  inner join city b inner join countrylanguage c
    on a.code = b.countrycode and b.countrycode = c.countrycode
  where a.code = 'kor'; 

-- from where 절로 바꾸면  
select a.code 국가코드, a.name 국가명, a.continent 대륙명, a.population 국가인구수, 
       c.language 국가언어, b.name 도시명, b.population 도시인구수
  from country a, city b, countrylanguage c
 where a.code = b.countrycode and b.countrycode = c.countrycode
    and a.code = 'kor'; 
  

-- (2) 외부 조인 
-- 아래 쿼리문으로부터 country 테이블에 존재하는 대륙이 7개임을 알 수 있음
select continent from country
  group by continent;

-- 그러나 country 테이블과 city 테이블을 내부조인했을 때 조회된 대륙은 6개임  
select a.continent, count(*) 도시수
  from country a
  inner join city b
    on a.code = b.countrycode
  group by a.continent;

-- 누락된 대륙인 antarctica의 국가명을 조회해보니 총 5개나라가 표시되었음
select code, name, continent
  from country
 where continent = 'Antarctica';
 
-- antarctica에 속한 5개의 국가가 city 테이블에서는 조회가 안됨
select *
  from city
 where countrycode in ('ATA', 'ATF', 'BVT', 'HMD', 'SGS');
 
-- 외부조인으로 누락된 대륙까지 조회되도록 할 수 있음 
select a.continent, count(b.name) 도시수
  from country a
  left join city b
    on a.code = b.countrycode
  group by a.continent;
 
-- 위의 left join은 테이블 위치만 바꾼뒤 right join으로 대체할 수 있음 
select b.continent, count(a.name) 도시수
  from city a
  right join country b
    on a.countrycode = b.code
  group by b.continent;  

-- (실습) 아프리카(africa) 대륙에 속한 국가 중 사용 언어가 없는 국가가 있음
-- country 테이블과 countrylanguage 테이블을 조인해서
-- 이 국가의 이름이 무엇인지 찾는 쿼리 작성하기

-- (1) 외부조인을 통해 country에서 빠지는 나라가 없도록 함
select a.name, b.language
  from country a
  left join countrylanguage b
    on a.code = b.countrycode
  where a.continent = 'africa';
  
-- (2) 위에서 조인한 테이블에서 나라의 언어가 없는 값 조회하기
select a.name, b.language
  from country a
  left join countrylanguage b
    on a.code = b.countrycode
  where a.continent = 'africa'
    and b.language is null;
    
select a.name, count(b.language) 언어수
  from country a
  left join countrylanguage b
    on a.code = b.countrycode
  where a.continent = 'africa'    
  group by a.name
  having count(b.language) = 0;

-- (3) 기타 조인 
-- (3-1) 자연조인
select count(*)
  from country a
  inner join city b
    on a.code = b.countrycode;
    
-- 위의 내부 조인을 자연조인으로 바꿔보기 
-- 두 테이블의 조인 조건에 사용되는 컬럼명이 같지 않으므로 자연조인이 안됨!!!
select count(*)
  from country a
  natural inner join city b;  
    
select count(*)
  from city a
  inner join countrylanguage b
    on a.countrycode = b.countrycode;
    
-- 위의 내부 조인을 자연조인으로 바꿔보기 
-- 두 테이블의 조인 조건에 사용되는 컬럼명이 같으므로 자연조인에 성공!!
select count(*)
  from city a
  natural inner join countrylanguage b;
    

-- (3-2) 카티전곱(크로스 조인)
select count(*) from country; -- 239
select count(*) from city; -- 4079

-- 조인 조건을 기술하지 않으면 됨
select count(*) -- 239 x 4079 = 974,881
  from country a
  inner join city b;

-- cross join 이란 문법을 사용  
select count(*) -- 239 x 4079 = 974,881
  from country a
  cross join city b;  

-- (4) Union (물리적으로 연결)
use mywork;
create table tbl1(
  col1 int,
  col2 varchar(20)
);

create table tbl2(
  col1 int,
  col2 varchar(20)
);

select * from tbl1;
insert into tbl1 values (1, '가');
insert into tbl1 values (2, '나');
insert into tbl1 values (3, '다');
select * from tbl1;

insert into tbl2 values (1, 'A');
insert into tbl2 values (2, 'B');
select * from tbl2;

-- 두 테이블의 한 컬럼 기준으로 연결(union)
select col1
  from tbl1
union -- default 옵션이 distinct
select col1
  from tbl2;  
  
select col1
  from tbl1
union all -- all 옵션은 모두 다 가져옴
select col1
  from tbl2;   

-- 두 테이블의 두 컬럼 기준으로 연결(union)  
select col1, col2
  from tbl1
union -- distinct 기준 : 두 컬럼의 조합으로 판단
select col1, col2
  from tbl2;    
  
select *
  from tbl1
union -- distinct 기준 : 두 컬럼의 조합으로 판단
select *
  from tbl2;    
  
-- union된 집합체의 정렬  
select col1, col2
  from tbl1
union -- distinct 기준 : 두 컬럼의 조합으로 판단
select col1, col2
  from tbl2
 order by col1 desc; -- 이 때의 order by 정렬은 전체 결과물에 대한 정렬
  
-- 개별 테이블만 정렬하고 싶을 때
-- 아래와 같이 소괄호를 이용해서 개별테이블을 정렬하게 했으나
-- 결국 최종 결과물의 정렬방식으로 마무리
(select col1, col2
  from tbl1
  order by 1 desc
)  
union -- distinct 기준 : 두 컬럼의 조합으로 판단
select col1, col2
  from tbl2  
 order by 1 desc;

-- limit 옵션을 줘서 개별 테이블 정렬 가능 
(select col1, col2
  from tbl1
  order by 1 desc
  limit 3
)  
union -- distinct 기준 : 두 컬럼의 조합으로 판단
select col1, col2
  from tbl2;
  
-- (실습) tbl1과 tbl2에서 tbl1은 전체, tbl2는 col1 값이 1인 건만 조회하기
select * from tbl1
 union
select * from tbl2 where col1 = 1;

 /* 사원 기존 정보를 이용한 테이블 조인 실습 */
-- 아래는 테이블과 그에 대한 설명
-- employees : 사원정보
-- dept_emp : 사원의 부서 할당정보
-- departments : 부서정보
-- dept_manager : 부서의 관리자 정보
-- titles : 사원의 직급 정보
-- salaries : 사원의 급여 정보

select count(*) from employees; -- 30023
select count(*) from departments; -- 10
select count(*) from dept_emp; -- 33188
select count(*) from dept_manager; -- 24
select count(*) from salaries; -- 285271
select count(*) from titles; -- 44423

-- (실습) 사원의 사번, 이름, 부서명 조회하기
desc employees;
desc dept_emp;
desc departments;

-- 1:m (employees:dept_emp)
-- 한 직원이 여러부서에 속한 이력이 있음 (33188 > 30023)
select a.emp_no, b.dept_no
  from employees a
  inner join dept_emp b
    on a.emp_no = b.emp_no; -- 33188
    
-- 위 결과에서는 부서명까지는 알 수 없으므로 departments를 추가로 조인
-- 1:m(departments:dept_emp(+emploees))
select count(*)
  from employees a
  inner join dept_emp b
    on a.emp_no = b.emp_no -- 33188
  inner join departments c
    on b.dept_no = c.dept_no; -- 33188
  
-- 마지막으로 조회할 정보를 명시
select a.emp_no 사번, concat(a.first_name, ' ', a.last_name) 이름, c.dept_name 부서명
  from employees a
  inner join dept_emp b
    on a.emp_no = b.emp_no -- 33188
  inner join departments c
    on b.dept_no = c.dept_no; -- 33188    

-- (실습) Marketing과 Finance 부서의 현재 관리자 (직원)정보 조회하기
select count(*) from departments; -- 10
select count(*) from dept_manager; -- 24

-- 1:m(departmenst:dept_manger)
select *
  from departments a
  inner join dept_manager b
    on a.dept_no = b.dept_no -- 24
 where sysdate() between b.from_date and b.to_date; -- 9

-- 1:m(employees:위에서 얻은 테이블)
select *
  from departments a
  inner join dept_manager b
    on a.dept_no = b.dept_no -- 24
  inner join employees c
    on b.emp_no = c.emp_no 
 where sysdate() between b.from_date and b.to_date; -- 9
 
-- 마지막으로 해당 부서로 필터링
select a.dept_name 부서명, concat(c.first_name, ' ', c.last_name) 이름
  from departments a
  inner join dept_manager b
    on a.dept_no = b.dept_no -- 24
  inner join employees c
    on b.emp_no = c.emp_no 
 where sysdate() between b.from_date and b.to_date -- 9
   and a.dept_name in('Marketing' , 'Finance');

-- (실습) 모든 부서의 이름과 현재 관리자의 사번 조회하기
-- 1:m(departments:dept_manager)
-- 현재 관리자로 필터링해서 건수를 조회해보면 총 9건
select count(*)
  from departments a
  inner join dept_manager b 
    on a.dept_no = b.dept_no -- 24
  where sysdate() between b.from_date and b.to_date; -- 9

-- 하지만 departments에서 부서 이름으로 유일한 이름을 구해보면 10건
select distinct dept_name -- 10
  from departments;
  
-- 따라서 외부조인을 통해서 누락된 부서정보까지 조회를 해야 함
-- 외부 조인 결과를 보면 IT 부서에는 할당된 매니저가 없음을 확인
select a.dept_name, b.emp_no
  from departments a
  left join dept_manager b
    on a.dept_no = b.dept_no
 where sysdate() between b.from_date and b.to_date
   or b.from_date is null; -- 10

-- (실습) 부서별 사원 수와 전체 부서의 총 사원 수 구하기   

-- 우선 dept_emp 테이블로부터 dept_no로 group by
select dept_no, count(*)
  from dept_emp
 where sysdate() between from_date and to_date -- 24135
 group by dept_no;

-- 부서명까지 조회하기 위해 departments 테이블과 조인
-- option 1 (with rolllup 사용)
select if(grouping(a.dept_name), "총사원수", a.dept_name) 부서명, count(*) 사원수
  from departments a
  inner join dept_emp b
    on a.dept_no = b.dept_no -- 33188
 where sysdate() between b.from_date and b.to_date -- 24135
 group by a.dept_name with rollup;

-- option 2 (union 사용)
-- (1) 부서별 사원수
select a.dept_name 부서명, count(*) 사원수
  from departments a
  inner join dept_emp b
    on a.dept_no = b.dept_no -- 33188
 where sysdate() between b.from_date and b.to_date
 group by a.dept_name;
 
-- (2) 총사원수
select "총사원수", count(*) -- 24135
  from dept_emp
 where sysdate() between from_date and to_date;

-- (3) (1) + (2)
select a.dept_name 부서명, count(*) 사원수
  from departments a
  inner join dept_emp b
    on a.dept_no = b.dept_no -- 33188
 where sysdate() between b.from_date and b.to_date
 group by a.dept_name
union
select "총사원수", count(*) -- 24135
  from dept_emp
 where sysdate() between from_date and to_date; 

-- (실습) 모든 부서의 이름과 현재 관리자의 사번 조회하기 + 관리자 이름까지


-- (실습) employees 테이블에서 1965년 2월 이후 출생자의 사번, 이름, 생일, 부서명을 조회하는 쿼리를
-- Natural 조인으로 작성하기


-- (실습) departments 테이블에서 Sales 부서의 코드(dept_no) 값은 'd007'임
-- 이 부서에 속한 "관리자의 사번과 급여", 이 부서에 속한 "사원의 사번과 급여"를 구하는 쿼리 작성하기
