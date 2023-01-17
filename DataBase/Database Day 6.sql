-- (실습) 모든 부서의 이름과 현재 관리자의 사번 조회하기 + 관리자 이름까지
select a.dept_name, b.emp_no, concat(c.first_name, ' ', c.last_name)
  from departments a
  left join dept_manager b
    on a.dept_no = b.dept_no
  left join employees c
    on b.emp_no = c.emp_no;
  

-- (실습) employees 테이블에서 1965년 2월 이후 출생자의 사번, 이름, 생일, 부서명을 조회하는 쿼리를
-- Natural 조인으로 작성하기
select count(*) from employees; -- 30023
select count(*) from dept_emp; -- 33188

select a.emp_no, concat(a.first_name, ' ', a.last_name), a.birth_date, c.dept_name       
  from employees a
  inner join dept_emp b
    on a.emp_no = b.emp_no -- 33188
  inner join departments c
    on b.dept_no = c.dept_no -- 33188
  where extract(year_month from a.birth_date) >= '196502';

-- 위 코드를 natural join으로 바꾸기
select a.emp_no, concat(a.first_name, ' ', a.last_name), a.birth_date, c.dept_name       
  from employees a
  natural inner join dept_emp b    
  natural inner join departments c    
  where extract(year_month from a.birth_date) >= '196502';  


-- (실습) departments 테이블에서 Sales 부서의 코드(dept_no) 값은 'd007'임
-- 이 부서에 속한 "관리자의 사번과 급여", 이 부서에 속한 "사원의 사번과 급여"를 구하는 쿼리 작성하기
-- (1) "관리자의 사번과 급여"
select * from dept_manager;
select * from salaries;

select *
  from dept_manager a
  inner join salaries b
    on a.emp_no = b.emp_no -- 383
    where a.dept_no = 'd007'; -- 34

-- 현재 부서의 매니저, 현재의 급여가 반영되도록 하려면 where 절 조건 추가    
select a.emp_no, b.salary
  from dept_manager a
  inner join salaries b
    on a.emp_no = b.emp_no -- 383
    where a.dept_no = 'd007' -- 34    
      and sysdate() between a.from_date and a.to_date -- 16 (현재부서의 매니저만)
      and sysdate() between b.from_date and b.to_date; -- 1 (현재의 급여만)

-- (2) "사원의 사번과 급여"
select count(*) from dept_emp; -- 33188
select count(*) from salaries; -- 285271
desc dept_emp;

select a.emp_no, b.salary
  from dept_emp a
  inner join salaries b
    on a.emp_no = b.emp_no
  where a.dept_no = 'd007' -- 50110
    and sysdate() between a.from_date and a.to_date -- 40092  (현재 근무하는 사원만)
    and sysdate() between b.from_date and b.to_date; -- 3810 (현재의 급여만)

-- (3) <= (1) + (2)
select '관리자' job_title, a.emp_no, b.salary
  from dept_manager a
  inner join salaries b
    on a.emp_no = b.emp_no -- 383
    where a.dept_no = 'd007' -- 34    
      and sysdate() between a.from_date and a.to_date -- 16 (현재부서의 매니저만)
      and sysdate() between b.from_date and b.to_date -- 1 (현재의 급여만)
union all      
select '사원' job_title, a.emp_no, b.salary
  from dept_emp a
  inner join salaries b
    on a.emp_no = b.emp_no
  where a.dept_no = 'd007' -- 50110
    and sysdate() between a.from_date and a.to_date -- 40092  (현재 근무하는 사원만)
    and sysdate() between b.from_date and b.to_date; -- 3810 (현재의 급여만)      

/* 서브쿼리 */
-- 1. 스칼라 서브쿼리
select 컬럼, (서브쿼리)
  from 테이블
 where 조건식;
 
-- 2. 파생 테이블
select 컬럼
  from 테이블, (서브쿼리)
 where 조건식;
 
-- 3. 조건 서브쿼리
select 컬럼
  from 테이블
 where 값 > (서브쿼리);
 
-- 연도별 1위 영화들의 평균 매출액보다 큰 영화만 조회 
select year(release_date), count(*), movie_name, sale_amt, avg(sale_amt)
  from box_office
 where ranks = 1
 group by year(release_date), movie_name;
 -- > avg(sale_amt) 컬럼값으로 조회된 평균 매출액은 16개 영화의 평균이 아님, 1위인 영화 한건의 평균

-- 1 단계 : 16개 영화의 평균을 구한다.
select avg(sale_amt) -- 81906468809.5
  from box_office
 where ranks = 1;

-- 2 단계 : 1단계에서 구한 평균보다 큰 영화를 조회
select year(release_date), movie_name, sale_amt
  from box_office
 where ranks = 1
   and sale_amt > 81906468809.5;
   

-- 앞에서 1위들의 영화 평균보다 큰 영화를 조회하는 쿼리를 한단계로 만들기
-- 1. 스칼라 서브쿼리 이용
select year(release_date), movie_name, sale_amt,
  ( select avg(sale_amt) -- 81906468809.5
      from box_office
	 where ranks = 1
  ) as average -- 81906468809.5
  from box_office
 where ranks = 1
 having sale_amt > average;

-- 2. 파생 테이블 서브쿼리
select year(release_date), movie_name, sale_amt
  from box_office a, 
  ( select avg(sale_amt) average -- 81906468809.5
      from box_office
     where ranks = 1 
  ) b
 where ranks = 1
   and sale_amt > b.average; -- b.average : 81906468809.5

-- 3. 조건 서브쿼리
select year(release_date), movie_name, sale_amt
  from box_office
 where ranks = 1
   and sale_amt > ( select avg(sale_amt) -- 81906468809.5
					  from box_office
                     where ranks = 1
				  );
                  
-- 서로 다른 테이블 이용
use world;
-- (1) 스칼라 서브쿼리 응용
-- city 테이블과 country 테이블을 내부 조인해서 country 에 있는 정보를 추가로 가져왔었음
select a.*, b.name
  from city a
  inner join country b
    on a.countrycode = b.code;
  
-- > 위의 코드를 스칼라 서브쿼리
select a.*, 
  ( select b.name
      from country b
	 where a.countrycode = b.code    
  ) countryname
  from city a;

-- 스칼라 서브쿼리 안에 두개의 두개의 컬럼을 넣어서 오류가 발생한 예  
select a.*, 
  ( select b.name, b.continent
      from country b
	 where a.countrycode = b.code    
  ) countryname
  from city a;  

-- 위에서 오류가 난 두 컬럼을 concat 함수를 써서 한 컬럼을 만들면 에러가 나지 않음                  
select a.*, 
  ( select concat(b.name, '/', b.continent)
      from country b
	 where a.countrycode = b.code    
  ) countryname
  from city a;  
  
-- (2) 파생 테이블 응용
use mywork;
-- 1단계 : 현재 관리자의 부서번호, 사번, 사원이름 조회하는 쿼리
select b.dept_no, b.emp_no, concat(c.first_name, ' ', c.last_name)
  from dept_manager b 
  inner join employees c
    on b.emp_no = c.emp_no
 where sysdate() between b.from_date and b.to_date;
-- 2단계 : 부서명까지 추가하면
select b.dept_no, b.emp_no, concat(c.first_name, ' ', c.last_name)
  from dept_manager b 
  inner join employees c
	on b.emp_no = c.emp_no
  inner join departments a
    on a.dept_no = b.dept_no
 where sysdate() between b.from_date and b.to_date; -- 9건 조회
-- 위의 코드를 파생테이블로 작성
select a.dept_no, a.dept_name, manager.emp_no, manager.full_name
  from departments a
  inner join ( select b.dept_no, b.emp_no, concat(c.first_name, ' ', c.last_name) full_name
                 from dept_manager b 
                 inner join employees c
	               on b.emp_no = c.emp_no         
              ) manager
  on a.dept_no = manager.dept_no;
  
-- (실습) box_office 테이블에서 2015년 이후 연도별 순위가 1~3위인 영화와
-- 해당 영화의 매출액이 "연도별 전체 매출액"에서 차지하는 비율을 구하는 쿼리
-- 1단계 : "연도별 전체 매출액"을 구하는 부분
-- 2단계 : 연도별 1~3위 영화의 정보와 매출액을 구한뒤
--        각 영화의 매출액을 전체 매출액으로 나누는 부분
    
select year(release_date), ranks, movie_name, sale_amt, count(*), sum(sale_amt)
  from box_office
 where year(release_date) >= 2015 and ranks <=3
 group by 1, 2;
-- > 위의 쿼리만으로는 연도별 전체 매출액을 알 수는 없음

-- 1단계 : "연도별 전체 매출액"을 구하는 부분

select year(release_date), sum(sale_amt)
  from box_office
 where year(release_date) >= 2015
 group by 1
 order by 1;

/* 
1657667127054
1719186452482
1808938584214
1734872210331
1870784163188
316011700
*/

-- 2단계 : 연도별 1~3위 영화의 정보와 매출액을 구한뒤
--        각 영화의 매출액을 전체 매출액으로 나누는 부분
select year(a.release_date), a.ranks, a.movie_name, a.sale_amt, b.total_amt, 
	   round((a.sale_amt/b.total_amt)*100, 2) percentage
  from box_office a,
  ( select year(release_date) release_year, sum(sale_amt) total_amt
      from box_office
     where year(release_date) >= 2015
     group by 1
     order by 1
  ) b
 where year(a.release_date) = b.release_year
       and ranks <=3
 group by 1, 2 
 order by 1, 2;

-- 3. 조건 서브쿼리 응용
-- 2019년도 개봉한 영화의 매출액이 2018년도 최대 매출액보다 큰 영화
select movie_name, sale_amt
  from box_office
 where year(release_date) = 2019
   and sale_amt > ( select max(sale_amt) -- 102666146909
                      from box_office
                     where year(release_date) = 2018
                  );                  
 
select max(sale_amt) -- 102666146909
  from box_office
  where year(release_date) = 2018;

-- 2018년도 최대 매출을 올린 영화 조회  
select movie_name, sale_amt
  from box_office
 where year(release_date) = 2018
 order by sale_amt desc;

-- 2018년도 최대 매출을 올린 영화와 2019년도에 2018년도 최대 매출보다 큰 영화를 함께 표시 
-- option 1
select year(release_date), movie_name, sale_amt
  from box_office
 where year(release_date) = 2019
   and sale_amt > ( select max(sale_amt) -- 102666146909
                      from box_office
                     where year(release_date) = 2018
                  )
union      
select year(release_date), movie_name, sale_amt
  from box_office
 where year(release_date) = 2018
 order by sale_amt desc
 limit 5;
 
-- option 2
 select year(release_date), movie_name, sale_amt
  from box_office
 where year(release_date) = 2019
   and sale_amt > ( select max(sale_amt) -- 102666146909
                      from box_office
                     where year(release_date) = 2018
                  )
union      
select year(release_date), movie_name, sale_amt
  from box_office
 where sale_amt = ( select max(sale_amt)
                      from box_office
					 where year(release_date) = 2018
                  );
-- 조건 서브쿼리에서 반환하는 값이 단일값이어야 하는데
-- 아래 예제는 다수의 값이 나와서 에러가 발생                  
select year(release_date), movie_name, sale_amt
  from box_office
 where year(release_date) = 2019
   and sale_amt >= ( select sale_amt -- 1~3위인 3개의 행인 반환되서 문제가 생김
                       from box_office
					  where year(release_date) = 2018
                        and ranks between 1 and 3
					);
                    
select sale_amt -- 1~3위인 3개의 행인 반환되서 문제가 생
  from box_office
 where year(release_date) = 2018
  and ranks between 1 and 3;
  
/*
102666146909
99926399769
80010440345
*/  
                        
-- All (서브쿼리의 결과로 나온 다수의 값 모두를 만족하는 결과를 조회) 
select year(release_date), movie_name, sale_amt  -- 4건 조회
  from box_office
 where year(release_date) = 2019
   and sale_amt >= All( select sale_amt -- 1~3위인 3개의 행인 반환되서 문제가 생김
                       from box_office
					  where year(release_date) = 2018
                        and ranks between 1 and 3
					);
                    
-- Any (서브쿼리의 결과로 나온 다수의 값 중에 하나라도 만족하는 결과를 조회) 
select year(release_date), movie_name, sale_amt -- 5건 조회
  from box_office
 where year(release_date) = 2019
   and sale_amt >= Any( select sale_amt -- 1~3위인 3개의 행인 반환되서 문제가 생김
                       from box_office
					  where year(release_date) = 2018
                        and ranks between 1 and 3
					);                  
-- IN
-- 2018년에 개봉한 영화 중 2019년까지 상영중인 영화의 이름과 감독 조회
select movie_name, director
  from box_office
 where year(release_date) = 2019
   and (movie_name, director) in (select movie_name, director
                        from box_office
                       where year(release_date) = 2018);
                       
-- NOT IN
-- 2019년도 1~100 순위안에 든 영화의 대표국가(rep_country)가 2018년도 1~100 순위권에 없었던 나라                       
select movie_name, ranks, release_date, rep_country
  from box_office
 where year(release_date) = 2019
   and ranks between 1 and 100
   and rep_country not in (select rep_country
                             from box_office
                            where year(release_date) = 2018
                              and ranks between 1 and 100);
   
-- Exists
-- 2018년에 개봉한 영화 중 2019년까지 상영중인 영화의 이름과 감독 조회 
select movie_name, director
  from box_office a
 where year(release_date) = 2019
   and exists (select *
                 from box_office b
				where year(release_date) = 2018
                  and a.movie_name = b.movie_name
                  and a.director = b.director);
                  
-- Not Exists
-- 2019년도 1~100 순위안에 든 영화의 대표국가(rep_country)가 2018년도 1~100 순위권에 없었던 나라                       
select movie_name, ranks, release_date, rep_country
  from box_office a
 where year(release_date) = 2019
   and ranks between 1 and 100
   and not exists (select *
				     from box_office b
                    where year(release_date) = 2018
                      and ranks between 1 and 100
                      and a.rep_country = b.rep_country);  
                      
-- (실습)
-- 현재를 기준으로 각 부서에서 급여를 가장 많이 받는 사원이 누구인지 찾는 쿼리
select a.dept_no, max(b.salary)
  from dept_emp a
  inner join salaries b
    on a.emp_no = b.emp_no
 where sysdate() between a.from_date and a.to_date
   and sysdate() between b.from_date and b.to_date
 group by a.dept_no;
-- > 위의 쿼리만으로는 부서별 최대 급여값은 알 수 있으나 해당 사원의 정보는 알 수 없음


select k.dept_no, c.emp_no, c.salary
  from salaries c,
       (select a.dept_no, max(b.salary) max_salary
          from dept_emp a
          inner join salaries b
            on a.emp_no = b.emp_no
         where sysdate() between a.from_date and a.to_date
           and sysdate() between b.from_date and b.to_date
         group by a.dept_no       
       )k
 where c.salary = k.max_salary
 order by 1;
  
 
-- (실습) 현재를 기준으로 어느 부서에도 속하지 않는 사원은 모두 몇 명인지 구하는 쿼리 작성하기   
select count(*)
  from employees a
 where a.emp_no not in (select b.emp_no
                         from dept_emp b
						where sysdate() between b.from_date and b.to_date);
   
-- (실습) box_office 테이블에서 2018년과 2019년에 개봉한 영화를 대상으로 연도별, 분기별 매출액을 구하되,
-- 아래와 같은 형식으로 조회되도록 쿼리 작성하기
-- (힌트 : case~end 구문 이용, sum(sale_amt)를 활용할 수 있는 서브쿼리 이용가능)
-- ----------------------------------------------
-- 연도  |    1분기  |   2분기  |   3분기  |  4분기 
-- ----------------------------------------------
-- 2018 |          |         |         |
-- ----------------------------------------------
-- 2019 |          |         |         |
-- ----------------------------------------------
-- (1)
select year(release_date), quarter(release_date), sum(sale_amt)
  from box_office
 where year(release_date) in (2018, 2019)
 group by 1, 2
 order by 1, 2;
 
-- (2) 
select a.years, 
      case a.qtr when 1 then a.qt_sum_amt else 0 end "1분기",
      case a.qtr when 2 then a.qt_sum_amt else 0 end "2분기",
      case a.qtr when 3 then a.qt_sum_amt else 0 end "3분기",
      case a.qtr when 4 then a.qt_sum_amt else 0 end "4분기"
      
  from (select year(release_date) years, quarter(release_date) qtr, sum(sale_amt) qt_sum_amt
         from box_office
        where year(release_date) in (2018, 2019)
       group by 1, 2
       order by 1, 2
       )a;
       
-- (3)
select a.years, 
      sum(case a.qtr when 1 then a.qt_sum_amt else 0 end) "1분기",
      sum(case a.qtr when 2 then a.qt_sum_amt else 0 end) "2분기",
      sum(case a.qtr when 3 then a.qt_sum_amt else 0 end) "3분기",
      sum(case a.qtr when 4 then a.qt_sum_amt else 0 end) "4분기"
      
  from (select year(release_date) years, quarter(release_date) qtr, sum(sale_amt) qt_sum_amt
         from box_office
        where year(release_date) in (2018, 2019)
       group by 1, 2
       order by 1, 2
       )a
  group by 1;       
 
/* 데이터 입력, 수정, 삭제, 트랜잭션 */
-- Insert 문으로 데이터 입력하기

-- 테이블 생성하기
create table emp_test(
  emp_no int not null,
  emp_name varchar(30) not null,
  hire_date date null,
  salary int null,
  primary key (emp_no)
);

-- 단일 로우 입력 insert 문
insert into emp_test(emp_no, emp_name, hire_date, salary)
       values (1001, '아인슈타인', '2021-01-01', 1000);
select * from emp_test;

insert into emp_test(emp_no, emp_name, hire_date)
       values (1002, '아이작뉴턴', '2021-02-01');
select * from emp_test;     

insert into emp_test(hire_date, emp_no, emp_name)
       values ('2021-02-10', 1003, '갈릴레오');
select * from emp_test;

-- (오류 예) not null 옵션이 있는 emp_name 컬럼은 필히 입력
insert into emp_test(emp_no, hire_date)
       values (1004, '2021-02-10');
-- (오류 예) pk에 중복값 입력
insert into emp_test(emp_no, emp_name, hire_date)
       values (1003, '리처드파인만', '2021-01-10');
       
-- 컬럼명을 생략
insert into emp_test
       values (1004, '리처드파인만', '2021-01-10', 3000);       
select * from emp_test;

-- 다중 로우 입력 insert 문
insert into emp_test values
row (1005, '퀴리부인', '2021-03-01', 4000),
row (1006, '스티븐호킹', '2021-03-05', 5000);

select * from emp_test;
insert into emp_test values
(1007, '마이클패러데이', '2021-04-01', 2200),
(1008, '맥스웰', '2021-04-05', 3300),
(1009, '막스클랑크', '2021-04-05', 4400);

select * from emp_test;

-- select 문이 결합된 insert문
-- 테이블 생성
create table emp_test2(
  emp_no int not null,
  emp_name varchar(30) not null,
  hire_date date null,
  salary int null,
  primary key (emp_no)
);

select * from emp_test2;

insert into emp_test2
select *
  from emp_test
 where emp_no in (1003, 1004);
 
select * from emp_test2; -- 2행 추가

-- (오류 예) 중복된 키값 (1004) 입력
insert into emp_test2
select *
  from emp_test
 where emp_no >= 1004;
 
select * from emp_test;

insert into emp_test
select emp_no+10, emp_name, hire_date, 100
  from emp_test
 where emp_no >= 1008;
 
select * from emp_test; 

-- (실습) emp_test 테이블에 insert 문을 사용하여 아래와 같이 입력하세요.
-- --------------------------------------------------
-- 사번  |   이름   |      입사일     |   급여 
-- --------------------------------------------------
-- 2001 |  장영실  |   2020-01-01   |   1500
-- --------------------------------------------------
-- 2002 |  최무선  |   2020-01-31   |  
-- ---------------------------------------------------

insert into emp_test values
(2001, '장영실', '2021-01-01', 1500),
(2002, '최무선', '2021-01-31', null);

select * from emp_test;

insert into emp_test2
select *
  from emp_test
 where emp_no in (1001, 1002);
 
select * from emp_test2; 




