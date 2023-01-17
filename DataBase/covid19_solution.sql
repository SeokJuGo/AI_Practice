/* 코로나 데이터 분석하기 */
use mywork;

-- 국가 정보 테이블
create table covid19_country 
(
  countrycode                 varchar(10) not null, 
  countryname                 varchar(80) not null, 
  continent                   varchar(50), 
  population                  double,
  population_density          double,
  median_age                  double,
  aged_65_older               double,
  aged_70_older               double,
  hospital_beds_per_thousand  int,
  primary key (countrycode)
);
-- 컬럼명 : 컬럼설명
-- countrycode : 국가코드(기본키)
-- countryname : 국가명
-- continent : 대륙명
-- population : 인구
-- population_density : 인구밀도
-- median_age : 중간 연령
-- aged_65_older : 65세 이상 인구 비율
-- aged_70_older : 70세 이상 인구 비율
-- hospital_beds_per_thousand : 1000명당 병실 침대 수


-- 코로나 데이터 테이블
create table covid19_data 
(
  countrycode                 varchar(10) not null, 
  issue_date                  date        not null,  
  cases                       int, 
  new_cases_per_million       double, 
  deaths                      int, 
  icu_patients                int, 
  hosp_patients               int, 
  tests                       int, 
  reproduction_rate           double, 
  new_vaccinations            int, 
  stringency_index            double,
  primary key (countrycode, issue_date)
);
-- 컬럼명 : 컬럼설명
-- countrycode : 국가코드(기본키)
-- issue_date : 발생일(기본키)
-- cases : 확진자 수
-- new_cases_per_million : 100만명당 확진자 수
-- deaths : 사망자 수
-- icu_patients : 중환자 수
-- hosp_patients : 병원 입원 환자 수
-- tests : 검사자 수
-- reproduction_rate : 감염 재생산 지수
-- new_vaccinations : 백신 접종자 수
-- stringency_index : 방역 지수(0에서 100까지의 값, 100이 가장 높음)

 
-- file -> open sql script -> 01.covid19_country_insert.sql 파일 열기 -> 전체 실행

-- file -> open sql script -> 02.covid19_data_insert.sql 파일 열기 -> 전체 실행


-- 각 테이블의 입력 건수 확인
select count(*) from covid19_data; -- 71957
select count(*) from covid19_country; -- 215
  

-- 1. 데이터 정제하기
-- (1) 불필요한 데이터 삭제하기 
-- covid19_country와 covid19_data 테이블에는 대륙용으로 집계된 중복 데이터가 들어가 있습니다.
-- 각 테이블에서 국가 코드가 OWID로 시작하는 데이터를 확인(select) 후 삭제(delete) 하세요.
select countrycode, countryname
  from covid19_country
 where countrycode like 'owid%'
 order by 1; -- 11
 
select count(*)
  from covid19_data
 where countrycode like 'owid%'
 order by 1; -- 3923

delete from covid19_country
 where countrycode like 'owid%'; -- 11
  
delete from covid19_data
 where countrycode like 'owid%'; -- 3923


-- (2) 숫자형 컬럼에 null 이 있는 값이 있습니다.
-- 이 건들을 0으로 변경하세요.
-- option 1
/*
select count(*)
from covid19_country
where population is null;

update covid19_country
  set population = 0
where population is null;  

select count(*)
from covid19_country
where population_density is null;

update covid19_country
  set population_density = 0
where population_density is null;  


select count(*)
from covid19_country
where median_age is null;

update covid19_country
  set median_age = 0
where median_age is null;  


select count(*)
from covid19_country
where aged_65_older is null;

update covid19_country
  set aged_65_older = 0
where aged_65_older is null;  


select count(*)
from covid19_country
where aged_70_older is null;

update covid19_country
  set aged_70_older = 0
where aged_70_older is null;  



select count(*)
from covid19_country
where hospital_beds_per_thousand is null;

update covid19_country
  set hospital_beds_per_thousand = 0
where hospital_beds_per_thousand is null;  
*/

-- option 2
update covid19_country
  set population = ifnull(population, 0),
  population_density = ifnull(population_density, 0),
  median_age = ifnull(median_age, 0),
  aged_65_older = ifnull(aged_65_older, 0),
  aged_70_older = ifnull(aged_70_older, 0),
  hospital_beds_per_thousand = ifnull(hospital_beds_per_thousand, 0);
  
update covid19_data
  set cases = ifnull(cases,0),
  new_cases_per_million = ifnull(new_cases_per_million,0),
  deaths = ifnull(deaths,0),
  icu_patients = ifnull(icu_patients,0),
  hosp_patients = ifnull(hosp_patients,0),
  tests = ifnull(tests,0),
  reproduction_rate = ifnull(reproduction_rate,0),
  new_vaccinations = ifnull(new_vaccinations,0),
  stringency_index = ifnull(stringency_index,0);
  
-- null check
-- covid19_country
with tmp1 as(
select population + population_density + median_age + aged_65_older + 
       aged_70_older + hospital_beds_per_thousand as plus_col
  from covid19_country
),
tmp2 as(
 select case when plus_col is null then "null" else "not null"
		end chk
	from tmp1
)
select chk, count(*)
  from tmp2
  group by chk; -- 204
  
-- covid19_data
with tmp1 as(
select cases + new_cases_per_million + deaths + icu_patients + 
       hosp_patients + tests + reproduction_rate + new_vaccinations + stringency_index as plus_col
  from covid19_data
),
tmp2 as(
 select case when plus_col is null then "null" else "not null"
		end chk
	from tmp1
)
select chk, count(*)
  from tmp2
  group by chk; -- 68034
  
-- 2. 데이터 분석 

-- (1) 2020년 사망자 수 상위 10개국 조회
-- option 1
select b.countryname, sum(a.deaths) death_num, sum(a.cases) case_num
  from covid19_data a
  inner join covid19_country b
    on a.countrycode = b.countrycode
 where year(a.issue_date) = 2020
 group by b.countryname
 order by 2 desc
 limit 10;
-- option 2
select b.countryname, sum(a.deaths) death_num, sum(a.cases) case_num,
  rank() over (order by sum(a.deaths) desc) death_rank
  from covid19_data a
  inner join covid19_country b
    on a.countrycode = b.countrycode
 where year(a.issue_date) = 2020
 group by b.countryname
 -- order by 2 desc
 limit 10;

-- (2) 2020년 인구 대비 확진자 수와 사망자 수 비율 조회
-- (2-1) 2020년 사망자 수 상위 10개국을 뽑아서 
select b.countryname, sum(a.deaths) death_num, sum(a.cases) case_num
  from covid19_data a
  inner join covid19_country b
    on a.countrycode = b.countrycode
 where year(a.issue_date) = 2020
 group by b.countryname
 order by 2 desc
 limit 10;

-- (2-2) 이 데이터의 인구대비 확진자 수 비율을 조회하세요.
select t.countryname, t.death_num, t.case_num, t.population,
   round(t.death_num/t.population * 100, 5) death_popul_rate,
   round(t.case_num/t.population * 100, 5) case_popul_rate
from (
select b.countryname, sum(a.deaths) death_num, sum(a.cases) case_num, b.population
  from covid19_data a
  inner join covid19_country b
    on a.countrycode = b.countrycode
 where year(a.issue_date) = 2020
 group by b.countryname
 order by 2 desc
 limit 10
)t
order by 5 desc;

-- (3) 우리나라의 월별 확진자 수와 사망자 수 조회
-- (3-1) 우리나라의 월별 확진자수와 사망자수의 합계를 구하세요.
select extract(year_month from issue_date) months, 
       sum(cases) case_num,
       sum(deaths) death_num
  from covid19_data
 where countrycode = 'kor'
 group by 1
 order by 1;

 
-- (3-2) (3-1)에서 구한 월별 확진자수와 사망자수의 총계를 구하세요.
select extract(year_month from issue_date) months, 
       sum(cases) case_num,
       sum(deaths) death_num
  from covid19_data
 where countrycode = 'kor'
 group by 1
union all
select "All", sum(cases), sum(deaths)
 from covid19_data
 where countrycode = 'kor';
 
-- (3-3) (3-1)에서 구한 결과를 참고해서 "확진자수"에 대해서만 년월별 합계를 컬럼 형태로 조회하세요.
-- 202002 202003 202004 202005 ...
-- 10	3139	6636	988	  729	1347	1486	5846	3707	2746	8017	27117	16739	11523
select extract(year_month from issue_date) months, 
       sum(cases) case_num,
       sum(deaths) death_num
  from covid19_data
 where countrycode = 'kor'
 group by 1
 order by 1;

with tmp as(
select extract(year_month from issue_date) months, sum(cases) case_num, sum(deaths) death_num
  from covid19_data
 where countrycode = 'kor'
 group by 1
) 
 select sum(case when months = 202001 then case_num else 0 end) "202001",
       sum(case when months = 202002 then case_num else 0 end) "202002",
       sum(case when months = 202003 then case_num else 0 end) "202003",
       sum(case when months = 202004 then case_num else 0 end) "202004",
       sum(case when months = 202005 then case_num else 0 end) "202005",
       sum(case when months = 202006 then case_num else 0 end) "202006",
       sum(case when months = 202007 then case_num else 0 end) "202007",
       sum(case when months = 202008 then case_num else 0 end) "202008",
       sum(case when months = 202009 then case_num else 0 end) "202009",
       sum(case when months = 202010 then case_num else 0 end) "202010",
       sum(case when months = 202011 then case_num else 0 end) "202011",
       sum(case when months = 202012 then case_num else 0 end) "202012",
       sum(case when months = 202101 then case_num else 0 end) "202101",
       sum(case when months = 202102 then case_num else 0 end) "202102"     
from tmp;

-- 사망자수까지 추가한다면..
with tmp as(
select extract(year_month from issue_date) months, sum(cases) case_num, sum(deaths) death_num
  from covid19_data
 where countrycode = 'kor'
 group by 1
) 
 select "확진" 종류, 
       sum(case when months = 202001 then case_num else 0 end) "202001",
       sum(case when months = 202002 then case_num else 0 end) "202002",
       sum(case when months = 202003 then case_num else 0 end) "202003",
       sum(case when months = 202004 then case_num else 0 end) "202004",
       sum(case when months = 202005 then case_num else 0 end) "202005",
       sum(case when months = 202006 then case_num else 0 end) "202006",
       sum(case when months = 202007 then case_num else 0 end) "202007",
       sum(case when months = 202008 then case_num else 0 end) "202008",
       sum(case when months = 202009 then case_num else 0 end) "202009",
       sum(case when months = 202010 then case_num else 0 end) "202010",
       sum(case when months = 202011 then case_num else 0 end) "202011",
       sum(case when months = 202012 then case_num else 0 end) "202012",
       sum(case when months = 202101 then case_num else 0 end) "202101",
       sum(case when months = 202102 then case_num else 0 end) "202102"     
from tmp
union all
 select "사망" 종류, 
       sum(case when months = 202001 then death_num else 0 end) "202001",
       sum(case when months = 202002 then death_num else 0 end) "202002",
       sum(case when months = 202003 then death_num else 0 end) "202003",
       sum(case when months = 202004 then death_num else 0 end) "202004",
       sum(case when months = 202005 then death_num else 0 end) "202005",
       sum(case when months = 202006 then death_num else 0 end) "202006",
       sum(case when months = 202007 then death_num else 0 end) "202007",
       sum(case when months = 202008 then death_num else 0 end) "202008",
       sum(case when months = 202009 then death_num else 0 end) "202009",
       sum(case when months = 202010 then death_num else 0 end) "202010",
       sum(case when months = 202011 then death_num else 0 end) "202011",
       sum(case when months = 202012 then death_num else 0 end) "202012",
       sum(case when months = 202101 then death_num else 0 end) "202101",
       sum(case when months = 202102 then death_num else 0 end) "202102"     
from tmp;
  
-- (4) 국가별, 월별 확진자 수와 사망자 수 조회
-- (4-1) 아래 그림과 같이 국가별로 확진자와 사망사주를 조회하되, 월을 컬럼에 위치시키세요.
-- countryname  종류   202001  202002 202003 .....
-- Afghanistan	1.확진	0	1	174	1952	13081	16299	5158	1494	1109	2157	4849	5252	3497	691
-- Afghanistan	2.사망	0	0	4	60	194	494	532	119	57	78	257	396	209	43
-- Albania	1.확진	0	0	243	530	364	1398	2741	4237	4136	7226	17307	20134	19811	29040
-- Albania	2.사망	0	0	15	16	2	29	95	127	103	122	301	371	199	416
-- Algeria	1.확진	0	1	715	3290	5388	4513	16487	14100	7036	6412	25257	16411	7729	5753
-- Algeria	2.사망	0	0	44	406	203	259	298	300	226	228	467	325	135	92
-- Andorra	1.확진	0	0	376	369	19	91	70	251	874	2706	1989	1304	1888	929
-- Andorra	2.사망	0	0	12	30	9	1	0	1	0	22	1	8	17	9

select b.countryname, extract(year_month from a.issue_date) months, sum(a.cases) case_num, sum(a.deaths) death_num
  from covid19_data a
  inner join covid19_country b
    on a.countrycode = b.countrycode
  group by 1, 2;

with tmp1 as(
select b.countryname, extract(year_month from a.issue_date) months, sum(a.cases) case_num, sum(a.deaths) death_num
  from covid19_data a
  inner join covid19_country b
    on a.countrycode = b.countrycode
  group by 1, 2
)
select countryname, "1.확진" 분류,
       sum(case when months = 202001 then case_num else 0 end) "202001",
       sum(case when months = 202002 then case_num else 0 end) "202002",
       sum(case when months = 202003 then case_num else 0 end) "202003",
       sum(case when months = 202004 then case_num else 0 end) "202004",
       sum(case when months = 202005 then case_num else 0 end) "202005",
       sum(case when months = 202006 then case_num else 0 end) "202006",
       sum(case when months = 202007 then case_num else 0 end) "202007",
       sum(case when months = 202008 then case_num else 0 end) "202008",
       sum(case when months = 202009 then case_num else 0 end) "202009",
       sum(case when months = 202010 then case_num else 0 end) "202010",
       sum(case when months = 202011 then case_num else 0 end) "202011",
       sum(case when months = 202012 then case_num else 0 end) "202012",
       sum(case when months = 202101 then case_num else 0 end) "202101",
       sum(case when months = 202102 then case_num else 0 end) "202102"    
  from tmp1
 group by 1
  union all
select countryname, "2. 사망" 분류,  
       sum(case when months = 202001 then death_num else 0 end) "202001",
       sum(case when months = 202002 then death_num else 0 end) "202002",
       sum(case when months = 202003 then death_num else 0 end) "202003",
       sum(case when months = 202004 then death_num else 0 end) "202004",
       sum(case when months = 202005 then death_num else 0 end) "202005",
       sum(case when months = 202006 then death_num else 0 end) "202006",
       sum(case when months = 202007 then death_num else 0 end) "202007",
       sum(case when months = 202008 then death_num else 0 end) "202008",
       sum(case when months = 202009 then death_num else 0 end) "202009",
       sum(case when months = 202010 then death_num else 0 end) "202010",
       sum(case when months = 202011 then death_num else 0 end) "202011",
       sum(case when months = 202012 then death_num else 0 end) "202012",
       sum(case when months = 202101 then death_num else 0 end) "202101",
       sum(case when months = 202102 then death_num else 0 end) "202102"  
  from tmp1
  group by 1
  order by 1;
 
   
-- (4-2) (4-1)에서 만든 쿼리를 뷰로 만들어 미국의 현황(확진자수와 사망자수)을 조회하세요.
-- (힌트 : 뷰 만들기)
create or replace view covid19_summary_v as
with tmp1 as(
select b.countryname, extract(year_month from a.issue_date) months, sum(a.cases) case_num, sum(a.deaths) death_num
  from covid19_data a
  inner join covid19_country b
    on a.countrycode = b.countrycode
  group by 1, 2
)
select countryname, "1.확진" 분류,
       sum(case when months = 202001 then case_num else 0 end) "202001",
       sum(case when months = 202002 then case_num else 0 end) "202002",
       sum(case when months = 202003 then case_num else 0 end) "202003",
       sum(case when months = 202004 then case_num else 0 end) "202004",
       sum(case when months = 202005 then case_num else 0 end) "202005",
       sum(case when months = 202006 then case_num else 0 end) "202006",
       sum(case when months = 202007 then case_num else 0 end) "202007",
       sum(case when months = 202008 then case_num else 0 end) "202008",
       sum(case when months = 202009 then case_num else 0 end) "202009",
       sum(case when months = 202010 then case_num else 0 end) "202010",
       sum(case when months = 202011 then case_num else 0 end) "202011",
       sum(case when months = 202012 then case_num else 0 end) "202012",
       sum(case when months = 202101 then case_num else 0 end) "202101",
       sum(case when months = 202102 then case_num else 0 end) "202102"    
  from tmp1
 group by 1
  union all
select countryname, "2. 사망" 분류,  
       sum(case when months = 202001 then death_num else 0 end) "202001",
       sum(case when months = 202002 then death_num else 0 end) "202002",
       sum(case when months = 202003 then death_num else 0 end) "202003",
       sum(case when months = 202004 then death_num else 0 end) "202004",
       sum(case when months = 202005 then death_num else 0 end) "202005",
       sum(case when months = 202006 then death_num else 0 end) "202006",
       sum(case when months = 202007 then death_num else 0 end) "202007",
       sum(case when months = 202008 then death_num else 0 end) "202008",
       sum(case when months = 202009 then death_num else 0 end) "202009",
       sum(case when months = 202010 then death_num else 0 end) "202010",
       sum(case when months = 202011 then death_num else 0 end) "202011",
       sum(case when months = 202012 then death_num else 0 end) "202012",
       sum(case when months = 202101 then death_num else 0 end) "202101",
       sum(case when months = 202102 then death_num else 0 end) "202102"  
  from tmp1
  group by 1
  order by 1;
       
select * from covid19_summary_v
  where countryname = 'united states';
  
-- (5) 우리나라의 월별 누적 확진자 수와 사망자 수 조회
-- (5-1) 우리나라의 월별 확진자수와 사망자수의 합을 조회하세요.
select extract(year_month from issue_date) months, sum(cases) case_num, sum(deaths) death_num
  from covid19_data
 where countrycode = 'kor'
 group by 1;
 

-- (5-2) 윈도우 함수를 사용하여 우리나라의 월별 누적 확진자수와 누적 사망자수를 조회하세요 
-- without cte
select extract(year_month from issue_date) months, sum(cases) case_num, sum(deaths) death_num,
  sum(sum(cases)) over (order by extract(year_month from issue_date)) cum_case_num,
  sum(sum(deaths)) over (order by extract(year_month from issue_date)) death_case_num
  from covid19_data
 where countrycode = 'kor'
 group by 1;
 
-- with cte 
with tmp as (
select extract(year_month from issue_date) months, sum(cases) case_num, sum(deaths) death_num
  from covid19_data
 where countrycode = 'kor'
 group by 1
)
select months, case_num, death_num,
  sum(case_num) over (order by months) cum_case_num,
  sum(death_num) over (order by months) death_case_num
  from tmp;
 
-- (6) 대륙별 사망자 수 상위 3개국 조회
-- 전 기간을 대상으로 대륙별로 사망자가 가장 많은 3개 국가와 해당 국가의 누적 사망자수를 조회하세요.
-- (힌트 : cte와 rank() 함수 활용하기)
-- (1) 대륙별/국가별 group by
select b.continent, b.countryname, sum(a.cases) case_num, sum(a.deaths) death_num
  from covid19_data a
  inner join covid19_country b
    on a.countrycode = b.countrycode
 group by 1, 2
 order by 1;
 -- (2) 대륙별 사망자합 내림 차순 정렬
select b.continent, b.countryname, sum(a.cases) case_num, sum(a.deaths) death_num,
  rank() over (partition by b.continent order by sum(a.deaths) desc) ranks
  from covid19_data a
  inner join covid19_country b
    on a.countrycode = b.countrycode
 group by 1, 2
 order by 1; 
 -- (3) (1)+(2)에 ranks <=3 조건 추가해서 최종버전
with tmp1 as(
select b.continent, b.countryname, sum(a.cases) case_num, sum(a.deaths) death_num
  from covid19_data a
  inner join covid19_country b
    on a.countrycode = b.countrycode
 group by 1, 2
),
tmp2 as(
select continent, countryname, case_num, death_num,
  rank() over (partition by continent order by death_num desc) ranks
  from tmp1
)
select * from tmp2
 where ranks <= 3;
 
 
 
