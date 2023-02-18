
create table calendar(
	seq int auto_increment primary key, -- auto_increment 옵션은 int 나 float같은 숫자에만 적용가능
	id varchar(50) not null,
	title varchar(200) not null,
	content varchar(4000),
	rdate varchar(12) not null, -- 202302160945
	wdate timestamp not null
);

alter table calendar
add
constraint fk_cal_id foreign key(id)   -- 무결성
references member(id);


select * from calendar;

-- ?월의 일정에서 5개만 갖고 온다 
select seq, id, title, content, rdate, wdate
from
(select row_number()over(partition by substr(rdate,1, 8) order by rdate asc) as rum, -- 날짜순으로 번호 할당(8자리까지) 오름차순 정렬
	seq, id, title, content, rdate, wdate

from calendar
where id = '2' and substr(rdate, 1, 6) = '202302161235') a --1 부터 6까지
where rnum between 1 and 5;
-----------------------------------------------------------------------------------------------------------------------
-- substr : 함수 substring은 하나의 필드 데이터의 일부를 읽는데 사용된다.

-- substr(rdate, 1, 8) : rdate(초까지 나와있음) 를 1에서 8자리까지(년월일)만 자르겠다.

-- partition by A : A컬럼을 기준으로 그룹을 나누겠다. 

-- partition by substr(rdate, 1, 8) 이와 같은 경우는 날짜를 기준(2023.02.16 이나 2023.04,30 등등 내가 선택한 날짜)으로 그룹을 나누겠다.

-- order by B : A컬럼으로 나누어진 그룹내에서 B를 기준으로 오더 바이를 내리겠다. asc는 오름차순

-- 그래서 row_number()over가 뭐냐 A컬럼으로 그룹바이 걸고 B컬럼으로 오더바이 내었고 그안에서 rnum이라는 컬럼을 만들어 순서를 메겨준다.

-- 이게 뭔소리냐 즉 20230218그룹과 20230222그룹으로 나누어(오름차순으로) 그 각 그룹의 1빠 2빠 3빠 등등이 rnum : 1, rnum : 2 , rnum : 3 
--------------------------------------------------------------------------------------------------------------------------
select seq, id, title, content, rdate, wdate
from
	(select row_number()over(partition by substr(rdate, 1, 8) order by rdate asc) as rnum, seq, id, title, content, rdate, wdate
	from calendar
	where id='2' and substr(rdate, 1, 6) = '202302181922') a
where rnum between 1 and 5;











