/* SQL 함수 사용하기 */
-- 수식 연산자
select 7+2;
select 7-2;
select 7/2, 7%2, 7 div 2;

-- 숫자형 함수
select ceil(6.5);
select floor(6.5);
select mod(7,2), 7%2;  -- 나머지 연산
select power(4,3);
select sqrt(25);
select round(1153.456, 1), round(1153.456, 2);
select round(1153.456, -1), round(1153.456, -2);
select rand(3); -- 0~1사이의 무작위수 

-- 문자형 함수
select char_length('sql');
select char_length('홍길동');

select length('sql');
select length('홍길동');

select concat('this', 'is', 'mysql');
select concat('this', null, 'mysql');
select concat_ws('**', 'this', 'is', 'mysql');

select format(55500000, 2);

select lower('AbCd'), upper('AbCd');

select lpad('sql', 7, '#');
select rpad('sql', 7, '#');

select left('thisismysql', 4);
select right('thisismysql', 4);

select reverse('sql');

select replace('생일 축하해 철수야', '철수', '영희');

select instr('abc', 'c');
select locate('c', 'abcabcabc', 7);
select position('c' in 'abc');

select substr('this is mysql', 6, 2); -- substring, mid와 동일
select substr('this is mysql', -8, 2);
select substr('this is mysql', 6);

select mid('this is mysql', 6, 2) as mid함수의결과;

select trim('    mysql    ');
select trim(both '*' from '****mysql****');
select trim(leading '*' from '****mysql****');
select trim(trailing '*' from '****mysql****');

select strcmp('mysql', 'mysql');
select strcmp('mysql1', 'mysql2');
select strcmp('mysql2', 'mysql1');

-- (실습) 문자형 함수 사용
-- world 데이터베이스에 접속해서 coutry 테이블에서 인구가 4,500만명에서 5,500만명 사이에 있는 국가를 조회하되,
-- 국가명(name)과 대륙명(continent)을 연결해서 '국가명 (대륙명)' 형태로 조회하기
-- (예 : South Korea (Asia))
-- 표시될 컬럼명(4개) : code, name, continent, name (continent)
use world;
select code, name, continent, concat(name, ' (', continent, ')') as 'name (continent)'
  from country
 where population between 45000000 and 55000000;

-- (실습) 숫자형 함수 사용
-- mywork 데이터베이스에 접속해 box_office 테이블에서 2019년 개봉한 한국 영화 중 관객수가 500만 명 이상인 영화를 조회
-- 이 때 매출액은 1억으로 나눈 후 소수점 없이 반올림 한 결과를 표시하기
-- 표시될 컬럼명(4개) : years, ranks, movie_name, release_date, audience_num, sales_amt(1억단위)
use mywork;

select years, ranks, movie_name, release_date, audience_num, round(sale_amt/100000000, 0) as 'sales_amt(1억단위)'
  from box_office
 where release_date between '2019-01-01' and '2019-12-31'
   and audience_num >= 5000000 and rep_country= '한국';
   
desc box_office;   

-- (실습) 문자형 함수 사용
-- 현재 box_office 테이블에 영화감독(director)이 두명 이상이면 ','로 연결되어 있음
-- 감독이 1명이면 그대로 두고, 두명 이상이면 ',' 대신 '/' 값으로 대체해 조회
select movie_name, replace(director, ',', '/') as 'director(/로구분)'
  from box_office
 where instr(director, ',') > 0;

-- 날짜형 함수
select current_date();
select current_time();
select now();
select current_timestamp();
select dayname('2022-11-02');
select dayofmonth('2022-11-02');
select dayofweek('2022-11-02'); -- 일요일 기준으로 몇번째 날인지
select dayofyear('2022-11-02');
select last_day('2022-11-02');
select year('2022-11-02');
select month('2022-11-02');
select quarter('2022-11-02');
select weekofyear('2022-11-02');

select adddate('2022-11-02', 10);
select date_add('2022-11-02', interval 10 day);
-- interval expr unit
-- https://dev.mysql.com/doc/refman/8.0/en/expressions.html#temporal-intervals
select date_add('2022-11-02', interval '1-3' year_month);

select subdate('2022-11-02', 10);
select date_sub('2022-11-02', interval 10 day);
select date_sub('2022-11-02', interval '1 3' day_hour);

-- unit from date
-- https://dev.mysql.com/doc/refman/8.0/en/expressions.html#temporal-intervals
select extract(year_month from '2022-11-02');
select extract(day_hour from '2022-11-02 12:08:00');
select extract(minute_second from '2022-11-02 12:08:00');

select datediff('2022-11-02', '2021-11-02');
select datediff('2021-11-02', '2022-11-02');

-- date_format에서 사용하는 식별자
-- https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_date-format
select date_format('2022-11-02', "%d-%b-%Y");

select makedate(2022, 100);
select makedate(2022, 365);

select sysdate(), sleep(2), sysdate(); -- 함수 호출 시간 기준
select now(), sleep(2), now(); -- 문장 단위 시간 기준

-- week 함수에서 사용할 수 있는 mode
-- https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_week
select week('2022-11-02');
select yearweek('2022-11-02');

-- (실습) 날짜형 함수
-- 현재 날짜를 기준으로 현재 일이 속한 월의 마지막 날짜에 해당하는 요일 구하기
select dayname(last_day(current_date()));

-- (실습) 날짜형 함수
-- 연인과 처음으로 만난 날이 2021년 5월 12일인데, 100일, 500일, 1000일이 되는 날을 조회하기
select adddate('2021-05-12', 100) as 100일, adddate('2021-05-12', 500) as 500일, adddate('2021-05-12', 1000) as 1000일;

-- (실습) 날짜형, 문자형 함수
-- mywork 데이터베이스에 접속해 box_office 테이블에서 2019년에 개봉된 영화 중, 영화 제목에 ':'이 들어간 영화 조회
select movie_name, release_date
  from box_office
 where year(release_date) = '2019'
   and instr(movie_name, ':') > 0;
   
-- 기타 함수들
select cast(10 as char);
select convert(10, char);

select cast('2022-11-02' as datetime);
select convert('2022-11-02', datetime);

-- 흐름제어 함수
select if(2<1, 1, 0);
select if(2>1, 1, 0);

select ifnull(null, 'null입니다');
select ifnull(1, 'null입니다');

select nullif(1, 1);
select nullif(1, 2);

select case 1 when 1 then '1입니다.'
			  when 2 then '2입니다.'
			  when 3 then '3입니다.'
			  when 4 then '4입니다.'
			  else 'none'
	   end case1,
       case 2 when 1 then '1입니다.'
			  when 2 then '2입니다.'
			  when 3 then '3입니다.'
			  when 4 then '4입니다.'
			  else 'none'
	   end case2;
       
select case when 1=1 then '1입니다.'
			when 1=2 then '2입니다.'
			when 1=3 then '3입니다.'
			when 1=4 then '4입니다.'
			else 'none'
	   end case1,
       case when 2=1 then '1입니다.'
			when 2=2 then '2입니다.'
			when 2=3 then '3입니다.'
			when 2=4 then '4입니다.'
			else 'none'
	   end case2;       

-- (실습) 날짜형 함수
-- box_office 테이블에서 2019년 개봉한 영화 중 순위(ranks) 기준 상위 10위까지의 영화 조회하되,
-- 이 때 개봉일이 무슨 요일인지와 개봉일이 어떤 분기에 속해 있는지도 조회하기
-- 표시할 컬럼 : 영화 이름, 개봉일, 개봉요일, 분기
select movie_name as '영화 이름', release_date as '개봉일', dayname(release_date) as '개봉요일',
	   quarter(release_date) as '분기'
  from box_office
 where year(release_date) = 2019
   and ranks <= 10
 order by ranks;

-- (실습) 흐름제어 함수
-- 위의 결과를 활용하여 분기를 상반기, 하반기로 바꾸어 표현해보자.
-- (예: 1,2분기이면 상반기, 3,4분기이면 하반기)
-- option 1 : if() 함수 사용
select movie_name as '영화 이름', release_date as '개봉일', dayname(release_date) as '개봉요일',
	   quarter(release_date) as '분기',
       if(quarter(release_date) = 1 or quarter(release_date) =2, '상반기', '하반기') as '상/하반기'
  from box_office
 where year(release_date) = 2019
   and ranks <= 10
 order by ranks;
 
-- option 2 : case value when compared_value then result
select movie_name as '영화 이름', release_date as '개봉일', dayname(release_date) as '개봉요일',
	   quarter(release_date) as '분기',
       case quarter(release_date) when 1 then '상반기'
				                  when 2 then '상반기'
                                  when 3 then '하반기'
                                  when 4 then '하반기'
                                  else 'none'
	   end '상/하반기'
  from box_office
 where year(release_date) = 2019
   and ranks <= 10
 order by ranks;
 
 -- option 3 : case when value = compared_value then result
select movie_name as '영화 이름', release_date as '개봉일', dayname(release_date) as '개봉요일',
	   quarter(release_date) as '분기',
       case when quarter(release_date) in (1, 2) then '상반기'
            when quarter(release_date) in (3, 4) then '상반기'
			else 'none'
	   end '상/하반기'
  from box_office
 where year(release_date) = 2019
   and ranks <= 10
 order by ranks;
 
-- (실습) 흐름제어 함수
-- world 데이터베이스에 있는 country 테이블에는 indepyear라는 컬럼에는 해당국가의 독립연도가 저장되어 있음
-- 이 때 각 국가명과 독립연도를 조회(출력)해 독립연도의 값이 없으면 '없음', 있으면 해당 독립연도가 출력
use world;
desc country;
select name, ifnull(indepyear, '없음') as indepyear
  from country;
 -- where name= 'south korea';
  
  
-- (실습) 
-- mywork 데이터베이스의 box_office 테이블에서 2019년 개봉한 영화 중 
-- 순위(ranks)가 1~10위인 경우 "상위10" 그 외(11위 이상)는 "나머지" 라고 표시하기
use mywork;

select movie_name, ranks, if(ranks<=10, '상위10', '나머지') as rank10
  from box_office
 where year(release_date) = 2019;

select movie_name, ranks, 
  case when ranks <= 10 then '상위10'
	   else '나머지'
  end rank10
  from box_office
 where year(release_date) = 2019;
 
/* 데이터 집계하기 */ 
-- > (1) 그룹화하기 (2) 집계함수 사용 (3) 집계쿼리((1)+(2))

-- (1) 그룹화하기
use world;
select continent
  from country
 group by continent
 order by continent;
  
select continent
  from country
 group by 1
 order by 1;
  
select continent, region
  from country
 group by continent, region
 order by continent, region;
  
select name, district, substr(district, 1, 3) as dist
  from city
 where countrycode = 'kor'
 group by substr(district, 1, 3);
 
select name, district, substr(district, 1, 3) as dist
  from city
 where countrycode = 'kor'
 group by 3;

select name, district, substr(district, 1, 3) as dist
  from city
 where countrycode = 'kor'
 group by dist;
 
-- Note. group by 한 대상(컬럼, 표현식, 순번)이 select 에 나와야 의미가 있음 
-- (아래와 같이하면 안됨!)
select continent
  from country
 group by region;
 
 
select continent
  from country
 group by continent;
 
select distinct continent
  from country; 
  
-- (2) 집계 함수
select *
  from country;
  
select count(*)  
  from country;
  
select count(name), count(continent), count(distinct continent)
  from country;
  
select min(population), max(population), avg(population)
  from country
 where continent='europe';
 
-- (1단계) 유럽인구의 최솟값을 구한다
select min(population)
  from country
 where continent='europe';
 
-- (2단계) 인구가 1000명인 나라를 조회한다
select name, population
  from country
 where continent='europe' and population=1000;
 
-- (sub query 방식 : 1, 2 단계를 한번에)
select b.name, b.population
 from (
select min(population) as min_population -- 1000
  from country
 where continent='europe' 
 )a, country b
 where b.population = a.min_population;
 
 
 
 
 
 
