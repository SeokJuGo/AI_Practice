-- (2) 윈도우 함수 
-- 테이블 생성
create table emp_hierarchy (
  employee_id int,
  emp_name varchar(80),
  manager_id int,
  salary int,
  dept_name varchar(80)
);
   
 insert into emp_hierarchy values
(200,'Jennifer Whalen',101,4400,'Administration'),
(203,'Susan Mavris',101,6500,'Human Resources'),
(103,'Alexander Hunold',102,9000,'IT'),
(104,'Bruce Ernst',103,6000,'IT'),
(105,'David Austin',103,4800,'IT'),
(107,'Diana Lorentz',103,4200,'IT'),
(106,'Valli Pataballa',103,4800,'IT'),
(204,'Hermann Baer',101,10000,'Public Relations'),
(100,'Steven King',null,24000,'Executive'),
(101,'Neena Kochhar',100,17000,'Executive'),
(102,'Lex De Haan',100,17000,'Executive'),
(113,'Luis Popp',108,6900,'Finance'),
(112,'Jose Manuel Urman',108,7800,'Finance'),
(111,'Ismael Sciarra',108,7700,'Finance'),
(110,'John Chen',108,8200,'Finance'),
(108,'Nancy Greenberg',101,12008,'Finance'),
(109,'Daniel Faviet',108,9000,'Finance'),
(205,'Shelley Higgins',101,12008,'Accounting'),
(206,'William Gietz',205,8300,'Accounting');

select * from emp_hierarchy;

-- 부서별 salary 합계
-- sum() over ~~
select employee_id, emp_name, manager_id, salary, dept_name,
  sum(salary) over (partition by dept_name) sum_salary
  from emp_hierarchy;
  
-- 윈도우 내에서 정렬할 컬럼을 order by 뒤에 지정할 수 있음
-- 그러나 oder by 뒤에 기본값으로 프레임의 범위가 지정되어 있는데,
-- order by가 지정되어 있을 때와 order by가 지정되지 않았을때 차이가 있음
-- order by가 지정되어 있을 경우에는
-- 프레임 절의 기본값은 range between unbounded preceding and current row 이며
-- 그런 이유로 sum_salary가 위에 order by를 지정하지 않았을 때와 다른 값으로 표시가 됨

select employee_id, emp_name, manager_id, salary, dept_name,
  sum(salary) over (partition by dept_name order by salary) sum_salary
  from emp_hierarchy;  

-- 해당 파티션 안에서 sum 값이 동일하게 지정되게 하고자 한다면
-- rows between unbounded preceding and unbounded following 와 같이 기본값을 변경해주면됨  
select employee_id, emp_name, manager_id, salary, dept_name,
  sum(salary) over (partition by dept_name order by salary rows between unbounded preceding and unbounded following) sum_salary
  from emp_hierarchy;   
  
-- row_number() : 로우의 순번
select employee_id, emp_name, manager_id, salary, dept_name,
  row_number() over (partition by dept_name order by salary desc) sequence
  from emp_hierarchy;    

-- rank() : 순위
-- dense_rank() : 누적 순위
-- percent_rank() : 비율 순위 (rank()-1)/(row-1), 상위 몇% ~
select employee_id, emp_name, manager_id, salary, dept_name,
  rank() over (partition by dept_name order by salary desc) ranks 
  from emp_hierarchy;  

-- lag(컬럼명) : 현재 로우를 기준으로 바로 앞의 로우의 컬럼값을 가져오기, lag(컬럼명, 1, null) 와 같음
-- lead(컬럼명) : 현재 로우를 기준으로 바로 뒤의 로우의 컬럼값을 가져오기, lead(컬러명, 1, null) 와 같음
select employee_id, emp_name, manager_id, salary, dept_name,
  lag(salary) over (partition by dept_name order by salary desc) lag_ ,
  lead(salary) over (partition by dept_name order by salary desc) lead_ 
  from emp_hierarchy; 

-- lag(컬럼명, n, '값') : 현재 로우를 기준으로 n행 앞의 로우의 컬럼값을 가져오기
-- lead(컬럼명, n, '값') : 현재 로우를 기준으로 n행 뒤의 로우의 컬럼값을 가져오기
select employee_id, emp_name, manager_id, salary, dept_name,
  lag(salary, 2, 0) over (partition by dept_name order by salary desc) lag_ ,
  lead(salary, 2, 0) over (partition by dept_name order by salary desc) lead_ 
  from emp_hierarchy; 
  
-- (실습) box_office 테이블에서 해마다 1위였던 영화들에 대해 전년도 기준으로 다음년도 매출의 증감율 구하기  
-- (1) 먼저 box_office 테이블에서 해마다 1위였던 영화들의 연도와 매출 구하기
select year(release_date), ranks, movie_name, sale_amt
  from box_office
 where ranks = 1
 order by 1;

-- (2) 매출 증감율을 알기 위해서는 전년 매출이 필요, lag() 함수 이용
select year(release_date) release_year, ranks, movie_name, sale_amt curr_year_sale_amt,
  lag(sale_amt) over (order by year(release_date)) last_year_sale_amt
  from box_office
 where ranks = 1
 order by 1;

-- (3) 최종적으로 매출 증감율 구하기 
-- 매출 증감율 : (올해 매출 - 전년 매출)/전년 매출 * 100 
with sale_amt_summary as
(select year(release_date) release_year, ranks, movie_name, sale_amt curr_year_sale_amt,
  lag(sale_amt) over (order by year(release_date)) last_year_sale_amt
  from box_office
 where ranks = 1
 order by 1
 )
 select release_year, ranks, movie_name, curr_year_sale_amt, last_year_sale_amt, 
        round((curr_year_sale_amt - last_year_sale_amt)/last_year_sale_amt*100, 2) as rates
 from sale_amt_summary;
 -- > 2005년도 기준 전년 대비 1위 매출액이 157% 증가

 
-- (실습) box_office 테이블에서 2019년 개봉 영화의 월별 총 매출액과 전월 대비 증감율을 구하는 쿼리 작성하기
-- (1) 월별 매출 합
select year(release_date) 개봉연도, month(release_date) 월, sum(sale_amt) 월매출합
  from box_office
 where year(release_date) = 2019
 group by 2
 order by 2;

-- (2) (1)의 쿼리에 추가하여 전월 매출까지 표시
select year(release_date) 개봉연도, month(release_date) 월, sum(sale_amt) 월매출합,
       lag(sum(sale_amt)) over (order by month(release_date) ) 전월매출합       
  from box_office
 where year(release_date) = 2019
 group by 2
 order by 2;

-- (3) 최종적으로 매출 증감율 구하기
with month_sale_amt as
(
select year(release_date) 개봉연도, month(release_date) 월, sum(sale_amt) 월매출합,
       lag(sum(sale_amt)) over (order by month(release_date) ) 전월매출합       
  from box_office
 where year(release_date) = 2019
 group by 2
 order by 2
 )
 select 개봉연도, 월, 월매출합, 전월매출합,
   round((월매출합 - 전월매출합)/전월매출합 * 100, 2) as 매출증감율
   from month_sale_amt;
   
-- 프레임절로 집계 범위 조정하기
-- https://dev.mysql.com/doc/refman/8.0/en/window-functions-frames.html
-- with order by : RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
-- without order by : RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING

-- 부서별 salary 합계 : sum() over ~
-- without order by 
select employee_id, emp_name, manager_id, salary, dept_name,
  sum(salary) over (partition by dept_name) sum_salary
  from emp_hierarchy;
  
-- with order by
select employee_id, emp_name, manager_id, salary, dept_name,
  sum(salary) over (partition by dept_name order by salary) sum_salary
  from emp_hierarchy;  

-- rows와 range의 차이
-- rows : 현재 로우를 기준으로 로우 단위로 대상 프레임 지정
-- range : 현재 로우를 기준으로 값의 범위 단위로 대상 프레임 지정

select employee_id, emp_name, manager_id, salary, dept_name,
  sum(salary) over (partition by dept_name order by salary rows between unbounded preceding and current row) row_sum_salary,
  sum(salary) over (partition by dept_name order by salary range between unbounded preceding and current row) range_sum_salary
  from emp_hierarchy; 
  
select employee_id, emp_name, manager_id, salary, dept_name,
  sum(salary) over (partition by dept_name order by salary rows between 1 preceding and 1 following) row_sum_salary,
  sum(salary) over (partition by dept_name order by salary range between 1000 preceding and 1000 following) range_sum_salary
  from emp_hierarchy;   





   
